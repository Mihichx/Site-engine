<?
    ini_set('display_errors', 0);  // Отключаем стандартный вывод ошибок PHP в браузер

    $host = 'localhost';
    $user = 'root';
    $pass = '';
    $db = 'HomeDecor'; 
    $charset = 'utf8mb4';

    $dsn = "mysql:host=$host;dbname=$db;charset=$charset";
    
    try {
        $pdo = new PDO($dsn, $user, $pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false
        ]);
    } catch (PDOException $e) {
        die("
            <div style='font-family: Arial; text-align: center; margin-top: 100px;'>
                <h1 style='color: #e74c3c;'>Ошибка сервера</h1>
                <p style='color: #7f8c8d;'>Не удалось установить соединение с сервером базы данных.</p>
                <hr style='width: 300px;'>
                <small style='color: #bdc3c7;'>Технический код: " . $e->getCode() . "</small>
             </div>
        ");
    }

    return $pdo;
?>