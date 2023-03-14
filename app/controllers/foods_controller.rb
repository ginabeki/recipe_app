class FoodsController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @foods = @user.foods
    else
      @foods = Food.all
    end
  end

  def new
    @user = User.find(params[:user_id])
    @food = @user.foods.build
  end

  def show
    @user = User.find(params[:user_id])
    @food = @user.foods.find(params[:id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @food = @user.foods.find(params[:id])
    @food.destroy
    flash[:notice] = 'Food item has been deleted.'
    redirect_to user_foods_path(@user)
  end

  def create
    @user = User.find(params[:user_id])
    @food = @user.foods.build(food_params)

    if @food.save
      redirect_to user_foods_path(@user), notice: 'Food added successfully'
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
