# Create sample metric data
metric = Metric.create(name: 'Production')
now = Time.now
(1..1000).each do |i|
  MetricInfo.create(metric_id: metric.id, value: rand(10..50), timestamp: rand(30.days).seconds.ago)
end
