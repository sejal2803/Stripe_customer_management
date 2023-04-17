class PaymentsController < ApplicationController
  include Stripe

  def new
    @payment = Payment.new
  end

  def create
    @amount = params[:amount]
    service = PaymentService.new(params)
    session = service.create_checkout_session(params[:product_name])
    redirect_to session.url

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  def success
    # Handle successful payment
    # You can access the Checkout Session ID via params[:session_id]
    flash[:success] = "Payment successful!"
    redirect_to root_path
  end

  def cancel
    flash[:error] = "Payment cancelled."
    redirect_to products_path
  end
end