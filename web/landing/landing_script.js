window.addEventListener('load', () => {
    // Reveal Animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

    // Demo Loading Logic
    const demoBtn = document.getElementById('start-demo-btn');
    const demoOverlay = document.getElementById('demo-overlay');
    const demoLoadingText = document.getElementById('demo-loading-text');
    const demoFrame = document.getElementById('flutter-app-frame');

    if (demoBtn) {
        demoBtn.addEventListener('click', () => {
            demoBtn.style.display = 'none';
            demoLoadingText.style.display = 'block';
            demoLoadingText.textContent = "Launching demo...";
            
            // Just set the source of the iframe!
            demoFrame.src = "app.html";
            
            // Hide overlay when iframe loads
            demoFrame.onload = () => {
                setTimeout(() => {
                    demoOverlay.classList.add('hidden');
                    console.log("Kefir Control Demo Loaded in Iframe.");
                }, 2000); // Give Flutter some time to boot after the page loads
            };
        });
    }
});
