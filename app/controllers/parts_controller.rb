# frozen_string_literal: true

class PartsController < ApplicationController
  include CsvExportable

  rescue_from Pagy::OverflowError, with: :page_overflow

  def index
    search = params[:query] || ''

    query = Part.where('part_number ILIKE ?', "%#{search}%")

    @length = query.count

    @pagy, @parts = pagy(
      query.includes(:company).order(updated_at: :desc),
      items: params[:count] || 20
    )
    @metadata = pagy_metadata(@pagy)

    render 'parts/index', status: :ok
  end

  def versions
    part = Part.find(params[:id])
    versions_data = part.versions.order(created_at: :desc)

    company_ids = versions_data.map { |version| version.object['company_id'] }.compact.uniq
    # Fetch all relevant companies in one query
    companies = Company.where(id: company_ids).index_by(&:id)

    @versions = versions_data.map do |version|
      version_data = version.as_json
      company_id = version.object['company_id']
      version_data['object'] = version.object.merge('company_name' => companies[company_id]&.name)

      version_data
    end

    render 'parts/versions', status: :ok
  end

  def delete_versions
    @part = Part.find(params[:id])
    if @part.versions.destroy_all
      head :no_content
    else
      render json: { error: @part.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    @part = Part.new(part_params)

    if @part.save
      @company_name = @part.company.name
      render 'parts/show', status: :ok
    else
      render json: { error: @part.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @part = Part.includes(:company).find(params[:id])

    render 'parts/show', status: :ok
  end

  def update
    @part = Part.includes(:company).find(params[:id])

    if @part.update(part_params)
      render 'parts/show', status: :ok
    else
      render json: { error: @part.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def export
    @parts = Part.all.includes(:company)

    export_csv(@parts)
  end

  private

  def page_overflow
    render json: { error: 'Page is not in valid range' }, status: :unprocessable_entity
  end

  def part_params
    params.permit(
      :id,
      :part_number,
      :description,
      :available,
      :reserved,
      :sold,
      :condition,
      :min_cost,
      :min_price,
      :min_order,
      :med_cost,
      :med_price,
      :med_order,
      :max_cost,
      :max_price,
      :max_order,
      :lead_time,
      :quote_type,
      :tag,
      :internal_note,
      :added,
      :company_id,
    )
  end
end
