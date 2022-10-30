#! ruby -Ku
=begin
[start]
ac
af
ai
al
ao
ar
au
ax
[end]
=end
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