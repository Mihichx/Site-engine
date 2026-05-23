<?
    $page = getPageBySlug($pdo, $slug);          

    // Формирование статичной страницы 
    if ($page && $page['in_menu'] === 1 || ($page['in_menu'] === 2 && $params[0] == 'admin') || $slug === 'index' || $slug === 'team') {
        $title = $page['title'];
        $header_content = $page['header_content'];
        $content = $page['content'];
    } else {
        $code_error = '404';
        header("HTTP/1.1 $code_error Not Found");
        $error = "Запрашиваемая страница не найдена";
        $title = "Страница не найдена";
        include './template/error.php';
        return;
    }

    // Форма отправки обратной связи
    if (isset($_POST['send_feedback'])) {
        $response = ['status' => '', 'color' => 'red'];

        $name = trim($_POST['rev_name1']);
        $email = $_POST['rev_email'];
        $text = trim($_POST['rev_text1']);

        if (!empty($name) && !empty($email) && !empty($text)) {
            addFeedback($pdo, $name, $email, $text);
            $response = ['status' => "Мы учтём ваши пожелания", 'color' => "white"];
        } else {
            $response['status'] = "Заполните все поля!";
        }

        // --- AJAX ОТВЕТ ---
        if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
            header('Content-Type: application/json');
            echo json_encode($response); 
            exit; 
        }
    }
    
    $login_val = $_SESSION['user']['login'] ?? '';
    $content = str_replace('{{ login }}', $login_val, $content ?? '');
?>