class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    # haetaan usernamea vastaava käyttäjä tietokannasta
    user = User.find_by username: params[:username]
    # tarkastetaan että käyttäjä on olemassa ja salasana on oikea
    if user.nil? || !user&.authenticate(params[:password])
      redirect_to signin_path, notice: "Username and/or password mismatch"
    elsif user.closed?
      redirect_to signin_path, notice: "account closed, please contact admin"
    else
      # talletetaan sessioon kirjautuneen käytttäjän id (jos käyttäjä on olemassa)
      session[:user_id] = user.id if user
      # uudelleenohjataan käyttäjä omalle sivulleen
      redirect_to user, notice: "Welcome back!"
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end
