class ApiKey < ActiveRecord::Base
  belongs_to :user
  
  validates :api_key, presence: true
  validates :api_key, uniqueness: true
end
