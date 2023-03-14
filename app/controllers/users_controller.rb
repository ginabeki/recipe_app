class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if params[:id] == 'foods'
      @foods = Food.all
    else
      @user = User.find(params[:id])
      @foods = @user.foods
    end
  end
end
