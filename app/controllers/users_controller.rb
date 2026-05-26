class UsersController < ApplicationController 
  allow_unauthenticated_access only: %i[ new create]
  layout "signup"

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)

    if @user.save
      redirect_to new_session_path, notice: "Cadastro realizado. Faça login"
    else 
      p @user.errors.full_messages
      render :new, status: :unprocessable_entity, error: "Verifique os campos em vermelho!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
