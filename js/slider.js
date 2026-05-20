document.addEventListener('DOMContentLoaded', () => {
    const slider = document.querySelector('.hero-slider');
    const track = document.querySelector('.hero-cards');
    const cards = document.querySelectorAll('.hero-card');
    const prevBtn = document.querySelector('.hero-prev');
    const nextBtn = document.querySelector('.hero-next');
    const dotsContainer = document.querySelector('.hero-dots');

    if (!slider || !track || !cards.length || !prevBtn || !nextBtn || !dotsContainer) {
        return;
    }

    let currentIndex = 0;

    const cardWidth = cards[0].offsetWidth;
    const gap = 25;
    const step = cardWidth + gap;

    const visibleCards = 3;
    const maxIndex = cards.length - visibleCards;

    // Создаём точки автоматически
    for (let i = 0; i <= maxIndex; i++) {
        const dot = document.createElement('span');

        if (i === 0) {
            dot.classList.add('active-dot');
        }

        dot.addEventListener('click', () => {
            currentIndex = i;
            updateSlider();
        });

        dotsContainer.appendChild(dot);
    }

    const dots = dotsContainer.querySelectorAll('span');

    function updateSlider() {
        track.style.transform = `translateX(-${currentIndex * step}px)`;

        dots.forEach(dot => dot.classList.remove('active-dot'));

        if (dots[currentIndex]) {
            dots[currentIndex].classList.add('active-dot');
        }
    }

    nextBtn.addEventListener('click', () => {
        if (currentIndex >= maxIndex) {
            currentIndex = 0;
        } else {
            currentIndex++;
        }

        updateSlider();
    });

    prevBtn.addEventListener('click', () => {
        if (currentIndex <= 0) {
            currentIndex = maxIndex;
        } else {
            currentIndex--;
        }

        updateSlider();
    });

    // Автоматическая прокрутка каждые 5 секунд
    setInterval(() => {
        if (currentIndex >= maxIndex) {
            currentIndex = 0;
        } else {
            currentIndex++;
        }

        updateSlider();
    }, 5000);
});