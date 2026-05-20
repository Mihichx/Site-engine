<?php
    // Включаем отображение ошибок для отладки
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    $page = getPageBySlug($pdo, 'admin');
    $title = 'Админ-панель';
    $header = '';
    $content = '';

    include './scripts/entrance.php';  // Логика логина/регистрации

    // Проверяем, авторизован ли пользователь и является ли он админом или модером
    if (isset($_SESSION['user']['id'])) {
        $user_role = $_SESSION['user']['role'];
        $current_user_id = $_SESSION['user']['id'];

        if ($user_role === 'admin' || $user_role === 'moderator') {
            $header = $page['header_content'];
            
            // 1. БЕЗОПАСНОЕ ИЗВЛЕЧЕНИЕ СЛАГА ИЗ ПАРАМЕТРОВ РОУТЕРА
            $slug = '';
            if (!empty($params)) {
                if (is_array($params)) {
                    if (isset($params[1]) && is_string($params[1])) {
                        $slug = $params[1];
                    } elseif (isset($params[0]) && is_string($params[0])) {
                        $slug = $params[0];
                    } else {
                        $first_element = reset($params);
                        $slug = is_array($first_element) ? '' : (string)$first_element;
                    }
                } else {
                    $slug = (string)$params;
                }
            }
            $slug = trim($slug);

            // --- ОГРАНИЧЕНИЕ ДОСТУПА ДЛЯ МОДЕРАТОРА ---
            if ($user_role === 'moderator') {
                $allowed_slugs = ['admin', 'reviews1', 'statistics'];
                if (!in_array($slug, $allowed_slugs)) {
                    $code_error = '403';
                    header("HTTP/1.1 $code_error Forbidden");
                    $error = 'У модераторов нет доступа к этому разделу';
                    $title = 'Доступ ограничен';
                    include './template/error.php';
                    return;
                }
            }

            // ДИНАМИЧЕСКИЙ ЗАПРОС КАТЕГОРИЙ ИЗ БАЗЫ ДАННЫХ (Имя таблицы изменено на category)
            try {
                $all_categories = $pdo->query("SELECT id, name FROM category ORDER BY id ASC")->fetchAll();
            } catch (PDOException $e) {
                $all_categories = [];
            }

            // =========================================================================
            // КОНФИГУРАЦИЯ ТАБЛИЦ (Строго по структуре вашей БД)
            // =========================================================================
            $table_config = [
                'goods' => [
                    'db_table' => 'products',
                    'title'    => 'Управление товарами',
                    'fields'   => ['id' => 'ID', 'category_id' => 'Категория', 'name' => 'Название', 'price' => 'Цена', 'image' => 'Изображение', 'description' => 'Описание', 'more_description' => 'Большое описание', 'material' => 'Материал', 'color' => 'Цвет', 'height' => 'Высота', 'length' => 'Длина', 'width' => 'Ширина', 'weight' => 'Вес']
                ],
                'reviews1' => [
                    'db_table' => 'reviews', 
                    'title'    => 'Модерация отзывов',
                    'fields'   => ['id' => 'ID', 'name' => 'Автор', 'text' => 'Текст отзыва', 'rating' => 'Оценка', 'status' => 'Отображать']
                ],
                'users' => [
                    'db_table' => 'users', 
                    'title'    => 'Список пользователей',
                    'fields'   => ['id' => 'ID', 'login' => 'Логин', 'email' => 'Email', 'role' => 'Роль']
                ],
                'pages' => [
                    'db_table' => 'pages',
                    'title'    => 'Управление страницами сайта',
                    'fields'   => [
                        'id'    => 'ID',
                        'slug'  => 'URL-адрес',
                        'title' => 'Заголовок страницы',
                        'content' => 'Содержимое (HTML)',
                        'header_content' => 'Контент шапки (HTML)',
                        'in_menu' => 'Какое-меню (0 - не в меню, 1 - верхнее, 2 - админское)'
                    ]
                ],
                'stock1' => [
                    'db_table' => 'stock',
                    'title'    => 'Акции',
                    'fields'   => [
                        'id'    => 'ID',
                        'title' => 'Заголовок',
                        'description' => 'Описание',
                        'image' => 'Изображение',
                        'type' => 'Тип акции'
                    ]
                ],
                'order1' => [
                    'db_table' => 'orders',
                    'title'    => 'Заказы',
                    'fields'   => [
                        'id'             => 'ID',
                        'user_id'        => 'ID пользователя',
                        'city'           => 'Город',
                        'phone'          => 'Телефон',
                        'address'        => 'Адрес',
                        'postal_code'    => 'Почтовый индекс',
                        'notes'          => 'Заметки',
                        'payment_method' => 'Способ оплаты',
                        'total_price'    => 'Итоговая цена',
                        'products_json'  => 'Товары (JSON)',
                        'created_at'     => 'Дата создания',
                        'status'         => 'Статус'
                    ]
                ]
            ];

            if (array_key_exists($slug, $table_config)) {
                $config = $table_config[$slug];
                $title = $config['title'];
                $db_table = $config['db_table'];

                // ---------------------------------------------------------------------
                // ОБРАБОТКА ДЕЙСТВИЙ (CRUD / Модерация)
                // ---------------------------------------------------------------------
                
                // Переключатель статуса отзыва (ВКЛ / ВЫКЛ)
                if ($slug === 'reviews1' && isset($_GET['toggle_status_id'])) {
                    $review_id = $_GET['toggle_status_id'];
                    $current_status = $_GET['current_status'] == 1 ? 0 : 1;
                    
                    $stmt = $pdo->prepare("UPDATE $db_table SET status = ? WHERE id = ?");
                    $stmt->execute([$current_status, $review_id]);
                    header("Location: /admin/$slug");
                    exit;
                }

                // Удаление записи (Только для Admin)
                if (isset($_GET['delete_row_id']) && $user_role === 'admin') {
                    if ($slug === 'users') {
                        $check = $pdo->prepare("SELECT role FROM users WHERE id = ?");
                        $check->execute([$_GET['delete_row_id']]);
                        $target_user = $check->fetch();
                        if ($target_user && $target_user['role'] === 'admin') {
                            header("Location: /admin/$slug?error=cant_delete_admin");
                            exit;
                        }
                    }

                    $stmt = $pdo->prepare("DELETE FROM $db_table WHERE id = ?");
                    $stmt->execute([$_GET['delete_row_id']]);
                    header("Location: /admin/$slug");
                    exit;
                }

                // Изменение или добавление записи (Защищенная валидация)
                if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action_save_table'])) {
                    $row_id = $_POST['row_id'];
                    
                    if ($slug === 'users' && $user_role === 'admin') {
                        if ($row_id == $current_user_id && $_POST['role'] !== $user_role) {
                            header("Location: /admin/$slug?error=cant_change_own_role");
                            exit;
                        }
                        $check = $pdo->prepare("SELECT role FROM users WHERE id = ?");
                        $check->execute([$row_id]);
                        $target_user = $check->fetch();
                        if ($target_user && $target_user['role'] === 'admin' && $_POST['role'] !== 'admin') {
                            header("Location: /admin/$slug?error=cant_demote_admin");
                            exit;
                        }
                    }

                    // Сбор полей для безопасного SQL-запроса
                    $fields_to_update = [];
                    $values = [];
                    foreach ($config['fields'] as $field => $label) {
                        if ($field === 'id') continue;
                        
                        $val = $_POST[$field] ?? '';

                        // Принудительное приведение к числу для category_id в товарах
                        if ($slug === 'goods' && $field === 'category_id') {
                            $val = (!empty($val) && is_numeric($val)) ? (int)$val : 1;
                        }

                        $fields_to_update[$field] = $val;
                        $values[] = $val;
                    }

                    if (!empty($row_id)) {
                        // Динамический UPDATE query
                        $set_sql = implode(' = ?, ', array_keys($fields_to_update)) . ' = ?';
                        $values[] = $row_id;
                        $stmt = $pdo->prepare("UPDATE $db_table SET $set_sql WHERE id = ?");
                        $stmt->execute($values);
                    } else {
                        // Динамический INSERT query
                        $cols_sql = implode(', ', array_keys($fields_to_update));
                        $placeholders = implode(', ', array_fill(0, count($fields_to_update), '?'));
                        $stmt = $pdo->prepare("INSERT INTO $db_table ($cols_sql) VALUES ($placeholders)");
                        $stmt->execute($values);
                    }
                    header("Location: /admin/$slug");
                    exit;
                }

                // ---------------------------------------------------------------------
                // ВЫВОД ОШИБОК И ГЕНЕРАЦИЯ ТАБЛИЦЫ
                // ---------------------------------------------------------------------
                if (isset($_GET['error'])) {
                    $error_msgs = [
                        'cant_change_own_role' => 'Ошибка: Вы не можете изменить свою собственную роль!',
                        'cant_demote_admin'    => 'Ошибка: Нельзя снимать права у других администраторов!',
                        'cant_delete_admin'    => 'Ошибка: Нельзя удалить аккаунт администратора!'
                    ];
                    $msg = $error_msgs[$_GET['error']] ?? 'Произошла ошибка доступа';
                    $content .= '<div style="color:red; background:#ffebeb; padding:10px; margin-bottom:15px; border-left:4px solid red; font-weight:bold;">' . $msg . '</div>';
                }

                $rows = $pdo->query("SELECT * FROM $db_table ORDER BY id DESC")->fetchAll();
                
                $content .= '<h2>' . $config['title'] . '</h2>';
                
                if ($slug !== 'reviews1' && $slug !== 'order1') {
                    $content .= '<button class="hover" onclick="openModal()" style="margin-bottom:15px; background:#28a745; color:white; padding:8px 15px; border:none; border-radius:4px; cursor:pointer;">+ Добавить запись</button>';
                }
                
                $content .= '<table class="admin-table"><thead><tr>';
                foreach ($config['fields'] as $label) {
                    $content .= '<th>' . htmlspecialchars($label) . '</th>';
                }
                $content .= '<th>Действия</th><tr></thead><tbody>';

                foreach ($rows as $row) {
                    $content .= '<tr>';
                    foreach ($config['fields'] as $field => $label) {
                        if ($field === 'status' && $slug === 'reviews1') {
                            $status_text = ($row[$field] == 1) ? '<span style="color:green; font-weight:bold;">Отображается</span>' : '<span style="color:gray;">Скрыт</span>';
                            $content .= '<td>' . $status_text . '</td>';
                        } 
                        // Ищем текстовое имя категории в динамическом массиве $all_categories по её ID
                        elseif ($field === 'category_id' && $slug === 'goods') {
                            $cat_name = 'Неизвестно (ID: ' . $row[$field] . ')';
                            foreach ($all_categories as $cat) {
                                if ($cat['id'] == $row[$field]) {
                                    $cat_name = htmlspecialchars($cat['name']);
                                    break;
                                }
                            }
                            $content .= '<td>' . $cat_name . '</td>';
                        } 
                        else {
                            $content .= '<td>' . htmlspecialchars($row[$field] ?? '') . '</td>';
                        }
                    }
                    
                    $jsonData = htmlspecialchars(json_encode($row), ENT_QUOTES, 'UTF-8');
                    $content .= '<td>';

                    if ($slug === 'reviews1') {
                        $btn_style = ($row['status'] == 1) ? 'background:#6c757d; color:white;' : 'background:#28a745; color:white;';
                        $btn_text = ($row['status'] == 1) ? 'Скрыть' : 'Показать на сайте';
                        $content .= '<a href="/admin/reviews1?toggle_status_id=' . $row['id'] . '&current_status=' . $row['status'] . '" class="admin-button hover" style="padding:4px 8px; text-decoration:none; font-size:13px; border-radius:3px;' . $btn_style . '">' . $btn_text . '</a>';
                    } else {
                        // Блокировка редактирования критических данных
                        $is_locked = ($slug === 'users' && ($row['id'] == $current_user_id || $row['role'] === 'admin')) || ($slug === 'order1');
                        if (!$is_locked) {
                            $content .= '<button class="admin-button edit hover" style="background:#ffc107; padding:4px 8px; border:none; cursor:pointer;" onclick=\'editRow(' . $jsonData . ')\'>Изм.</button>';
                            $content .= '<a href="/admin/' . $slug . '?delete_row_id=' . $row['id'] . '" class="admin-button delete hover" style="background:#dc3545; color:white; padding:4px 8px; text-decoration:none; margin-left:5px; font-size:13px; border-radius:3px;" onclick="return confirm(\'Удалить эту запись?\')">Удл.</a>';
                        } else {
                            $content .= '<span style="color:#999; font-size:12px; font-style:italic;">Заблокировано системой</span>';
                        }
                    }

                    $content .= '</td></tr>';
                }
                $content .= '</tbody></table>';

                // Динамическое модальное окно добавления/изменения
                if ($slug !== 'reviews1') {
                    $content .= '
                    <div id="dynamicModal" class="admin-modal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center; z-index:9999;">
                        <div class="admin-modal-content" style="background:white; padding:25px; border-radius:5px; width:380px; position:relative;">
                            <span class="close-btn" style="position:absolute; top:10px; right:15px; font-size:24px; cursor:pointer;" onclick="closeModal()">&times;</span>
                            <h3 id="modalTitle">Запись</h3>
                            <form method="POST">
                                <input type="hidden" name="action_save_table" value="1">
                                <input type="hidden" id="rowId" name="row_id">';
                    
                    foreach ($config['fields'] as $field => $label) {
                        if ($field === 'id') continue;
                        
                        $content .= '<div class="form-group" style="margin-bottom:12px;">';
                        $content .= '<label style="display:block; margin-bottom:4px; font-weight:bold;">' . htmlspecialchars($label) . '</label>';
                        
                        if ($field === 'role') {
                            $content .= '
                            <select id="field_role" name="role" style="width:100%; padding:8px; border:1px solid #ccc;">
                                <option value="user">User</option>
                                <option value="moderator">Moderator</option>    
                            </select>';
                        } 
                        // Выпадающий список категорий, который строится ДИНАМИЧЕСКИ из БД (таблица category)
                        elseif ($field === 'category_id' && $slug === 'goods') {
                            $content .= '<select id="field_category_id" name="category_id" style="width:100%; padding:8px; border:1px solid #ccc;">';
                            foreach ($all_categories as $cat) {
                                $content .= '<option value="' . $cat['id'] . '">' . htmlspecialchars($cat['name']) . '</option>';
                            }
                            $content .= '</select>';
                        } 
                        else {
                            $content .= '<input type="text" id="field_' . $field . '" name="' . $field . '" style="width:100%; padding:8px; border:1px solid #ccc; box-sizing:border-box;">';
                        }
                        $content .= '</div>';
                    }
                    
                    $content .= '
                                <button type="submit" class="admin-button hover" style="width:100%; padding:10px; background:#007bff; color:white; border:none; cursor:pointer;">Сохранить изменения</button>
                            </form>
                        </div>
                    </div>';

                    $content .= '
                    <script>
                        const modal = document.getElementById("dynamicModal");
                        const fields = ' . json_encode(array_keys($config['fields'])) . ';
                        
                        function openModal() {
                            document.getElementById("modalTitle").innerText = "Добавить новую запись";
                            document.getElementById("rowId").value = "";
                            fields.forEach(f => {
                                if(f !== "id") document.getElementById("field_" + f).value = (f === "category_id") ? "1" : "";
                            });
                            modal.style.display = "flex";
                        }
                        
                        function editRow(data) {
                            document.getElementById("modalTitle").innerText = "Редактировать запись #" + data.id;
                            document.getElementById("rowId").value = data.id;
                            fields.forEach(f => {
                                if(f !== "id") document.getElementById("field_" + f).value = data[f] || "";
                            });
                            modal.style.display = "flex";
                        }
                        
                        function closeModal() { modal.style.display = "none"; }
                        window.onclick = function(e) { if (e.target == modal) closeModal(); }
                    </script>';
                }

            } elseif ($slug === 'statistics') {
                // =============================================================
                // СТРАНИЦА СТАТИСТИКИ
                // =============================================================
                
                try {
                    // Всего заказов
                    $stmt = $pdo->query("SELECT COUNT(*) as total FROM orders");
                    $total_orders = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
                    
                    // Заказов сегодня
                    $stmt = $pdo->query("SELECT COUNT(*) as today FROM orders WHERE DATE(created_at) = CURDATE()");
                    $today_orders = $stmt->fetch(PDO::FETCH_ASSOC)['today'];
                    
                    // Заказов в этом месяце
                    $stmt = $pdo->query("SELECT COUNT(*) as month FROM orders WHERE MONTH(created_at) = MONTH(CURDATE()) AND YEAR(created_at) = YEAR(CURDATE())");
                    $month_orders = $stmt->fetch(PDO::FETCH_ASSOC)['month'];
                    
                    // Средний чек
                    $stmt = $pdo->query("SELECT AVG(total_price) as avg_price FROM orders WHERE total_price > 0");
                    $avg_check = $stmt->fetch(PDO::FETCH_ASSOC)['avg_price'];
                    $avg_check = round($avg_check, 0);
                    
                    // Динамика: прошлый месяц (для общего кол-ва)
                    $stmt = $pdo->query("SELECT COUNT(*) as last_month FROM orders WHERE MONTH(created_at) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(created_at) = YEAR(CURDATE() - INTERVAL 1 MONTH)");
                    $last_month_total = $stmt->fetch(PDO::FETCH_ASSOC)['last_month'];
                    $percent_total = ($last_month_total > 0) ? round((($total_orders - $last_month_total) / $last_month_total) * 100) : 0;
                    
                    // Динамика: вчера
                    $stmt = $pdo->query("SELECT COUNT(*) as yesterday FROM orders WHERE DATE(created_at) = CURDATE() - INTERVAL 1 DAY");
                    $yesterday = $stmt->fetch(PDO::FETCH_ASSOC)['yesterday'];
                    $percent_today = ($yesterday > 0) ? round((($today_orders - $yesterday) / $yesterday) * 100) : 0;
                    
                    // Динамика: прошлый месяц (для месячных заказов)
                    $stmt = $pdo->query("SELECT COUNT(*) as last_month FROM orders WHERE MONTH(created_at) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(created_at) = YEAR(CURDATE() - INTERVAL 1 MONTH)");
                    $last_month_monthly = $stmt->fetch(PDO::FETCH_ASSOC)['last_month'];
                    $percent_month = ($last_month_monthly > 0) ? round((($month_orders - $last_month_monthly) / $last_month_monthly) * 100) : 0;
                    
                    // Динамика: средний чек
                    $stmt = $pdo->query("SELECT AVG(total_price) as avg_price FROM orders WHERE MONTH(created_at) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(created_at) = YEAR(CURDATE() - INTERVAL 1 MONTH) AND total_price > 0");
                    $last_month_avg = $stmt->fetch(PDO::FETCH_ASSOC)['avg_price'];
                    $last_month_avg = ($last_month_avg !== null) ? round($last_month_avg, 0) : 0;
                    $percent_avg = ($last_month_avg > 0) ? round((($avg_check - $last_month_avg) / $last_month_avg) * 100) : 0;
                    
                } catch (PDOException $e) {
                    $total_orders = 0;
                    $today_orders = 0;
                    $month_orders = 0;
                    $avg_check = 0;
                    $percent_total = 0;
                    $percent_today = 0;
                    $percent_month = 0;
                    $percent_avg = 0;
                }
                
                $content .= '<h2>Статистика заказов</h2>';
                $content .= '<hr>';
                $content .= '<p><strong>Всего заказов:</strong> ' . number_format($total_orders, 0, '', ' ') . ' (' . ($percent_total >= 0 ? '+' : '') . $percent_total . '% от прошлого месяца)</p>';
                $content .= '<p><strong>Сегодня заказов:</strong> ' . number_format($today_orders, 0, '', ' ') . ' (' . ($percent_today >= 0 ? '+' : '') . $percent_today . '% от вчера)</p>';
                $content .= '<p><strong>Заказов в этом месяце:</strong> ' . number_format($month_orders, 0, '', ' ') . ' (' . ($percent_month >= 0 ? '+' : '') . $percent_month . '% от прошлого месяца)</p>';
                $content .= '<p><strong>Средний чек:</strong> ' . number_format($avg_check, 0, '', ' ') . ' руб. (' . ($percent_avg >= 0 ? '+' : '') . $percent_avg . '% от прошлого месяца)</p>';
                $content .= '<hr>';
                
            } else {
                // Главный экран авторизованного пользователя
                $content .= '
                <div style="text-align: center; margin-top: 50px;">
                    <h1>Панель управления сайтом</h1>
                    <p>Вы успешно вошли как: <strong>' . htmlspecialchars($_SESSION['user']['login']) . '</strong> (' . htmlspecialchars($user_role) . ')</p>
                    <p style="margin-top: 20px; font-size: 16px; color: #555;">Используйте верхнее навигационное меню, чтобы переключаться между таблицами управления.</p>
                    
                    <div style="margin-top: 40px;">
                        <form method="POST">
                            <input type="hidden" name="logout" value="1">
                            <button class="hover" style="background:#dc3545; color:white; border:none; padding:10px 25px; font-size:15px; border-radius:4px; cursor:pointer;" type="submit">Выйти из системы</button>
                        </form>
                    </div>
                </div>';
            }

            // ПРИНУДИТЕЛЬНО очищаем старую форму входа из переменной шаблона, так как админ УЖЕ вошел
            $page['content'] = ''; 

        } else {
            $code_error = '403';
            header("HTTP/1.1 $code_error Forbidden");
            $error = 'У вас нет прав';
            $title = 'Доступ запрещен';
            include './template/error.php';
            return;
        }
    } else {
        // Если НЕ авторизован — выводим стандартную форму входа из базы данных
        $content .= $page['content']; 
    }

    // Записываем финально сгенерированные таблицы в контент шаблона перед рендерингом страницы сайта
    if (!empty($content)) {
        $page['content'] = $content;
    }

    // --- AJAX ОТВЕТ ---
    if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
        header('Content-Type: application/json');
        
        $out = [
            'status'   => 'Успешно',
            'color'    => 'green',
            'redirect' => '/admin/' . $slug
        ];

        echo json_encode($out);
        exit;
    }
?>