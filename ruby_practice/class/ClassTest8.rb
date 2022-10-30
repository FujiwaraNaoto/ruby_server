class Car
    @@count=0 #最初のCarインスタンスが作られたときに発動.
    def initialize(carname="undefined")
        @name=carname
        @@count +=1 #インスタンスが作られるたびに生成される
    end

    def getCount()#getterとして機能
        return @@count;
    end

end

car1 = Car.new("crown")
car2 = Car.new("civic")
car3 = Car.new("alto")

print("the number of current instances that have been created:",car1.getCount()) #3