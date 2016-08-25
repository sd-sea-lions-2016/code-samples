class Contact < ActiveRecord::Base
  # Remember to create a migration!
  validates_presence_of :first_name
  # What validations would you create here?
end
