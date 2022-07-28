class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :update_password, :change_password]
  before_action :authenticate_user!, only: [:edit]
  before_action :authorized_user!, only: [:edit, :update]


  def new
    @user = User.new
  end

  def create
    @user = User.new params.require(:user).permit(:name, :email, :password, :password_confirmation)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @user.update params.require(:user).permit(:name, :email, :password, :password_confirmation)
      redirect_to root_path
    else
      flash.alert = 'try again'
      render :edit
    end
  end

  def change_password
  end

  def update_password    
    if @user&.authenticate(params[:user][:current_password])
        if params[:user][:current_password] == params[:user][:password]
            @user.errors.add(:current_password, "try again")
        end
        if params[:user][:password] != params[:user][:password_confirmation]
            @user.errors.add(:password, "try again")
        end
        if (!@user.errors.any?) && (@user.update user_params)
            flash[:success] = "password updated"
            redirect_to root_path
        else
            render :change_password
        end
      end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def find_user
    @user = current_user
  end

  def authorized_user!
    redirect_to root_path, alert: "Not authorized" unless can?(:crud, user)
  end
  
end
end
