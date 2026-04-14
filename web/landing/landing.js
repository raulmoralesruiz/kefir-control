// window.addEventListener('load', () => {
window.addEventListener('DOMContentLoaded', () => {
    // --- Language Logic ---
    const langBtn = document.getElementById('lang-btn');
    const langDropdown = document.getElementById('lang-dropdown');
    const langFlag = document.getElementById('current-lang-flag');
    const langName = document.getElementById('current-lang-name');

    const flags = { 
        'en': './landing/img/languages/en.svg', 
        'es': './landing/img/languages/es.svg', 
        'and': './landing/img/languages/and.svg' 
    };
    const names = { 'en': 'English', 'es': 'Castellano', 'and': 'Andalûh' };

    // Toggle dropdown
    if (langBtn) {
        langBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            langDropdown.classList.toggle('show');
        });
    }

    // Close dropdown on click outside
    window.addEventListener('click', () => {
        if (langDropdown && langDropdown.classList.contains('show')) {
            langDropdown.classList.remove('show');
        }
    });

    // Translation function
    window.setLanguage = (lang) => {
        try {
            localStorage.setItem('kefir_control_lang', lang);
        } catch (e) {}
        
        // Update UI
        if (langFlag) langFlag.src = flags[lang];
        if (langName) langName.textContent = names[lang];
        if (langDropdown) langDropdown.classList.remove('show');

        // Update all elements with data-i18n
        const i18nElements = document.querySelectorAll('[data-i18n]');

        i18nElements.forEach(el => {
            const key = el.getAttribute('data-i18n');
            if (translations[lang] && translations[lang][key]) {
                if (key.includes('title')) {
                    el.innerHTML = translations[lang][key];
                } else {
                    el.textContent = translations[lang][key];
                }
            }
        });

        // Update Meta Tags
        if (translations[lang]['meta-title']) {
            document.title = translations[lang]['meta-title'];
        }
        const metaDesc = document.querySelector('meta[name="description"]');
        if (metaDesc && translations[lang]['meta-description']) {
            metaDesc.setAttribute('content', translations[lang]['meta-description']);
        }
    };

    // Auto-detect or load initial language
    let initialLang = 'en';
    try {
        const savedLang = localStorage.getItem('kefir_control_lang');
        const browserLang = navigator.language.split('-')[0];
        
        if (savedLang && translations[savedLang]) {
            initialLang = savedLang;
        } else if (translations[browserLang]) {
            initialLang = browserLang;
        }
    } catch (e) {}
    
    setLanguage(initialLang);

    // --- Reveal Animations ---
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

    // --- Demo Loading Logic ---
    const demoBtn = document.getElementById('start-demo-btn');
    const demoOverlay = document.getElementById('demo-overlay');
    const demoLoadingText = document.getElementById('demo-loading-text');
    const demoFrame = document.getElementById('flutter-app-frame');

    if (demoBtn) {
        demoBtn.addEventListener('click', () => {
            const currentLang = localStorage.getItem('kefir_control_lang') || 'en';
            
            demoBtn.style.display = 'none';
            demoLoadingText.style.display = 'block';
            demoLoadingText.textContent = translations[currentLang]['demo-launching'];
            
            demoFrame.src = "app.html";
            
            demoFrame.onload = () => {
                setTimeout(() => {
                    demoOverlay.classList.add('hidden');
                }, 2000);
            };
        });
    }
});
