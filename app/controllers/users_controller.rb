class UsersController < ApplicationController
  def new
    @user = User.new
    # Instancia um novo usuário para o form
  end

  def create
    @user = User.new(user_params)
    # Cria usuário com parâmetros vindos do form

    if @user.save
      session[:user_id] = @user.id
      # Salva o ID do usuário na sessão (login automático)

      redirect_to root_path, notice: "Cadastro realizado"
    else
      render :new, status: :unprocessable_entity
      # Re-renderiza o form caso haja erro
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
    # Strong params → segurança contra mass assignment
  end
end