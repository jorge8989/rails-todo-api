class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :text
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
