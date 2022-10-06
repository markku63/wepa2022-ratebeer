class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    # haetaan usernamea vastaava käyttäjä tietokannasta
    user = User.find_by username: params[:username]
    # talletetaan sessioon kirjautuneen käytttäjän id (jos käyttäjä on olemassa)
    session[:user_id] = user.id if user
    # uudelleenohjataan käyttäjä omalle sivulleen
    redirect_to user
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end
