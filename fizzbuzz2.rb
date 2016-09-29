module FizzBuzz2
  # Runner iterates from 1 to 100
  class Runner
    def run
      parser = Parser.new
      1.upto(100) do |n|
        puts parser.handle n
      end
    end
  end

  # The default parser just outputs what is given
  class DefaultParser
    def handle(n)
      ret = ''

      instance = self
      self.class.class_eval do
        @handlers ||= []
        @handlers.each do |m|
          ret += m.bind(instance).call(n).to_s
        end
      end

      return ret unless ret.empty?

      n
    end

    def self.fizzify(guard, text)
      @handlers ||= []

      define_method :_handle do |n|
        text if n % guard == 0
      end

      @handlers.push instance_method :_handle
    end
  end

  # Our parser that also includes FizzBuzz behaviour on top of the default
  # parser
  class Parser < DefaultParser
    fizzify 3, 'Fizz'
    fizzify 5, 'Buzz'
  end
end
