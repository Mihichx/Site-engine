-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 23 2026 г., 07:18
-- Версия сервера: 8.0.30
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `HomeDecor`
--

-- --------------------------------------------------------

--
-- Структура таблицы `category`
--

CREATE TABLE `category` (
  `id` int NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `href` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `category`
--

INSERT INTO `category` (`id`, `name`, `image`, `href`) VALUES
(1, 'ВАЗЫ', 'img/front_catalog1.jpg', 'vases'),
(2, 'СВЕЧИ ВОСКОВЫ', 'img/front_catalog2.jpg', 'wax_candles'),
(3, 'САЛАТНИКИ', 'img/front_catalog3.jpg', 'salad_bowls'),
(4, 'ЗЕРКАЛА', 'img/front_catalog4.jpg', 'mirrors'),
(5, 'КАШПО', 'img/front_catalog5.jpg', 'planters'),
(6, 'ЧАСЫ', 'img/front_catalog6.jpg', 'clocks'),
(7, 'КОМПОЗИЦИИ ИЗ ЦВЕТОВ', 'img/front_catalog7.jpg', 'flower_compositions'),
(8, 'СТАТУЭТКИ', 'img/front_catalog8.jpg', 'figurines'),
(9, 'ШКАТУЛКИ', 'img/front_catalog9.jpg', 'boxes'),
(10, 'ПОДНОСЫ', 'img/front_catalog10.jpg', 'trays'),
(11, 'ТАРЕЛКИ', 'img/front_catalog11.jpg', 'plates'),
(12, 'КОНФЕТНИЦЫ', 'img/front_catalog12.jpg', 'candy_bowls');

-- --------------------------------------------------------

--
-- Структура таблицы `contact_you`
--

CREATE TABLE `contact_you` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `contact_you`
--

INSERT INTO `contact_you` (`id`, `name`, `email`, `number`) VALUES
(2, 'Лиза', 'liza777px@gmail.com', '79120076556'),
(3, 'фывфыв', 'misha777px@gmail.com', 'asdasd');

-- --------------------------------------------------------

--
-- Структура таблицы `feedback`
--

CREATE TABLE `feedback` (
  `id` int NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `feedback`
--

INSERT INTO `feedback` (`id`, `name`, `email`, `text`) VALUES
(2, 'Максим', 'max@gmail.com', 'Предлагаю вам открыться в Москве !');

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_price` int NOT NULL,
  `products_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'process'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `city`, `phone`, `address`, `postal_code`, `notes`, `payment_method`, `total_price`, `products_json`, `created_at`, `status`) VALUES
(18, 6, 'Ижевск', '+79328539301', 'ул. Ленина, дом 4, кв. 20', '49223', '', 'cash', 5790, '[{\"id\":1,\"name\":\"Ваза из прозрачного стекла 15 см\",\"image\":\"img\\/vase1.jpg\",\"price\":810,\"quantity\":1,\"sum\":810},{\"id\":2,\"name\":\"Ваза из прозрачного стекла 11 см\",\"image\":\"img\\/vase2.jpg\",\"price\":1180,\"quantity\":1,\"sum\":1180},{\"id\":3,\"name\":\"Ваза из прозрачного стекла 24 см\",\"image\":\"img\\/vase3.jpg\",\"price\":3800,\"quantity\":1,\"sum\":3800}]', '2026-05-22 17:19:00', 'new'),
(19, 9, 'Ижевск', '+79228729036', 'ул. Удмуртская, дом 22, кв. 2', '48953', 'Быстрее', 'cod', 6836, '[{\"id\":11,\"name\":\"Свеча в стекле «Сакура с клубникой»\",\"image\":\"img\\/candle2.jpg\",\"price\":1230,\"quantity\":1,\"sum\":1230},{\"id\":10,\"name\":\"Свеча «Лавандовый вечер»\",\"image\":\"img\\/candle1.jpg\",\"price\":790,\"quantity\":1,\"sum\":790},{\"id\":12,\"name\":\"Свеча «Снежная сказка»\",\"image\":\"img\\/candle3.jpg\",\"price\":1000,\"quantity\":1,\"sum\":1000},{\"id\":17,\"name\":\"Настольное зеркало «Ажур»\",\"image\":\"img\\/mirror2.jpg\",\"price\":3490,\"quantity\":1,\"sum\":3490}]', '2026-05-22 17:21:11', 'new');

-- --------------------------------------------------------

--
-- Структура таблицы `pages`
--

CREATE TABLE `pages` (
  `id` int NOT NULL,
  `slug` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `header_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `in_menu` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `pages`
--

INSERT INTO `pages` (`id`, `slug`, `title`, `content`, `header_content`, `in_menu`) VALUES
(1, 'index', 'Главная', '<section class=\"hero\">\r\n\r\n        <div class=\"hero-content\">\r\n            <button class=\"hero-arrow hero-prev\" type=\"button\">&#10094;</button>\r\n\r\n            <div class=\"hero-slider\">\r\n                <div class=\"hero-cards\">\r\n\r\n                    <div class=\"hero-card\">\r\n                        <img src=\"/img/banner1.png\" alt=\"Ароматы для дома\">\r\n                        <p>30% на все декоративные подушки и мягкие пледы.</p>\r\n                    </div>\r\n\r\n                    <div class=\"hero-card\">\r\n                        <img src=\"/img/banner2.png\" alt=\"Светильники и гирлянды\">\r\n                        <p>Скидки до 40% на дизайнерские светильники и гирлянды.</p>\r\n                    </div>\r\n\r\n                    <div class=\"hero-card\">\r\n                        <img src=\"/img/banner3.png\" alt=\"Кухонная керамика\">\r\n                        <p>Кухонная керамика и сервировочные доски со скидкой 25%</p>\r\n                    </div>\r\n\r\n                    <div class=\"hero-card\">\r\n                        <img src=\"/img/banner4.png\" alt=\"Вазы и декор\">\r\n                        <p>Новая коллекция ваз и интерьерного декора.</p>\r\n                    </div>\r\n\r\n                    <div class=\"hero-card\">\r\n                        <img src=\"/img/banner5.png\" alt=\"Товары для уюта\">\r\n                        <p>Товары для уюта дома по специальным ценам.</p>\r\n                    </div>\r\n\r\n                </div>\r\n            </div>\r\n\r\n            <button class=\"hero-arrow hero-next\" type=\"button\">&#10095;</button>\r\n        </div>\r\n\r\n        <div class=\"hero-dots center\"></div>\r\n    </div>\r\n</section>\r\n\r\n<section class=\"about\">\r\n    <div class=\"content-container\">\r\n\r\n        <h2 class=\"main-title\">О НАС</h2>\r\n\r\n        <p class=\"about-text\">\r\n            «Декор для дома» — это больше, чем магазин. Мы помогаем наполнять пространство теплом,\r\n            уютом и индивидуальностью. Пледы, свечи, вазы, картины — всё, что делает ваш дом особенным.\r\n        </p>\r\n\r\n        <div class=\"about-cards\">\r\n\r\n            <div class=\"about-card\">\r\n                <h3>Качество</h3>\r\n                <p>Только проверенные бренды и ручная работа мастеров</p>\r\n            </div>\r\n\r\n            <div class=\"about-card\">\r\n                <h3>Доставка</h3>\r\n                <p>По всей России за 3–7 дней, бережная упаковка</p>\r\n            </div>\r\n\r\n            <div class=\"about-card\">\r\n                <h3>Гарантия</h3>\r\n                <p>Возврат в течение 30 дней без лишних вопросов</p>\r\n            </div>\r\n\r\n        </div>\r\n\r\n</section>\r\n\r\n<section class=\"products-section\">\r\n    <div class=\"content-container\">\r\n\r\n        <h2 class=\"main-title black-title\">ДЕШЁВЫЕ ТОВАРЫ</h2>\r\n\r\n        <div class=\"products\">\r\n\r\n            {{ products }}\r\n\r\n        </div>\r\n\r\n    </div>\r\n</section>\r\n\r\n\r\n<section class=\"sale-section\">\r\n    <div class=\"content-container\">\r\n\r\n        <h2 class=\"main-title black-title\">АКЦИИ</h2>\r\n\r\n        <div class=\"sales\">\r\n\r\n            <div class=\"sale-card\">\r\n                <p>Скидка 20% на первый заказ по промокоду QWERTY</p>\r\n            </div>\r\n\r\n        </div>\r\n\r\n    </div>\r\n</section>\r\n\r\n<section class=\"reviews-section\">\r\n    <div class=\"content-container\">\r\n\r\n        <h2 class=\"main-title\">ОТЗЫВЫ</h2>\r\n\r\n        <div class=\"reviews\">\r\n\r\n            {{ reviews }}\r\n\r\n        </div>\r\n\r\n    </div>\r\n</section>\r\n\r\n<section class=\"home-feedback\">\r\n    <div class=\"content-container\">\r\n\r\n        <h2 class=\"main-title black-title\">СВЯЗАТЬСЯ С ВАМИ</h2>\r\n\r\n        <form class=\"home-feedback-form\">\r\n            <input name=\"rev_name2\" type=\"text\" placeholder=\"Имя\">\r\n            <input name=\"rev_email2\" type=\"email\" placeholder=\"E-mail\">\r\n            <input name=\"rev_number\" type=\"text\" placeholder=\"Телефон\">\r\n            <button name=\"contact_you\" type=\"submit\">Отправить</button>\r\n        </form>\r\n\r\n    </div>\r\n</section>', '<h2>Главная</h2>', 0),
(3, 'aboutus', 'О нас', '<div class=\"container-about\">\r\n    <!-- Главный блок -->\r\n    <section class=\"heroo-center\">\r\n        <img src=\"img/about1.jpg\" loading=\"lazy\" alt=\"\">\r\n        <div class=\"hero-text\">\r\n            <p>\r\n            Добро пожаловать в «Дом Деталей» — пространство, где декор перестаёт быть просто дополнением, а становится главным инструментом для создания уюта. Мы созданы для тех, кто верит: дом — это отражение внутреннего мира, и каждая деталь в нём имеет значение.\r\n            </p>\r\n        </div>\r\n    </section>\r\n\r\n    <!-- О компании -->\r\n    <section class=\"about_a\">\r\n        <h2>О КОМПАНИИ</h2>\r\n        <div class=\"about-content\">\r\n            <img src=\"img/about2.jpg\" loading=\"lazy\" alt=\"\">\r\n            <p>\r\n            «Дом Деталей» был основан в 2020 году командой дизайнеров и энтузиастов, уставших от безликих решений для интерьера. Мы начали с небольшой мастерской по созданию авторских светильников и керамики, а сегодня — это уютное онлайн-пространство уникального декора, который объединяет сотни мастеров из разных уголков мира.\r\n            </p>\r\n        </div>\r\n    </section>\r\n\r\n    <!-- Миссия -->\r\n    <section class=\"mission\">\r\n        <p class=\"mission-title\">Наша миссия - вдохновлять людей наполнять свои дома смыслом и эстетикой без компромиссов</p>\r\n        <div class=\"mission-content\">\r\n            <div class=\"mission-text\">\r\n                <p>\r\n                    Мы хотим доказать, что декор не обязан быть дорогим, чтобы быть красивым, и не обязан быть сложным, чтобы быть эффектным. Наша задача сделать процесс создания уютного интерьера простым, понятным и доступным для каждого, независимо от бюджета или стиля жизни.\r\n                </p>\r\n            </div>\r\n            <img src=\"img/about3.jpg\" loading=\"lazy\" alt=\"\">\r\n        </div>\r\n    </section>\r\n\r\n    <!-- Преимущества -->\r\n    <section class=\"advantages\">\r\n        <h2>НАШИ ПРЕИМУЩЕСТВА</h2>\r\n        <div class=\"advantages-grid\">\r\n            <div class=\"advantage\">1. Только уникальные вещи — в нашем ассортименте нет масс-маркета.</div>\r\n            <div class=\"advantage\">3. Честная гарантия — вы можете вернуть или обменять товар в течение 30 дней.</div>\r\n            <div class=\"advantage\">2. Экологичный подход — мы отдаём предпочтение натуральным материалам.</div>\r\n            <div class=\"advantage\">4. Быстрая доставка по всей стране — отправляем заказы в течение 24 часов.</div>\r\n        </div>\r\n    </section>\r\n\r\n    <!-- Контакты -->\r\n    <section class=\"contacts\">\r\n        <h2>КОНТАКТЫ</h2>\r\n        <p>Мы всегда на связи и открыты к диалогу — будь то вопрос по заказу, предложение сотрудничества или просто идея для нового декора.</p>\r\n        <div class=\"contact-info\">\r\n            <p>Телефон: +7 (999) 123-45-67 (ежедневно, с 10:00 до 21:00 по МСК)</p>\r\n            <p>Email: hello@dom-detali.ru — по вопросам заказов и возвратов</p>\r\n            <p>Email для партнёров: partners@dom-detali.ru — для художников, мастеров и брендов</p>\r\n        </div>\r\n    </section>\r\n</div>', '<h2>Вдохновение в каждой детали</h2>', 1),
(4, 'footer', '', '<div class=\"footer center column\">\r\n    <div class=\" center row\">\r\n        <h3>ДЕКОР ДЛЯ <br> ДОМА</h3>\r\n        <img src=\"/img/logo.png\" loading = \"lazy\" alt=\"Логотип\" style=\"max-width: 50px; margin: 20px;\">\r\n    </div>\r\n    <p style=\"opacity: 0.6;\">&copy; {{ year }} Декор для дома. Все права защищены.</p>\r\n    <a href=\"/team\" style=\"margin-top: 20px; text-decoration: none; color: white;\" class=\"hover\">\r\n        Команда разработчиков: <br>\r\n        Бакулев Михаил <br>\r\n        Сухарева Ангелина <br>\r\n        Рагазина Елена\r\n    </a>\r\n    <div class=\"center row\" style=\"margin-top: 20px;\">\r\n        <a target=\"_blank\" class=\"hover\" href=\"https://web.telegram.org/\"><img class=\"margin15\" src=\"/img/telegram.png\" loading = \"lazy\" alt=\"telegram\" style=\"max-width: 40px;\"></a>\r\n        <a target=\"_blank\" class=\"hover\" href=\"https://www.youtube.com/\"><img class=\"margin15\" src=\"/img/youtube.png\" loading = \"lazy\" alt=\"youtube\" style=\"max-width: 40px;\"></a>\r\n        <a target=\"_blank\" class=\"hover\" href=\"https://vk.com/\"><img class=\"margin15\" src=\"/img/vk.png\" loading = \"lazy\" alt=\"vk\" style=\"max-width: 40px;\"></a>\r\n    </div>\r\n</div>', '', 0),
(5, 'catalog', 'Каталог', '<div class=\"category-item\">\r\n    <a href=\"/catalog/{{ href }}\"><img src=\"{{ image }}\" loading=\"lazy\" alt=\"{{ name }}\">{{ name }}</a>\r\n</div>', '<form method=\"POST\" data-no-ajax>\r\n    <div class=\"center\" style=\"-webkit-mask-image: -webkit-radial-gradient(white, black); align-items: center; width: 700px; height: 55px; background: white; border: 2px solid #CFCFCF; border-radius: 25rem; padding: 0 20px; overflow: hidden;\">\r\n        <input type=\"text\" placeholder=\"Поиск по товарам...\" style=\"flex: 1; border: none; outline: none; font-size: 18px; background: transparent; height: 55px;\" name=\"search\">\r\n        <button class=\"hover\" type=\"submit\" style=\"background: none; border: none;\"><img src=\"/img/search.svg\" loading=\"lazy\" alt=\"Поиск\" style=\"width: 30px; cursor: pointer;\"></button>\r\n    </div>\r\n</form>', 1),
(6, 'header', '', '<nav class=\"center row\">\r\n    {{ menu }}\r\n</nav>\r\n<div class=\"header-content center row space-between\">\r\n    <div class=\"margin-left80\" style=\"width: 211px;\">\r\n        <a class=\"hover center row\" href=\"/index\">\r\n            <h3>ДЕКОР ДЛЯ <br> ДОМА</h3>\r\n            <img src=\"/img/logo.png\" alt=\"Логотип\" style=\"max-width: 50px; margin: 20px;\">\r\n        </a>\r\n    </div>\r\n    \r\n    {{ header_content }}\r\n\r\n    <div class=\"center row margin-right80\" style=\"width: 211px;\">\r\n        <a class=\"{{ basket_class }}\" href=\"/basket\">\r\n            <img class=\"margin15\" src=\"{{ basket_img }}\" alt=\"Корзина\" style=\"max-width: 40px;\">\r\n        </a>\r\n        \r\n        <a class=\"{{ profile_class }}\" href=\"/profile\">\r\n            {{ profile }} \r\n        </a>\r\n    </div>\r\n</div>', '', 0),
(9, 'admin', 'Админпанель', '<div class=\'center column\'>\r\n    <h1 class=\'margin15\'>Админ-панель</h1>\r\n    <form class=\'center margin15 column\' method=\'POST\'>\r\n        <input class=\'margin5 admin-input\' type=\'login\' name=\'login\' placeholder=\'Логин\' required>\r\n        <input class=\'margin5 admin-input\' type=\'password\' name=\'password\' placeholder=\'Пароль\' required>\r\n        <button class=\'margin5 admin-button hover\' type=\'submit\' name=\'action\'>Вход</button>\r\n    </form>\r\n</div>', '<nav class=\"center row\">\r\n    {{ menu }}\r\n</nav>\r\n<div class=\"header-content center \">\r\n        <a class=\"hover center row\" href=\"/admin\">\r\n            <h3>АДМИН ДЛЯ <br> ДОМА</h3>\r\n            <img src=\"/img/logo.png\" loading = \"lazy\" alt=\"Логотип\" style=\"max-width: 50px; margin: 20px;\">\r\n        </a>\r\n</div>', 2),
(10, 'reviews', 'Отзывы', '<div class=\"container-reviews\">\r\n    <section class=\"top-text\">\r\n        <p>Делитесь впечатлениями и читайте, что думают другие о магазине «Дом Деталей»!</p>\r\n    </section>\r\n\r\n    <!-- Отзывы -->\r\n    <section class=\"review\">\r\n        {{ reviews }}\r\n    </section>\r\n\r\n    <section class=\"form-section center column\">\r\n        <h2>Оставить свой отзыв</h2>\r\n        <form class=\"review-form center column\">\r\n            <input type=\"text\" name=\"rev_name\" placeholder=\"Имя\" value=\"{{ login }}\" readonly>\r\n            <select name=\"rev_rating\">\r\n                <option value=\"5\">★★★★★</option>\r\n                <option value=\"4\">★★★★</option>\r\n                <option value=\"3\">★★★</option>\r\n                <option value=\"2\">★★</option>\r\n                <option value=\"1\">★</option>\r\n            </select>\r\n            <textarea name=\"rev_text\" placeholder=\"Ваш отзыв\"></textarea>\r\n            <button type=\"submit\" name=\"send_review\">Отправить</button>\r\n        </form>\r\n    </section>\r\n</div>', '<h2>Отзывы наших покупателей</h2>', 1),
(11, 'сontacts', 'Контакты', '<section class=\"contact-info-contact\">\r\n\r\n<div class=\"contact-text\">\r\n    <p>\r\n        Наполните дом уютом в любое удобное время — наш сайт открыт для заказов 24/7.\r\n        Если вам нужна помощь в выборе декора или возникли вопросы по заказу,\r\n        мы всегда связи! Позвоните на горячую линию или напишите на электронную почту.\r\n        Также вы можете оставить заявку через форму обратной связи, и наш менеджер\r\n        перезвонит вам в ближайшее время.\r\n    </p>\r\n</div>\r\n\r\n<div class=\"contact-items\">\r\n\r\n    <div class=\"contact-item\">\r\n        <p>hello@dom-detali.ru</p>\r\n    </div>\r\n\r\n    <div class=\"contact-item\">\r\n        <p>+7 947 485 98 87</p>\r\n    </div>\r\n\r\n    <div class=\"contact-item\">\r\n        <p>+7 947 485 98 87</p>\r\n    </div>\r\n\r\n</div>\r\n\r\n</section>\r\n\r\n\r\n<section class=\"feedback\">\r\n\r\n<h2 class=\"feedback-title\">Обратная связь</h2>\r\n\r\n<form class=\"feedback-form\">\r\n    <input name=\"rev_name1\" type=\"text\" placeholder=\"Ваше имя\">\r\n    <input name=\"rev_email\" type=\"email\" placeholder=\"Ваш email\">\r\n    <textarea name=\"rev_text1\" placeholder=\"Ваше сообщение\"></textarea>\r\n    <button type=\"submit\" name=\"send_feedback\">Отправить</button>\r\n</form>\r\n\r\n</section>\r\n\r\n\r\n<section class=\"location\">\r\n\r\n<div class=\"location-content\">\r\n\r\n    <div class=\"location-text\">\r\n        <h2>Где нас найти:</h2>\r\n\r\n        <p>ул. Пушкинская, 270</p>\r\n        <p>ул. Холмогорова, 11</p>\r\n        <p>ул. Баранова, 55</p>\r\n    </div>\r\n\r\n    <div class=\"location-map\">\r\n        <iframe src=\"https://yandex.ru/map-widget/v1/?um=constructor%3A484fa3e7973acd9e3382ddfbfacd8592c0ea7df9aab1e1cd44dc8a9c4f8bce83&amp;source=constructor\" frameborder=\"0\"></iframe>\r\n    </div>\r\n\r\n</div>\r\n\r\n</section>', '<h2>Свяжитесь с нами!</h2>', 1),
(12, 'stock', 'Акции', '<div class=\"content-container\">\r\n\r\n<section class=\"section\">\r\n    <h2 class=\"section-title\">Скидки</h2>\r\n\r\n    <div class=\"cards\">\r\n        {{ sales }}\r\n    </div>\r\n</section>\r\n\r\n<section class=\"section\">\r\n    <h2 class=\"section-title\">Специальные предложения</h2>\r\n\r\n    <div class=\"cards\">\r\n        {{ special }}\r\n    </div>\r\n</section>\r\n\r\n</div>', '<h2>Найди своё</h2>', 1),
(13, 'basket', 'Корзина', '<div class=\"cart-container\">\r\n    <h1 class=\"cart-title\">Моя корзина</h1>\r\n\r\n    <div class=\"cart-top\">\r\n        <div class=\"coupon\">\r\n            <label for=\"coupon-input\">Введите код купона для скидки:</label>\r\n            <form id=\"promoForm\" class=\"coupon-input-wrap\">\r\n                <input type=\"text\" name=\"promo_code\">\r\n                <button type=\"submit\" name=\"apply_promo\" class=\"coupon-btn\">›</button>\r\n            </form>\r\n        </div>\r\n        <div class=\"total\">\r\n            <p class=\"total-label\">Итого:</p>\r\n            <p id=\"sum\" class=\"total-sum\">{{ final_price }} руб.</p>\r\n        </div>\r\n        <a href=\"/order\" class=\"arrange\">Оформить заказ</a>\r\n    </div>\r\n\r\n    <div class=\"cart-bottom\">\r\n\r\n        <div class=\"cart-bottom-header\">\r\n            <p class=\"items-count\">В корзине {{ value }}</p>\r\n        </div>\r\n\r\n        <!-- товар -->\r\n        {{ product }}\r\n    </div>\r\n</div>', '<h2 class=\"items-count\">В корзине {{ value }}</h2>', 0),
(14, 'profile', 'Личный кабинет', '<section class=\"profile\">\n    <div class=\"center row\">\n        <div class=\"profile-sidebar\">\n            <p class=\"profile-email\">{{ email }}</p>\n            <a href=\"/profile/settings\" class=\"profile-button\">Редактировать профиль</a>\n            <form method=\"POST\">\n                <input type=\"hidden\" name=\"logout\" value=\"1\">\n                <button class=\"logout-button\" type=\"submit\">Выйти</button>\n            </form>\n            <button onclick=\"history.back();\" class=\"logout-button\">Назад</button>\n        </div>\n\n        <div class=\"profile-content\">\n            <h1>{{ login }}</h1>\n            <div class=\"orders\">\n                <h2>История заказов</h2>\n                {{ orders }}\n            </div>\n        </div>\n    </div>\n</section>', '<h2>Ваш личный кабинет</h2>', 0),
(15, 'goods', 'Товары', '', '', 2),
(16, 'reviews1', 'Отзывы', '', '', 2),
(17, 'users', 'Пользователи', '', '', 2),
(18, 'statistics', 'Статистика', '', '', 2),
(21, 'registration', 'Регистрация', '<section class=\"auth-page center\">\r\n    <div class=\"auth-card\">\r\n        <h1>Регистрация</h1>\r\n        <form class=\"auth-form\" method=\"POST\">           \r\n            <div class=\"auth-field\">\r\n                <label>Имя</label>\r\n                <input type=\"text\" name=\"login1\" placeholder=\"Логин\" required>\r\n            </div>\r\n\r\n            <div class=\"auth-field\">\r\n                <label>E-mail</label>\r\n                <input type=\"e-mail\" name=\"e-mail1\" placeholder=\"E-mail\" required>\r\n            </div>\r\n\r\n            <div class=\"auth-field\">\r\n                <label>Пароль</label>\r\n                <input type=\"password\" name=\"password1\" placeholder=\"Пароль\" required>\r\n            </div>\r\n            <div class=\"auth-field\">\r\n                <input type=\"password\" name=\"password_repeat\" placeholder=\"Повторите пароль\" required>\r\n            </div>\r\n\r\n            <button type=\"submit\" class=\"auth-button\" name=\"register_btn\">Зарегистрироваться</button>\r\n            \r\n            <a href=\"/profile\" class=\"auth-link\">Уже есть аккаунт?</a>\r\n        </form>\r\n    </div>\r\n</section>\r\n', '', 0),
(22, 'entrance', 'Вход', '<section class=\"auth-page center\">\r\n    <div class=\"auth-card\">\r\n        <h1>Вход в личный кабинет</h1>\r\n        <form class=\"auth-form\" method=\"POST\">\r\n            <div class=\"auth-field\">\r\n                <label>Логин</label>\r\n                <input type=\"text\" name=\'login\' placeholder=\"Введите логин\" required>\r\n            </div>\r\n\r\n            <div class=\"auth-field\">\r\n                <label>Пароль</label>\r\n                <input type=\"password\" name=\'password\' placeholder=\"Введите пароль\" required>\r\n            </div>\r\n\r\n            <button type=\"submit\" class=\"auth-button\" name=\"entrance\">Войти</button>\r\n        </form>\r\n        <form method=\"POST\" data-no-ajax>\r\n            <input type=\"hidden\" name=\"registration\">\r\n            <button class=\"auth-link hover\" type=\"submit\">Регистрация</button>\r\n        </form>\r\n    </div>\r\n</section>', '', 0),
(23, 'card_product', '', '<div class=\"vase-card\">\r\n    <a href=\"{{ product_url }}\">\r\n        <img src=\"{{ image }}\" loading=\"lazy\" alt=\"Ваза\">\r\n        <div class=\"center column\">\r\n            <p class=\"vase-name\">{{ name }}</p>\r\n            <p class=\"vase-prise\">{{ price }}</p>\r\n        </div>\r\n    </a>\r\n    <div class=\"center column add-button hover\">\r\n        <form method=\"POST\">\r\n            <input name=\"id\" type=\"hidden\" value=\"{{ id }}\"></input>\r\n            <button name=\"addItem\" type=\"submit\">Добавить</button>\r\n        </form>\r\n    </div>\r\n</div>', '', 0),
(24, 'detailed_card_product', '', '<section class=\"product-card\">\n    <div class=\"product-container center column\">\n        <h1 class=\"product-title\">{{ title }}</h1>\n        \n        <div class=\"product-main center row\">\n            <!-- Фото -->\n            <div class=\"product-image\">\n                <img src=\"{{ img }}\" alt=\"Товар\">\n            </div>\n\n            <!-- Характеристики -->\n            <div class=\"product-info margin15\">\n                <ul class=\"specs-list\">\n                    <li><span>номер</span><span>{{ id }}</span></li>\n                    <li><span>материал</span><span>{{ material }}</span></li>\n                    <li><span>цвет</span><span>{{ color }}</span></li>\n                    <li><span>высота, см</span><span>{{ height }}</span></li>\n                    <li><span>длина, см</span><span>{{ length }}</span></li>\n                    <li><span>ширина, см</span><span>{{ width }}</span></li>\n                    <li><span>вес нетто, кг</span><span>{{ weight }}</span></li>\n                </ul>\n            </div>\n        </div>\n\n        <div class=\"center column add-button hover\">\n            <form method=\"POST\">\n                <input name=\"id\" type=\"hidden\" value=\"{{ id }}\"></input>\n                <button name=\"addItem\" type=\"submit\">Добавить</button>\n            </form>\n        </div>\n\n        <div class=\"product-description\">\n            <p>{{ description }}</p>\n            <p>{{ more_description }}</p>\n        </div>\n    </div>\n</section>\n\n', '', 0),
(26, 'settings', 'Настройки профиля', '<section class=\"profile-edit\">\r\n    <div class=\"profile-edit-container\">\r\n        <form class=\"profile-edit-form\" method=\"POST\">    \r\n            <div class=\"profile-edit-row\">\r\n                <div class=\"profile-edit-field\">\r\n                    <label>Имя</label>\r\n                    <input type=\"text\" name=\"login\" value=\"{{ login }}\" required>\r\n                </div>\r\n\r\n                <div class=\"profile-edit-field\">\r\n                    <label>Старый пароль</label>\r\n                    <input type=\"password\" name=\"old_password\" placeholder=\"Введите текущий пароль\" required>\r\n                </div>\r\n            </div>\r\n\r\n            <div class=\"profile-edit-row\">\r\n                <div class=\"profile-edit-field\">\r\n                    <label>Email</label>\r\n                    <input type=\"email\" name=\"email\" value=\"{{ email }}\" required>\r\n                </div>\r\n\r\n                <div class=\"profile-edit-field\">\r\n                    <label>Новый пароль (необязательно)</label>\r\n                    <input type=\"password\" name=\"new_password\" placeholder=\"Введите новый пароль\">\r\n                </div>\r\n            </div>\r\n\r\n            <div class=\"profile-edit-buttons center\">\r\n                <button type=\"submit\" name=\"update_profile\" class=\"save-button\">Сохранить изменения</button>\r\n                <a href=\"/profile\" class=\"cancel-button center\">Отмена</a>\r\n            </div>\r\n        </form>\r\n    </div>\r\n</section>', '<h2>Настройки профиля</h2>', 0),
(27, 'card_product_basket', '', '<div class=\"cart-item\">\r\n    <div class=\"item-image\">\r\n        <img src=\"{{ img }}\" loading=\"lazy\" alt=\"Ваза\">\r\n    </div>\r\n\r\n    <div class=\"item-info\">\r\n        <h3 class=\"item-name\">{{ name }}</h3>\r\n        <p class=\"item-number\">Номер товара:<br>{{ id }}</p>\r\n    </div>\r\n\r\n    <div class=\"item-price\">\r\n        <span class=\"price-one\" data-price=\"{{ price_clean }}\">{{ price }}</span> руб.\r\n        <p class=\"price-label\">цена за 1 шт.</p>\r\n    </div>\r\n\r\n    <div class=\"item-quantity\">\r\n        <button class=\"btn-quantity minus\">−</button>\r\n        <input type=\"text\" value=\"{{ quantity }}\" class=\"quantity-input\" readonly>\r\n        <button class=\"btn-quantity plus\">+</button>\r\n    </div>\r\n\r\n    <div class=\"item-total\">{{ end_price }} руб.</div>\r\n</div>', '', 0),
(28, 'order', 'Оформление', '<div class=\"container-checkout\">\r\n    <h1>Оформление заказа</h1>\r\n\r\n    <form class=\"left-side\" method=\"POST\">\r\n        <div class=\"delivery\">\r\n            <label>Доставка в</label>\r\n            <input type=\"text\" name=\"city\" placeholder=\"Укажите ваш город\" required>\r\n        </div>\r\n\r\n        <div class=\"row-3\">\r\n            <input type=\"text\" name=\"fullname\" placeholder=\"Фамилия и имя\" value=\"{{ name }}\" readonly>\r\n            <input type=\"tel\" name=\"phone\" placeholder=\"Телефон\" required>\r\n            <input type=\"email\" name=\"email\" placeholder=\"E-mail\" value=\"{{ email }}\" readonly>\r\n        </div>\r\n\r\n        <div class=\"row-2\">\r\n            <input type=\"text\" name=\"address\" placeholder=\"Адрес\" required>\r\n            <input type=\"text\" name=\"postal_code\" placeholder=\"Почтовый индекс\" required>\r\n        </div>\r\n\r\n        <textarea name=\"notes\" placeholder=\"Примечания покупателя\"></textarea>\r\n\r\n        <div class=\"payment\">\r\n            <h2>Способы оплаты</h2>\r\n            <div class=\"payment-methods\">\r\n                <button type=\"button\" class=\"payment-card\" data-payment=\"cash\">Оплата наличными при получении</button>\r\n                <button type=\"button\" class=\"payment-card\" data-payment=\"card\">Оплата банковской картой при получении</button>\r\n                <button type=\"button\" class=\"payment-card\" data-payment=\"sberbank\">На карту Сбербанка № 2202 3245 7896 5467</button>\r\n                <button type=\"button\" class=\"payment-card\" data-payment=\"cod\">Наложенный платёж (стоимость увеличивается на 5%)</button>\r\n            </div>\r\n            <!-- Скрытое поле для передачи выбранного метода на сервер -->\r\n            <input type=\"hidden\" name=\"payment_method\" id=\"selectedPayment\" required>\r\n        </div>\r\n\r\n        <div class=\"checkboxes\">\r\n            <div class=\"checkbox-row\">\r\n                <input type=\"checkbox\" id=\"terms\" required>\r\n                <label for=\"terms\">Отметьте флажок, чтобы принять <a href=\"#\">Условия использования</a></label>\r\n            </div>\r\n            <div class=\"checkbox-row\">\r\n                <input type=\"checkbox\" id=\"personal\" required>\r\n                <label for=\"personal\">Я согласен/согласна на обработку своих <a href=\"#\">персональных данных</a> указанным образом</label>\r\n            </div>\r\n        </div>\r\n        \r\n        <div class=\"column\">\r\n            <button type=\"submit\" class=\"btn-order\">Оформить заказ ({{ final_price }} руб.)</button>\r\n            <button onclick=\"history.back();\" class=\"btn-order\">Назад</button>\r\n        </div>\r\n    </form>\r\n</div>', '<h2>Оформление заказа</h2>', 0),
(30, 'card_review', '', '<div class=\"reviews-card\">\r\n    <div class=\"review-content\">\r\n        <div class=\"review-top\">\r\n            <span class=\"stars\">{{ stars }}</span>\r\n            <span class=\"date\">{{ date }}</span>\r\n        </div>\r\n        <h3>{{ name }}</h3>\r\n        <p>«{{ description }}»</p>\r\n    </div>\r\n</div>', '', 0),
(31, 'pages', 'Страницы', '', '', 2),
(32, 'stock1', 'Акции', '', '', 2),
(33, 'order1', 'Заказы', '', '', 2),
(34, 'team', 'Наша команда', '<div class=\"dev-card\">\r\n    <div class=\"dev-header\">\r\n        <h2 class=\"dev-name\">Бакулев Михаил</h2>\r\n        <span class=\"dev-badge\">Full‑stack разработчик</span>\r\n    </div>\r\n    <ul class=\"dev-list\">\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Проектирование макетов</strong> для основных страниц сайта: админка и главная.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Динамическая маршрутизация</strong> на PHP, шаблонизация страниц через базу данных (таблица pages).</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Авторизация и регистрация</strong> с хешированием паролей (password_hash/verify), разграничение ролей (пользователь, модератор, администратор).</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Корзина товаров</strong> на сессиях + AJAX (добавление/удаление, изменение количества, промокоды с динамическим пересчётом).</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Административная панель</strong> с CRUD для товаров, пользователей, отзывов, страниц, акций и заказов; модерация отзывов.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Оформление заказа</strong> с выбором способа оплаты (наценка 5% при наложенном платеже), сохранением в БД и очисткой корзины.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Поиск, сортировка и фильтрация</strong> товаров по категориям, оптимизация БД (индексы на slug, login, name).</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Отзывы с премодерацией</strong>: отправка через AJAX только авторизованными, отображение после одобрения модератором.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Проектирование БД</strong> (таблицы products, users, orders, reviews, pages, stock, contact) и ежедневные коммиты в GitHub.</span>\r\n        </li>\r\n    </ul>\r\n    <div class=\"dev-footer\">\r\n        Стек: Figma, HTML, CSS, JavaScript (AJAX/Fetch), PHP, MySQL • GitHub-репозиторий с ежедневными коммитами\r\n    </div>\r\n</div>\r\n\r\n<div class=\"dev-card\">\r\n    <div class=\"dev-header\">\r\n        <h2 class=\"dev-name\">Сухарева Ангелина</h2>\r\n        <span class=\"dev-badge\">Full-stack разработчик</span>\r\n    </div>\r\n    <ul class=\"dev-list\">\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Проектирование макетов</strong> для основных страниц сайта: профиль, вход, регистрация, контакты, акции, управление профилем</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Разработка модуля вывода акций:</strong> написание PHP-скриптов для динамической подстановки данных вместо маркеров на страницах, загружаемых из БД.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Работа с базой данных:</strong> проектирование структуры таблицы для акций, а также наполнение таблиц товаров и акций информацией.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Верстка пользовательских интерфейсов:</strong> создание HTML/CSS-кода для главной страницы, контактов, форм авторизации, личного кабинета и управления профилем.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Оптимизация CSS:</strong> очистка стилей от дублирующего кода и оптимизация файлов для ускорения загрузки страниц.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Разработка визуальных макетов:</strong> проектирование внешнего вида страниц акций, контактов, форм авторизации, личного кабинета и разделов управления профилем.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Тестирование и отладка:</strong> проверка корректности отображения верстки в браузерах и исправление ошибок.</span>\r\n        </li>\r\n    </ul>\r\n    <div class=\"dev-footer\">\r\n        Стек: Figma, HTML, CSS, PHP, MySQL.\r\n    </div>\r\n</div>\r\n\r\n<div class=\"dev-card\">\r\n    <div class=\"dev-header\">\r\n        <h2 class=\"dev-name\">Рагазина Елена</h2>\r\n        <span class=\"dev-badge\">Full‑stack разработчик</span>\r\n    </div>\r\n    <ul class=\"dev-list\">\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Проектирование макетов</strong> для основных страниц сайта: каталог, категории товаров, детальная страница товара, отзывы, «О нас», корзина и оформление заказа.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>HTML- и CSS-вёрстка</strong> страниц каталога, категорий, отзывов, страницы «О нас», корзины и оформления заказа с учётом общей стилистики интернет-магазина.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Слайдер на главной странице:</strong>Слайдер на главной странице: добавление интерактивного блока с акционными предложениями, стрелками переключения, точками-индикаторами и автоматической прокруткой.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Наполнение базы данных:</strong> добавление товаров в таблицу products, указание названий, цен, изображений, категорий и детальной информации о товарах.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>История заказов:</strong> реализация вывода заказов в личном кабинете пользователя с отображением номера заказа, даты, суммы, статуса, способа оплаты и списка товаров.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Корзина и оформление заказа:</strong> разработка структуры страницы корзины, блока с товарами, итоговой стоимостью, формой доставки, контактными данными и выбором способа оплаты.</span>\r\n        </li>\r\n        <li class=\"dev-list-item\">\r\n            <span><strong>Работа с шаблонами и базой данных:</strong> использование HTML-шаблонов страниц и подстановка данных из БД для динамического отображения товаров и заказов.</span>\r\n        </li>\r\n    </ul>\r\n    <div class=\"dev-footer\">\r\n        Стек: Figma, HTML, CSS, JavaScript, PHP, MySQL • GitHub-репозиторий с ежедневными коммитами\r\n    </div>\r\n</div>', '<h2>Мы крутые !</h2>', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `category_id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` int NOT NULL,
  `image` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `more_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `material` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `height` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `length` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `width` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `weight` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image`, `description`, `more_description`, `material`, `color`, `height`, `length`, `width`, `weight`) VALUES
(1, 1, 'Ваза стеклянная «Капля росы»', 810, 'img/vase1.jpg', 'Элегантная ваза из прозрачного стекла для цветов.', 'Идеально подходит для небольших букетов. Легко моется, устойчива к перепадам температур.', 'стекло', 'прозрачный', '15', '7', '7', '200'),
(2, 1, 'Ваза стеклянная «Ледяной лепесток»', 1180, 'img/vase2.jpg', 'Миниатюрная ваза из прозрачного стекла.', 'Подходит для одного-двух цветов. Компактная, не занимает много места.', 'стекло', 'прозрачный', '11', '5', '5', '0.15'),
(3, 1, 'Ваза стеклянная «Гранёный свет»', 3800, 'img/vase3.jpg', 'Большая ваза из прозрачного стекла.', 'Идеально для крупных композиций. Устойчивое основание предотвращает опрокидывание.', 'стекло', 'прозрачный', '24', '12', '12', '0.8'),
(4, 1, 'Ваза из керамики «Керамическая сага»', 1240, 'img/vase4.jpg', 'Стильная керамическая ваза для цветов.', 'Матовая поверхность, устойчива к царапинам. Отлично подойдёт для сухоцветов или живых цветов. Добавит уюта в гостиную или спальню.', 'керамика', 'бежевый', '22', '10', '10', '0.7'),
(5, 1, 'Ваза из керамики «Песочный бриз»', 1000, 'img/vase5.jpg', 'Керамическая ваза среднего размера для декора.', 'Глянцевая поверхность, легко очищается. Компактный размер позволяет разместить вазу на тумбочке или комоде. Доступная альтернатива стеклянным вазам.', 'керамика', 'белый с го', '19', '9', '9', '0.65'),
(6, 1, 'Ваза из керамики «Глиняная капля»', 2400, 'img/vase6.jpg', 'Элегантная керамическая ваза маленького размера.', 'Ручная роспись, уникальный дизайн. Подходит для одного цветка или декоративной композиции. Станет изюминкой вашего интерьера.', 'керамика', 'кремовый с', '15', '7', '7', '0.5'),
(7, 1, 'Ваза из керамики «Песчаный берег»', 750, 'img/vase7.jpg', 'Практичная керамическая ваза для домашних цветов.', 'Простая форма, нейтральный цвет. Отлично подойдёт для кактусов или суккулентов. Лёгкая и прочная.', 'керамика', 'серый', '23', '11', '11', '0.75'),
(8, 1, 'Ваза «Керамическая симфония»', 7500, 'img/vase8.jpg', 'Роскошная керамическая ваза для композиций.', 'Ручная работа, сложный орнамент. Идеально для больших букетов. Премиальный сегмент — для ценителей искусства.', 'керамика', 'терракотов', '30', '15', '15', '3'),
(9, 1, 'Ваза из керамики «Тёплый оттенок»', 1200, 'img/vase9.jpg', 'Керамическая ваза с рельефным узором.', 'Среднеразмерная ваза для домашних цветов. Рельефный орнамент придаёт изделию особый шарм. Отлично впишется в классический интерьер.', 'керамика', 'кремовый', '26', '12', '12', '0.9'),
(10, 2, 'Свеча «Лавандовый вечер»', 790, 'img/candle1.jpg', 'Ароматическая свеча с нежным лавандовым ароматом.', 'Создаёт расслабляющую атмосферу. Время горения — до 30 часов. Идеальный подарок для близких. Безопасный фитиль, без копоти.', 'воск', 'лавандовый', '10', '7', '7', '0.2'),
(11, 2, 'Свеча в стекле «Сакура с клубникой»', 1230, 'img/candle2.jpg', 'Ароматическая свеча в стеклянном стакане.', 'Изящный дизайн, долгий срок горения. Подходит для романтического вечера. Стеклянный стакан можно использовать повторно.', 'воск, стек', 'розовый', '12', '6', '6', '0.3'),
(12, 2, 'Свеча «Снежная сказка»', 1000, 'img/candle3.jpg', 'Зимняя ароматическая свеча с морозным ароматом.', 'Создаёт атмосферу зимнего уюта. Время горения — 40 часов. Стильный дизайн для праздничного декора.', 'воск', 'белый', '11', '8', '8', '0.25'),
(13, 3, 'Салатница «Цветочный вальс»', 1390, 'img/bowl1.jpg', 'Керамическая салатница с цветочным орнаментом.', 'Объёмная, подходит для больших салатов. Легко моется, устойчива к сколам. Украсит любой праздничный стол.', 'фарфор', 'пастельные', '15', '20', '20', '0.85'),
(14, 3, 'Фиолетовая рифлёная салатница', 1250, 'img/bowl2.jpg', 'Стильная салатница с рифлёными краями.', 'Объём — 1.5 литра. Фиолетовый цвет добавит яркости в сервировку. Подходит для подачи фруктов или закусок.', 'керамика', 'фиолетовый', '14', '22', '22', '0.78'),
(15, 3, 'Голубая салатница «Небесный узор»', 1670, 'img/bowl3.jpg', 'Элегантная салатница с небесным орнаментом.', 'Объёмная, с устойчивым основанием. Голубая гамма создаёт ощущение свежести. Идеальна для праздничных застолий.', 'фарфор', 'голубой с ', '16', '25', '25', '1'),
(16, 4, 'Настенное зеркало «Винтаж»', 8970, 'img/mirror1.jpg', 'Настенное зеркало в деревянной раме с патиной.', 'Винтажная рама с резьбой, размер — 70x50 см. Добавит шарма в гостиную или спальню. Устойчивое крепление в комплекте.', 'дерево, ст', 'коричневый', '70', '50', '0.5', '3.5'),
(17, 4, 'Настольное зеркало «Ажур»', 3490, 'img/mirror2.jpg', 'Изящное настольное зеркало с ажурным обрамлением.', 'Лёгкая конструкция, размер — 30x20 см. Идеально для туалетного столика. Ажурный узор придаёт изделию утончённость.', 'металл, ст', 'серебристы', '30', '20', '0.5', '0.8'),
(18, 4, 'Настенное зеркало «Великолепие»', 14000, 'img/mirror3.jpg', 'Роскошное настенное зеркало в массивной раме.', 'Размер — 100x80 см, рама из кованого металла. Премиальный сегмент — для просторных помещений. Добавит роскоши в интерьер.', 'кованый ме', 'золотистый', '100', '80', '0.5', '15'),
(19, 5, 'Кашпо «Эклипс»', 1240, 'img/kashpo1.jpg', 'Стильное кашпо для растений в тёмных тонах.', 'Материал — керамика, устойчива к влаге. С дренажным отверстием. Подходит для небольших растений. Легко очищается.', 'керамика', 'чёрный', '12', '15', '15', '0.5'),
(20, 5, 'Кашпо «Лунный срез»', 2100, 'img/kashpo2.jpg', 'Кашпо с оригинальным дизайном.', 'Материал — глазурованная керамика. Диаметр — 20 см, высота — 15 см. С дренажным отверстием. Подходит для суккулентов и кактусов. Дизайн придаёт интерьеру уникальность.', 'глазурован', 'серо-голуб', '15', '20', '20', '0.8'),
(21, 5, 'Кашпо «Чистый цилиндр»', 1720, 'img/kashpo3.jpg', 'Стильное кашпо в форме цилиндра.', 'Лёгкое и практичное решение для озеленения интерьера. Подходит для небольших растений. Можно использовать внутри и снаружи помещения.', 'пластик', 'белый', '18', '12', '12', '0.3'),
(22, 6, 'Настенные часы «Утренняя роза»', 4520, 'img/clock1.jpg', 'Настенные часы с цветочным орнаментом.', 'Украшены росписью. Идеально для гостиной или спальни. Придадут интерьеру лёгкость и романтичность.', 'дерево, ст', 'пастельные', '35', '35', '0.5', '1.2'),
(23, 6, 'Настольные часы «Шёпот сада»', 3210, 'img/clock2.jpg', 'Элегантные настольные часы.', 'Механический механизм, требует завода раз в неделю. Компактны, подойдут для рабочего стола или прикроватной тумбочки.', 'дерево', 'бежевый с ', '15', '10', '0.5', '0.6'),
(24, 6, 'Настенные часы «Вечная классика»', 3700, 'img/clock3.jpg', 'Классические настенные часы с римскими цифрами.', 'Универсальный дизайн, подойдёт для любого интерьера. Тихий ход, надёжность.', 'металл, ст', 'чёрный с з', '40', '40', '0.5', '1.5'),
(25, 7, 'Цветочная композиция «Весна»', 2300, 'img/flower1.jpg', 'Искусственная композиция из тюльпанов и ландышей.', 'Идеально для украшения гостиной. Не требует ухода. Придаёт интерьеру свежесть и весеннее настроение. Легко размещается на полке или столе.', 'искусствен', 'пастельные', '30', '25', '25', '0.4'),
(26, 7, 'Цветочная композиция «Нежность»', 1200, 'img/flower2.jpg', 'Миниатюрная композиция из искусственных ромашек.', 'Подходит для рабочего стола. Устойчивая основа. Добавит уюта и лёгкости в рабочий интерьер. Не требует ухода.', 'искусствен', 'белый, кре', '15', '10', '10', '0.2'),
(27, 7, 'Цветочная композиция «Свежесть»', 4260, 'img/flower3.jpg', 'Элегантная композиция из искусственного эвкалипта.', 'Придаёт интерьеру свежесть и уют. Премиальный сегмент для просторных помещений. Отлично подойдёт для холла или гостиной.', 'искусствен', 'зелёный, с', '45', '35', '35', '0.6'),
(28, 8, 'Статуэтка «Пушистый страж»', 1500, 'img/statuette1.jpg', 'Милая статуэтка в виде пушистого зверька.', 'Идеально для полки или рабочего стола. Добавит уюта и игривости в интерьер. Легко очищается мягкой тканью.', 'полистоун', 'бежевый', '10', '8', '8', '0.3'),
(29, 8, 'Статуэтка «Кроличий секрет»', 2120, 'img/statuette2.jpg', 'Забавная статуэтка кролика.', 'Премиальный сегмент — для украшения гостиной или кабинета. Материал устойчив к царапинам. Дизайн вызывает улыбку.', 'фарфор', 'белый', '12', '9', '7', '0.4'),
(30, 8, 'Статуэтка «Нежность небес»', 2940, 'img/statuette3.jpg', 'Статуэтка ангела с расправленными крыльями.', 'Подходит для спальни или гостиной. Придаёт интерьеру лёгкость и воздушность. Можно использовать как элемент религиозного декора.', 'керамика', 'белый', '15', '10', '10', '0.6'),
(31, 9, 'Шкатулка «Розовое вдохновение»', 2310, 'img/box1.jpg', 'Шкатулка для украшений в нежно-розовых тонах.', 'Компактный размер, идеально подходит для хранения бижутерии или мелких аксессуаров. Крышка украшена цветочным орнаментом.', 'дерево, ла', 'розовый', '8', '10', '5', '0.3'),
(32, 9, 'Шкатулка «Сердце в золоте»', 3020, 'img/box2.jpg', 'Роскошная шкатулка с инкрустацией.', 'Премиальный сегмент — для хранения ценных украшений. Размер позволяет разместить серьги, кольца и браслеты. Крышка фиксируется магнитом.', 'дерево, ла', 'коричневый', '10', '12', '7', '0.5'),
(33, 9, 'Шкатулка «Голубая роза»', 2970, 'img/box3.jpg', 'Изящная шкатулка с рисунком голубой розы.', 'Средний размер, подходит для хранения как украшений, так и мелких канцелярских принадлежностей. Материал устойчив к царапинам. Дизайн в стиле прованс.', 'МДФ, лак', 'голубой', '9', '11', '6', '0.4'),
(34, 10, 'Поднос «Элегантный порядок»', 3590, 'img/tray1.jpg', 'Прямоугольный поднос с приподнятыми краями.', 'Идеально для подачи десертов или закусок. Размер позволяет разместить несколько пирожных или фруктов. Материал не впитывает запахи.', 'керамика', 'белый', '30', '20', '2', '1.2'),
(35, 10, 'Поднос «Нежная симфония»', 4100, 'img/tray2.jpg', 'Круглый поднос с цветочным узором по краю.', 'Премиальный сегмент — для сервировки чая или кофе. Узор выполнен вручную. Подходит для использования в микроволновой печи.', 'фарфор', 'пастельные', '25', '25', '3', '1.5'),
(36, 10, 'Поднос «Золотая симметрия»', 3810, 'img/tray3.jpg', 'Квадратный поднос с геометрическим золотым узором.', 'Современный дизайн, подойдёт для сервировки или как элемент декора. Края обработаны аккуратно, не царапают поверхность стола.', 'металл, эм', 'чёрный', '28', '28', '2', '1'),
(37, 11, 'Тарелка «Нежная мелодия»', 1990, 'img/plate1.jpg', 'Керамическая тарелка с цветочным орнаментом.', 'Подходит для подачи десертов или лёгких закусок. Орнамент не стирается при мытье. Можно использовать в посудомоечной машине.', 'керамика', 'белый', '20', '20', '2', '0.5'),
(38, 11, 'Тарелка «Цветочный венок»', 2340, 'img/plate2.jpg', 'Декоративная тарелка с объёмным цветочным венком.', 'Премиальный сегмент — может использоваться как элемент декора или для сервировки. Венок выполнен с высокой детализацией.', 'фарфор', 'белый', '22', '22', '3', '0.8'),
(39, 11, 'Тарелка «Голубая мечта»', 2160, 'img/plate3.jpg', 'Тарелка с градиентом от голубого к белому.', 'Современный дизайн, подойдёт для подачи завтрака или лёгких блюд. Градиент придаёт изделию лёгкость и воздушность.', 'стекло', 'голубой гр', '21', '21', '2', '0.6'),
(40, 12, 'Конфетница «Золотой сад»', 20170, 'img/bonbonniere1.jpg', 'Роскошная конфетница с позолоченными элементами.', 'Премиальный сегмент — для сервировки сладостей на торжественных мероприятиях. Объём позволяет разместить большое количество конфет.', 'фарфор, по', 'белый', '25', '30', '15', '3'),
(41, 12, 'Конфетница «Триумф золота»', 18200, 'img/bonbonniere2.jpg', 'Элегантная конфетница с золотыми вставками.', 'Подходит для сервировки конфет, орехов или сухофруктов. Узор выполнен с высокой точностью. Устойчивая основа предотвращает опрокидывание.', 'фарфор', 'белый', '24', '28', '14', '2.8'),
(42, 12, 'Конфетница «Венок природы»', 17140, 'img/bonbonniere3.jpg', 'Конфетница с рельефным венком из листьев.', 'Универсальный дизайн — подойдёт как для сервировки, так и для декора. Рельеф придаёт изделию текстуру и объём.', 'керамика', 'кремовый', '23', '27', '13', '2.5'),
(43, 2, 'Свеча «Карамельный латте»', 890, 'img/candle4.jpg', 'Ароматическая свеча с теплым кофейно-карамельным ароматом.', 'Создаёт уютную атмосферу и наполняет помещение мягким сладким ароматом. Отлично подходит для осеннего и зимнего декора.', 'воск', 'бежевый', '10', '7', '7', '0.22'),
(44, 2, 'Свеча в банке «Морской бриз»', 1150, 'img/candle5.jpg', 'Освежающая ароматическая свеча с морскими нотами.', 'Стильная свеча в стеклянной банке с длительным временем горения. Идеально подходит для ванной комнаты и зоны отдыха.', 'воск', 'голубой', '11', '8', '8', '0.28'),
(45, 2, 'Свеча «Шоколадный десерт»', 970, 'img/candle6.jpg', 'Ароматическая свеча с насыщенным шоколадным ароматом.', 'Создаёт атмосферу тепла и комфорта. Подходит для подарка и украшения интерьера.', 'воск', 'коричневый', '9', '7', '7', '0.21'),
(46, 3, 'Хрустальная салатница «Империал»', 2100, 'img/bowl4.jpg', 'Классическая хрустальная чаша с резными гранями.', 'Идеально преломляет свет, создавая праздничную атмосферу за столом.', 'хрусталь', 'прозрачный', '12', '22', '22', '1.2'),
(47, 3, 'Деревянная салатница «Эко»', 1450, 'img/bowl5.jpg', 'Салатница из натурального дуба ручной работы.', 'Покрыта безопасным маслом. Не использовать в микроволновке.', 'дерево', 'коричневый', '10', '24', '24', '0.6'),
(48, 3, 'Салатница «Черный мрамор»', 1850, 'img/bowl6.jpg', 'Стильная пиала из прочного матового стекла.', 'Трендовая текстура камня подойдет для современной кухни.', 'стекло', 'черный', '11', '21', '21', '0.85');

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `id` int NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rating` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `reviews`
--

INSERT INTO `reviews` (`id`, `name`, `rating`, `text`, `status`, `date`) VALUES
(27, 'Анна', '5', 'Заказывала вазу и свечи — всё пришло целым, упаковано с любовью. Даже бонусный магнитик положили! Теперь только к вам.', 1, '2026-05-19 15:08:55'),
(28, 'Екатерина', '5', 'Отличный магазин! Быстрая доставка в Ижевск за 4 дня. Плед купила — очень мягкий, как на фото. Спасибо!', 1, '2026-05-19 15:09:22'),
(29, 'Дмитрий', '4', 'Хороший выбор декора, цены приятные. Единственное — свеча пахла не так ярко, как ожидала. Но в целом довольна.', 1, '2026-05-19 15:09:45'),
(33, 'Михаил', '5', 'Быстрое оформление, мне понравилось', 1, '2026-05-22 17:19:25'),
(34, 'Миш', '1', 'Долгая заставка ****', 0, '2026-05-22 17:22:07');

-- --------------------------------------------------------

--
-- Структура таблицы `stock`
--

CREATE TABLE `stock` (
  `id` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `stock`
--

INSERT INTO `stock` (`id`, `title`, `description`, `image`, `type`) VALUES
(4, 'Уют в деталях', '-30% на все декоративные подушки и мягкие пледы.', 'pillow.png', 'sales'),
(5, 'Магия света', 'Скидки до 40% на дизайнерские светильники и гирлянды.', 'lamp.png', 'sales'),
(6, 'Эстетика завтраков', 'Кухонная керамика и сервировочные доски со скидкой 25%', 'kitchen.png', 'sales'),
(7, 'Ароматный дом', '-20% на диффузоры, соевые свечи и благовония.', 'aroma.png', 'sales'),
(8, 'Порядок со вкусом', 'Скидка на стильные корзины и системы хранения.', 'storage.png', 'sales'),
(9, 'Финальный сейл', 'До -50% на товары из коллекции прошлого сезона.', 'sale.png', 'sales'),
(10, 'Сет для ванной', 'При покупке дозатора и мыльницы — стакан для щеток в подарок.', 'bath.png', 'special'),
(11, 'Добро пожаловать', 'Скидка 10% на ваш первый заказ при подписке на новости.', 'welcome.png', 'special'),
(12, 'Готовое решение', 'Соберите сет из 3-х постеров и получите рамки бесплатно.', 'posters.png', 'special'),
(13, 'Бесплатная доставка', 'Привезем ваш декор бережно и бесплатно при заказе от 5 000 руб.', 'delivery.png', 'special'),
(14, 'Дарите красиво', 'При покупке любого декора — праздничная упаковка в подарок.', 'gift.png', 'special'),
(15, 'Закрытый клуб', 'Специальные цены только для участников программы лояльности.', 'club.png', 'special');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `login` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date_regist` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `email`, `password`, `role`, `date_regist`) VALUES
(6, 'Михаил', 'misha777px@gmail.com', '$2y$10$IVqvGoLq5DlNMs1gfYfpI.eRa2xTPrXrHmJkU2JGanvH1ZR/FX4Wu', 'admin', '2026-05-07'),
(8, 'Миша', 'misha7277px@gmail.com', '$2y$10$wiKMoz0dzklb0iZPZw.vZOEm38CbBDUUyb9AM79qfywPlcJWlBgUW', 'moderator', '2026-05-07'),
(9, 'Миш', '', '$2y$10$pdwKm/mno1UGxU63NZD/SeLeZNkd.DAiPPVIVOZHFTPJlrITsmGOO', 'user', '2026-05-07'),
(22, 'Анна', 'anna@gmail.com', '$2y$10$qN0NY.s0BR5uZzpJn9SgiegnIGmXtiaJoBNiD83NmETdhL/B6Jara', 'user', '2026-05-19'),
(23, 'Екатерина', 'ekaterina@gmail.com', '$2y$10$RQYTq.Eh7iQJKYtfCuefnuKanHJnCAnI1RO3oWXU.bUAmyDOmezdC', 'user', '2026-05-19'),
(24, 'Дмитрий', 'dmitri@gmail.com', '$2y$10$D48gRN4v1.cqvfJO0SnqAOkw0BCU99PQLQWr6AICgQndQ2kQAKKqK', 'user', '2026-05-19'),
(25, 'Ангелина', 'suharevaangelina4@gmail.com', '$2y$10$K5iYyIVaXY5flYGMsG9Sf.9tPw1ZdnONgx3pcuB.DbrhPicl/fjpy', 'admin', '2026-05-19');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `contact_you`
--
ALTER TABLE `contact_you`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `slug_2` (`slug`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `name_2` (`name`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `login` (`login`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `contact_you`
--
ALTER TABLE `contact_you`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT для таблицы `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
