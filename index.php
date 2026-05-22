<?
    session_start();
    $pdo = require_once 'connect.php';
    $url_path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $url = urldecode($url_path); 
    require_once './scripts/request.php';

    $slug = trim($url, '/');
    $params = explode('/', $slug);

    ob_start();
    include './template/layout.php';
    $layout = ob_get_clean();

    
    // Определяем основной раздел (проверка на пустой params[0])
    $current_section = $params[0] ?? '';
    if ($current_section == '' || $current_section == 'index.php' || $current_section == 'index') {
        include './scripts/index.php';
    } elseif ($current_section == 'catalog') {
        include './scripts/catalog.php';
    } elseif ($current_section == 'admin') {
        include './scripts/admin.php';
    } elseif ($current_section == 'profile') {
        include './scripts/profile.php';
    } elseif ($current_section == 'basket') {
        include './scripts/basket.php';
    } elseif ($current_section == 'stock') {
        include './scripts/stock.php';
    } elseif ($current_section == 'order') {
        include './scripts/order.php';
    } elseif ($current_section == 'reviews') {
        include './scripts/reviews.php';
    } else {
        $slug = $current_section;
        include './scripts/page.php';
    }


    $param1 = $params[1] ?? null;
    $param2 = $params[2] ?? null;
    if ($current_section == "admin") {
        $stmt = $pdo->query("SELECT slug, title FROM pages WHERE in_menu = 2 AND slug != 'admin'");
    } else {
        $stmt = $pdo->query("SELECT slug, title FROM pages WHERE in_menu = 1");
    }

    // Шапка
    if ($current_section != 'admin') {
        $row = getPageBySlug($pdo, 'header');
        $header = $row['content'];
    }

    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $menu_html = '<ul class="center row">';
    foreach ($rows as $row) {
        $row_slug = $row['slug'];
        $path = htmlspecialchars($row_slug);

        if ($current_section == 'admin') {
            $path = '/admin/' . $path;
        }

        // БЕЗОПАСНАЯ проверка активной ссылки
        $active = in_array($row_slug, $params) ? 'active-link' : '';

        if (!empty($active)) {
            $menu_html .= "<li><a class='$active' style='color: black;'>" . htmlspecialchars($row['title']) . "</a></li>";
        } elseif ($current_section == 'admin') {
            $menu_html .= "<li><a href='$path' class='hover' style='color: black;'>" . htmlspecialchars($row['title']) . "</a></li>";
        } else {
            $menu_html .= "<li><a href='/$path' class='hover' style='color: black;'>" . htmlspecialchars($row['title']) . "</a></li>";
        }
    }
    $menu_html .= '</ul>';


    // Футер
    if ($current_section != "admin") {
        $footer = getPageBySlug($pdo, 'footer');
        $footer_content = $footer['content'] ?? '';
        $footer_content = str_replace('{{ year }}', date("Y"), $footer_content);
    }


    // Иконки и профиль
    $is_basket = ($current_section == 'basket');
    $basket_class = $is_basket ? 'hover center active-icon' : 'hover center';
    $basket_img = $is_basket ? '/img/basket-b.png' : '/img/basket.png';
    if (isset($_SESSION['user']['id'])) {
        $profile_class = 'hover center active-profile';
        $profile = htmlspecialchars($_SESSION['user']['login']);
    } else {
        $is_profile = ($current_section == 'profile');
        $profile_class = $is_profile ? 'hover center active-icon' : 'hover center';
        $profile_img = $is_profile ? '/img/profile-b.png' : '/img/profile.png';
        $profile = '<img class="margin15" src="'.$profile_img.'" alt="Профиль" style="max-width: 40px;">';
    }


    // Финальная сборка
    $replacements = [
        '{{ basket_class }}'   => $basket_class,
        '{{ basket_img }}'     => $basket_img,
        '{{ profile_class }}'  => $profile_class,
        '{{ profile }}'        => $profile,
        '{{ header_content }}' => $header_content ?? '',
        '{{ menu }}'           => $menu_html
    ];
    $header = str_replace(array_keys($replacements), array_values($replacements), $header);
    $layout = str_replace('{{ title }}', $title, $layout);
    $layout = str_replace('{{ header }}', $header, $layout);
    $layout = str_replace('{{ content }}', $content, $layout);
    $layout = str_replace('{{ footer }}', $footer_content ?? '', $layout);
    echo $layout;
?>