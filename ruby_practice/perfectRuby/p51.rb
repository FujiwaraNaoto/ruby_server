#super class
class Parent
    def hello
        print("Hello parent\n")
    end
end

#child succeeded to parent
class Child < Parent
    def hi
        print("Hello, Child class\n")
    end
end

child=Child.new
child.hello
child.hi
