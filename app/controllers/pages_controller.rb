class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  before_action :set_locale, only: [:results]

  def home
  end

  def dashboard
    @popular_perfume = Perfume.joins(:results).group('perfumes.id').order('count(results.id) DESC').first
  end

  def favorites
    @favorites = current_user.favorite_perfumes
  end

  def infos
    @infos = current_user
  end

  def results
    @results = current_user.results
    @perfumes_result = @results.map do |result|
      PerfumesResult.find_by(result_id: result.id)
    end.compact

    all_perfumes = @perfumes_result.map do |perfumes_result|
      if perfumes_result.present?
        perfume_ids = perfumes_result.perfume_ids.split(',')
        Perfume.where(id: perfume_ids).to_a
      end
    end.compact.flatten
    @perfumes = all_perfumes.take(5)
  end


  def apropos
  end

  private

  def set_locale
    I18n.locale = :fr
  end
end
