class ChangeBeers < ActiveRecord::Migration[7.0]
  def change
    change_table :beers do |t|
      t.rename :style, :old_style
    end
    add_reference :beers, :style, foreign_key: true
  end
end
