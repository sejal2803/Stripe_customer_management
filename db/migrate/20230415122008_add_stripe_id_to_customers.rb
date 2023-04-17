class AddStripeIdToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :stripe_id, :string
  end
end
