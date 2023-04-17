class PaymentService
  def initialize(params)
    @params = params
  end

  def create_checkout_session(product_name)
    payment_method = Stripe::PaymentMethod.create(
      type: 'card',
      card: {
        token: @params[:stripeToken]
      }
    )

    customer = Stripe::Customer.create(
      email: @params[:stripeEmail]
    )

    Stripe::PaymentMethod.attach(
      payment_method.id,
      { customer: customer.id }
    )

    Stripe::Customer.update(
      customer.id,
      invoice_settings: {
        default_payment_method: payment_method.id
      }
    )

    session = Stripe::Checkout::Session.create(
      line_items: [{
        price_data: {
          currency: 'usd',
          unit_amount: Integer(@params[:amount].to_i)*100,
          product_data: {
            name: product_name,
          }
        },
        quantity: 1
      }],
      payment_method_types: ['card'],
      mode: 'payment',
      payment_intent_data: {
        setup_future_usage: 'off_session',
        description: product_name
      },
      success_url: 'http://localhost:3000/payments/success',
      cancel_url: 'http://localhost:3000/payments/cancel'
    )

    return session
  end
end