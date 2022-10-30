# ruby test3-1.rb

def printHello(msg,name)
    print(msg+","+name+"\n")
end

printHello("Hello","Yamada")


def addString(str)
    str<<",Japan" #文字の追加
end

address="Tokyo"
print(address+"\n")
addString(address)
print(address+"\n")