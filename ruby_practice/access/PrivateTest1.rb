class Car

    def accele(acceletime=1)
        print("accel")
        print("speed=",calcSpeed(acceletime),"km\n")
    end

    public :accele

    def brake
        print("brake\n")
    end

    public :brake
    def calcSpeed(acceletime)
        return acceletime*10

    end

    private :calcSpeed
end

car=Car.new
car.accele(10)
#car.calcSpeed(1) #error