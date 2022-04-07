class Flight
    attr_reader :passengers

    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    def full?
        if @passengers.length == @capacity
            return true
        elsif @passengers.length < @capacity
            return false
        end
    end

    #or
      def full?
    @passengers.length == @capacity
  end


    def board_passenger(passenger)
        if passenger.has_flight?(@flight_number) && !self.full?
            @passengers << passenger
        end
    end

    def list_passengers #needs attention!
        @passengers.map(&:name)
    end

    def [](index)
        @passengers.each_with_index do |ele, i|
            return ele if i == index
        end
    end

    #or 
    def [](idx)
        @passengers[idx]

    def <<(passenger)
        self.board_passenger(passenger)
    end

end