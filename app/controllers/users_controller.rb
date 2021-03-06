include ActionView::Helpers::TextHelper

class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page]
  end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".checkmail_notice"
      redirect_to root_url
    else
      flash.now[:danger] = t(".form_contain")  + pluralize(@user.errors.count, t(".error"))
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".updated"
      redirect_to @user
    else
      flash.now[:danger] = t(".form_contain") + pluralize(@user.errors.count, t(".error"))
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".deleted_notice"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    raise ActionController::RoutingError.new(t ".not_found") if @user.nil? 
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
