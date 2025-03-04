class CreateAgencies < ActiveRecord::Migration[7.1]
  def change
    create_table :agencies do |t|

      t.timestamps
    end
  end
end
