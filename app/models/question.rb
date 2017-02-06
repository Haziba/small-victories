class Question < ActiveRecord::Base
  has_many :answers

  belongs_to :questionnaire

  serialize :common_answers, Hash

  attr_accessor :setting_answers
end
