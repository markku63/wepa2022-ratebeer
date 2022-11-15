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
      redirect_to membership_url(@membership), notice: "Membership was succesfully created"
    else
      @memberships = Membership.all
      render :new, status: :unprocessable_entity
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
