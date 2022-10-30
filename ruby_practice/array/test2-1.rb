#! ruby -Ku

array=["Yamada","Taro","male",24]

print("name:"+array[0]+array[1]+"\n")
print("sex: "+array[2]+"\n")
print("age: ",array[3],"\n")

#array[x] も array.at(0)も同じ
print("name:"+array.at(0)+array.at(1)+"\n")
print("sex: "+array.at(2)+"\n")
print("age: ",array.at(3),"\n")
