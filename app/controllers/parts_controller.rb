# frozen_string_literal: true

class PartsController < ApplicationController
  def index
    @pagy, @parts = pagy(Part.includes(:company), items: params[:count] || 25)
    @metadata = pagy_metadata(@pagy)

    render 'parts/index', status: :ok
  end
end
