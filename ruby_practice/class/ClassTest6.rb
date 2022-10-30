class Car
    def initialize(carname="undefined")
        @name=carname
    end

    attr_accessor :name #これでnameは参照と更新が可能
end

car = Car.new()
car.name="civic"
print(car.name)


