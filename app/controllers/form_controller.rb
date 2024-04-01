# frozen_string_literal: true

class FormController < ApplicationController
  skip_before_action :authenticate_request

  def create
    FormMailer.with(params: form_params).contact_form.deliver_now

    head 200
  end

  private

  def form_params
    params.permit(:name, :email, :message)
  end
end
