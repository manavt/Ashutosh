class Import
  def self.source_json
    JSON.parse(File.open("#{Rails.root}/public/product.json", "r").collect{|row| row}.last).each do |product|
      images = product["images"]
      product.delete("images")
      product.delete("id")
      p = Product.new(product)
      if p.save and !images.blank?
       images.each do | image |
         ima = Image.new(photo: File.open(image), entity: p)
         ima.save(validate: false)
       end
      end
    end
  end

end
