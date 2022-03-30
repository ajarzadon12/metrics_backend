class Metric < ApplicationRecord
  has_many :metric_infos, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: true

  def values
    metric_infos.last_30_days.map do |metric_info|
      [metric_info.timestamp.to_i * 1000, metric_info.value]
    end
  end

  def average_min
    now = Time.now
    (1..60).map do |i|
      metric_infos.time_average((now - (i).minute)..(now - (i-1).minute))
    end.reverse
  end

  def average_hour
    now = Time.now
    (1..24).map do |i|
      metric_infos.time_average((now - (i).hour)..(now - (i-1).hour))
    end.reverse
  end

  def average_day
    now = Time.now
    (1..30).map do |i|
      metric_infos.time_average((now - (i).day)..(now - (i-1).day))
    end.reverse
  end
end
