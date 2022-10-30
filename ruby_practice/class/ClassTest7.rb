=begin
perchase:100
perchase:80
SUM=198.00000000000003
tax rate=0.1
=end
class Reji
    SHOUHIZEI=0.10

    def initialize(init=0)
        @sum=init;
    end

    def buy(price)
        @sum+=price
        print("perchase:",price,"\n")
    end

    def sum()
        return @sum*(1+SHOUHIZEI)
    end
end


reji=Reji.new(0)#最初は購入無しで0
reji.buy(100)
reji.buy(80)
print("SUM=",reji.sum(),"\n")

print("tax rate=",Reji::SHOUHIZEI)