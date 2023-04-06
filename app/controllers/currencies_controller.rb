class CurrenciesController < ApplicationController
  def first_currency

    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    render({ :template => "currency_templates/step_one.html.erb" })
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    # params are
    # Parameters: {"from_currency"=>"ARS"}
    
    @from_symbol = params.fetch("from_currency")

    render({ :template => "currency_templates/step_two.html.erb" })
  end

  def convert

    require "open-uri"
    require "json"

    @from_symbol = params.fetch("from_currency")
    @to_symbol = params.fetch("to_currency")

    url = "https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@to_symbol}"

    raw_convert_data = URI.open(url).read

    parsed_convert_data = JSON.parse(raw_convert_data)

    @rate = parsed_convert_data.fetch("result")

    render({ :template => "currency_templates/currency_results.html.erb"})
  end
end
