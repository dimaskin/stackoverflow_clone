class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :check_author!, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answers  = @question.answers
    @answer   = Answer.new
  end

  def new
    @question = current_user.questions.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    #byebug
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    #byebug
    redirect_to questions_url
  end

  private
  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def check_author!
    redirect_to question_path(@question) unless current_user.author?(@question)
  end

end
