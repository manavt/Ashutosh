require 'csv'
class ProductsController < ApplicationController
  def index
    #@products = Product.all
    @products = Product.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @product = Product.new
  end

  def create
    image_attributes = product_params[:image]
    product_params.delete(:image)
    @product = Product.new(product_params)
    if @product.save
       image_attributes[:photo].each do | image |
         img = Image.new(photo: image, product: @product)
         img.save(validate: false)
       end
       redirect_to products_path
     else
       render :new
    end
  end
  def show
  end

  def edit
  end
  def download_in_csv
   CSV.open("#{Rails.root}/public/product.csv", "a+") do |csv|
    #headers
    csv << (Product.column_names + ["image"])
    Product.pluck(Product.column_names.join(",")).each do | product |
      if not Product.find(product.first).images.blank?
        images = Product.find(product.first).images.collect {|a| a.photo.path}
      else
        images = ["NO image"]
      end
      csv << (product + images)
    end
   end
   send_file "#{Rails.root}/public/product.csv", :disposition => 'downloaded'
  end
  private
  def product_params
    params.require(:product).permit!
  end
end
