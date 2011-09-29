class ProductsController < ApplicationController
  def index
    @category = Category.find_by_id_and_session_id!(params[:category_id], session[:session_id])
    @products = @category.products.order(params[:order] ||= :name).paginate(:page => params[:page], :per_page => 15)
  end
  
  def show
    @product = Product.find_by_id_and_session_id!(params[:id], session[:session_id])
  end
  
  def edit
    @product = Product.find_by_id_and_session_id!(params[:id], session[:session_id])
  end
  
  def update
    @product = Product.find_by_id_and_session_id!(params[:id], session[:session_id])

    if @product.update_attributes(params[:product])
      redirect_to product_path(session[:session_secret], @product), :notice => 'Updated'
    else
      redirect_to edit_product_path(session[:session_secret], @product), :alert => @product.errors.full_messages
    end
  end
  
  def search
    @q = filter_search(params[:q])
    @products = Product.search(session[:session_id], @q).order(params[:order] ||= :name).paginate(:page => params[:page], :per_page => 15)
  end
end
