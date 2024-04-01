# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/form_mailer
class FormMailerPreview < ActionMailer::Preview
  def contact_form
    FormMailer.with(name: 'John Doe', email: 'john@doe.com', message: 'Test').contact_form
  end
end
