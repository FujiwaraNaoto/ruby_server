=begin
実行環境で数字自体は変わります.
しかし,値が一致している部分と一致していない部分に注目
=end
#! ruby -Ku

array1=Array["Red","Red"]
print("array1=",array1,"\n")
print(array1[0].object_id,"\n")#60
print(array1[1].object_id,"\n")#80


array2=Array.new(2,"Red")
print("array2=",array2,"\n")
print(array2[0].object_id,"\n")#100
print(array2[1].object_id,"\n")#100

array3=Array.new(2){"Red"}
print("array3=",array3,"\n")
print(array3[0].object_id,"\n")#120
print(array3[1].object_id,"\n")#140


array4=array1
print("array4=",array4,"\n")
print(array4[0].object_id,"\n")#60
print(array4[1].object_id,"\n")#80


