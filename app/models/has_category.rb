class HasCategory < ApplicationRecord
  belongs_to :Article
  belongs_to :Category
end
