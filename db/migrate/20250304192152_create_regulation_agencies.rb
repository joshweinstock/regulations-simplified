class CreateRegulationAgencies < ActiveRecord::Migration[7.1]
  def change
    create_table :regulation_agencies do |t|
      t.integer :agency_id
      t.integer :regulation_id

      t.timestamps
    end
  end
end
