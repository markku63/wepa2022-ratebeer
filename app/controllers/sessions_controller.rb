class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    # haetaan usernamea vastaava käyttäjä tietokannasta
    user = User.find_by username: params[:username]
    # tarkastetaan että käyttäjä on olemassa ja salasana on oikea
    if user && user.authenticate(params[:password])
      # talletetaan sessioon kirjautuneen käytttäjän id (jos käyttäjä on olemassa)
      session[:user_id] = user.id if user
      # uudelleenohjataan käyttäjä omalle sivulleen
      redirect_to user, notice: "Welcome back!"
    else
      redirect_to signin_path, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end
