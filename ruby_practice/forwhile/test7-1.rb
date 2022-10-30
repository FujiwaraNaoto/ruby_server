#! ruby -Ku
=begin
2.4.step(5.3,0.8)
num=2.4
num=3.2
num=4.0
num=4.800000000000001
1.step(5,1)
num=1
num=2
num=3
num=4
num=5
=end

print("2.4.step(5.3,0.8)\n")
2.4.step(5.3,0.8){|num|
    print("num=",num,"\n")
}

print("1.step(5,1)\n") #5が含まれる
1.step(5,1){|num|
    print("num=",num,"\n")
}


