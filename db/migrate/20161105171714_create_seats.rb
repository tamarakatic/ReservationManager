class CreateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :seats do |t|
      t.integer :number
      t.string :type

      t.timestamps
    end
  end
end
