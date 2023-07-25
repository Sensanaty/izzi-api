# frozen_string_literal: true

class PartsController < ApplicationController
  rescue_from Pagy::OverflowError, with: :page_overflow

  def index
    search = params[:query]

    @length = Part
              .where('part_number ILIKE ?', "%#{search}%")
              .includes(:company)
              .length

    @pagy, @parts = pagy(
      Part
        .order(updated_at: :desc)
        .where('part_number ILIKE ?', "%#{search}%")
        .includes(:company), items: params[:count] || 25
    )
    @metadata = pagy_metadata(@pagy)

    render 'parts/index', status: :ok
  end

  def show
    @part = Part.includes(:company).find(params[:id])

    render 'parts/show', status: :ok
  end

  private

  def page_overflow
    render json: { error: 'Page is not in valid range' }, status: :unprocessable_entity
  end
end
