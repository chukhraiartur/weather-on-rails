class ChangeDateDataTypeInCities < ActiveRecord::Migration[7.0]
  def change
    change_column :cities, :date, :string
  end
end
