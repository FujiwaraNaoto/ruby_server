class Car

    private 
    def calcSpeed(acceletime)
        return acceletime*10

    end

    public

    def accele(acceletime=1)
        print("accel")
        print("speed=",calcSpeed(acceletime),"km\n")
    end

    def brake
        print("brake\n")
    end
end

car=Car.new
car.accele(10)
#car.calcSpeed(1) #error