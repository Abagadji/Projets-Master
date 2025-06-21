document.addEventListener('DOMContentLoaded', function() {
    const questionMarksContainer = document.getElementById('questionMarks');
    const numberOfMarks = 10; // Nombre de points d'interrogation
    const radius = 30; // Rayon du cercle de rotation

    for (let i = 0; i < numberOfMarks; i++) {
        const angle = (i / numberOfMarks) * 360;
        const x = radius * Math.cos(angle * Math.PI / 180);
        const y = radius * Math.sin(angle * Math.PI / 180);

        const questionMark = document.createElement('div');
        questionMark.className = 'question-mark';
        questionMark.style.left = `calc(50% + ${x}px)`;
        questionMark.style.top = `calc(50% + ${y}px)`;
        questionMark.textContent = '?';
        questionMarksContainer.appendChild(questionMark);
    }
});
