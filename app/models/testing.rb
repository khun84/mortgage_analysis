class Testing

    def initialize
        @result = 1
    end

    def result
        @result
    end

    def change_result
        self.result=2
    end

    private

    attr_writer :result

end