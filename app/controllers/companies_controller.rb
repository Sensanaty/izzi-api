# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]

  def index
    @companies = Company.all.order(parts_count: :desc)

    render 'companies/index', status: :ok
  end

  def show
    render json: @company
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      render json: @company, status: :created, location: @company
    else
      render json: { error: @company.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: { error: @company.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
  end

  def parts
    @company = Company.find(params[:id])
    # noinspection RubyArgCount
    limited_parts = @company.parts
                            .select(:id, :part_number, :description, :tag)
                            .order(updated_at: :desc)
                            .limit(100)

    render json: limited_parts, status: :ok
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.permit(:id, :name, :address, :city, :country, :website, :type, :subscription)
  end
end
