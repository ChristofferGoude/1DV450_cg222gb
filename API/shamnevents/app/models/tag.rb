class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  
  has_and_belongs_to_many :events
  
  def serializable_hash (options={})
    options = {
      only: [:name],
      methods: [:self_ref]
      }.update(options)
    super(options)
  end
  
  private
  
  def self_ref
    { :link => "#{Rails.configuration.baseurl}#{tag_path(self)}" }
  end
end
