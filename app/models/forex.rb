require 'open-uri'
class Forex

    FOREX_TICKER = [:AUD, :EUR, :GBP, :JPY, :MYR, :SGD]

    attr_reader :rates, :status, :base, :all_rates, :error

    def initialize
        @status = nil
        @rates = {}
        @all_rates = {}
        @base = nil
        # call the api and get request status and all rates
        get_all_rates_and_base!
    end

    # laod all the rates into instance variable
    def get_all_rates_and_base!
        data = JSON.parse open("https://openexchangerates.org/api/latest.json?app_id=#{ENV['FOREX_API_KEY']}").read
        data.deep_symbolize_keys!

        self.status = status_success?(data)
        if self.status
            self.all_rates= data[:rates]
            self.base= data[:base]
        end

        self.status

    end

    # load the selected rates into instance variable
    def get_rates!
        if self.status
            Forex.forex_ticker.each do |key|
                self.rates[key]= self.all_rates[key]
            end
        end
        self.rates
    end



    def self.forex_ticker
        FOREX_TICKER
    end

    private

    attr_writer :rates, :status, :base, :all_rates, :error

    def status_success?(data)
        if data[:error].present?
            self.error = data[:error]
            false
        else
            true
        end
    end
end