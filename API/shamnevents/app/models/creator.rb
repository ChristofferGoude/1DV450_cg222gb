class Creator < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :events
  
  has_secure_password
  
  def serializable_hash (options={})
    options = {
      only: [:name],
      methods: [:self_ref]
      }.update(options)
    super(options)
  end
  
  private
  
  def self_ref
    { :link => "#{Rails.configuration.baseurl}#{Rails.application.routes.url_helpers.creator_path(self)}" }
  end
  
  def event_ref
    event = self.event
    { 
      :name => event.name,
      :link => "#{Rails.configuration.baseurl}#{Rails.application.routes.url_helpers.event_path(event)}" }
  end
end
