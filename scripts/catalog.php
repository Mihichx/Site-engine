<?php
    $page = getPageBySlug($pdo, 'catalog');
    $header_content = $page['header_content'];
    $content = "";

    if (isset($params[2])) {
        include 'detailed_card_product.php';
    } elseif (isset($params[1])) {
        include 'catalog_product.php';
    } else {
        include 'catalog_category.php';
    }

    // Функция для формирования карточки товара
    function card($pdo, $products) {
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
        return $products_html;
    }

    // Обработка поиска
    if (isset($_POST['search']) && !empty(trim($_POST['search']))) {
        $search_val = trim($_POST['search']);
        $title = "Поиск: " . htmlspecialchars($search_val);

        $found_products = searchALL($pdo, 'products', 'name', $search_val);

        if (!empty($found_products)) {
            $products_html = card($pdo, $found_products);
            $content = "<div class='vases-grid'>$products_html</div>";
        } else {
            $content .= "<h2>По вашему запросу ничего не найдено</h2>";
            $title = "Товар не найден";
        }
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
?>