module ApplicationHelper
  def lnil(date)
    date.nil? ? 'не указано' : l(date)
  end
end
