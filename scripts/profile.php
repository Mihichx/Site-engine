<?php
    $redirect_url = "/profile";
    include './scripts/entrance.php';


    if (isset($_POST['update_profile']) && isset($_SESSION['user']['id'])) {
        $user_id = $_SESSION['user']['id'];
        
        $stmt = $pdo->prepare("SELECT password FROM users WHERE id = :id");
        $stmt->execute([':id' => $user_id]);
        $current_db_user = $stmt->fetch();

        if ($current_db_user && password_verify($_POST['old_password'], $current_db_user['password'])) {
            $newData = [
                'login'    => trim($_POST['login']),
                'email'    => trim($_POST['email']),
                'password' => $_POST['new_password']
            ];

            if (updateUser($pdo, $user_id, $newData)) {
                $_SESSION['user']['login'] = $newData['login'];
                $_SESSION['user']['email'] = $newData['email'];
                $color_status = "green";
            } else {
                $status = "Ошибка при обновлении!";
            }
        } else {
            $status = "Старый пароль введен неверно!";
        }
    }

    
    // AJAX ответ после логина/регистрации
    if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') {
        header('Content-Type: application/json');

        $out = [
            'status' => $status ?? '',
            'color' => $color_status ?? ''
        ];

        if (isset($color_status) && $color_status === 'green') {
            $out['redirect'] = $redirect_url;
        }

        echo json_encode($out);
        exit;
    }


    // Если пользователь НЕ авторизован — показываем вход или регистрацию
    if (!isset($_SESSION['user']['id'])) {
        $pageSlug = isset($_POST['registration']) ? 'registration' : 'entrance';

        $page = getPageBySlug($pdo, $pageSlug);
        $title = ($pageSlug === 'registration') ? 'Регистрация' : 'Вход';
        $content = $page['content'];

        return;
    }


    // Если пользователь авторизован и открыл настройки
    if (isset($params[1]) && $params[1] === 'settings') {
        $page = getPageBySlug($pdo, 'settings');
        $title = 'Настройки профиля';
        $content = $page['content'];

        $content = str_replace(
            ['{{ login }}', '{{ email }}'],
            [
                htmlspecialchars($_SESSION['user']['login'], ENT_QUOTES, 'UTF-8'),
                htmlspecialchars($_SESSION['user']['email'], ENT_QUOTES, 'UTF-8')
            ],
            $content
        );

        return;
    }


    // Ниже уже только профиль авторизованного пользователя + история заказов

    $page = getPageBySlug($pdo, 'profile');
    $title = $page['title'] ?? 'Профиль';

    if (!function_exists('hd_e')) {
        function hd_e($value) {
            return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8');
        }
    }

    if (!function_exists('hd_format_price')) {
        function hd_format_price($price) {
            return number_format((float)$price, 0, '', ' ');
        }
    }

    if (!function_exists('hd_format_date_ru')) {
        function hd_format_date_ru($date) {
            $months = [
                1 => 'января',
                2 => 'февраля',
                3 => 'марта',
                4 => 'апреля',
                5 => 'мая',
                6 => 'июня',
                7 => 'июля',
                8 => 'августа',
                9 => 'сентября',
                10 => 'октября',
                11 => 'ноября',
                12 => 'декабря',
            ];

            $time = strtotime($date);

            if (!$time) {
                return '';
            }

            $day = date('j', $time);
            $month = $months[(int)date('n', $time)];
            $year = date('Y', $time);

            return $day . ' ' . $month . ' ' . $year;
        }
    }

    if (!function_exists('hd_status_info')) {
        function hd_status_info($status) {
            $status = strtolower((string)$status);

            switch ($status) {
                case 'delivered':
                    return [
                        'text' => 'Доставлено',
                        'class' => 'delivered'
                    ];

                case 'cancel':
                case 'cancelled':
                    return [
                        'text' => 'Отменён',
                        'class' => 'cancel'
                    ];

                case 'new':
                    return [
                        'text' => 'Оформлен',
                        'class' => 'process'
                    ];

                case 'process':
                case 'processing':
                default:
                    return [
                        'text' => 'В пути',
                        'class' => 'process'
                    ];
            }
        }
    }

    if (!function_exists('hd_payment_name')) {
        function hd_payment_name($payment) {
            switch ($payment) {
                case 'cash':
                    return 'Наличными при получении';

                case 'card':
                    return 'Банковской картой при получении';

                case 'sberbank':
                    return 'Перевод на карту Сбербанка';

                case 'cod':
                    return 'Наложенный платёж';

                default:
                    return $payment;
            }
        }
    }

    $user_id = (int)($_SESSION['user']['id'] ?? 0);

    $stmt = $pdo->prepare("
        SELECT 
            id,
            city,
            phone,
            address,
            postal_code,
            notes,
            payment_method,
            total_price,
            products_json,
            status,
            created_at
        FROM orders
        WHERE user_id = ?
        ORDER BY created_at DESC, id DESC
    ");

    $stmt->execute([$user_id]);
    $orders = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $orders_html = '';

    if (!$orders) {
        $orders_html = '<p class="empty-orders">У вас пока нет заказов.</p>';
    } else {
        foreach ($orders as $order) {
            $status_info = hd_status_info($order['status'] ?? 'process');

            $products = json_decode($order['products_json'] ?? '[]', true);
            $products_html = '';

            if (is_array($products) && !empty($products)) {
                $products_html .= '<div class="order-products">';

                foreach ($products as $key => $product) {
                    if (is_array($product)) {
                        $product_id = (int)($product['id'] ?? 0);
                        $product_name = $product['name'] ?? ('Товар №' . $product_id);
                        $product_price = (float)($product['price'] ?? 0);
                        $product_quantity = (int)($product['quantity'] ?? 1);
                        $product_sum = (float)($product['sum'] ?? ($product_price * $product_quantity));
                    } else {
                        $product_id = (int)$key;
                        $product_quantity = (int)$product;

                        $item = getProductById($pdo, $product_id);

                        if (!$item) {
                            continue;
                        }

                        $product_name = $item['name'];
                        $product_price = (float)$item['price'];
                        $product_sum = $product_price * $product_quantity;
                    }

                    $products_html .= '
                        <div class="order-product-row">
                            <span class="order-product-name">' . hd_e($product_name) . '</span>
                            <span class="order-product-qty">' . $product_quantity . ' шт.</span>
                            <span class="order-product-price">' . hd_format_price($product_sum) . ' руб.</span>
                        </div>
                    ';
                }

                $products_html .= '</div>';
            }

            $orders_html .= '
                <div class="order-card">
                    <div class="order-info">
                        <h3>Заказ №' . (int)$order['id'] . '</h3>
                        <p>' . hd_format_date_ru($order['created_at']) . '</p>
                        <p>Сумма: ' . hd_format_price($order['total_price']) . ' руб.</p>
                        <p>Оплата: ' . hd_e(hd_payment_name($order['payment_method'])) . '</p>
                        <p>Адрес: ' . hd_e($order['city']) . ', ' . hd_e($order['address']) . '</p>
                    </div>

                    <span class="status ' . hd_e($status_info['class']) . '">
                        ' . hd_e($status_info['text']) . '
                    </span>

                    ' . $products_html . '
                </div>
            ';
        }
    }

    $page_content = str_replace(
        ['{{ email }}', '{{ login }}', '{{ orders }}'],
        [
            hd_e($_SESSION['user']['email'] ?? ''),
            hd_e($_SESSION['user']['login'] ?? ''),
            $orders_html
        ],
        $page['content']
    );

    $content = $page_content;
?>