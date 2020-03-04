class Merchant::DiscountsController < Merchant::BaseController

  def index
    @discounts = Discount.all
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
  end

  def create
    merchant = current_user.merchant
    discount = merchant.discounts.new(discount_params)
    if discount.save
      flash[:notice] = "Your discount has been added."
      redirect_to "/merchant/discounts"
    else
      flash[:notice] = discount.errors.full_messages.to_sentence
      redirect_to "/merchant/discounts/new"
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    merchant = current_user.merchant
    discount = Discount.find(params[:id])
    if discount.update(discount_params)
      flash[:notice] = "Your discount changes have been saved."
      redirect_to "/merchant/discounts/#{discount.id}"
    else
      flash[:notice] = "Your discount changes have not been saved."
      redirect_to "/merchant/discounts/#{discount.id}/edit"
    end
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchant/discounts"
  end

  private

    def discount_params
      params.permit(:description, :item_threshold, :percent_discount)
    end

end
