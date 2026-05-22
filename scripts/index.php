<? 
    $page = getPageBySlug($pdo, 'index');
    $title = $page['title'];
    $header_content = $page['header_content'];

    $stmt = $pdo->query("SELECT * FROM products ORDER BY price ASC LIMIT 6");
    $products = $stmt->fetchALL(PDO::FETCH_ASSOC);

    $product_page = getPageBySlug($pdo, 'card_product');
    $card_template = $product_page['content'];
    
    $products_html = "";
    foreach ($products as $row) {
        $category = category($pdo, $row);
        $product_url = "/catalog/" . $category['href'] ."/detailed_card_product?id=" . $row['id'];
        $card_content = str_replace(
            ['{{ name }}', '{{ image }}', '{{ price }}', '{{ description }}', '{{ product_url }}', '{{ id }}'],
            [
                htmlspecialchars($row['name']), 
                htmlspecialchars('/' . $row['image']), 
                htmlspecialchars(number_format($row['price'], 0, '', ' ')), 
                htmlspecialchars($row['description']),
                htmlspecialchars($product_url),
                htmlspecialchars($row['id'])
            ],
            $card_template
        );
        $products_html .= $card_content;
    }

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

    // Добавление в корзину
    $isAjax = !empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';
    if (isset($_POST['id']) && $isAjax) {
        header('Content-Type: application/json');
        if (isset($_SESSION['user']['basket'])) {
            $id = intval($_POST['id'] ?? 0);

            if ($id > 0) {
                if (isset($_SESSION['user']['basket'][$id])) {
                    $_SESSION['user']['basket'][$id]++;
                } else {
                    $_SESSION['user']['basket'][$id] = 1;
                }

                $total_items = array_sum($_SESSION['user']['basket']);

                echo json_encode([
                    'status' => 'Добавлено',
                    'color' => 'white'
                ]);
            } else {
                echo json_encode([
                    'status' => 'error'
                ]);
            }
            exit;
        } else {
            echo json_encode([
                'status' => 'Авторизуйтесь'
            ]);
            exit;
        }
    }

    $content = $page['content'];
    $content = str_replace('{{ reviews }}', $html_reviews, $content);
    $content = str_replace('{{ products }}', $products_html, $content);
?>