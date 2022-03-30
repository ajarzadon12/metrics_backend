class Api::V1::MetricsController < ApplicationController
  def index
    @metrics = Metric.all
    render json: @metrics, each_serializer: MetricSerializer
  end

  def create
    @metric = Metric.new(metric_params)
    if @metric.save
      render json: @metric, status: :created, serializer: MetricSerializer
    else
      render json: @metric.errors, status: :unprocessable_entity
    end
  end

  def show
    @metric = Metric.find(params[:id])
    render json: @metric, serializer: MetricDetailedSerializer
  end

  private

  def metric_params
    params.require(:metric).permit(:name)
  end
end
