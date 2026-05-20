-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 20 2026 г., 16:22
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
  `name` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'index', 'Главная', '<section class=\"hero\">\n    <div class=\"content-container\">\n\n        <div class=\"hero-content\">\n            <button class=\"hero-arrow hero-prev\" type=\"button\">&#10094;</button>\n\n            <div class=\"hero-slider\">\n                <div class=\"hero-cards\">\n\n                    <div class=\"hero-card\">\n                        <img src=\"/img/aroma.png\" alt=\"Ароматы для дома\">\n                        <p>30% на все декоративные подушки и мягкие пледы.</p>\n                    </div>\n\n                    <div class=\"hero-card\">\n                        <img src=\"/img/banner2.png\" alt=\"Светильники и гирлянды\">\n                        <p>Скидки до 40% на дизайнерские светильники и гирлянды.</p>\n                    </div>\n\n                    <div class=\"hero-card\">\n                        <img src=\"/img/banner3.png\" alt=\"Кухонная керамика\">\n                        <p>Кухонная керамика и сервировочные доски со скидкой 25%</p>\n                    </div>\n\n                    <div class=\"hero-card\">\n                        <img src=\"/img/banner4.png\" alt=\"Вазы и декор\">\n                        <p>Новая коллекция ваз и интерьерного декора.</p>\n                    </div>\n\n                    <div class=\"hero-card\">\n                        <img src=\"/img/banner5.png\" alt=\"Товары для уюта\">\n                        <p>Товары для уюта дома по специальным ценам.</p>\n                    </div>\n\n                </div>\n            </div>\n\n            <button class=\"hero-arrow hero-next\" type=\"button\">&#10095;</button>\n        </div>\n\n        <div class=\"hero-dots center\"></div>\n\n    </div>\n</section>\n\n<section class=\"about\">\n    <div class=\"content-container\">\n\n        <h2 class=\"main-title\">О НАС</h2>\n\n        <p class=\"about-text\">\n            «Декор для дома» — это больше, чем магазин. Мы помогаем наполнять пространство теплом,\n            уютом и индивидуальностью. Пледы, свечи, вазы, картины — всё, что делает ваш дом особенным.\n        </p>\n\n        <div class=\"about-cards\">\n\n            <div class=\"about-card\">\n                <h3>Качество</h3>\n                <p>Только проверенные бренды и ручная работа мастеров</p>\n            </div>\n\n            <div class=\"about-card\">\n                <h3>Доставка</h3>\n                <p>По всей России за 3–7 дней, бережная упаковка</p>\n            </div>\n\n            <div class=\"about-card\">\n                <h3>Гарантия</h3>\n                <p>Возврат в течение 30 дней без лишних вопросов</p>\n            </div>\n\n        </div>\n\n    </div>\n</section>\n\n<section class=\"products-section\">\n    <div class=\"content-container\">\n\n        <h2 class=\"main-title black-title\">ПОПУЛЯРНЫЕ ТОВАРЫ</h2>\n\n        <div class=\"products\">\n\n            <div class=\"product-card\">\n                <img src=\"./img/aroma.png\" alt=\"\">\n                <div class=\"product-info\">\n                    <h3>Плед <br> «Шерстяной уют»</h3>\n                    <p>2 394 ₽</p>\n                    <button>Добавить</button>\n                </div>\n            </div>\n\n            <div class=\"product-card\">\n                <img src=\"./img/product2.png\" alt=\"\">\n                <div class=\"product-info\">\n                    <h3>Ароматическая свеча «Лаванда»</h3>\n                    <p>890 ₽</p>\n                    <button>Добавить</button>\n                </div>\n            </div>\n\n            <div class=\"product-card\">\n                <img src=\"./img/product3.png\" alt=\"\">\n                <div class=\"product-info\">\n                    <h3>Орхидея <br> «Фаленопсис»</h3>\n                    <p>4 200 ₽</p>\n                    <button>Добавить</button>\n                </div>\n            </div>\n\n            <div class=\"product-card\">\n                <img src=\"./img/product4.png\" alt=\"\">\n                <div class=\"product-info\">\n                    <h3>Керамическая ваза «Минимал»</h3>\n                    <p>1 290 ₽</p>\n                    <button>Добавить</button>\n                </div>\n            </div>\n\n            <div class=\"product-card\">\n                <img src=\"./img/product5.png\" alt=\"\">\n                <div class=\"product-info\">\n                    <h3>Картина-модуль <br> «Горы»</h3>\n                    <p>3 490 ₽</p>\n                    <button>Добавить</button>\n                </div>\n            </div>\n\n            <div class=\"product-card\">\n                <img src=\"./img/product6.png\" alt=\"\">\n                <div class=\"product-info\">\n                    <h3>Диванная подушка <br> «Лён»</h3>\n                    <p>1 190 ₽</p>\n                    <button>Добавить</button>\n                </div>\n            </div>\n\n        </div>\n\n    </div>\n</section>\n\n\n<section class=\"sale-section\">\n    <div class=\"content-container\">\n\n        <h2 class=\"main-title black-title\">АКЦИИ</h2>\n\n        <div class=\"sales\">\n\n            <div class=\"sale-card\">\n                <p>Скидка 20% на первый заказ по промокоду WELCOME</p>\n            </div>\n\n            <div class=\"sale-card\">\n                <p>Бесплатная доставка от 3 000 ₽</p>\n            </div>\n\n        </div>\n\n    </div>\n</section>\n\n<section class=\"reviews-section\">\n    <div class=\"content-container\">\n\n        <h2 class=\"main-title\">ОТЗЫВЫ</h2>\n\n        <div class=\"reviews\">\n\n            <div class=\"review-card\">\n                <span>★★★★★</span>\n                <h3>Анна С.</h3>\n                <p>\n                    Заказывала вазу и свечи — всё пришло целым, упаковано с любовью.\n                    Даже бонусный пакетик положили! Теперь только у вас ♥\n                </p>\n            </div>\n\n            <div class=\"review-card\">\n                <span>★★★★★</span>\n                <h3>Екатерина К.</h3>\n                <p>\n                    «Отличный магазин! Быстрая доставка и плед за 4 дня.\n                    Плед купила — очень мягкий, сын не смог с ним расстаться»\n                </p>\n            </div>\n\n            <div class=\"review-card\">\n                <span>★★★★☆</span>\n                <h3>Дмитрий В.</h3>\n                <p>\n                    «Хороший выбор декора, цены приятные.\n                    Единственное — свеча пахла не так ярко, как ожидал.\n                    Но в целом доволен.»\n                </p>\n            </div>\n\n        </div>\n\n    </div>\n</section>\n\n<section class=\"home-feedback\">\n    <div class=\"content-container\">\n\n        <h2 class=\"main-title black-title\">СВЯЗАТЬСЯ С ВАМИ</h2>\n\n        <form class=\"home-feedback-form\">\n            <input name=\"rev_name2\" type=\"text\" placeholder=\"Имя\">\n            <input name=\"rev_email2\" type=\"email\" placeholder=\"E-mail\">\n            <input name=\"rev_number\" type=\"text\" placeholder=\"Телефон\">\n            <button name=\"contact_you\" type=\"submit\">Отправить</button>\n        </form>\n\n    </div>\n</section>', '<h2>Главная</h2>', 0),
(3, 'aboutus', 'О нас', '<div class=\"container-about\">\r\n    <!-- Главный блок -->\r\n    <section class=\"heroo-center\">\r\n        <img src=\"img/about1.jpg\" loading=\"lazy\" alt=\"\">\r\n        <div class=\"hero-text\">\r\n            <p>\r\n            Добро пожаловать в «Дом Деталей» — пространство, где декор перестаёт быть просто дополнением, а становится главным инструментом для создания уюта. Мы созданы для тех, кто верит: дом — это отражение внутреннего мира, и каждая деталь в нём имеет значение.\r\n            </p>\r\n        </div>\r\n    </section>\r\n\r\n    <!-- О компании -->\r\n    <section class=\"about_a\">\r\n        <h2>О КОМПАНИИ</h2>\r\n        <div class=\"about-content\">\r\n            <img src=\"img/about2.jpg\" loading=\"lazy\" alt=\"\">\r\n            <p>\r\n            «Дом Деталей» был основан в 2020 году командой дизайнеров и энтузиастов, уставших от безликих решений для интерьера. Мы начали с небольшой мастерской по созданию авторских светильников и керамики, а сегодня — это уютное онлайн-пространство уникального декора, который объединяет сотни мастеров из разных уголков мира.\r\n            </p>\r\n        </div>\r\n    </section>\r\n\r\n    <!-- Миссия -->\r\n    <section class=\"mission\">\r\n        <p class=\"mission-title\">Наша миссия - вдохновлять людей наполнять свои дома смыслом и эстетикой без компромиссов</p>\r\n        <div class=\"mission-content\">\r\n            <div class=\"mission-text\">\r\n                <p>\r\n                    Мы хотим доказать, что декор не обязан быть дорогим, чтобы быть красивым, и не обязан быть сложным, чтобы быть эффектным. Наша задача сделать процесс создания уютного интерьера простым, понятным и доступным для каждого, независимо от бюджета или стиля жизни.\r\n                </p>\r\n            </div>\r\n            <img src=\"img/about3.jpg\" loading=\"lazy\" alt=\"\">\r\n        </div>\r\n    </section>\r\n\r\n    <!-- Преимущества -->\r\n    <section class=\"advantages\">\r\n        <h2>НАШИ ПРЕИМУЩЕСТВА</h2>\r\n        <div class=\"advantages-grid\">\r\n            <div class=\"advantage\">1. Только уникальные вещи — в нашем ассортименте нет масс-маркета.</div>\r\n            <div class=\"advantage\">3. Честная гарантия — вы можете вернуть или обменять товар в течение 30 дней.</div>\r\n            <div class=\"advantage\">2. Экологичный подход — мы отдаём предпочтение натуральным материалам.</div>\r\n            <div class=\"advantage\">4. Быстрая доставка по всей стране — отправляем заказы в течение 24 часов.</div>\r\n        </div>\r\n    </section>\r\n\r\n    <!-- Контакты -->\r\n    <section class=\"contacts\">\r\n        <h2>КОНТАКТЫ</h2>\r\n        <p>Мы всегда на связи и открыты к диалогу — будь то вопрос по заказу, предложение сотрудничества или просто идея для нового декора.</p>\r\n        <div class=\"contact-info\">\r\n            <p>Телефон: +7 (999) 123-45-67 (ежедневно, с 10:00 до 21:00 по МСК)</p>\r\n            <p>Email: hello@dom-detali.ru — по вопросам заказов и возвратов</p>\r\n            <p>Email для партнёров: partners@dom-detali.ru — для художников, мастеров и брендов</p>\r\n        </div>\r\n    </section>\r\n</div>', '<h2>Вдохновение в каждой детали</h2>', 1),
(4, 'footer', '', '<div class=\"footer center column\">\r\n    <div class=\" center row\">\r\n        <h3>ДЕКОР ДЛЯ <br> ДОМА</h3>\r\n        <img src=\"/img/logo.png\" loading = \"lazy\" alt=\"Логотип\" style=\"max-width: 50px; margin: 20px;\">\r\n    </div>\r\n    <p style=\"opacity: 0.6;\">&copy; {{ year }} Декор для дома. Все права защищены.</p>\r\n    <p style=\"opacity: 0.6; margin-top: 20px;\">\r\n        Команда разработчиков: <br>\r\n        Бакулев Михаил <br>\r\n        Сухарева Ангелина <br>\r\n        Рагазина Елена\r\n    </p>\r\n    <div class=\"center row\" style=\"margin-top: 20px;\">\r\n        <a target=\"_blank\" class=\"hover\" href=\"https://web.telegram.org/\"><img class=\"margin15\" src=\"/img/telegram.png\" loading = \"lazy\" alt=\"telegram\" style=\"max-width: 40px;\"></a>\r\n        <a target=\"_blank\" class=\"hover\" href=\"https://www.youtube.com/\"><img class=\"margin15\" src=\"/img/youtube.png\" loading = \"lazy\" alt=\"youtube\" style=\"max-width: 40px;\"></a>\r\n        <a target=\"_blank\" class=\"hover\" href=\"https://vk.com/\"><img class=\"margin15\" src=\"/img/vk.png\" loading = \"lazy\" alt=\"vk\" style=\"max-width: 40px;\"></a>\r\n    </div>\r\n</div>', '', 0),
(5, 'catalog', 'Каталог', '<div class=\"category-item\">\r\n    <a href=\"/catalog/{{ href }}\"><img src=\"{{ image }}\" loading=\"lazy\" alt=\"{{ name }}\">{{ name }}</a>\r\n</div>', '<form method=\"POST\" data-no-ajax>\r\n    <div class=\"center\" style=\"-webkit-mask-image: -webkit-radial-gradient(white, black); align-items: center; width: 700px; height: 55px; background: white; border: 2px solid #CFCFCF; border-radius: 25rem; padding: 0 20px; overflow: hidden;\">\r\n        <input type=\"text\" placeholder=\"Поиск по товарам...\" style=\"flex: 1; border: none; outline: none; font-size: 18px; background: transparent; height: 55px;\" name=\"search\">\r\n        <button class=\"hover\" type=\"submit\" style=\"background: none; border: none;\"><img src=\"/img/search.svg\" loading=\"lazy\" alt=\"Поиск\" style=\"width: 30px; cursor: pointer;\"></button>\r\n    </div>\r\n</form>', 1),
(6, 'header', '', '<nav class=\"center row\">\r\n    {{ menu }}\r\n</nav>\r\n<div class=\"header-content center row space-between\">\r\n    <div class=\"margin-left80\" style=\"width: 211px;\">\r\n        <a class=\"hover center row\" href=\"/index\">\r\n            <h3>ДЕКОР ДЛЯ <br> ДОМА</h3>\r\n            <img src=\"/img/logo.png\" alt=\"Логотип\" style=\"max-width: 50px; margin: 20px;\">\r\n        </a>\r\n    </div>\r\n    \r\n    {{ header_content }}\r\n\r\n    <div class=\"center row margin-right80\" style=\"width: 211px;\">\r\n        <a class=\"{{ basket_class }}\" href=\"/basket\">\r\n            <img class=\"margin15\" src=\"{{ basket_img }}\" alt=\"Корзина\" style=\"max-width: 40px;\">\r\n        </a>\r\n        \r\n        <a class=\"{{ profile_class }}\" href=\"/profile\">\r\n            {{ profile }} \r\n        </a>\r\n    </div>\r\n</div>', '', 0),
(9, 'admin', 'Админпанель', '<div class=\'center column\'>\r\n    <h1 class=\'margin15\'>Админ-панель</h1>\r\n    <form class=\'center margin15 column\' method=\'POST\' data-no-ajax>\r\n        <input class=\'margin5 admin-input\' type=\'login\' name=\'login\' placeholder=\'Логин\' required>\r\n        <input class=\'margin5 admin-input\' type=\'password\' name=\'password\' placeholder=\'Пароль\' required>\r\n        <button class=\'margin5 admin-button hover\' type=\'submit\' name=\'action\'>Вход</button>\r\n    </form>\r\n</div>', '<nav class=\"center row\">\r\n    {{ menu }}\r\n</nav>\r\n<div class=\"header-content center \">\r\n        <a class=\"hover center row\" href=\"/admin\">\r\n            <h3>АДМИН ДЛЯ <br> ДОМА</h3>\r\n            <img src=\"/img/logo.png\" loading = \"lazy\" alt=\"Логотип\" style=\"max-width: 50px; margin: 20px;\">\r\n        </a>\r\n</div>', 2),
(10, 'reviews', 'Отзывы', '<div class=\"container-reviews\">\r\n    <section class=\"top-text\">\r\n        <p>Делитесь впечатлениями и читайте, что думают другие о магазине «Дом Деталей»!</p>\r\n    </section>\r\n\r\n    <!-- Отзывы -->\r\n    <section class=\"review\">\r\n        {{ reviews }}\r\n    </section>\r\n\r\n    <section class=\"form-section center column\">\r\n        <h2>Оставить свой отзыв</h2>\r\n        <form class=\"review-form center column\">\r\n            <input type=\"text\" name=\"rev_name\" placeholder=\"Имя\" value=\"{{ login }}\" readonly>\r\n            <select name=\"rev_rating\">\r\n                <option value=\"5\">★★★★★</option>\r\n                <option value=\"4\">★★★★</option>\r\n                <option value=\"3\">★★★</option>\r\n                <option value=\"2\">★★</option>\r\n                <option value=\"1\">★</option>\r\n            </select>\r\n            <textarea name=\"rev_text\" placeholder=\"Ваш отзыв\"></textarea>\r\n            <button type=\"submit\" name=\"send_review\">Отправить</button>\r\n        </form>\r\n    </section>\r\n</div>', '<h2>Отзывы наших покупателей</h2>', 1),
(11, 'сontacts', 'Контакты', '<section class=\"contact-info\">\r\n\r\n<div class=\"contact-text\">\r\n    <p>\r\n        Наполните дом уютом в любое удобное время — наш сайт открыт для заказов 24/7.\r\n        Если вам нужна помощь в выборе декора или возникли вопросы по заказу,\r\n        мы всегда связи! Позвоните на горячую линию или напишите на электронную почту.\r\n        Также вы можете оставить заявку через форму обратной связи, и наш менеджер\r\n        перезвонит вам в ближайшее время.\r\n    </p>\r\n</div>\r\n\r\n<div class=\"contact-items\">\r\n\r\n    <div class=\"contact-item\">\r\n        <p>hello@dom-detali.ru</p>\r\n    </div>\r\n\r\n    <div class=\"contact-item\">\r\n        <p>+7 947 485 98 87</p>\r\n    </div>\r\n\r\n    <div class=\"contact-item\">\r\n        <p>+7 947 485 98 87</p>\r\n    </div>\r\n\r\n</div>\r\n\r\n</section>\r\n\r\n\r\n<section class=\"feedback\">\r\n\r\n<h2 class=\"feedback-title\">Обратная связь</h2>\r\n\r\n<form class=\"feedback-form\">\r\n    <input name=\"rev_name1\" type=\"text\" placeholder=\"Ваше имя\">\r\n    <input name=\"rev_email\" type=\"email\" placeholder=\"Ваш email\">\r\n    <textarea name=\"rev_text1\" placeholder=\"Ваше сообщение\"></textarea>\r\n    <button type=\"submit\" name=\"send_feedback\">Отправить</button>\r\n</form>\r\n\r\n</section>\r\n\r\n\r\n<section class=\"location\">\r\n\r\n<div class=\"location-content\">\r\n\r\n    <div class=\"location-text\">\r\n        <h2>Где нас найти:</h2>\r\n\r\n        <p>ул. Пушкинская, 270</p>\r\n        <p>ул. Холмогорова, 11</p>\r\n        <p>ул. Баранова, 55</p>\r\n    </div>\r\n\r\n    <div class=\"location-map\">\r\n        <iframe src=\"https://yandex.ru/map-widget/v1/?um=constructor%3A484fa3e7973acd9e3382ddfbfacd8592c0ea7df9aab1e1cd44dc8a9c4f8bce83&amp;source=constructor\" frameborder=\"0\"></iframe>\r\n    </div>\r\n\r\n</div>\r\n\r\n</section>', '<h2>Свяжитесь с нами!</h2>', 1),
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
(24, 'detailed_card_product', '', '<section class=\"product-card\">\r\n    <div class=\"product-container center column\">\r\n        <h1 class=\"product-title\">{{ title }}</h1>\r\n        \r\n        <div class=\"product-main center row\">\r\n            <!-- Фото -->\r\n            <div class=\"product-image\">\r\n                <img src=\"{{ img }}\" alt=\"Товар\">\r\n            </div>\r\n\r\n            <!-- Характеристики -->\r\n            <div class=\"product-info margin15\">\r\n                <ul class=\"specs-list\">\r\n                    <li><span>номер</span><span>{{ id }}</span></li>\r\n                    <li><span>материал</span><span>{{ material }}</span></li>\r\n                    <li><span>цвет</span><span>{{ color }}</span></li>\r\n                    <li><span>высота, см</span><span>{{ height }}</span></li>\r\n                    <li><span>длина, см</span><span>{{ length }}</span></li>\r\n                    <li><span>ширина, см</span><span>{{ width }}</span></li>\r\n                    <li><span>вес нетто, кг</span><span>{{ weight }}</span></li>\r\n                </ul>\r\n            </div>\r\n        </div>\r\n\r\n        <div class=\"center column add-button hover\">\r\n            <form method=\"POST\">\r\n                <input name=\"id\" type=\"hidden\" value=\"{{ id }}\"></input>\r\n                <button name=\"addItem\" type=\"submit\">Добавить</button>\r\n            </form>\r\n        </div>\r\n\r\n        <div class=\"product-description\">\r\n            <p>Минималистичная ваза из прозрачного стекла — универсальное решение для повседневного декора...</p>\r\n            <p>Благодаря нейтральному дизайну ваза подходит для одиночных веток, полевых цветов...</p>\r\n        </div>\r\n    </div>\r\n</section>', '', 0),
(26, 'settings', 'Настройки профиля', '<section class=\"profile-edit\">\r\n    <div class=\"profile-edit-container\">\r\n        <form class=\"profile-edit-form\" method=\"POST\">    \r\n            <div class=\"profile-edit-row\">\r\n                <div class=\"profile-edit-field\">\r\n                    <label>Имя</label>\r\n                    <input type=\"text\" name=\"login\" value=\"{{ login }}\" required>\r\n                </div>\r\n\r\n                <div class=\"profile-edit-field\">\r\n                    <label>Старый пароль</label>\r\n                    <input type=\"password\" name=\"old_password\" placeholder=\"Введите текущий пароль\" required>\r\n                </div>\r\n            </div>\r\n\r\n            <div class=\"profile-edit-row\">\r\n                <div class=\"profile-edit-field\">\r\n                    <label>Email</label>\r\n                    <input type=\"email\" name=\"email\" value=\"{{ email }}\" required>\r\n                </div>\r\n\r\n                <div class=\"profile-edit-field\">\r\n                    <label>Новый пароль (необязательно)</label>\r\n                    <input type=\"password\" name=\"new_password\" placeholder=\"Введите новый пароль\">\r\n                </div>\r\n            </div>\r\n\r\n            <div class=\"profile-edit-buttons center\">\r\n                <button type=\"submit\" name=\"update_profile\" class=\"save-button\">Сохранить изменения</button>\r\n                <a href=\"/profile\" class=\"cancel-button center\">Отмена</a>\r\n            </div>\r\n        </form>\r\n    </div>\r\n</section>', '<h2>Настройки профиля</h2>', 0),
(27, 'card_product_basket', '', '<div class=\"cart-item\">\r\n    <div class=\"item-image\">\r\n        <img src=\"{{ img }}\" loading=\"lazy\" alt=\"Ваза\">\r\n    </div>\r\n\r\n    <div class=\"item-info\">\r\n        <h3 class=\"item-name\">{{ name }}</h3>\r\n        <p class=\"item-number\">Номер товара:<br>{{ id }}</p>\r\n    </div>\r\n\r\n    <div class=\"item-price\">\r\n        <span class=\"price-one\" data-price=\"{{ price_clean }}\">{{ price }}</span> руб.\r\n        <p class=\"price-label\">цена за 1 шт.</p>\r\n    </div>\r\n\r\n    <div class=\"item-quantity\">\r\n        <button class=\"btn-quantity minus\">−</button>\r\n        <input type=\"text\" value=\"{{ quantity }}\" class=\"quantity-input\" readonly>\r\n        <button class=\"btn-quantity plus\">+</button>\r\n    </div>\r\n\r\n    <div class=\"item-total\">{{ end_price }} руб.</div>\r\n</div>', '', 0),
(28, 'order', 'Оформление', '<div class=\"container-checkout\">\r\n    <h1>Оформление заказа</h1>\r\n\r\n    <form class=\"left-side\" method=\"POST\">\r\n        <div class=\"delivery\">\r\n            <label>Доставка в</label>\r\n            <input type=\"text\" name=\"city\" placeholder=\"Укажите ваш город\" required>\r\n        </div>\r\n\r\n        <div class=\"row-3\">\r\n            <input type=\"text\" name=\"fullname\" placeholder=\"Фамилия и имя\" value=\"{{ name }}\" readonly>\r\n            <input type=\"tel\" name=\"phone\" placeholder=\"Телефон\" required>\r\n            <input type=\"email\" name=\"email\" placeholder=\"E-mail\" value=\"{{ email }}\" readonly>\r\n        </div>\r\n\r\n        <div class=\"row-2\">\r\n            <input type=\"text\" name=\"address\" placeholder=\"Адрес\" required>\r\n            <input type=\"text\" name=\"postal_code\" placeholder=\"Почтовый индекс\" required>\r\n        </div>\r\n\r\n        <textarea name=\"notes\" placeholder=\"Примечания покупателя\"></textarea>\r\n\r\n        <div class=\"payment\">\r\n            <h2>Способы оплаты</h2>\r\n            <div class=\"payment-methods\">\r\n                <button type=\"button\" class=\"payment-card\" data-payment=\"cash\">Оплата наличными при получении</button>\r\n                <button type=\"button\" class=\"payment-card\" data-payment=\"card\">Оплата банковской картой при получении</button>\r\n                <button type=\"button\" class=\"payment-card\" data-payment=\"sberbank\">На карту Сбербанка № 2202 3245 7896 5467</button>\r\n                <button type=\"button\" class=\"payment-card\" data-payment=\"cod\">Наложенный платёж (стоимость увеличивается на 5%)</button>\r\n            </div>\r\n            <!-- Скрытое поле для передачи выбранного метода на сервер -->\r\n            <input type=\"hidden\" name=\"payment_method\" id=\"selectedPayment\" required>\r\n        </div>\r\n\r\n        <div class=\"checkboxes\">\r\n            <div class=\"checkbox-row\">\r\n                <input type=\"checkbox\" id=\"terms\" required>\r\n                <label for=\"terms\">Отметьте флажок, чтобы принять <a href=\"#\">Условия использования</a></label>\r\n            </div>\r\n            <div class=\"checkbox-row\">\r\n                <input type=\"checkbox\" id=\"personal\" required>\r\n                <label for=\"personal\">Я согласен/согласна на обработку своих <a href=\"#\">персональных данных</a> указанным образом</label>\r\n            </div>\r\n        </div>\r\n        \r\n        <div class=\"column\">\r\n            <button type=\"submit\" class=\"btn-order\">Оформить заказ ({{ final_price }} руб.)</button>\r\n            <button onclick=\"history.back();\" class=\"btn-order\">Назад</button>\r\n        </div>\r\n    </form>\r\n</div>', '', 0),
(30, 'card_review', '', '<div class=\"reviews-card\">\r\n    <div class=\"review-content\">\r\n        <div class=\"review-top\">\r\n            <span class=\"stars\">{{ stars }}</span>\r\n            <span class=\"date\">{{ date }}</span>\r\n        </div>\r\n        <h3>{{ name }}</h3>\r\n        <p>«{{ description }}»</p>\r\n    </div>\r\n</div>', '', 0),
(31, 'pages', 'Страницы', '', '', 2),
(32, 'stock1', 'Акции', '', '', 2),
(33, 'order1', 'Заказы', '', '', 2);

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
  `description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
(1, 1, 'Ваза из прозрачного стекла 15 см', 810, 'img/vase1.jpg', '', '', '', '', '', '', '', ''),
(2, 1, 'Ваза из прозрачного стекла 11 см', 1180, 'img/vase2.jpg', '', '', '', '', '', '', '', ''),
(3, 1, 'Ваза из прозрачного стекла 24 см', 3800, 'img/vase3.jpg', '', '', '', '', '', '', '', ''),
(4, 1, 'Ваза из керамики 22 см', 1240, 'img/vase4.jpg', '', '', '', '', '', '', '', ''),
(5, 1, 'Ваза из керамики 19 см', 1000, 'img/vase5.jpg', '', '', '', '', '', '', '', ''),
(6, 1, 'Ваза из керамики 15 см', 2400, 'img/vase6.jpg', '', '', '', '', '', '', '', ''),
(7, 1, 'Ваза из керамики 23 см', 750, 'img/vase7.jpg', '', '', '', '', '', '', '', ''),
(8, 1, 'Ваза из керамики 30 см', 7500, 'img/vase8.jpg', '', '', '', '', '', '', '', ''),
(9, 1, 'Ваза из керамики 26 см', 1200, 'img/vase9.jpg', '', '', '', '', '', '', '', ''),
(10, 2, 'Свеча «Лавандовый вечер»', 790, 'img/candle1.jpg', '', '', '', '', '', '', '', ''),
(11, 2, 'Свеча в стекле «Сакура с клубникой', 1230, 'img/candle2.jpg', '', '', '', '', '', '', '', ''),
(12, 2, 'Свеча «Снежная сказка»', 1000, 'img/candle3.jpg', '', '', '', '', '', '', '', ''),
(13, 3, 'Салатница «Цветочный вальс»', 1390, 'img/bowl1.jpg', '', '', '', '', '', '', '', ''),
(14, 3, 'Фиолетовая рифлёная салатница', 1250, 'img/bowl2.jpg', '', '', '', '', '', '', '', ''),
(15, 3, 'Голубая салатница «Небесный узор»', 1670, 'img/bowl3.jpg', '', '', '', '', '', '', '', ''),
(16, 4, 'Настенное зеркало «Винтаж»', 8970, 'img/mirror1.jpg', '', '', '', '', '', '', '', ''),
(17, 4, 'Настольное зеркало «Ажур»', 3490, 'img/mirror2.jpg', '', '', '', '', '', '', '', ''),
(18, 4, 'Настенное зеркало «Великолепие»', 14000, 'img/mirror3.jpg', '', '', '', '', '', '', '', ''),
(19, 5, 'Кашпо «Эклипс»', 1240, 'img/kashpo1.jpg', '', '', '', '', '', '', '', ''),
(20, 5, 'Кашпо «Лунный срез»', 2100, 'img/kashpo2.jpg', '', '', '', '', '', '', '', ''),
(21, 5, 'Кашпо «Чистый цилиндр»', 1720, 'img/kashpo3.jpg', '', '', '', '', '', '', '', ''),
(22, 6, 'Настенные часы «Утренняя роза»', 4520, 'img/clock1.jpg', '', '', '', '', '', '', '', ''),
(23, 6, 'Настольные часы «Шёпот сада»', 3210, 'img/clock2.jpg', '', '', '', '', '', '', '', ''),
(24, 6, 'Настенные часы «Вечная классика»', 3700, 'img/clock3.jpg', '', '', '', '', '', '', '', ''),
(25, 7, 'Цветочная композиция «Весна»', 2300, 'img/flower1.jpg', '', '', '', '', '', '', '', ''),
(26, 7, 'Цветочная композиция «Нежность»', 1200, 'img/flower2.jpg', '', '', '', '', '', '', '', ''),
(27, 7, 'Цветочная композиция «Свежесть»', 4260, 'img/flower3.jpg', '', '', '', '', '', '', '', '');

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
(29, 'Дмитрий', '4', 'Хороший выбор декора, цены приятные. Единственное — свеча пахла не так ярко, как ожидала. Но в целом довольна.', 1, '2026-05-19 15:09:45');

-- --------------------------------------------------------

--
-- Структура таблицы `settings`
--

CREATE TABLE `settings` (
  `id` int NOT NULL,
  `key_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(25, 'df', 'suharevaangelina4@gmail.com', '$2y$10$K5iYyIVaXY5flYGMsG9Sf.9tPw1ZdnONgx3pcuB.DbrhPicl/fjpy', 'admin', '2026-05-19');

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
-- Индексы таблицы `settings`
--
ALTER TABLE `settings`
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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
