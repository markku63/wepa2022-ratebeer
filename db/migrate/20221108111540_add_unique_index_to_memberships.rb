class AddUniqueIndexToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_index(:memberships, [:user_id, :beer_club_id], unique: true)
  end
end
