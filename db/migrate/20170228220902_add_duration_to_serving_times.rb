class AddDurationToServingTimes < ActiveRecord::Migration[5.0]
  def change
    add_column :serving_times, :duration, :decimal, :precision => 4, :scale => 2
  end
end
