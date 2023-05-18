class UsersController < ApplicationController
    def index
      @users = User.all
    end
  
  
  def show
    @user = User.find(params[:id])
  end

  def edit
  @user = User.find_by_id(params[:id])
  if @user.nil?
    # Handle the case when the user record is not found
    redirect_to root_path, alert: 'User not found.'
  end
end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User successfully updated."
    else
      render :edit
    end
  end

  private

  def user_params
  params.require(:user).permit(:email, :country, :first_name, :last_name, :middle_name, :phone_number)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User successfully deleted."
  end
end