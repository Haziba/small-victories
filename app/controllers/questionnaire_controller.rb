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
  end
end
