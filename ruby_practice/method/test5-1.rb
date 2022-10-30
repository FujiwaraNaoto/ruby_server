=begin
最後の引数に*をつける あまった引数を要素とする配列として受け取れる
    def メソッド名(変数1, 変数2, ..., *変数n)
     実行する処理
     実行する処理
    end

=end

def printHellO(msg,*name)
    print(msg+","+name+"\n")
end

print("Hello")
print("Hello","Yamada")
print("Hello","Yamada","Endou")
print("Hello","Yamada","Endou","Katou","Takahashi")

