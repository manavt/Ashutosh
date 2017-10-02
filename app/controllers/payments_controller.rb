class PaymentsController < ApplicationController
  def process_payment
  end
  def call_braintree
    @product=Product.find(params[:product_id])
    @result = Braintree::Transaction.sale(
      :amount => @product.price,
      :credit_card => {
      :number => params[:credit_card_number],
      :expiration_date => params[:date]["month"] + "/" + params[:date]["year"]
    },
    :options=> {
                store_in_vault: true,
                submit_for_settlement: true
              })
    if @result.success?
      get_current_user.update_columns({braintree_customer_id: @result.transaction.customer_details.id})
      flash[:notice] =  "Congraulations! Your transaction has been successfully!"
      redirect_to products_path
    else
      flash[:notice] =  "Transaction fail"
      redirect_to :action=>"process_payment"
    end
  end
end
