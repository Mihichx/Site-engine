<? 
    $product_page_more = getPageBySlug($pdo, 'detailed_card_product');
    $found_products = searchALL($pdo, 'products', 'id', $_GET['id']);
    $title = $found_products[0]['name'];
    $products_html = str_replace(
        ['{{ img }}', '{{ id }}', '{{ material }}', '{{ color }}', '{{ height }}', '{{ length }}', '{{ width }}', '{{ weight }}', '{{ price }}', '{{ description }}', '{{ more_description }}', '{{ name }}', '{{ title }}'],
        [   
            htmlspecialchars('/' . $found_products[0]['image']), 
            htmlspecialchars($found_products[0]['id']), 
            htmlspecialchars($found_products[0]['material']), 
            htmlspecialchars($found_products[0]['color']), 
            htmlspecialchars($found_products[0]['height']),
            htmlspecialchars($found_products[0]['length']),
            htmlspecialchars($found_products[0]['width']),
            htmlspecialchars($found_products[0]['weight']),
            htmlspecialchars($found_products[0]['price']),
            htmlspecialchars($found_products[0]['description']),
            htmlspecialchars($found_products[0]['more_description']),
            htmlspecialchars($found_products[0]['name']),
            htmlspecialchars($title)
        ],
        $product_page_more['content']
    );
    $content = "$products_html";
?>