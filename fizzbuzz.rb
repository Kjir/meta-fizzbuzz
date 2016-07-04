module FizzBuzz
  module Fizz
    def self.included(base)
      base.class_eval do
        @handlers ||= [instance_method(:handle)]

        def handle(n)
          'Fizz' if n % 3 == 0
        end
        @handlers.push instance_method :handle

        def handle(n)
          ret = ''

          instance = self
          self.class.class_eval do
            @handlers[1..-1].each do |m|
              ret += m.bind(instance).call(n).to_s
            end
          end

          return ret unless ret.empty?

          self.class.class_eval do
            @handlers[0].bind(instance).call(n)
          end
        end
      end
    end
  end

  module Buzz
    def self.included(base)
      base.class_eval do
        @handlers ||= [instance_method(:handle)]

        def handle(n)
          'Buzz' if n % 5 == 0
        end
        @handlers.push instance_method :handle

        def handle(n)
          ret = ''

          instance = self
          self.class.class_eval do
            @handlers[1..-1].each do |m|
              ret += m.bind(instance).call(n).to_s
            end
          end

          return ret unless ret.empty?

          self.class.class_eval do
            @handlers[0].bind(instance).call(n)
          end
        end
      end
    end
  end

  class Runner
    def run
      parser = Parser.new
      1.upto(100) do |n|
        puts parser.handle n
      end
    end
  end

  class Parser
    def handle(n)
      n
    end

    include Fizz
    include Buzz
  end
end
