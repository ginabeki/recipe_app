class FoodsController < ApplicationController
  def index
    @foods = current_user.foods
    @user = current_user
  end

  def new
    @food = current_user.foods.build
    @user = current_user
  end

  def show
    @user = User.find(params[:user_id])
    @food = @user.foods.find(params[:id])
  end

  def destroy
    @recipe_food = RecipeFood.where(food_id: params[:id])
    @recipe_food.first.destroy
    @user = current_user
    @food = @user.foods.find(params[:id])
    @food.destroy
    flash[:notice] = 'Food item has been deleted.'
    redirect_to food_path(@user)
  end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      redirect_to food_path(current_user, @food), notice: 'Food added successfully'
    else
      flash.now[:error] = 'Failed to add food'
      render :new
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
