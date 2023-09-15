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

    customer_success.reject { |cs| away_customer_success.include?(cs[:id]) }
  end

  def order_by_score(array)
    array.sort_by { |element| element[:score] }
  end

  def allocate_clients_to_css(sorted_cses, sorted_customers)
    cs_counts = Hash.new(0)

    sorted_customers.each do |customer|
      suitable_cs = sorted_cses.find { |cs| cs[:score] >= customer[:score] }
      cs_counts[suitable_cs[:id]] += 1 if suitable_cs
    end

    return 0 if cs_counts.empty?

    max_clients = cs_counts.values.max
    cs_with_max_clients = cs_counts.select { |_, v| v == max_clients }

    cs_with_max_clients.size > 1 ? 0 : cs_with_max_clients.keys.first
  end
end
