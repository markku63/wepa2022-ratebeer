class AddUniqueIndexToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_index(:memberships, [:user, :beer_club], unique: true)
  end
end
