class Export
  def self.in_json
    all_product = Product.includes(:images).collect {|a|
      { id: a.id,
        title: a.title,
        brand: a.brand,
        size: a.size,
        price: a.price,
        images: a.images.map{|b| b.photo.path
       }
       }
     }.to_json
     File.open("#{Rails.root}/public/product.json", "w") {|foo| foo.write(all_product)}
  end
  def self.to_xml
    all_product = Product.includes(:images).collect {|a|
      { id: a.id,
        title: a.title,
        brand: a.brand,
        size: a.size,
        price: a.price,
        images: a.images.map{|b| b.photo.path
       }
       }
     }.to_xml
     File.open("#{Rails.root}/public/product.xml", "w") {|foo| foo.write(all_product)}
  end
end
