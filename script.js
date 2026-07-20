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

    // 2. Tab Navigation Logic for Section 4 (Process)
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

    // 3. Phase Switcher Logic
    const phaseBtns = document.querySelectorAll('.phase-btn');
    const phaseSwitcher = document.querySelector('.phase-switcher');
    const phase1Content = document.getElementById('phase-1-content');
    const phase2Content = document.getElementById('phase-2-content');
    const navLinksPhase1 = document.getElementById('nav-links-phase1');
    const navLinksPhase2 = document.getElementById('nav-links-phase2');

    // Add inline transitions helper
    [phase1Content, phase2Content].forEach(el => {
        if (el) el.style.transition = 'opacity 0.4s ease, transform 0.4s ease';
    });

    // Function to explicitly set Phase I as default on page load
    function setPhaseIDefault() {
        phaseBtns.forEach(b => b.classList.remove('active'));
        const phase1Btn = document.querySelector('.phase-btn[data-phase="1"]');
        if (phase1Btn) phase1Btn.classList.add('active');
        if (phaseSwitcher) phaseSwitcher.classList.remove('phase-2-active');

        if (phase1Content) {
            phase1Content.style.display = 'block';
            phase1Content.style.opacity = '1';
            phase1Content.style.transform = 'translateY(0)';
        }
        if (phase2Content) {
            phase2Content.style.display = 'none';
            phase2Content.style.opacity = '0';
            phase2Content.style.transform = 'translateY(15px)';
        }
        if (navLinksPhase1) navLinksPhase1.style.display = 'flex';
        if (navLinksPhase2) navLinksPhase2.style.display = 'none';
    }

    // Always load Phase I as default when entering the website
    setPhaseIDefault();

    phaseBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            if (btn.classList.contains('active')) return;

            phaseBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const phase = btn.getAttribute('data-phase');
            if (phase === '1') {
                phaseSwitcher.classList.remove('phase-2-active');
                
                // Transition out Phase 2
                phase2Content.style.opacity = '0';
                phase2Content.style.transform = 'translateY(15px)';
                
                setTimeout(() => {
                    phase2Content.style.display = 'none';
                    
                    // Transition in Phase 1
                    phase1Content.style.display = 'block';
                    phase1Content.style.opacity = '0';
                    phase1Content.style.transform = 'translateY(15px)';
                    
                    setTimeout(() => {
                        phase1Content.style.opacity = '1';
                        phase1Content.style.transform = 'translateY(0)';
                    }, 50);
                }, 400);

                // Toggle Navigation
                navLinksPhase2.style.display = 'none';
                navLinksPhase1.style.display = 'flex';
            } else {
                phaseSwitcher.classList.add('phase-2-active');

                // Transition out Phase 1
                phase1Content.style.opacity = '0';
                phase1Content.style.transform = 'translateY(15px)';
                
                setTimeout(() => {
                    phase1Content.style.display = 'none';
                    
                    // Transition in Phase 2
                    phase2Content.style.display = 'block';
                    phase2Content.style.opacity = '0';
                    phase2Content.style.transform = 'translateY(15px)';
                    
                    setTimeout(() => {
                        phase2Content.style.opacity = '1';
                        phase2Content.style.transform = 'translateY(0)';
                    }, 50);
                }, 400);

                // Toggle Navigation
                navLinksPhase1.style.display = 'none';
                navLinksPhase2.style.display = 'flex';
            }
        });
    });

    // 3.5. Header Nav Phase Clicks
    const navPhaseBtns = document.querySelectorAll('.nav-phase-btn');
    navPhaseBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            const targetPhase = btn.getAttribute('data-target-phase');
            const targetBtn = document.querySelector(`.phase-btn[data-phase="${targetPhase}"]`);
            if (targetBtn) {
                targetBtn.click();
            }
        });
    });

    // 4. Mouse parallax effect for blobs
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
