require 'rails_helper'

RSpec.describe 'Metric', type: :request do
  describe 'GET /metrics' do
    let!(:metrics) { create_list(:metric, 3) }
    let(:subject) { JSON.parse(response.body) }

    before { get  '/api/v1/metrics' }

    it { expect(subject.count).to eq(3)}

    it { expect(subject.first['id']).to eq(metrics.first.id) }

    it { expect(subject.first['name']).to eq(metrics.first.name) }
  end

  describe 'POST /metrics' do
    let!(:metric) { create(:metric, name: 'Sales') }
    let(:name) { 'Production' }
    let(:params) { { metric: { name: name } } }

    before do
      post '/api/v1/metrics', params: params
    end

    context 'with valid params' do
      it { expect(response.status).to eq(201) }
    end

    context 'with no name' do
      let(:name) { nil }

      it { expect(response.status).to eq(422) }
    end

    context 'duplicate name' do
      let(:name) { 'Sales' }

      it { expect(response.status).to eq(422) }
    end
  end

  describe 'GET /metrics/:id' do
    let!(:metric) { create(:metric) }
    let!(:metric_infos) { create_list(:metric_info, 5, metric: metric) }
    let(:subject) { JSON.parse(response.body) }

    before { get "/api/v1/metrics/#{metric.id}" }

    it { expect(subject['name']).to eq(metric.name) }

    it { expect(subject['values'].count).to eq(5) }

    context 'average per minute' do
      let!(:metric_infos) { create_list(:metric_info, 5, :timestamp_within_1_min, metric: metric) }
      let(:average) { metric_infos.pluck(:value).sum.fdiv(metric_infos.pluck(:value).size) }

      it { expect(subject['average_min']).to include(average) }
    end

    context 'average per hour' do
      let!(:metric_infos) { create_list(:metric_info, 5, :timestamp_within_1_hour, metric: metric) }
      let(:average) { metric_infos.pluck(:value).sum.fdiv(metric_infos.pluck(:value).size) }

      it { expect(subject['average_hour']).to include(average) }
    end

    context 'average per day' do
      let!(:metric_infos) { create_list(:metric_info, 5, :timestamp_within_1_day, metric: metric) }
      let(:average) { metric_infos.pluck(:value).sum.fdiv(metric_infos.pluck(:value).size) }

      it { expect(subject['average_day']).to include(average) }
    end
  end
end
