#!ruby -Ku

array=Array["red","blue","green"]
p array #["red", "blue", "green"]
print("array.length=",array.length,"\n") # 3
print("array.size=",array.size,"\n") # 3
#print("array.nitems=",array.nitems,"\n")

array[5]="white"
p array #["red", "blue", "green", nil, nil, "white"]
print("array.length=",array.length,"\n") #6
print("array.size=",array.size,"\n") #6
#print("array.nitems=",array.nitems,"\n")