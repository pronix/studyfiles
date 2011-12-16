class ImagePreview < ActiveRecord::Base
  has_attached_file :asset, :styles => {:full => "130x130", :thumb => "60x60>", :icon => "32x32" }
end
