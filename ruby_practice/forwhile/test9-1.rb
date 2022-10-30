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
