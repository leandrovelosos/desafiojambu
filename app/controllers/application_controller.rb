class ApplicationController < ActionController::Base
  helper_method :current_user
  # Permite usar current_user nas views

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # Busca o usuário logado com base na sessão
  end

  def require_login
    # Método para proteger rotas

    unless current_user
      # Se NÃO estiver logado

      redirect_to login_path, alert: "Você precisa estar logado para acessar esta página."
      # Redireciona para login
    end
  end
end