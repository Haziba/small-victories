class Questionnaire < ActiveRecord::Base
  has_many :questions

  validates :name, presence: true
  validates :questionnaire_type, presence: true
end