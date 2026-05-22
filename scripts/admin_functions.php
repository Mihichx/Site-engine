<?
    // 1. Получение слага
    function getAdminSlug($params) {
        if (empty($params)) return '';
        if (is_array($params)) {
            if (isset($params[1]) && is_string($params[1])) return trim($params[1]);
            if (isset($params[0]) && is_string($params[0])) return trim($params[0]);
            $first = reset($params);
            return is_array($first) ? '' : trim((string)$first);
        }
        return trim((string)$params);
    }

    // 2. Проверка доступа
    function checkAdminAccess($role, $slug) {
        if ($role === 'admin') return true;
        if ($role === 'moderator') {
            $allowed_slugs = ['admin', 'reviews1', 'statistics', 'order1'];
            return in_array($slug, $allowed_slugs);
        }
        return false;
    }

    // 3. Получение конфигурации таблиц
    function getTableConfig() {
        return [
            'goods'    => ['db_table' => 'products', 'title' => 'Управление товарами', 'fields' => ['id' => 'ID', 'category_id' => 'Категория', 'name' => 'Название', 'price' => 'Цена', 'image' => 'Изображение', 'description' => 'Описание', 'more_description' => 'Большое описание', 'material' => 'Материал', 'color' => 'Цвет', 'height' => 'Высота', 'length' => 'Длина', 'width' => 'Ширина', 'weight' => 'Вес']],
            'reviews1' => ['db_table' => 'reviews',  'title' => 'Модерация отзывов', 'fields' => ['id' => 'ID', 'name' => 'Автор', 'text' => 'Текст отзыва', 'rating' => 'Оценка', 'status' => 'Отображать']],
            'users'    => ['db_table' => 'users',    'title' => 'Список пользователей', 'fields' => ['id' => 'ID', 'login' => 'Логин', 'email' => 'Email', 'role' => 'Роль']],
            'pages'    => ['db_table' => 'pages',    'title' => 'Управление страницами сайта', 'fields' => ['id' => 'ID', 'slug' => 'URL-адрес', 'title' => 'Заголовок страницы', 'content' => 'Содержимое (HTML)', 'header_content' => 'Контент шапки (HTML)', 'in_menu' => 'Какое-меню (0 - не в меню, 1 - верхнее, 2 - админское)']],
            'stock1'   => ['db_table' => 'stock',    'title' => 'Акции', 'fields' => ['id' => 'ID', 'title' => 'Заголовок', 'description' => 'Описание', 'image' => 'Изображение', 'type' => 'Тип акции']],
            'order1'   => ['db_table' => 'orders',   'title' => 'Заказы', 'fields' => ['id' => 'ID', 'user_id' => 'ID пользователя', 'city' => 'Город', 'phone' => 'Телефон', 'address' => 'Адрес', 'postal_code' => 'Почтовый индекс', 'notes' => 'Заметки', 'payment_method' => 'Способ оплаты', 'total_price' => 'Итоговая цена', 'products_json' => 'Товары (JSON)', 'created_at' => 'Дата создания', 'status' => 'Статус']]
        ];
    }

    // 4. Обработка CRUD действий (Удаление, Статус, Сохранение)
    function handleAdminActions($pdo, $slug, $config, $user_role, $current_user_id) {
        $db_table = $config['db_table'];

        // Переключатель статуса отзыва
        if ($slug === 'reviews1' && isset($_GET['toggle_status_id'])) {
            $status = $_GET['current_status'] == 1 ? 0 : 1;
            $stmt = $pdo->prepare("UPDATE $db_table SET status = ? WHERE id = ?");
            $stmt->execute([$status, $_GET['toggle_status_id']]);
            header("Location: /admin/$slug");
            exit;
        }

        // Удаление записи
        if (isset($_GET['delete_row_id']) && $user_role === 'admin') {
            if ($slug === 'users') {
                $check = $pdo->prepare("SELECT role FROM users WHERE id = ?");
                $check->execute([$_GET['delete_row_id']]);
                if (($check->fetch()['role'] ?? '') === 'admin') {
                    header("Location: /admin/$slug?error=cant_delete_admin");
                    exit;
                }
            }
            $stmt = $pdo->prepare("DELETE FROM $db_table WHERE id = ?");
            $stmt->execute([$_GET['delete_row_id']]);
            header("Location: /admin/$slug");
            exit;
        }

        // Сохранение (INSERT/UPDATE)
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action_save_table'])) {
            $row_id = $_POST['row_id'];
            
            // Защита ролей пользователей
            if ($slug === 'users' && $user_role === 'admin') {
                if ($row_id == $current_user_id && $_POST['role'] !== $user_role) {
                    header("Location: /admin/$slug?error=cant_change_own_role"); exit;
                }
                $check = $pdo->prepare("SELECT role FROM users WHERE id = ?");
                $check->execute([$row_id]);
                if (($check->fetch()['role'] ?? '') === 'admin' && $_POST['role'] !== 'admin') {
                    header("Location: /admin/$slug?error=cant_demote_admin"); exit;
                }
            }

            $fields = []; $values = [];
            foreach (array_keys($config['fields']) as $field) {
                if ($field === 'id') continue;
                $val = $_POST[$field] ?? '';
                if ($slug === 'goods' && $field === 'category_id') $val = (!empty($val) && is_numeric($val)) ? (int)$val : 1;
                
                $fields[] = $field;
                $values[] = $val;
            }

            if (!empty($row_id)) {
                $set_sql = implode(' = ?, ', $fields) . ' = ?';
                $values[] = $row_id;
                $stmt = $pdo->prepare("UPDATE $db_table SET $set_sql WHERE id = ?");
            } else {
                $cols_sql = implode(', ', $fields);
                $placeholders = implode(', ', array_fill(0, count($fields), '?'));
                $stmt = $pdo->prepare("INSERT INTO $db_table ($cols_sql) VALUES ($placeholders)");
            }
            $stmt->execute($values);
            header("Location: /admin/$slug");
            exit;
        }
    }

    // 5. Получение данных для статистики
    function getStatisticsData($pdo) {
        $stats = ['total' => 0, 'today' => 0, 'month' => 0, 'avg' => 0, 'p_total' => 0, 'p_today' => 0, 'p_month' => 0, 'p_avg' => 0];
        try {
            $stats['total'] = $pdo->query("SELECT COUNT(*) FROM orders")->fetchColumn();
            $stats['today'] = $pdo->query("SELECT COUNT(*) FROM orders WHERE DATE(created_at) = CURDATE()")->fetchColumn();
            $stats['month'] = $pdo->query("SELECT COUNT(*) FROM orders WHERE MONTH(created_at) = MONTH(CURDATE()) AND YEAR(created_at) = YEAR(CURDATE())")->fetchColumn();
            $stats['avg']   = round((float)$pdo->query("SELECT AVG(total_price) FROM orders WHERE total_price > 0")->fetchColumn(), 0);

            $last_month_total = $pdo->query("SELECT COUNT(*) FROM orders WHERE MONTH(created_at) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(created_at) = YEAR(CURDATE() - INTERVAL 1 MONTH)")->fetchColumn();
            $yesterday = $pdo->query("SELECT COUNT(*) FROM orders WHERE DATE(created_at) = CURDATE() - INTERVAL 1 DAY")->fetchColumn();
            $last_month_avg = round((float)$pdo->query("SELECT AVG(total_price) FROM orders WHERE MONTH(created_at) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(created_at) = YEAR(CURDATE() - INTERVAL 1 MONTH) AND total_price > 0")->fetchColumn(), 0);

            $stats['p_total'] = $last_month_total > 0 ? round((($stats['total'] - $last_month_total) / $last_month_total) * 100) : 0;
            $stats['p_today'] = $yesterday > 0 ? round((($stats['today'] - $yesterday) / $yesterday) * 100) : 0;
            $stats['p_month'] = $last_month_total > 0 ? round((($stats['month'] - $last_month_total) / $last_month_total) * 100) : 0;
            $stats['p_avg']   = $last_month_avg > 0 ? round((($stats['avg'] - $last_month_avg) / $last_month_avg) * 100) : 0;
        } catch (PDOException $e) { /* Игнорируем ошибки, возвращаем нули */ }
        return $stats;
    }
?>