require 'rails_helper'

RSpec.describe MetricInfo, type: :model do
  describe "validate presence of value" do
    let(:metric_info) { build(:metric_info, value: nil) }

    it { expect(metric_info).to_not be_valid }
  end

  describe "validate presence of timestamp" do
    let(:metric_info) { build(:metric_info, timestamp: nil) }

    it { expect(metric_info).to_not be_valid }
  end

  describe '#time_average' do
    let!(:metric) { create(:metric) }
    let!(:metric_infos) { create_list(:metric_info, 5, :timestamp_within_1_hour, metric: metric) }
    let(:expected_ave) { metric_infos.pluck(:value).sum.fdiv(metric_infos.pluck(:value).size) }
    let(:range) { (Time.now - 1.hour)..Time.now }

    it { expect(MetricInfo.time_average(range)).to eq(expected_ave) }
  end
end
