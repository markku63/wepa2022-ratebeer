class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show edit update destroy]
  before_action :set_beer_clubs, only: %i[new edit create]

  def index
    @memberships = Membership.all
  end

  def show
  end

  def new
    @membership = Membership.new
  end

  def edit
  end

  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    @membership.user = current_user

    if @membership.save
      redirect_to beer_club_url(@membership.beer_club), notice: "#{current_user.username} welcome to the club"
    else
      @memberships = Membership.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to user_path current_user, notice: "Membership has ended" }
      format.json { head :no_content }
    end
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def set_beer_clubs
    memberships_of_current = current_user.memberships.map(&:beer_club)
    @beer_clubs = BeerClub.where.not(id: memberships_of_current)
  end
end
