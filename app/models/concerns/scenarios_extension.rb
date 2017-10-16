module ScenariosExtension

    class DefaultInput

        attr_accessor :buying_price, :selling_price, :deposit, :interest, :holding_period, :tenure,
                      :rental_period, :rental, :purchase_transaction_cost, :sell_transaction_cost

        def initialize
            @buying_price = DefaultInput.buying_price
            @selling_price = DefaultInput.selling_price
            @deposit = DefaultInput.deposit
            @interest = DefaultInput.interest
            @holding_period = DefaultInput.holding_period
            @tenure = DefaultInput.tenure
            @rental_period = DefaultInput.rental_period
            @rental = DefaultInput.rental
            @purchase_transaction_cost = DefaultInput.purchase_transaction_cost
            @sell_transaction_cost = DefaultInput.sell_transaction_cost
        end

        DefaultData = Struct.new(:base, :min, :max)

        # unit in '000
        def self.buying_price
            DefaultData.new(500, 50, 100000)
        end

        # unit in '000
        def self.selling_price
            DefaultData.new(800, 50, 200000)
        end

        # unit in %
        def self.deposit
            DefaultData.new(10, 0, 100)
        end

        # unit in %
        def self.interest
            DefaultData.new(4, 1, 50)
        end

        # unit in year
        def self.tenure
            DefaultData.new(30, 5, 45)
        end

        # unit in year
        def self.holding_period
            DefaultData.new(5, 1, 50)
        end

        # unit in year
        def self.rental_period
            DefaultData.new(2, 1, 20)
        end

        # unit in '000 per year
        def self.rental
            DefaultData.new(12, 6, 500)
        end

        # unit in '000
        def self.purchase_transaction_cost
            DefaultData.new(5, 0, self.buying_price.max)
        end

        # unit in '000
        def self.sell_transaction_cost
            DefaultData.new(5, 0, self.selling_price.max)
        end
    end
end