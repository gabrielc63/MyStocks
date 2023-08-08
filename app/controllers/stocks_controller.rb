# frozen_string_literal: true

class StocksController < ApplicationController
  def search
    return display_invalid_symbol_message if params[:stock].blank?

    api_stock = FinancialDataService.fetch(params[:stock])
    return display_invalid_symbol_message if api_stock.empty?

    @stock = Stock.new(ticker: params[:stock].upcase,
                       name: api_stock[:name],
                       last_price: api_stock[:price])
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  rescue Alphavantage::Error => e
    respond_to do |format|
      flash.now[:alert] = e.message
      format.js { render partial: 'users/result' }
    end
  end

  private

  def display_invalid_symbol_message
    respond_to do |format|
      flash.now[:alert] = 'Please enter a valid symbol'
      format.js { render partial: 'users/result' }
    end
  end
end
