require 'rails_helper'

RSpec.describe Metric, type: :model do
  describe "validate presence of name" do
    let(:metric) { build(:metric, name: nil) }

    it { expect(metric).to_not be_valid }
  end

  describe "validate uniqueness of name" do
    let!(:metric) { create(:metric, name: 'Sales') }
    let(:dup_metric) { build(:metric, name: 'Sales') }

    it { expect(dup_metric).to_not be_valid }
  end

  describe '#values' do
    let!(:metric) { create(:metric) }
    let!(:metric_infos) { create_list(:metric_info, 5, metric: metric) }

    it { expect(metric.values.count).to eq(5) }
  end

  describe '#average_min' do
    let!(:metric) { create(:metric) }
    let!(:metric_infos) { create_list(:metric_info, 5, :timestamp_within_1_min, metric: metric) }
    let(:expected_ave) { metric_infos.pluck(:value).sum.fdiv(metric_infos.pluck(:value).size) }

    it { expect(metric.average_min).to include(expected_ave) }
  end

  describe '#average_hour' do
    let!(:metric) { create(:metric) }
    let!(:metric_infos) { create_list(:metric_info, 5, :timestamp_within_1_hour, metric: metric) }
    let(:expected_ave) { metric_infos.pluck(:value).sum.fdiv(metric_infos.pluck(:value).size) }

    it { expect(metric.average_hour).to include(expected_ave) }
  end

  describe '#average_day' do
    let!(:metric) { create(:metric) }
    let!(:metric_infos) { create_list(:metric_info, 5, :timestamp_within_1_day, metric: metric) }
    let(:expected_ave) { metric_infos.pluck(:value).sum.fdiv(metric_infos.pluck(:value).size) }

    it { expect(metric.average_day).to include(expected_ave) }
  end
end
