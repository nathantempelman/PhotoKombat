class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, only: :destroy

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:notice] = "Welcome to the site!"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.join("<br/>").html_safe
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html {
          flash[:error] = @user.errors.full_messages.to_sentence
          render :edit
        }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def authenticate_admin
    redirect_to(root_url) unless current_user.admin
  end

end
