# app/controllers/results_controller.rb
class ResultsController < ApplicationController
  before_action :authenticate_user!

  def new
    @result = Result.new
    @questions = questions
  end

  def create
    @result = Result.new(result_params)
    @result.user_id = current_user.id
    if @result.save
      redirect_to result_path(@result), notice: 'Résultats enregistrés avec succès'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @results = current_user.results
  end

  def show
    @result = Result.find(params[:id])
    @perfumes = filter_perfumes(@result)
    @perfumes_count = @perfumes.count
    @perfumes_result = PerfumesResult.new(perfume_ids: @perfumes.ids, result_id: @result.id)
    @perfumes_result.save
  end

  private

  def result_params
    params.require(:result).permit(:name, :description, :answer_1, :answer_2, :answer_3, :answer_4, :answer_5, :answer_6, :answer_7, :answer_8, :answer_9, :answer_10, :budget_min, :budget_max)
  end

  def filter_perfumes(result)
    perfumes = Perfume.all

    # Filtrer par genre
    if ["Pour femme", "Pour homme"].include?(result.answer_2)
      perfumes = perfumes.where(genre: result.answer_2)
    end

     # Filtrer par intensité
    case result.answer_3
    when "Ne passe pas inaperçu"
      perfumes = perfumes.where(intensity: 3..5)
    when "Est plutôt intime, juste pour vous"
      perfumes = perfumes.where(intensity: 1..3)
    end

    # Filtrer par période
    if ["Journée", "Soirée"].include?(result.answer_4)
      perfumes = perfumes.where(period: result.answer_4)
    end

    # Filtrer par season
    if ["Plutôt l’été", "Plutôt l’hiver"].include?(result.answer_5)
      perfumes = perfumes.where(season: result.answer_5)
    end

    # Filtrer par price
    # case answer_6
    # when
    # end

    # Filtrer par situations
    if ["Un week-end intense", "Un déjeuner entre amis", "Un moment cocooning"].include?(result.answer_7)
      perfumes = perfumes.where(situations: result.answer_7)
    end

    # Filtrer par smells
    answer_8_array = result.answer_8.split(",")
    if ["Un jus d’agrumes vitaminé", "Un bouquet de fleurs", "Un fruit frais ou sucré", "Un dessert très gourmand", "Une balade en forêt", "Un bouquet d’herbes et aromates", "Des embruns rafraichissants", "Un souvenir de vacances épicé", "Un cocktail intense et puissant"].include?(answer_8_array[0])
      perfumes = perfumes.where(smell: answer_8_array[0].to_s)
    end
    perfumes
  end

  def questions
    [
      {
        question: "A qui est destiné le parfum ?",
        answers: ["A un proche", "A vous même"]
      },
      {
        question: "Quel type de parfum cherchez-vous ?",
        answers: ["Pour femme", "Pour homme", "Mixte"]
      },
      {
        question: "Un parfum qui :",
        answers: ["Ne passe pas inaperçu", "Est plutôt intime, juste pour vous"]
      },
      {
        question: "Un parfum à porter :",
        answers: ["Journée", "Soirée", "Tout le temps"]
      },
      {
        question: "Un parfum à porter :",
        answers: ["Plutôt l'été", "Plutôt l’hiver", "Toute l’année"]
      },
      {
      question: "Quel est votre budget ?",
      answers: { budget_min: 0, budget_max: 300 }
      },
      {
        question: "Un parfum pour :",
        answers: ["Un week-end intense", "Un déjeuner entre amis", "Un moment cocooning", "Toute occasion"]
      },
      {
        question: "Un parfum qui évoque :",
        answers: ["Un jus d’agrumes vitaminé", "Un bouquet de fleurs", "Un fruit frais ou sucré", "Un dessert très gourmand", "Une balade en forêt", "Un bouquet d’herbes et aromates", "Des embruns rafraichissants", "Un souvenir de vacances épicé", "Un cocktail intense et puissant"]
      }
    ]
  end
end
