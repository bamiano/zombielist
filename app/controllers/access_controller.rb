class AccessController < ApplicationController

  before_action :confirm_logged_in, except: [:new, :create, :attempt_login, :login, :logout, :send_reset, :forgot_password, :reset_password, :update_password]
  before_action :prevent_login_signup, only: [:login, :new]

  def new
    @user = User.new
  end

  def favorites

  end

  def create
    @user = User.create(user_params)
    if(@user.save)
      UserMailer.signup_confirmation(@user).deliver
      # .deliver - method that action mailer and rails knows
      session[:user_id] = @user.id
      # session[:is_admin] = @user.is_admin
      flash[:success] = "You have create an account!"
      redirect_to users_path
    else
      render :new
    end

  end

  def login
    @user = User.new
  end

  def attempt_login

    if params[:email].present? && params[:password].present?
      found_user = User.where(email: params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if !found_user
      flash.now[:alert] = "Invalid email"
      render :login
    elsif !authorized_user
      flash.now[:alert] = "Invalid password"
      # use .now when rendering a new page, instead of redirecting to a page
      render :login
    else
      session[:user_id] = authorized_user.id
      # session[:is_admin] = authorized_user.is_admin
      flash[:success] = "You are now logged in!"
      redirect_to users_path
    end

  end

  def logout
    # mark user as logged out
    session[:user_id] = nil

    flash[:notice] = "Logged out"
    redirect_to login_path
  end


  def reset_password
    @token = params[:token]
    @user = User.find_by :reset_token => @token
    if @user.nil?
      flash[:error] = "Invalid reset token"
      render :login
    else
      render :reset_password
    end
  end

  #post '/send_reset' => 'user#reset_password'
  def send_reset
    # email in param
    email = params[:email]
    user =  User.find_by email: email
    if user.nil?
      flash[:error] = "No such user:" + email
    else
      # create and save reset token on user
      reset_token = (0...16).map { (65 + rand(26)).chr }.join
      user.update_attributes(reset_token: reset_token)
      UserMailer.forgot_password_email(user).deliver
      flash[:success] = "Please check your email for reset instructions ..."
    end
      redirect_to :login
  end

  def forgot_password
    render :forgot_password
  end

  def update_password
  # do I need to include the password_confirmation?

    user_params = params.permit(:email, :password, :password_confirmation)
    @user = User.find_by email: user_params[:email]
    @user.update_attributes(password: user_params[:password], password_confirmation: user_params[:password_confirmation])
    flash[:success] = "Your password has changed, try it out ..."
    render :login
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :zipcode)
  end

end
