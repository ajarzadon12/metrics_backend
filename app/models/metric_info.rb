class MetricInfo < ApplicationRecord
  belongs_to :metric

  validates_presence_of :value, :timestamp

  scope :last_30_days, -> { where(timestamp: (Time.now.tomorrow.midnight - 30.day)..Time.now.tomorrow.midnight).order('timestamp ASC') }
  scope :by_time_range, ->(range) { where(timestamp: range) }

  def self.time_average(range)
    by_time_range(range).average(:value).to_f || 0
  end
end
