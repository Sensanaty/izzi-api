# frozen_string_literal: true

class PartsController < ApplicationController
  def index
    parts = Part.all

    render json: PartSerializer.new(parts).serializable_hash.to_json, status: :ok
  end

end
