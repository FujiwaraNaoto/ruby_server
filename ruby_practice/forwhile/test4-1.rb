#! ruby -Ku
=begin
18..20 is 
num=18
num=19
num=20
18..20 =18..20
Ax..Bb is
str=Ax
str=Ay
str=Az
str=Ba
=end

print("18..20 is \n")
for num in 18..20 do
    print("num=",num,"\n")
end


print("18..20 =",18..20,"\n")

print("Ax..Bb is \n")
for str in "Ax"..."Bb" do
    print("str="+str+"\n")
end

range1=Range.new(5,10)
range2=Range.new(5,10,true) #最後の項を含めない

print("range1=",range1)
print("range2=",range2)

for k in range1
    print(k)
end