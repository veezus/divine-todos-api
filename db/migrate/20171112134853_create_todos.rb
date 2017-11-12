class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :checked_at

      t.timestamps
    end
  end
end
