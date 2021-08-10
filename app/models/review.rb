class Review < ApplicationRecord
  
#1以上5以下で星を設定
 validates :rate, numericality: {
    less_than_or_equal_to: 5, greater_than_or_equal_to: 1
  }, presence: true
end
