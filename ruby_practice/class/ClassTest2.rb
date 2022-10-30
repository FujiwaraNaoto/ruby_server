=begin
crown
civiv
=end
class Car
    def initialize(carname)
        @name = carname
    end

    def dispName
        print(@name,"\n")
    end
end

car1 = Car.new("crown")
car1.dispName

car2 = Car.new("civiv")
car2.dispName



