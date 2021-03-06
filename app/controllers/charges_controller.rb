class ChargesController < ApplicationController
  def create
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}!  You now have a premium WikiLand account!  Feel free to pay me again."

    current_user.update_attribute(:role, "premium")

    redirect_to root_path # Or wherever

    # Stripe will send back CardErrors, with friendly messages when something goes wrong.
    # This rescue block catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: Amount.default
    }
  end

  def destroy
    if current_user.update_attributes(role: "standard")
      flash[:notice] = "You now have a standard WikiLand account.  Feel free to upgrade back to premium at anytime!"
      redirect_to root_path
    else
      flash[:error] = "There was an error downgrading your account.  Please contact technical support."
      redirect_to edit_user_registration_path
    end
  end
end