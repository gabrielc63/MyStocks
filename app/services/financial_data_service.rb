class FinancialDataService
  def self.fetch_price(ticker)
    stock = client.stock symbol: ticker
    stock.quote.price
  end

  def self.fetch(ticker)
    response = client.search keywords: ticker
    stock_found = response.stocks.first
    name = stock_found.name
    price = stock_found.stock.quote.price
    { name: name, price: price }
  end

  def self.client
    @client ||= Alphavantage::Client.new(
      key: Rails.application.credentials.alphavantage
    )
  end
end
