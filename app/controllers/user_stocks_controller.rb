class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    stock = save_new_stock(params[:ticker]) if stock.nil?
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} was successfully removed from portfolio"
    redirect_to my_portfolio_path
  end

  private

  def save_new_stock(ticker)
    api_stock = FinancialDataService.fetch(ticker)
    stock = Stock.new(ticker: ticker.upcase, name: api_stock[:name], last_price: api_stock[:price])
    stock.save
    stock
  end
end
