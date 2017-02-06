class QuestionController < ApplicationController
  def new
    @command = Question.new

    @questionnaire = Questionnaire.find(params[:questionnaire_id])
  end

  def create
    @command = Question.new(params[:question].permit!)

    Questionnaire.find(params[:questionnaire_id]).questions.append(@command)

    unless @command.valid?
      @questionnaire = Questionnaire.find(params[:questionnaire_id])

      render :new and return
    end

    if @command.question_type.to_sym == :radio_list
      @command.common_answers = @command.setting_answers.split(',').map { |answer| [answer, 0] }.to_h
    end

    @command.save

    redirect_to questionnaire_path(params[:questionnaire_id])
  end
end