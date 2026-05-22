<?
    // Защита от прямого входа (Проверяем ТОЛЬКО при GET-запросе, чтобы AJAX POST не ломался)
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $allowed_source = "basket";
        $referer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';

        if (strpos($referer, $allowed_source) === false) {
            $code_error = '404';
            header("HTTP/1.1 $code_error Not Found");
            $error = "Запрашиваемая страница не найдена";
            $title = "Страница не найдена";
            include './template/error.php';
            return;
        }
    }

    $page = getPageBySlug($pdo, 'order');
    $title = $page['title'];

    // Если корзина в сессии пустая — прерываем выполнение для GET-запроса
    $basket = $_SESSION['user']['basket'] ?? [];
    if (empty($basket) && $_SERVER['REQUEST_METHOD'] !== 'POST') {
        $content = "<h2>Ваша корзина пуста</h2>";
        return; 
    }

    // ОБРАБОТЧИК ПРИЕМА ДАННЫХ ИЗ ФОРМЫ (Ориентирован на AJAX)
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        header('Content-Type: application/json');

        if (empty($basket)) {
            echo json_encode(['status' => 'Ваша корзина пуста', 'color' => 'red']);
            exit;
        }

        $user_id      = $_SESSION['user']['id'];
        $city         = trim($_POST['city'] ?? '');
        $phone        = trim($_POST['phone'] ?? '');
        $address      = trim($_POST['address'] ?? '');
        $postal_code  = trim($_POST['postal_code'] ?? '');
        $notes        = trim($_POST['notes'] ?? '');
        $payment      = trim($_POST['payment_method'] ?? '');
        
        $final_price  = $_SESSION['user']['final_price'] ?? 0;

        // Проверяем обязательные поля
        if (empty($city) || empty($phone) || empty($payment) || empty($address) || empty($postal_code)) {
            echo json_encode(['status' => 'Пожалуйста, заполните все поля и выберите способ оплаты', 'color' => 'red']);
            exit;
        }

        // Если выбран наложенный платёж (cod) — увеличиваем стоимость на 5%
        if ($payment === 'cod') {
            $final_price = round($final_price * 1.05);
        }

        // история заказов
        $order_products = [];

        foreach ($basket as $product_id => $quantity) {
            $product = getProductById($pdo, (int)$product_id); // ищет товар в базе данных по его ID

            if (!$product) {
                continue;
            }

            $price = (float)$product['price'];
            $quantity = (int)$quantity;

            // добавляет один товар в массив $order_products
            $order_products[] = [
                'id' => (int)$product_id,
                'name' => $product['name'],
                'image' => $product['image'] ?? '',
                'price' => $price,
                'quantity' => $quantity,
                'sum' => $price * $quantity
            ];
        }

        $products_json = json_encode($order_products, JSON_UNESCAPED_UNICODE);

        // Вставляем запись в таблицу заказов
        $stmt = $pdo->prepare("INSERT INTO orders (user_id, city, phone, address, postal_code, notes, payment_method, total_price, products_json, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())");

        $order_saved = $stmt->execute([
            $user_id, $city, $phone, $address, $postal_code, $notes, $payment, $final_price, $products_json, 'new'
        ]);

        if ($order_saved) {
            // Очищаем данные корзины
            $_SESSION['user']['basket'] = [];
            unset($_SESSION['discount_multiplier']);
            unset($_SESSION['user']['final_price']);

            echo json_encode(['redirect' => '/profile']);
            exit;
        } else {
            echo json_encode(['status' => 'Ошибка базы данных. Попробуйте позже.', 'color' => 'red']);
            exit;
        }
    }

    $final_price_display = $_SESSION['user']['final_price'] ?? 0;

    $page_content = str_replace(
        ['{{ name }}', '{{ email }}', '{{ final_price }}'], 
        [
            htmlspecialchars($_SESSION['user']['login']), 
            htmlspecialchars($_SESSION['user']['email'] ?? ''), 
            htmlspecialchars(number_format($final_price_display, 0, '', ' '))
        ], 
        $page['content']
    );

    $content = $page_content;
?>