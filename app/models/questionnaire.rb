class Questionnaire < ActiveRecord::Base
  validates :name, presence: true
  validates :questionnaire_type, presence: true
end