def login(user)
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
      flash[:success] = "You are now logged in."
      redirect_to users_path
    end


  def user_params
    params.require(:user).permit(:email, :password)
  end

end