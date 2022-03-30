require 'rails_helper'

RSpec.describe 'MetricInfos', type: :request do
  describe 'POST /metric_infos' do
    let(:metric) { create(:metric) }
    let(:metric_id) { metric.id }
    let(:value) { 12 }
    let(:timestamp) { DateTime.now }
    let(:params) do
      {
        metric_info: {
          metric_id: metric_id,
          value: value,
          timestamp: timestamp
        }
      }
    end

    before do
      post '/api/v1/metric_infos', params: params
    end

    context 'with valid params' do
      it { expect(response.status).to eq(201) }
    end

    context 'with invalid metric_id' do
      let(:metric_id) { nil }

      it { expect(response.status).to eq(422) }
    end

    context 'with no value' do
      let(:value) { nil }

      it { expect(response.status).to eq(422) }
    end

    context 'with no timestamp' do
      let(:timestamp) { nil }

      it { expect(response.status).to eq(422) }
    end
  end
end
