class CreateShifts < ActiveRecord::Migration[5.0]
  def change
    create_table :shifts do |t|
      t.date :work_day
      t.time :start_at
      t.time :end_at

      t.timestamps
    end
  end
end
