class CreateRegulations < ActiveRecord::Migration[7.1]
  def change
    create_table :regulations do |t|
      t.string :register_url
      t.string :document_number
      t.string :pdf_url
      t.string :title
      t.string :action
      t.string :original_url
      t.string :raw_url
      t.integer :comment_count
      t.string :citation
      t.boolean :significant

      t.timestamps
    end
  end
end
