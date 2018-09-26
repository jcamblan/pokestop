module SessionsHelper

  # On crée une session pour l'utilisateur
  # ==================================================

  def log_in(user)
    session[:user_id] = user.id
  end

  # On enregistre la session de l'utilisateur dans un cookie
  # ==================================================

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # On récupère les données de l'utilisateur connecté
  # ==================================================
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Est-ce qu'il y a un utilisateur connecté ?
  # ==================================================
  def logged_in?
    !current_user.nil?
  end

  # On supprime le cookie d'un utilisateur
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # On supprime la session
  # ==================================================
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
end
