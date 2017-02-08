class ReportController < ApplicationController
  def show
    @questionnaire = Questionnaire.find(params[:questionnaire_id])

    answer_dates = @questionnaire.questions.flat_map { |q| q.answers.map(&:when) }

    @start_date = answer_dates.min.to_date
    @end_date = answer_dates.max.to_date
  end
end