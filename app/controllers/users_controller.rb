class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :authorize_user!, except: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_user, only: %i[ show edit update destroy approve_user ]
  # before_action :check_privilege, only

  # GET /users or /users.json
  def index
    redirect_to root_path if current_user.role != 'Admin'
    @users = User.all
    @pending_users = User.where(status: 'Pending')
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(user_params).deliver_now
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    
    if user_params[:user][:password].blank?
      # If the password is blank, remove it from the parameters
      user_params[:user].delete(:password)
      user_params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def approve_user
    if @user.update(status: 'Approved')
      UserMailer.approved_email(@user).deliver_now
      redirect_to users_path, notice:"User successfully approved!"
    else 
      redirect_to users_path, notice:@user.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email_address, :password, :password_confirmation, :full_name, :role, :status)
    end
end
