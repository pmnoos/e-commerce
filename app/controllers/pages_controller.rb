class PagesController < ApplicationController
  layout "storefront"

  def django_diary; end

  def privacy; end

  def terms; end

  def refunds; end

  def contact; end

  def contact_submit
    name    = params[:name].to_s.strip
    email   = params[:email].to_s.strip
    message = params[:message].to_s.strip

    if name.blank? || email.blank? || message.blank?
      flash[:error] = "Please fill in all fields."
      redirect_to contact_path and return
    end

    unless email.match?(/\A[^@\s]+@[^@\s]+\z/)
      flash[:error] = "Please enter a valid email address."
      redirect_to contact_path and return
    end

    ContactMailer.contact_message(name: name, email: email, message: message).deliver_later
    flash[:notice] = "Thanks #{name}, your message has been sent! We'll reply within 24 hours."
    redirect_to contact_path
  end
end
