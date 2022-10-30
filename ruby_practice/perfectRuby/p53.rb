module Brainfsck
    class Parser
        print("Hello Parser Brainfsck\n")
    end
end

module Whitespace
    class Parser
        print("Hello Parser Whitespace\n")
    end
end

# ::を用いて参照する
Brainfsck::Parser
Whitespace::Parser