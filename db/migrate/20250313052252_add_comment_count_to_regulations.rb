class AddCommentCountToRegulations < ActiveRecord::Migration[7.1]
  def change
    add_column :regulations, :comment_count, :integer
  end
end
