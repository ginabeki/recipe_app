window.addEventListener('DOMContentLoaded', function() {
    const switchInput = document.querySelector('.my-form-class .switch input[type="checkbox"]');
    const switchSlider = document.querySelector('.my-form-class .switch .slider');
    let recipeIdField = document.querySelector('input[name="recipe_id"]');
    let recipeId = recipeIdField.value;
  
    switchInput.addEventListener('change', function() {
        window.location.href =(`/recipes/${recipeId}/toggle_public`)
    });
  });
  