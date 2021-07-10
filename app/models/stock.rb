class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:publishable_token],
      secret_token: Rails.application.credentials.iex_client[:secret_token],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    begin
      quote = client.quote(ticker_symbol)
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: quote.latest_price)
    rescue => e
      Rails.logger.error(e.message)
      nil
    end
  end
end
