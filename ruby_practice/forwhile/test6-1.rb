#! ruby -Ku
=begin
3.times
num=0
num=1
num=2
6.upto(8)
num=6
num=7
num=8
8.downto(6)
num=8
num=7
num=6
=end

print("3.times\n")
3.times{|num|
    print("num=",num,"\n")
}


print("6.upto(8)\n")
6.upto(8){|num|
    print("num=",num,"\n")
}


print("8.downto(6)\n")
8.downto(6){|num|
    print("num=",num,"\n")
}

