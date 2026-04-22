class SessionsController < ApplicationController
  def new
    # Apenas renderiza a tela de login
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    # Busca usuário pelo email

    if user&.authenticate(params[:password])
      # authenticate vem do has_secure_password

      session[:user_id] = user.id
      # salva na sessão

      redirect_to root_path, notice: "Login realizado"
    else
      flash.now[:alert] = "Email ou senha inválidos"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    # remove usuário da sessão

    redirect_to root_path, notice: "Sessão encerrada"
  end
end