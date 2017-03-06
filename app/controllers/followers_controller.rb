class FollowersController < ApplicationController
  before_action :logged_in_user

  def index
    @title = t ".followers"
    @user = User.find_by id: params[:user_id]
    @users = @user.followers.paginate page: params[:page]
  end
end
