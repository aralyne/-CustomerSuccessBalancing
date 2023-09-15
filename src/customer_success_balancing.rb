require 'set'

class CustomerSuccessBalancing
  attr_reader :customer_success, :customers, :away_customer_success

  def initialize(customer_success, customers, away_customer_success)
    @customer_success = customer_success
    @customers = customers
    @away_customer_success = away_customer_success
  end

  def execute
    return 0 if customer_success.empty? || customers.empty?

    sorted_customer_success = order_by_score(filter_active_customer_success)
    sorted_customers = order_by_score(customers)
    allocate_clients_to_css(sorted_customer_success, sorted_customers)
  end

  private

  def filter_active_customer_success
    return customer_success if away_customer_success.empty?

    away_set = Set.new(away_customer_success)
    customer_success.reject { |cs| away_set.include?(cs[:id]) }
  end

  def order_by_score(array)
    array.sort_by { |element| element[:score] }
  end

  def allocate_clients_to_css(sorted_cses, sorted_customers)
    cs_counts = Hash.new(0)
    cs_index = 0

    sorted_customers.each do |customer|
      while cs_index < sorted_cses.length && sorted_cses[cs_index][:score] < customer[:score]
        cs_index += 1
      end
      cs_counts[sorted_cses[cs_index][:id]] += 1 if cs_index < sorted_cses.length
    end

    return 0 if cs_counts.empty?

    max_clients = cs_counts.values.max
    cs_with_max_clients = cs_counts.select { |_, c| c == max_clients }

    cs_with_max_clients.size > 1 ? 0 : cs_with_max_clients.keys.first
  end
end
