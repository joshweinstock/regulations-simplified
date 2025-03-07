class AddUserReferenceToRegulations < ActiveRecord::Migration[7.1]
  def change
    add_reference :regulations, :user, foreign_key: true
  end
end
