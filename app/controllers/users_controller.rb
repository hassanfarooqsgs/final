class UsersController < ApplicationController
     def index
      
      @users = if params[:search]
      User.where("first_name LIKE :search OR last_name LIKE :search OR email LIKE :search OR id = :id",
                 search: "%#{params[:search]}%", id: params[:search].to_i)
     else
      @user = User.page(params[:page]).per(3)

     end
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

  def export_csv
    @users = User.all
      require 'csv'
      respond_to do |format|
        format.csv { send_data @users.to_csv, filename: 'users.csv' }
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
