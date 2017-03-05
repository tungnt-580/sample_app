class AddMicropostsCount < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :microposts_count, :integer, default: 0
  end
end
