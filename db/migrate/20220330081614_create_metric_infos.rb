class CreateMetricInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :metric_infos do |t|
      t.references :metric, null: false, foreign_key: true
      t.float :value
      t.datetime :timestamp

      t.timestamps
    end
  end
end
