class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
  end

  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all - current_user.beer_clubs
  end

  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    @membership.user = current_user

    if @membership.save
      redirect_to user_path current_user
    else
      @memberships = Membership.all
      render :new, status: :unprocessable_entity
    end
  end
end
