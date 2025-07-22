class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :residence
  belongs_to :room_type 
end
