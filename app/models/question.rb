class Question < ActiveRecord::Base
  belongs_to :questionnaire

  serialize :common_answers, Hash

  attr_accessor :setting_answers
end
