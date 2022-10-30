#! ruby -Ku
=begin
18..20 is 
num=18
num=19
num=20
Ax..Bc is
str=Ax
str=Ay
str=Az
str=Ba
str=Bb
=end

print("18..20 is \n")
(18..20).each{|num|
    print("num=",num,"\n")
}

print("Ax..Bc is \n")
("Ax".."Bb").each do |str|
    print("str=",str,"\n")
end