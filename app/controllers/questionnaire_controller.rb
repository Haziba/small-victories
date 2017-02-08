class QuestionnaireController < ApplicationController
  helper_method :answer_colour

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

    colours = @question.last_colour.slice(/[0-9,]+/).split(',').map(&:to_i)
    @last_colour = colours[0] == 0 ? 256 + colours[1] : 256 - colours[0]
    #render text: @question.last_colour and return
    #render text: @last_colour and return

    @command = Answer.new(question_id: @question.id, when: Date.today)
  end

  def answer
    @command = Answer.new(params[:answer].permit!)

    question = Question.find(@command.question_id)

    if question.common_answers[@command.answer].nil?
      question.common_answers[@command.answer] = {
          frequency: 0,
          colour: ""
      }
    end

    question.common_answers[@command.answer][:frequency] += 1
    question.common_answers[@command.answer][:colour] = @command.colour

    @command.save
    question.save

    redirect_to questionnaire_path(question.questionnaire_id)
  end

  def answer_colour(colour)
    split = colour.slice(/[0-9,]+/).split(',').map(&:to_i)

    split[0] == 0 ? 256 + split[1] : 256 - split[0]
  end
end
