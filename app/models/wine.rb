class Wine < ActiveRecord::Base 
  belongs_to :user
  self.inheritance_column = nil
end