class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def toggle_public
    @recipe = current_user.recipes.find_by(id: params[:id])
    unless @recipe.nil?
      @recipe = Recipe.find(params[:id])
      @recipe.update(public: !@recipe.public)
    end
    redirect_to request.referrer || root_path
  end

  def new
    @recipe = current_user.recipes.build
    @user = current_user
  end

  def new_ingredient
    @recip = current_user.recipes.find_by(id: params[:format])
    redirect_to request.referrer || root_path if @recip.nil?
    @recipe = Recipe.find(params[:format])
    @foods = current_user.foods
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = current_user.foods.joins(:recipe_foods).where(recipe_foods: { recipe_id: @recipe.id }).distinct
  end

  def destroy
    @recipe_food = RecipeFood.where(recipe_id: params[:id])
    @recipe_food.first&.destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'Recipe has been deleted.'
    redirect_to recipe_path(current_user)
  end

  def general_shopping_list
    @food_ids = current_user.foods
      .joins(:recipe_foods)
      .distinct
      .pluck(:id)
    @foods = current_user.foods.where.not(id: @food_ids)
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipe_path(current_user, @recipe), notice: 'Recipe added successfully'
    else
      flash.now[:error] = 'Failed to add recipe'
      render :new
    end
  end

  def create_ingredient
    @food = current_user.foods.build(food_params.except(:recipe_id))
    @recipe = Recipe.find(params[:recipe_food][:recipe_id])
    @recipe_food = RecipeFood.new(recipe: @recipe, food: @food, quantity: food_params[:quantity])

    return unless @recipe_food.save

    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def food_params
    params.require(:recipe_food).permit(:name, :measurement_unit, :price, :recipe_id, :quantity)
  end
end
