class Event < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  validates :name, presence: true
  
  belongs_to :creator
  has_many :tags
  
  accepts_nested_attributes_for :tags

  def serializable_hash (options={})
    options = {
      only: [:name, :address, :latitude, :longitude],
      include: [:tags],
      methods: [:self_ref]
    }.update(options)

    super(options)
  end

  def self_ref
    { :link => "#{Rails.configuration.baseurl}#{Rails.application.routes.url_helpers.event_path(self)}.json" }
  end 

  def creator_ref
    creator = self.creator
    { 
      :name => creator.name,
      :creator_id => creator.id,
      :link => "#{Rails.configuration.baseurl}#{Rails.application.routes.url_helpers.creator_path(creator)}" 
    }
  end
end  


