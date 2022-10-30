#! ruby -Ku
=begin
[start]
1:aa
2:ab
4:ac
5:ad
7:ae
[end]
=end
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