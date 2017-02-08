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

    @command.save

    redirect_to questionnaire_path(params[:questionnaire_id])
  end
end