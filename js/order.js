document.addEventListener('DOMContentLoaded', () => {
    const orderButton = document.querySelector('.btn-order');
    if (!orderButton) return;
    const paymentButtons = document.querySelectorAll('.payment-card');
    const selectedPaymentInput = document.getElementById('selectedPayment');

    // Запоминаем исходную цену, которая пришла из PHP шаблона (вырезаем только цифры)
    const basePrice = parseInt(orderButton.textContent.replace(/[^0-9]/g, ''));

    paymentButtons.forEach(button => {
        button.addEventListener('click', () => {
            // 1. Подсветка кнопок
            paymentButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            
            // 2. Запись метода в скрытый input
            const method = button.getAttribute('data-payment');
            selectedPaymentInput.value = method;

            // 3. ПЕРЕСЧЕТ ЦЕНЫ НА ЭКРАНЕ
            let currentPrice = basePrice;

            if (method === 'cod') {
                // Если выбран наложенный платёж — увеличиваем на 5%
                currentPrice = Math.round(basePrice * 1.05);
            }

            // Обновляем текст на главной кнопке отправки
            orderButton.textContent = `Оформить заказ (${currentPrice.toLocaleString('ru-RU')} руб.)`;
        });
    });

    // Валидация перед отправкой
    const orderForm = document.querySelector('.left-side');
    if (orderForm) {
        orderForm.addEventListener('submit', (e) => {
            if (!selectedPaymentInput.value) {
                e.preventDefault();
                alert('Пожалуйста, выберите способ оплаты!');
            }
        });
    }
});
