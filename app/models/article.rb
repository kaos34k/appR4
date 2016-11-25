class Article < ApplicationRecord
   include AASM
    
    belongs_to :user
    has_many :comments
    has_many :has_categories
    has_many :categories, through: :has_categories, :source => :Category   
    
    validates :title, presence: true, uniqueness: true
    validates :body, presence: true, length: {minimum:20}
    
    before_create :set_visist_count
    after_create :save_categories
    #setter
    def categories=(value)
        @categories = value
    end
    
    #scopes 
    scope :publicados,->{ where(state:"in_draf") }
    scope :ultimos,->{ order("created_at DESC") }
    
    
    aasm column: "state" do
        state :in_draf, initial: true
        state :published 
        
        event :publish do
            transitions from: :in_draf, to: :published 
        end
        
        event :unpublish do
            transitions from: :published, to: :in_draf
        end
    end    
    
    
    def update_visits_count
        self.update(visits_count: self.visits_count + 1)
    end 
    
    private 
    def save_categories
        unless @categories.nil?
           @categories.each do |category|
                HasCategory.create( Category_id: category, Article_id: self.id)
            end 
        end
    end
    
    def set_visist_count
        self.visits_count = 0
    end
end
