class Scenario < ApplicationRecord
    include Finance
    include ScenariosExtension

    validates :deposit, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: DefaultInput.deposit.min, less_than_or_equal_to: DefaultInput.deposit.max}
    validates :interest, presence: true, numericality: {greater_than: DefaultInput.interest.min, less_than_or_equal_to: DefaultInput.interest.max}
    validates :buying_price, presence: true, numericality: {only_integer: true, greater_than: DefaultInput.buying_price.min}
    validates :selling_price, presence: true, numericality: {only_integer: true, greater_than: DefaultInput.selling_price.min}
    validates :tenure, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: DefaultInput.tenure.min, less_than_or_equal_to: DefaultInput.tenure.max}
    validates :holding_period, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: DefaultInput.holding_period.min, less_than_or_equal_to: DefaultInput.holding_period.max}

    belongs_to :project

    attr_accessor :amortization, :irr

    def basic_analysis!
        @amortization = Amortization.new(loan_amt, rate)

        begin
            self.irr = (calculate_irr(0, 0.15, self.cf_mortgage) * 12 * 100)
        rescue RuntimeError
            self.errors.messages[:irr] << 'Invalid cashflow or the IRR is less than 0 or more than 130.'
            return false
        end

        return true
    end

    def cf_mortgage
        sum_cash_flows(self.cf_down_payment, self.cf_repayment, self.cf_settlement, self.cf_selling_price)
    end

    def cf_down_payment
        cash_flow_builder(amt: -self.down_payment, pos_arr: [0])
    end

    def cf_repayment
        if self.holding_period > self.tenure
            # pay until the end of tenure
            cf_repayment = cash_flow_builder(amt: self.payment, pos_arr: (1..self.tenure_mth))
        else
            cf_repayment = cash_flow_builder(amt: self.payment, pos_arr: (1..self.holding_period_mth))
        end

        cf_repayment
    end

    def cf_settlement
        settlement_amt = self.loan_amt-self.paid_principal
        if self.holding_period > self.tenure
            # no settlement with bank as it has been fully paid
            cf_settlement = cash_flow_builder(amt: 0)
        else
            cf_settlement = cash_flow_builder(amt: -settlement_amt, pos_arr: [self.holding_period_mth])
        end

        cf_settlement
    end

    def cf_selling_price
        cash_flow_builder(amt: self.selling_price*1000, pos_arr:[self.holding_period_mth])
    end

    def basic_analysis_input!
        self.buying_price = DefaultInput.buying_price.base
        self.deposit = DefaultInput.deposit.base
        self.interest = DefaultInput.interest.base
        self.tenure = DefaultInput.tenure.base
        self.selling_price = DefaultInput.selling_price.base
        self.holding_period = DefaultInput.holding_period.base
        return true
    end

    def tenure_mth
        self.tenure*12
    end

    def holding_period_mth
        self.holding_period*12
    end

    def rate
        Rate.new(self.interest/100, :apr, duration: self.tenure * 12)
    end

    def loan_amt
        (self.buying_price*1000) * (1 - (self.deposit/100))
    end

    def down_payment
        self.deposit/100 * ( self.buying_price * 1000 )
    end

    def payment
        if @amortization.present?
            @amortization.payment
        else
            nil
        end
    end

    def paid_principal(amortization=self.amortization, duration=self.holding_period_mth)
        total_payment = -amortization.payments[0...duration].sum
        total_interest = amortization.interest[0...duration].sum

        total_payment - total_interest
    end

    def sum(array)
        array.reduce(0) {|base, ele|
            base+=ele
        }
    end

    def sum_cash_flows(*cash_flows)

        if !cash_flows_same_length?(cash_flows)
            return nil
        end

        sum = cash_flows.pop

        while cash_flows.length > 0
            cash_flow = cash_flows.pop
            sum = cash_flows_addition(sum, cash_flow)
        end

        sum
    end

    def cash_flows_same_length?(cash_flows)
        cash_flows.each_with_index do |cf, idx|
            if idx == 0
                next
            end

            if cf.length != cash_flows[idx-1].length
                return false
            end
        end

        return true
    end

    def cash_flows_addition(cf_1, cf_2)
        (0...cf_1.length).map {|i|
            cf_1[i] + cf_2[i]
        }
    end

    # len must be greater than the max of pos_arr
    def cash_flow_builder(amt:nil, len: self.holding_period_mth+1, pos_arr:nil)
        pos_arr||= (0...len).to_a

        cash_flow = Array.new(len) {|i| i = 0}

        pos_arr.each do |pos|
            cash_flow[pos] = amt
        end
        cash_flow
    end

    def calculate_irr(min_rate, max_rate, amounts)
        while true
            range = max_rate - min_rate

            raise RuntimeError if range <= Float::EPSILON * 2

            rate = range.fdiv(2) + min_rate
            present_value = npv(rate, amounts)

            if present_value > 0
                min_rate = rate
            elsif present_value < -1
                max_rate = rate
            else
                return rate
            end
        end
    end

    def npv(rate, amounts)
        amounts.each_with_index.reduce(0) do |sum, (amount, index)|
            sum + amount / ((rate + 1)**index)
        end
    end

    def fv(rate, amounts)
        len = amounts.length
        amounts.each_with_index.reduce(0) do |sum, (amount, index)|
            sum + amount * (1+rate)**(len - index)
        end
    end

    def get_input
        input = DefaultInput.new
        input.buying_price.base = self.buying_price
        input.selling_price.base= self.selling_price
        input.deposit.base = self.deposit
        input.interest.base = self.interest
        input.tenure.base = self.tenure
        input.holding_period.base= self.holding_period
        return input
    end



end
