<? 
    $page = getPageBySlug($pdo, 'reviews');
    $title = $page['title'];
    $content = '';

    $stmt = $pdo->query("SELECT * FROM reviews WHERE status = 1 ORDER BY date DESC LIMIT 3");
    $results = $stmt->fetchALL(PDO::FETCH_ASSOC);

    $card_query = getPageBySlug($pdo, 'card_review');
    $card = $card_query['content'];

    $html_reviews = '';
    foreach ($results as $result) {
        $date = $result['date'];
        $ru_date = date("d.m.Y", strtotime($date));

        $rating = str_repeat('★', $result['rating']);
        (mb_strlen($rating) < 5) ? $rating .= str_repeat('☆', 5 - mb_strlen($rating)) : '';

        $card_content = str_replace(
            ['{{ name }}', '{{ description }}', '{{ stars }}', '{{ date }}'],
            [
                htmlspecialchars($result['name']), 
                htmlspecialchars($result['text']),
                htmlspecialchars($rating), 
                htmlspecialchars($ru_date)
            ],
            $card
        );
        $html_reviews .= $card_content;
    } 

    $content .= $page['content'];
    $content = str_replace('{{ reviews }}', $html_reviews, $content);

    $login_val = $_SESSION['user']['login'] ?? '';
    $content = str_replace('{{ login }}', $login_val, $content ?? '');

    // Форма отправки отзыва
    if (isset($_POST['send_review'])) {
        $response = ['status' => '', 'color' => 'red'];

        if (isset($_SESSION['user']['login'])) {
            $stmt = $pdo->prepare("SELECT user_id FROM orders WHERE user_id = :user_id");
            $stmt->execute([':user_id' => $_SESSION['user']['id']]);

            if ($stmt->fetch(PDO::FETCH_ASSOC)) {
                $name = trim($_POST['rev_name']);
                $rating = $_POST['rev_rating'];
                $text = trim($_POST['rev_text']);


                if (!empty($name) && !empty($text)) {
                    addReview($pdo, $name, $rating, $text);
                    $response = ['status' => "Спасибо за отзыв!", 'color' => "green"];
                } else {
                    $response['status'] = "Заполните все поля!";
                }
            } else {
                $response['status'] = "Сделайте заказ, чтобы оставить отзыв";
            }
        } else {
            $response['status'] = "Сначала авторизуйтесь";
        }

        // --- AJAX ОТВЕТ ---
        if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
            header('Content-Type: application/json');
            echo json_encode($response);    
            exit; 
        }
    }
?>