tmp=Array.new(5,1)
print(tmp)

tmp[1]=2
print(tmp)

array1=["Red","Red","Red"]
array2=Array.new(3,"Red")
print(array2)
array2[1]="t"
print(array2)

print(Array.new(3){|index| index.succ}) #[1,2,3]