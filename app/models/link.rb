class Link < ApplicationRecord
	
	has_many :stats, dependent: :destroy

  validates_presence_of :url, message: 'Please check your link and try again' 
  validates :url, format: URI::regexp(%w[http https]) 
  validates_uniqueness_of :slug
  validates_length_of :url, within: 3..255, on: :create, message: "too short"  
  
  # auto slug generation
  before_validation :generate_slug, :short

  def generate_slug
    self.slug = SecureRandom.uuid[0..4] if self.slug.nil? || self.slug.empty?
    true
  end
  
  def expired?
    value = self.created_at <= 30.days.ago
    if value == true 
      self.destroy
    end
  end

  def short
   "https://www.short.com/" + self.slug
  end

  def url_exists?
    link = Link.find_by_url(self.url)
    return true if link
  end
  
end
