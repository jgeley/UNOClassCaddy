class AddDayToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :day, :string
  end
end
