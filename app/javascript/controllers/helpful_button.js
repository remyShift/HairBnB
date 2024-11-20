document.addEventListener('DOMContentLoaded', () => {
  let helpfulCount = 19;
  const helpfulButton = document.getElementById('helpful-button');
  const helpfulCountElement = document.getElementById('helpful-count');

  if (helpfulButton && helpfulCountElement) {
    helpfulButton.addEventListener('click', () => {
      helpfulCount++;
      helpfulCountElement.textContent = `${helpfulCount} people found this helpful`;
    });
  }
});
