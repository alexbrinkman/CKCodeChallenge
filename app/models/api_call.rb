class ApiCall < ActiveRecord::Base
  validates_presence_of :source, :status
end
