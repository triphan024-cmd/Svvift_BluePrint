document.addEventListener('DOMContentLoaded', () => {
    // 1. Intersection Observer for scroll animations
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.15
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('in-view');
            }
        });
    }, observerOptions);

    const observeElements = document.querySelectorAll('.observe');
    observeElements.forEach(el => observer.observe(el));

    // 2. Tab Navigation Logic for Section 4 (Process) (Disabled to prevent clicking)
    /*
    const tabNodes = document.querySelectorAll('.tab-node');
    const tabPanels = document.querySelectorAll('.tab-panel');

    tabNodes.forEach(node => {
        node.addEventListener('click', () => {
            // Remove active class from all
            tabNodes.forEach(n => n.classList.remove('active'));
            tabPanels.forEach(p => p.classList.remove('active'));

            // Add active class to clicked node
            node.classList.add('active');

            // Show corresponding panel
            const targetId = node.getAttribute('data-tab');
            document.getElementById(targetId).classList.add('active');
        });
    });
    */

    // 3. Optional: Mouse parallax effect for blobs
    const blobs = document.querySelectorAll('.blob');
    document.addEventListener('mousemove', (e) => {
        const x = e.clientX / window.innerWidth;
        const y = e.clientY / window.innerHeight;

        blobs.forEach((blob, index) => {
            const speed = (index + 1) * 20;
            const xOffset = (x - 0.5) * speed;
            const yOffset = (y - 0.5) * speed;
            
            blob.style.transform = `translate(${xOffset}px, ${yOffset}px)`;
        });
    });
});
