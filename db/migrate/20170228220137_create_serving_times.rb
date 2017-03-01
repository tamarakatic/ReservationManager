class CreateServingTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :serving_times do |t|

      t.timestamps
    end
  end
end
