class Car
    def dispClassname() #引数いらない場合は　dipClassname のように()をのけても良い
        print("Car class\n")
    end

    def dispString(str)
        print(str,"\n")
    end
end


car = Car.new
car.dispClassname
car.dispString("crown")