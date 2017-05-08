class Order < ActiveRecord::Base
  belongs_to :automobile
  belongs_to :tariff

  validate :time_of_travel_cannot_be_in_the_past
  validates :departure_address, length: {minimum: 10, maximum: 64}
  validates :arrival_address, length: {minimum: 10, maximum: 64}
  validates :number_of_passengers, numericality: {greater_than_or_equal_to: 1}
  validates :length_of_route, numericality: {greater_than_or_equal_to: 1}
  validates :time_of_travel, :automobile_id, :tariff_id, presence: true

  # валидатор времени подачи такси:
  def time_of_travel_cannot_be_in_the_past
    if !time_of_travel.nil?
      if time_of_travel < Time.now
        errors.add(:time_of_travel, "не может быть меньше текущего времени")
      end
    end
  end

  # поиск
  def self.search(params)
    result = Order.includes(:automobile, :tariff)

    if params['departure_address'].present?
      result = result.where(departure_address: params['departure_address'])
    end
    if params['arrival_address'].present?
      result = result.where(arrival_address: params['arrival_address'])
    end
    if params['number_of_passengers'].present?
      result = result.where(number_of_passengers: params['number_of_passengers'])
    end
    if params['length_of_route_from'].present?
      result = result.where.not(length_of_route: 0..(params['length_of_route_from']).to_i)
    end
    if params['length_of_route_to'].present?
      result = result.where(length_of_route: 0..(params['length_of_route_to']).to_i)
    end
    if params['automobile'].present?
      result = result.where(automobiles: {state_number: params['automobile']})
    end
    if params['tariff'].present?
      result = result.where(tariffs: {name: params['tariff']})
    end

    result.all
  end
end
