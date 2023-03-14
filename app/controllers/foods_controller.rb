class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def destroy
    if session[:user_id].nil?
      redirect_to root_path, alert: 'You must be logged in to delete a food'
    else
      @food = Food.find_by(id: params[:id], user_id: session[:user_id])
      if @food
        @food.destroy
        redirect_to user_foods_path(user_id: session[:user_id]), notice: 'Food deleted successfully'
      else
        redirect_to user_foods_path(user_id: session[:user_id]), alert: 'Food not found'
      end
    end
  end
end
