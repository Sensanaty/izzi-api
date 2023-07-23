# frozen_string_literal: true

class PartsController < ApplicationController
  def index
    search = params[:query]

    @length = Part
              .where('part_number ILIKE ?', "%#{search}%")
              .includes(:company)
              .length

    @pagy, @parts = pagy(Part.where('part_number ILIKE ?', "%#{search}%").includes(:company), items: params[:count] || 25)
    @metadata = pagy_metadata(@pagy)

    render 'parts/index', status: :ok
  end
end
