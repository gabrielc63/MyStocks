class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:publishable_token],
      secret_token: Rails.application.credentials.iex_client[:secret_token],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    begin
      quote = client.quote(ticker_symbol)
      new(ticker: ticker_symbol.upcase,
          name: client.company(ticker_symbol).company_name,
          last_price: quote.latest_price)
    rescue => e
      Rails.logger.error(e.message)
      nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol.upcase).first
  end
end
