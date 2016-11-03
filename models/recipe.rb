
CarrierWave.configure do |config|
  config.fog_credentials = {
    
    # Configuration for Amazon S3
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET'],
    :region                => 'ap-southeast-2', # sydney
    :host   => 's3-ap-southeast-2.amazonaws.com'
  }

  config.storage = :fog
  config.fog_directory    = ENV['S3_BUCKET']
end

class MyUploader < CarrierWave::Uploader::Base
  storage :fog
end


class Recipe < ActiveRecord::Base
  has_many :links
  has_many :categories, through: :links

  belongs_to :user
  mount_uploader :recipe, MyUploader
  mount_uploader :photo, MyUploader

end
