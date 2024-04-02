# frozen_string_literal: true

class FormController < ApplicationController
  skip_before_action :authenticate_request

  def create
    FormMailer.with(
      { name: form_params[:name], email: form_params[:email], message: [form_params[:message]] }
    ).contact_form.deliver_now

    head 200
  end

  private

  def form_params
    params.permit(:name, :email, :message)
  end
end
