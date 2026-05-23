<?
    include './scripts/entrance.php'; 
    include './scripts/admin_functions.php'; // Подключаем функции, созданные выше

    $slug = getAdminSlug($params ?? []);
    $isAjax = (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest');

    if (!isset($_SESSION['user']['id'])) {  // 1. СНАЧАЛА ПРОВЕРЯЕМ: АВТОРИЗОВАН ЛИ ПОЛЬЗОВАТЕЛЬ
        
        if ($isAjax) {
            header('Content-Type: application/json');
            echo json_encode([
                'status' => $status ?? 'Ошибка авторизации', 
                'color' => $color_status ?? 'red'
            ]);
            exit;
        }

        // Если обычный заход — код формы у тебя уже ниже выводится, так что просто отдаем его
        $page = getPageBySlug($pdo, 'admin');
        $title = 'Авторизация';
        $header = '';
        $content = $page['content'];
        
    } else {  // 2. ЕСЛИ СЕССИЯ ЕСТЬ
        if ($isAjax) {
            header('Content-Type: application/json');
            echo json_encode([
                'status' => 'Успешно', 
                'color' => 'green', 
                'redirect' => ($slug == 'admin') ? '/admin' : '/admin/' . $slug
            ]);
            exit;
        }

        $page = getPageBySlug($pdo, 'admin');
        $title = 'Админ-панель';
        $header = '';
        $content = '';

        $user_role = $_SESSION['user']['role'];
        $current_user_id = $_SESSION['user']['id'];

        // Проверка прав (Admin или Moderator)
        if ($user_role !== 'admin' && $user_role !== 'moderator') {
            $code_error = '403';
            header("HTTP/1.1 $code_error Forbidden");
            $error = 'У вас нет прав';
            $title = 'Доступ запрещен';
            include './template/error.php';
            return;
        }

        $header = $page['header_content'];
        $slug = getAdminSlug($params ?? []);

        // Проверка доступа к конкретному разделу для модератора
        if (!checkAdminAccess($user_role, $slug)) {
            $code_error = '403';
            header("HTTP/1.1 $code_error Forbidden");
            $error = 'У модераторов нет доступа к этому разделу';
            $title = 'Доступ ограничен';
            include './template/error.php';
            return;
        }

        // Загрузка категорий для селектов
        $all_categories = [];
        try { $all_categories = $pdo->query("SELECT id, name FROM category ORDER BY id ASC")->fetchAll(); } 
        catch (PDOException $e) {}

        $table_config = getTableConfig();

        // ==========================================
        // МАРШРУТИЗАЦИЯ СТРАНИЦ АДМИНКИ
        // ==========================================

        if (array_key_exists($slug, $table_config)) {
            // 1. РЕНДЕР ТАБЛИЦ CRUD
            $config = $table_config[$slug];
            $title = $config['title'];
            
            handleAdminActions($pdo, $slug, $config, $user_role, $current_user_id);


            // Вывод ошибок
            $error_msgs = [
                'cant_change_own_role' => 'Ошибка: Вы не можете изменить свою роль!',
                'cant_demote_admin'    => 'Ошибка: Нельзя снимать права у других администраторов!',
                'cant_delete_admin'    => 'Ошибка: Нельзя удалить аккаунт администратора!'
            ];
            if (isset($_GET['error']) && isset($error_msgs[$_GET['error']])) {
                $content .= '<div class="admin-error-msg">' . $error_msgs[$_GET['error']] . '</div>';
            }


            // Рендер кнопки добавления
            $content .= '<h2>' . $config['title'] . '</h2>';
            $jsFieldsList = json_encode(array_keys($config['fields']));
            
            if (!in_array($slug, ['reviews1', 'order1', 'users'])) {
                $content .= "<button class='admin-button btn-green' onclick='openModal($jsFieldsList)'>+ Добавить запись</button>";
            }


            // Сборка таблицы
            $rows = $pdo->query("SELECT * FROM {$config['db_table']} ORDER BY id DESC")->fetchAll(PDO::FETCH_ASSOC);

            $content .= '<table class="admin-table"><thead><tr>';
            foreach ($config['fields'] as $label) { $content .= "<th>{$label}</th>"; }  // Заголовки столбцов
            $content .= '<th>Действия</th></tr></thead><tbody>';

            foreach ($rows as $row) {  // Начало строки
                $content .= '<tr>';
                foreach ($config['fields'] as $field => $label) {  // Вывод ячейки
                    if ($field === 'status' && $slug === 'reviews1') {
                        $status_html = $row[$field] == 1 ? '<span class="status-active">Отображается</span>' : '<span class="status-hidden">Скрыт</span>';
                        $content .= "<td>{$status_html}</td>";
                    } elseif ($field === 'category_id' && $slug === 'goods') {
                        $cat_name = 'Неизвестно (ID: ' . $row[$field] . ')';
                        foreach ($all_categories as $cat) {
                            if ($cat['id'] == $row[$field]) { $cat_name = htmlspecialchars($cat['name']); break; }
                        }
                        $content .= "<td>{$cat_name}</td>";
                    } else {
                        $content .= "<td>" . htmlspecialchars($row[$field] ?? '') . "</td>";
                    }
                }

                // Кнопки действий
                $content .= '<td>';
                $jsonData = htmlspecialchars(json_encode($row), ENT_QUOTES, 'UTF-8');
                
                if ($slug === 'reviews1') {
                    $btn_class = $row['status'] == 1 ? 'btn-gray' : 'btn-green';
                    $btn_text = $row['status'] == 1 ? 'Скрыть' : 'Показать на сайте';
                    $content .= "<a href='/admin/{$slug}?toggle_status_id={$row['id']}&current_status={$row['status']}' class='admin-button {$btn_class}'>{$btn_text}</a>";
                } else {
                    $is_locked = ($slug === 'users' && ($row['id'] == $current_user_id || $row['role'] === 'admin')) || ($slug === 'order1');
                    if (!$is_locked) {
                        $content .= "<button class='admin-button btn-yellow' onclick='editRow({$jsonData}, {$jsFieldsList})'>Изм.</button> ";
                        $content .= "<a href='/admin/{$slug}?delete_row_id={$row['id']}' class='admin-button btn-red' onclick=\"return confirm('Удалить эту запись?')\">Удл.</a>";
                    } else {
                        $content .= '<span class="system-locked">Заблокировано</span>';
                    }
                }
                $content .= '</td></tr>';
            }
            $content .= '</tbody></table>';

            // Рендер модального окна
            if ($slug !== 'reviews1' && $slug !== 'users') {
                $content .= '
                <div id="dynamicModal" class="admin-modal">
                    <div class="admin-modal-content">
                        <span class="close-btn" onclick="closeModal()">&times;</span>
                        <h3 id="modalTitle">Запись</h3>
                        <form method="POST" data-no-ajax>
                            <input type="hidden" name="action_save_table" value="1">
                            <input type="hidden" id="rowId" name="row_id">';
                
                foreach ($config['fields'] as $field => $label) {
                    if ($field === 'id') continue;
                    $content .= '<div class="form-group"><label>' . htmlspecialchars($label) . '</label>';
                    
                    if ($field === 'role') {
                        $content .= '<select id="field_role" name="role" class="form-control"><option value="user">User</option><option value="moderator">Moderator</option></select>';
                    } elseif ($field === 'category_id' && $slug === 'goods') {
                        $content .= '<select id="field_category_id" name="category_id" class="form-control">';
                        foreach ($all_categories as $cat) { $content .= '<option value="' . $cat['id'] . '">' . htmlspecialchars($cat['name']) . '</option>'; }
                        $content .= '</select>';
                    } else {
                        $content .= '<input type="text" id="field_' . $field . '" name="' . $field . '" class="form-control">';
                    }
                    $content .= '</div>';
                }
                $content .= '
                            <button type="submit" class="admin-button btn-blue">Сохранить изменения</button>
                        </form>
                    </div>
                </div>';
            }

        } elseif ($slug === 'statistics') {
            // 2. РЕНДЕР СТАТИСТИКИ
            $st = getStatisticsData($pdo);
            
            $content .= '<h2>Статистика заказов</h2><hr>';
            $content .= '<p><strong>Всего заказов:</strong> ' . number_format($st['total'], 0, '', ' ') . ' (' . ($st['p_total'] >= 0 ? '+' : '') . $st['p_total'] . '% от прошлого месяца)</p>';
            $content .= '<p><strong>Сегодня заказов:</strong> ' . number_format($st['today'], 0, '', ' ') . ' (' . ($st['p_today'] >= 0 ? '+' : '') . $st['p_today'] . '% от вчера)</p>';
            $content .= '<p><strong>Заказов в этом месяце:</strong> ' . number_format($st['month'], 0, '', ' ') . ' (' . ($st['p_month'] >= 0 ? '+' : '') . $st['p_month'] . '% от прошлого месяца)</p>';
            $content .= '<p><strong>Средний чек:</strong> ' . number_format($st['avg'], 0, '', ' ') . ' руб. (' . ($st['p_avg'] >= 0 ? '+' : '') . $st['p_avg'] . '% от прошлого месяца)</p>';
            $content .= '<hr>';

        } else {
            // 3. ГЛАВНЫЙ ЭКРАН (Приветствие)
            $content .= '
            <div style="text-align: center; margin-top: 50px;">
                <h1>Панель управления сайтом</h1>
                <p>Вы успешно вошли как: <strong>' . htmlspecialchars($_SESSION['user']['login']) . '</strong> (' . htmlspecialchars($user_role) . ')</p>
                <p style="margin-top: 20px; color: #555;">Используйте навигационное меню для работы.</p>
                <div style="margin-top: 40px;">
                    <form method="POST" data-no-ajax>
                        <input type="hidden" name="logout" value="1">
                        <button class="admin-button btn-red" style="padding:10px 25px; font-size:15px;" type="submit">Выйти из системы</button>
                    </form>
                </div>
            </div>';
        }
    }
?>