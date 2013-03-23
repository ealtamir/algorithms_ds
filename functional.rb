module RecursionTracker
  def recursion_tracker(func_name)
    nesting_count = 0
    method_proxy_name = "#{func_name}_old".to_sym
    alias_method(method_proxy_name, func_name)
    define_method(func_name) do |*args|
      first = "#{nesting_count}:" + " "*(nesting_count)
      second = "#{func_name}(#{args})"
      print first + " -> " + second + "\n"
      nesting_count += 1
      result = send(method_proxy_name, *args)
      nesting_count += -1
      puts first + " <---------"
      return result
    end
  end
end

class Test
  extend RecursionTracker

  def dec(n)
    if n == 0
      puts "End"
    else
      dec(n-1)
    end
  end
  recursion_tracker(:dec)

  def you
    puts "Method Executed."
  end
end
