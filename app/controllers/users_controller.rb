include ActionView::Helpers::TextHelper

class UsersController < ApplicationController
  before_action :load_user, only: :show

  def show
  end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      flash[:danger] = t(".form_contain")  + pluralize(@user.errors.count, t(".error"))
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    raise ActionController::RoutingError.new(t ".not_found") if @user.nil? 
  end
end
