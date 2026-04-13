class ContactMailer < ApplicationMailer
  default to: -> { ENV.fetch("CONTACT_EMAIL", "digital.diary85@gmail.com") }

  def contact_message(name:, email:, message:)
    @name    = name
    @email   = email
    @message = message

    mail(
      from:    "#{@name} via Digital Apps Store <#{ApplicationMailer.default[:from]}>",
      reply_to: @email,
      subject: "New Contact Message from #{@name}"
    )
  end
end
