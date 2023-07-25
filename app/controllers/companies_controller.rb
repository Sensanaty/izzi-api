# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]

  def index
    search = params[:query]

    @companies = Company.order(updated_at: :desc).where('name ILIKE ?', "%#{search}%").all

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
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.fetch(:company, {})
  end
end
