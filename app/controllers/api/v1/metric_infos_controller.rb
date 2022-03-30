class Api::V1::MetricInfosController < ApplicationController
  def create
    @metric_info = MetricInfo.new(metric_info_params)
    if @metric_info.save
      render json: @metric_info, status: :created
    else
      render json: @metric_info.errors, status: :unprocessable_entity
    end
  end

  private

  def metric_info_params
    params.require(:metric_info).permit(:metric_id, :value, :timestamp)
  end
end
