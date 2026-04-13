class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("SMTP_FROM", "digital.diary85@gmail.com")
  layout "mailer"
end
