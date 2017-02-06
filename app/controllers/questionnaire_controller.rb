class QuestionnaireController < ApplicationController
  def index
    @questionnaires = Questionnaire.all
  end

  def new
    @command = Questionnaire.new
  end

  def create
    @questionnaire = Questionnaire.new(params[:questionnaire].permit!)

    unless @questionnaire.valid?
      render :new and return
    end

    @questionnaire.save

    redirect_to questionnaire_index_path
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])

    @question = @questionnaire.questions.first

    @command = Answer.new(question_id: @question.id, when: Date.today)
  end

  def answer
    @command = Answer.new(params[:answer].permit!)

    question = Question.find(@command.question_id)

    if question.common_answers[@command.answer].nil?
      question.common_answers[@command.answer] = 0
    end

    question.common_answers[@command.answer] += 1

    @command.save
    question.save

    redirect_to questionnaire_path(question.questionnaire_id)
  end
end
