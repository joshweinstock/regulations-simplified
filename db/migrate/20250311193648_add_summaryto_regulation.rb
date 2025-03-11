class AddSummarytoRegulation < ActiveRecord::Migration[7.1]
  def change
      add_column :regulations, :summary, :string
  end
end
