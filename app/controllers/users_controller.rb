class UsersController < ApplicationController
  before_action :set_user, except: %i[index] 
  
  def index
    if params[:search]
      @users = User.search(params[:search])
    else
      @users = User
        .order(params[:sort])
        .page(params[:page])
        .per(3)
    end
  end


  def show; end

  def edit
    redirect_to root_path, alert: 'User not found.' if user.nil?
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User successfully updated."
    else
      render :edit
    end
  end


  def export_csv
  @users = User.all
    require 'csv'
    respond_to do |format|
      format.csv { send_data @users.to_csv, filename: 'users.csv' }
    end
  end
  
  def destroy
    @user.destroy
    
    redirect_to users_path, notice: "User successfully deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email,
      :country,
      :first_name,
      :last_name,
      :middle_name,
      :phone_number,
      :image
    )
  end
end
