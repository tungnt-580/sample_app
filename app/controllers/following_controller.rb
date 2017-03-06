class FollowingController < ApplicationController
  before_action :logged_in_user

  def index
    @title = t ".following"
    @user = User.find_by id: params[:user_id]
    @users = @user.following.paginate page: params[:page]
  end
end
