module ApplicationHelper
  def formatted_date(date)
    I18n.l(date, format: :full_with_day)
  end
end
