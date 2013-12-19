class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])

    if @user.save
      login!
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    render :new
  end
end