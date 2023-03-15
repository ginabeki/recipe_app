class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def new
    @recipe = current_user.recipes.build
    @user = current_user
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'Recipe has been deleted.'
    redirect_to recipe_path(current_user)
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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
