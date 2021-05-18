# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@cannabishouse.eu'
  layout 'mailer'
end
