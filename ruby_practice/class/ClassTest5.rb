class Car
    def initialize(carname="undefined")
        @name=carname
    end

    def dispName()
        print(@name,"\n")
    end
end

car1=Car.new("civic")
car2=Car.new()

car1.dispName()#civic
car2.dispName()#undefined