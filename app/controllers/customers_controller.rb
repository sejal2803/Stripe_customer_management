class CustomersController < ApplicationController
  def index
    @customers = Stripe::Customer.list(limit: 10)
  end

  def show
    @customer = Stripe::Customer.retrieve(params[:id])
  end

  def edit
    @customer = Stripe::Customer.retrieve(params[:id])
  end

  def create
    customer = Stripe::Customer.create(
      email: params[:email]
    )
  
    if customer.save
      redirect_to customers_path, notice: "Customer created successfully"
    else
      flash[:error] = "Failed to create customer"
      redirect_to new_customer_path
    end
  end
  

  def update
    if Stripe::Customer.update(params[:id], { email: params[:email] })
    redirect_to customer_path(params[:id])
    else
      flash[:error] = "Failed to update customer"
      redirect_to edit_customer_path(params[:id])
    end
  end
  

  def destroy
    customer = Stripe::Customer.retrieve(params[:id])
  
    if customer.delete
      redirect_to delete_customer_path
    else
      flash[:error] = "Failed to delete customer"
      redirect_to customers_path
    end
  end
  
end
