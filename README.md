# meta-fizzbuzz
Solving the FizzBuzz problem the wrong way: with Ruby metaprogramming

# Why is it the wrong way?
Because using metaprogramming to solve such a simple problem is overkill. The
best solution is the easiest one, which in Ruby would look something like this:
```ruby
def parse(n)
  return 'FizzBuzz' if n % 15 == 0
  return 'Fizz' if n % 3 == 0
  return 'Buzz' if n % 5 == 0
  return n
end

1.upto(100) do |n|
  puts parse(n)
end
```
# Why do it, then?
Well, for fun! And also to practice metaprogramming and Ruby, to explore
different patterns and see the pros and cons of each approach.
