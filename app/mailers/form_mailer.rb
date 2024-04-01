# frozen_string_literal: true

class FormMailer < ApplicationMailer
  def contact_form
    @email = params[:email]
    @name = params[:name]
    @message = params[:message]

    mail(to: 'salevic@lu-ka.me', subject: 'New response via contact form')
  end
end
