class MainController < ApplicationController

    before_action :set_user, only: %i[ main ]

  def main
    session[:user_id]=nil
  end

  def login

    @email= params[:email]
    @pass= params[:pass]
    @user = User.find_by(email:@email.to_s)

    respond_to do |format|
      if @user && @user.authenticate(@pass)
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: "User was successfully login." }
        format.json { render :show, status: :created, location: @user }
      else
        session.delete(:user_id)
        format.html { redirect_to '/main', alert: "Your email or password is invalid." }
        format.json { render json: @user.errors,status: :unprocessable_entity}
      end
    end

  end



  def set_user
      @user = User.new
  end


end
