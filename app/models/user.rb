class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true,  on: :create
  validates :mobile, presence: true, numericality: true
  has_one :image , as: :entity
  accepts_nested_attributes_for :image
  before_save :encrypt_password
  def encrypt_password
    unless provider == "facebook"
      self.password = Digest::MD5.hexdigest(password)
      self.confirm_password = Digest::MD5.hexdigest(confirm_password)
    end
  end

  def self.db_authenticate(user_cred)
    user_cred["password"] = Digest::MD5.hexdigest(user_cred["password"])
    where(user_cred).last
  end
  before_destroy :take_backup
  def take_backup
     File.open("#{Rails.root}/public/#{self.id}.json", "w") {|foo| foo.write(self.to_json)}
  end
  def self.omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.token = auth.credentials.token
      user.email = auth.info.email
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save(validate: false)
      im = Image.new(photo: "http://graph.facebook.com/v2.6/860101950679738/picture", entity: user)
      im.save(validate: false)
      user.image = im
      user.save(validate: false)
      return user
    end
  end
end
