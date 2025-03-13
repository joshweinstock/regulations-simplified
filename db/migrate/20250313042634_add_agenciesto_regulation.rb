class AddAgenciestoRegulation < ActiveRecord::Migration[7.1]
  def change
    add_column :regulations, :agency_names, :string
  end
end
