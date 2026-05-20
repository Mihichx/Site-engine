<? 

    $page = getPageBySlug($pdo, 'stock');

    $title = $page['title'];
    $content = '';
    $header_content = $page['header_content'];


    // СКИДКИ
    $stmt = $pdo->prepare("SELECT * FROM stock WHERE type = ?");
    $stmt->execute(['sales']);

    $sales = $stmt->fetchAll(PDO::FETCH_ASSOC);


    // СПЕЦ ПРЕДЛОЖЕНИЯ
    $stmt = $pdo->prepare("SELECT * FROM stock WHERE type = ?");
    $stmt->execute(['special']);

    $specials = $stmt->fetchAll(PDO::FETCH_ASSOC);


    // ШАБЛОН КАРТОЧКИ
    $card = '
        <div class="card">
            <img src="./img/{{ image }}" alt="{{ title }}">

            <div class="card-content">
                <h3>{{ title }}</h3>
                <p>{{ description }}</p>
            </div>
        </div>
    ';


    // СКИДКИ HTML
    $html_sales = '';

    foreach ($sales as $item) {

        $card_content = str_replace(
            ['{{ image }}', '{{ title }}', '{{ description }}'],
            [
                htmlspecialchars($item['image']),
                htmlspecialchars($item['title']),
                htmlspecialchars($item['description'])
            ],
            $card
        );

        $html_sales .= $card_content;
    }


    // СПЕЦ ПРЕДЛОЖЕНИЯ HTML
    $html_special = '';

    foreach ($specials as $item) {

        $card_content = str_replace(
            ['{{ image }}', '{{ title }}', '{{ description }}'],
            [
                htmlspecialchars($item['image']),
                htmlspecialchars($item['title']),
                htmlspecialchars($item['description'])
            ],
            $card
        );

        $html_special .= $card_content;
    }


    $content .= $page['content'];
    $content = str_replace('{{ sales }}', $html_sales, $content);
    $content = str_replace('{{ special }}', $html_special, $content);

?>