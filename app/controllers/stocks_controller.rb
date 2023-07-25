# frozen_string_literal: true

class StocksController < ApplicationController
  def search
    display_error_message if params[:stock].blank?

    api_stock = FinancialDataService.fetch(params[:stock])
    if api_stock
      @stock = Stock.new(ticker: params[:stock],
                         name: api_stock[:name],
                         last_price: api_stock[:price])
      respond_to do |format|
        format.js { render partial: 'users/result' }
      end
    else
      display_error_message
    end
  end

  private

  def display_error_message
    respond_to do |format|
      flash.now[:alert] = 'Please enter a valid symbol'
      format.js { render partial: 'users/result' }
    end
  end
end
