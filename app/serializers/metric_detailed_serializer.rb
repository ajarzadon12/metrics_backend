class MetricDetailedSerializer < ActiveModel::Serializer
  attributes :name, :values, :average_min, :average_hour, :average_day
end
