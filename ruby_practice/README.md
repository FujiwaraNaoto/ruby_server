https://www.javadrive.jp/ruby/

# How to run ruby
```
ruby test.rb
```

一行のコメントアウト
```
#
```
複数行のコメントアウト
```
=begin
プログラム作成日時：2007年4月25日
作成者：xxxx
=end
```


# 繰り返し処理

## for method

書式
```
for 変数 in オブジェクト do #ここのdoは省略可能
    実行処理1
    実行処理2
end
```
繰り返しが一回行われるたびにオブジェクトに対してeachメソッドが実行し,
取得した要素などを変数に代入する.
eachメソッドを持ったものがオブジェクトに入る.
例えば,範囲オブジェクト,ハッシュ,配列など...

例
```
#! ruby -Ku

print("begin loop")
for num in 1..3 do
    print("num=",num,"\n");
end

print("end loop")
```

## while method
書式
```
while 条件式 do
    実行処理1
    実行処理2
end
```

例
```
#! ruby -Ku

num=0
print("begin while\n")

while(num<5) do
    print("num=",num);
    num=num+1;
end

print("end while\n")
```

## loop method
書式
```
loop{
実行処理
}
```

breakし続けるまでずっとloop
```
#! ruby -Ku
num=1
loop{
    print("num= ",num,"\n")
    num+=1
    if num>10 then
        break
    end
}
```

## range class
```
range1=5..10
range2="d".."g"
```
range1には5~10の範囲を持つ範囲オブジェクト
range2には"d"から"g"の範囲をもつ範囲オブジェクト

Range クラスメソッドである newメソッドでも作成が可能.
```
Range.new(first,last[,excluded_end])
```
firstには最初の値,lastには最後の値を指定.
excluded_end は最後の値を要素に含めるかどうかの指定.

```
range1=Range.new(5,10)
range2=Range.new(5,10,true) #最後の項を含めない
```

## eachメソッド
書式
```
オブジェクト.each{|変数|
    実行処理1
    実行処理2
}
```
もしくは以下のように書く
```
オブジェクト.each do |変数|
    実行処理1
    実行処理2
end
```
オブジェクトに含まれる要素を succメソッドで順に取得,変数に格納し,
{ ~ }までの処理( もしくは do ~ end )を実行する.

実装例
```
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

```

## times method
書式
```
オブジェクト.times{|変数|
    実行処理1
    実行処理2
}
```
もしくは次のようにする
```
オブジェクト.times do|変数|
    実行処理1
    実行処理2
end
```
変数に 0 から 対象のオブジェクトが持つ数値-1　を順に代入しながら{ ~} までの処理を実行する. 1回繰り返すごとに1ずつ数値が増加する

例: 10回 Hello の表示
```
to.times{
    print("Hello\n")
}
```

## upto method
書式
```
オブジェクト.upto(max){|変数|
    実行処理1
    実行処理2
}
```
もしくは次のようにする
```
オブジェクト.upto(max) do|変数|
    実行処理1
    実行処理2
end
```
対象オブジェクトが持つ数値 から max を順に代入しながら{~}の処理を実行する.1回繰り返すたびに数値が1ずつ増加
```
3.upto(7){|num|
    print("num=",num,"\n")
}
```


## downto method
書式
```
オブジェクト.downto(min){|変数|
    実行処理1
    実行処理2
}
```
もしくは次のようにする
```
オブジェクト.downto(min) do|変数|
    実行処理1
    実行処理2
end
```
対象オブジェクトが持つ数値 から min を順に代入しながら{~}の処理を実行する.1回繰り返すたびに数値が1ずつ減少
```
7.downto(3){|num|
    print("num=",num,"\n")
}
```

## step method
Numeric クラスで用意されているメソッド.times とことなりFloatクラスのオブジェクトでも使用可能.

書式
```
オブジェクト.step(limit,stepno){|変数|
    実行処理1
    実行処理2
}
```
もしくは次のように記述
```
オブジェクト.step(limit,stepno) do |変数|
    実行処理1
    実行処理2
end
```
対象のオブジェクトが持つ数値を変数に代入し,
一回繰り返しをするたびに　変数にstepnoを加算する.limitを超えると終了. limit, stepnoには浮動小数点も指定が可能

```

print("2.4.step(5.3,0.8)\n")
2.4.step(5.3,0.8){|num|
    print("num=",num,"\n")
}

print("1.step(5,1)\n") #5が含まれる
1.step(5,1){|num|
    print("num=",num,"\n")
}
```

## break 
breakが実行されると繰り返しが終了する.
```
while
until
for
イテレータ
```
繰り返しが入れ子になっている場合はbreakが実行された一番内側繰り返しをぬける.
```
while ...
    ...
    for ...
        break
    end #end for
    ...
end #end while
```
この場合,breakによって内側の繰り返しfor文を抜けるが,while文は抜けない.
```
#! ruby -Ku

count=1

print("[start]\n")
("aa".."az").each{|str|
    print(str + "\n");

    count+=1
    if count>10 then
        break #26回ループが,breakで10回ループで終了
    end
}
print("[end]\n")
```

## next
繰り返し処理中にnextが実行されると,ブロック内のnext以降の処理が行われずに次の繰り返し処理へ進む. c++のcontinueに該当.
breakと同様,繰り返しの入れ子の場合,nextが実行された一番内側の繰り返し処理をおこなう.

```
print("[start]\n")

count=0

("aa".."az").each{|str|
    count+=1
    if count%3 !=0 then
        next
    end

    print(str+"\n")#3の倍数に該当するもののみ
}

print("[end]\n")
```

## redo
eachメソッドにより ac が取り出された場合,countの値は3でありredoで繰り返しがあらためて行われる.このとき取り出される要素は同じ(つまりac)で改めて繰り返しが最初から実行される. 
```
#! ruby -Ku
count=0
print("[start]\n")
("aa".."ae").each{|str|
    count+=1

    if count%3==0 then #3の倍数になるたびにredoで同じ処理が行われる
        redo
    end
    print(count,":"+str+"\n")
}
print("[end]\n")
```
実行結果
```
[start]
1:aa
2:ab
4:ac
5:ad
7:ae
[end]
```

#　配列

## 配列の定義

```
[オブジェクト1,オブジェクト2,...]
```
括弧[]で囲んだ中にオブジェクトをカンマ,で区切って記述.
```
array=[2005,2006,2007,2008]
```
変数がオブジェクトそのものを複製して格納するわけではなく,オブジェクトを参照する名札としての役割であるため,配列の各要素もオブジェクトを格納するのではなく,オブジェクトを参照する名札となる.
配列には異なった種類のオブジェクトを指定して作成することもできる.
```
array=["Yamada","Taro",1992,12,32,"male"]
```

## インデックス

i番目の要素のアクセスする場合(0-indexedであることに注意),
[i]でアクセスするか, at(i)でアクセスする.

```
array=["Yamada","Taro","male",24]
print("name:"+array[0]+array[1]+"\n")
print("age: ",array.at(3),"\n")
```
どちらも機能は同じ.

## Arrayクラス

配列オブジェクトのもとになっているArrayクラス.配列を作る際は配列オブジェクトのArrayクラスメソッドをもちいることもできる.
書式
```
Array[item,]
```
オブジェクトをカンマで区切って指定する.
具体例
```
array=Array[2005,2006,2007,2008]
```

もしくは,クラスメソッドのnewを用いた方法.

作成する要素数だけをvalに指定する. 要素数を省略した場合は空のオブジェクトが作られる.

書式
```
Array.new(size[,val])
```

```
array1=Array.new(3)
array2=Array.new
```
要素数だけを指定した場合,各要素にはnilが入っている.

c++の
```
array=vector<Type>(3)　
array = vector<Type>()
```
みたいなもの.

要素に代入するオブジェクトを指定することも可能.
各要素に"red"を代入する場合.
```
array=Array.new(3,"Red")
```
これは,
```
array=["Red","Red","Red"]
array=Array.new(3,"Red")
```
と等しい.
この場合,最初の例では各要素には"Red"という文字列オブジェクトが各要素に代入される。これらのオブジェクト値はRedで同じだが,オブジェクトとしては全く別のオブジェクト.

二つ目の例では Redという文字列オブジェクトが一つだけ作成され,すべての要素に代入される.各要素は同じオブジェクトを参照していることになるため,文字列オブジェクトを何らかの方法で作成するとすべての要素が参照しているオブジェクトに影響が出る.



## Array.new(size){|index|...}

ブロック付きクラスメソッドのnewを使用した場合.
```
Array.new(size){|index|...}
```
作成する要素数を指定する.そしてブロック内で各要素に対して代入するオブジェクトを作成するための処理を記述する.
```
array=Array.new(3){"Red"}
```
要素数が3つの配列オブジェクトが作成されるが,各要素に対してブロック内の処理が呼び出されて実行される.各要素に Redが格納されるが,別々の文字列オブジェクトとなる.


## Array.new(ary)

クラスメソッドnewの引数にほかのオブジェクト指定した場合.
```
Array.new(ary)
```
もとになっている配列オブジェクトと複製された配列オブジェクトの同じ位置にある要素は同じオブジェクトを参照する.

具体例
```
array=["Red","Red"]
newarray=Array.new(array)
```

配列オブジェクトのarrayの0と1番目の要素に代入されたオブジェクトはそれぞれ別物.
複製されたnewarrayの0番目の要素に代入されているオブジェクトはもとのオブジェクトのarrayの0番目の要素に代入されているオブジェクトと同一.

```

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
```
#　配列サイズの拡大
配列オブジェクトで使用される最大インデックスよりも大きな数を指定してそのインデックスへ値を代入した場合,配列サイズは自動的に拡張される.
```
array=Array[1,2,3]
array[3]=4
```

```
array=Array[1,2,3]
array[5]=4
```
この場合,
```
array=[1,2,3,nil,nil,4]
```
となる.


```
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
```


# クラス

## クラス定義 と　オブジェクトの作成
クラス定義 と　オブジェクトの作成
書式
```
class クラス名

end

変数名 = クラス名.new()
```

例
```
class Car
    def initialize(carname)
        @name = carname
    end

    def dispName
        print(@name,"\n")
    end
end

car1 = Car.new("crown")
car1.dispName

car2 = Car.new("civiv")
car2.dispName

```

## メソッド
書式
```
class クラス名
    def メソッド名(引数1,引数2,...)
        処理
    end
end
```
オブジェクトからメソッドの呼び出しは
```
オブジェクト名.メソッド名(引数1,引数2,...)
オブジェクト.メソッド名
```
このように書くこともできる
```
オブジェクト名::メソッド名(引数1,引数2,...)
オブジェクト名::メソッド名
```
どちらかに統一すべき

オブジェクトを作成するために使用した newはクラスに対して実行した.　
このようにクラスに対して実行するクラスメソッドと呼ばれる.
クラス内で定義したインスタンスメソッドはクラスから作成したオブジェクトに対して実行することに注意.

## インスタンス変数
オブジェクト中で値を保存するために利用されるのがインスタンス変数.ローカル変数は一度メソッドを抜けると値は消える.
一度作成されたインスタンス変数はほかのメソッドで値を取り出したり格納することが可能.
インスタンス変数はオブジェクトごとに固有のもの.
python でいうselfのようなもの.


インスタンス変数の書式
```
class クラス名
    def メソッド名
        @name = 値 #インスタンス変数name
    end
end
```

サンプル
```
#ruby -Ku

class Car
    def setName(str)
        @name=str
    end

    def dispName()
        print(@name,"\n")
    end
end


car1=Car.new() #インスタンスcar1の作成
car1.setName("crown")

car2=Car.new()
car2.setName("civic")

car1.dispName()#crown
car2.dispName()#civic
```

## コンストラクタ
initializeという名前がつけられた特殊なメソッドがコンストラクタ.
このメソッドをクラス内に記述するとオブジェクトが作成される際に自動的に呼び出される.

```
class クラス名
    def initialize()
        処理
    end
end
```
initializeメソッドを使用することで必ず初期化の際に実行すべき処理が行える.

引数を指定することができ,その場合

書式
```
class クラス名
    def initialize(変数1,変数2,...)
        処理
    end
end
```

次のように引数のデフォルト値を設定することも可能
```
def initialize(変数1=default,変数2,...)
    処理
end
```

## 定数

クラス内で定数を定義することが可能.　定数はアルファベットの大文字で始まる定数名に対して一度だけ格納することが可能.
c++ の const に該当.


以下の例ではReiji内部で定数 SHOUHIZEIを定義している.
メソッド中では定数の定義は不可能

クラス内で定義された定数は次のように記述することでクラス外で参照が可能.

書式
```
クラス名::定数名
```
これはメソッドを呼び出す
```
クラス名::メソッド
```
に似ている.しかし, 
```
クラス名.定数名
```
このようにして定数名を呼ぶことは無理.


```
=begin
perchase:100
perchase:80
SUM=198.00000000000003
tax rate=0.1
=end

class Reji
    SHOUHIZEI=0.10

    def initialize(init=0)
        @sum=init;
    end

    def buy(price)
        @sum+=price
        print("perchase:",price,"\n")
    end

    def sum()
        return @sum*(1+SHOUHIZEI)
    end
end


reji=Reji.new(0)#最初は購入無しで0
reji.buy(100)
reji.buy(80)
print("SUM=",reji.sum(),"\n")

print("tax rate=",Reji::SHOUHIZEI)

```

## アクセスメソッド
クラスで使用されるインスタンス変数はクラス外から参照や更新が無理.ンスタンスメソッドを経由することで更新や参照を行う.
getterやsetterのようなもの.しかし,これでは変数が莫大に多くなるとメソッドの用意が大変.

そこでアクセスメソッドというものが定義されており,以下の通り

- attr_reader:変数名　参照が可能
- attr_writer:変数名　更新が可能
- attr_accessor:変数名 参照と更新が可能

使い方
```
class Car
    def initialize(carname="undefined")
        @name=carname
    end

    attr_accessor :name #これでnameは参照と更新が可能
end

car = Car.new()
car.name="civic"
print(car.name)#civic
```

この場合, インスタンス変数@nameは更新も参照も行える.



## クラス変数
クラスから作成されたすべてのオブジェクトで共有される変数となる.
c++のstatic で宣言された変数に該当.静的変数.
rubyの書式
```
class クラス名
    @@name=値
end
```
定数と同じくクラス内のメソッドではない場所で定義する.


```
class Car
    @@count=0 #最初のCarインスタンスが作られたときに発動.
    def initialize(carname="undefined")
        @name=carname
        @@count +=1 #インスタンスが作られるたびに生成される
    end

    def getCount()#getterとして機能
        return @@count;
    end

end

car1 = Car.new("crown")
car2 = Car.new("civic")
car3 = Car.new("alto")

print("the number of current instances that have been created:",car1.getCount())
```
@@count=0
は,クラス変数の初期化が行われている場所.しかし,最初のオブジェクトが作成された時にしか実行されない.
インスタンスが増えるたびに+1することでクラス変数の値が増加していく.

# アクセス制御
オブジェクトからインスタンスメソッドとして実行可能なメソッドはpublic
クラス内のほかのメソッドからのみ実行可能なメソッドはprivateを指定する.
デフォルトではpublicに設定される.


例外として,コンストラクタで用いるinitializeは必ずprivateメソッドとして定義される.
initializeメソッドはクラスオブジェクトから実行することは無理.

```
class Car

    def accele(acceletime=1)
        print("accel")
        print("speed=",calcSpeed(acceletime),"km\n")
    end

    public :accele

    def brake
        print("brake\n")
    end

    public :brake
    def calcSpeed(acceletime)
        return acceletime*10

    end

    private :calcSpeed
end

car=Car.new
car.accele(10)
#car.calcSpeed(1) #error
```

個別に設定することが面倒な場合.
```
public 
```
と宣言した後に書いたすべてのメソッドはpublicになる.
privateについても同様の書き方ができる.

```
class Car

    private 
    def calcSpeed(acceletime)
        return acceletime*10

    end

    public

    def accele(acceletime=1)
        print("accel")
        print("speed=",calcSpeed(acceletime),"km\n")
    end

    def brake
        print("brake\n")
    end
end

car=Car.new
car.accele(10)
#car.calcSpeed(1) #error
```

publicに acceleメソッド,brakeメソッド
privateにcalcSpeedメソッドとなる.


# 日付

Date クラスを用いるには, 以下をインポートする
```
require "date"
```
Date クラスオブジェクトの作成には newメソッドを用いて
```
Date.new([year[,mon[,start]]]])
```
本日付けのDateオブジェクトの作成
```
Date.today([start])
```


使用例
```
#! ruby -Ks

require "date"

d=Date.new(2007,2,4)
print(d,"\n")
dt=Date.today #本日づけ
print(dt)
```


