<?php 
    $page = getPageBySlug($pdo, 'basket');
    $title = $page['title'];
    $header_content = "<h2>Корзина</h2>";

    if (isset($_SESSION['user']['login'])) {
        
        // Обработчик изменения количества товара
        if (isset($_POST['set_quantity']) && !empty($_SERVER['HTTP_X_REQUESTED_WITH'])) {
            header('Content-Type: application/json');
            header('Cache-Control: no-store, no-cache, must-revalidate');
            
            $id = intval($_POST['id'] ?? 0);
            $qty = intval($_POST['quantity'] ?? 0);

            if ($id > 0) {
                if ($qty <= 0) {
                    unset($_SESSION['user']['basket'][$id]); 
                } else {
                    $_SESSION['user']['basket'][$id] = $qty; 
                }

                echo json_encode(['status' => 'ok']);
            }
            exit;
        }


        // Обработчик промокода
        if (isset($_POST['apply_promo'])) {
            header('Content-Type: application/json');
            header('Cache-Control: no-store, no-cache, must-revalidate');

            if (isset($_SESSION['discount_multiplier'])) {
                echo json_encode([
                    'status' => 'Промокод уже применен',
                    'color'  => 'red',
                    'data'   => null
                ]);
                exit;
            }

            $code = trim($_POST['promo_code'] ?? '');

            if ($code === "QWERTY") {
                $status = 'Скидка применена';
                $color_status = 'green';
                $data = ['discount_multiplier' => 0.8]; 
                $_SESSION['discount_multiplier'] = 0.8;
            } else {
                $status = 'Неверный код';
                $color_status = 'red';
                $data = null;
            }

            echo json_encode([
                'status' => $status,
                'color'  => $color_status,
                'data'   => $data
            ]);
            exit;
        }

        $total_items = isset($_SESSION['user']['basket']) ? array_sum($_SESSION['user']['basket']) : 0;
        $value_text = $total_items . ' товар(ов)'; 
        $header_content = str_replace('{{ value }}', $value_text, $page['header_content']);

        $products_html = '';
        $total_cart_price = 0;

        if (!empty($_SESSION['user']['basket'])) {
            $card_page = getPageBySlug($pdo, 'card_product_basket');
            $card_template = $card_page['content'] ?? '';

            foreach ($_SESSION['user']['basket'] as $id => $quantity) {
                $item = getProductById($pdo, $id);
                
                if ($item) {
                    $end_price = $item['price'] * $quantity;
                    $total_cart_price += $end_price;

                    $card_content = str_replace(
                        ['{{ name }}', '{{ img }}', '{{ price }}', '{{ price_clean }}', '{{ end_price }}', '{{ id }}', '{{ quantity }}'],
                        [
                            htmlspecialchars($item['name']), 
                            htmlspecialchars('/' . $item['image']), 
                            htmlspecialchars(number_format($item['price'], 0, '', ' ')), 
                            intval($item['price']),
                            htmlspecialchars(number_format($end_price, 0, '', ' ')),
                            htmlspecialchars($item['id']),
                            intval($quantity)
                        ],
                        $card_template
                    );
                    $products_html .= $card_content;
                }
            }
        }

        if ($total_cart_price <= 0) {
            unset($_SESSION['discount_multiplier']);
            unset($_SESSION['user']['final_price']);
        }

        $multiplier = $_SESSION['discount_multiplier'] ?? 1;
        $final_price_with_discount = round($total_cart_price * $multiplier);
        $_SESSION['user']['final_price'] = $final_price_with_discount;

        $page_content = str_replace('{{ product }}', $products_html, $page['content']);
        $page_content = str_replace('{{ value }}', $value_text, $page_content);
        $content = str_replace('{{ final_price }}', number_format($final_price_with_discount, 0, '', ' '), $page_content);

    } else {
        $content = "<h2>Сначала авторизуйтесь</h2>";
    }
?>