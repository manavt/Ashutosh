class ImportImages
  def self.import_to_image
    images = Image.all
    images.each do | image |
       unless image.user_id.blank?
         puts "Importing for user"
           image.entity_id = image.user_id
           image.entity_type = "User"
           image.save
         else
           puts "Importing for Product"
           image.entity_id = image.product_id
           image.entity_type = "Product"
           image.save
       end
    end
  end
end
