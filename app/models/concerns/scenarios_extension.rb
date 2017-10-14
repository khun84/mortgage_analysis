module ScenariosExtension

    class Default
        
        DefaultData = Struct.new(:base, :min, :max)

        # unit in '000
        def self.buying_price
            DefaultData.new(500, 50, 100000)
        end

        # unit in '000
        def self.selling_price
            DefaultData.new(600, 50, 200000)
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

    end
end