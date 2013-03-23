require_relative 'functional'

class Algorithms
  extend RecursionTracker

  # Using divide and conquer.
  def find_maximum_subarray(arr, low, high)
    if high == low or arr.length == 0
      return low, high, arr[low]
    else
      mid = (low + high)/2
      left_low, left_high, left_sum =
        find_maximum_subarray(arr, low, mid)
      right_low, right_high, right_sum =
        find_maximum_subarray(arr, mid + 1, high)
      cross_low, cross_high, cross_sum =
        find_maximum_crossing_subarray(arr, low, mid, high)
      if left_sum >= right_sum and left_sum >= cross_sum
        return left_low, left_high, left_sum
      elsif right_sum >= left_sum and right_sum >= cross_sum
        return right_low, right_high, right_sum
      else
        return cross_low, cross_high, cross_sum
      end
    end
  end
  #recursion_tracker(:find_maximum_subarray)

  def find_maximum_crossing_subarray(arr, low, mid, high)
    left_sum = right_sum = -Float::INFINITY
    max_left = max_right = 0
    sum = 0
    mid.downto(low) do |i|
      sum = sum + arr[i]
      if sum > left_sum
        left_sum = sum
        max_left = i
      end
    end
    sum = 0
    (mid+1..high).each do |j|
      sum = sum + arr[j]
      if sum > right_sum
        right_sum = sum
        max_right = j
      end
    end
    return max_left, max_right, left_sum + right_sum
  end

  def find_maximum_subarray_brute(arr)
    if arr.length == 1
      return 0, 0, arr[0]
    end
    left_bound = right_bound = 0
    (0...arr.length).each do |i|
      (i...arr.length).each do |j|
        if arr[i..j].inject(:+) > arr[left_bound..right_bound].inject(:+)
          left_bound = i
          right_bound = j
        end
      end
    end
    return left_bound, right_bound, arr[left_bound..right_bound].inject(:+)
  end
end


a = 100.times.map { Random.rand(40) * [1, -1][Random.rand(2)] }
#puts "----------- testing find_maximum_crossing_subarray -----------"
#puts a.inspect
#puts Algorithms.new.find_maximum_subarray(a, 0, a.length-1).inspect
#puts "------------------------------------------------------------\n"
#

#puts "----------- testing find_maximum_subarray_brute ------------"
#puts a.inspect
#puts Algorithms.new.find_maximum_subarray_brute(a).inspect
#puts "------------------------------------------------------------\n"

puts "----------- testing for fastest algorithms for input n ------------"
(1..100).each do |i|
  a = i.times.map { Random.rand(40) * [1, -1][Random.rand(2)] }
  start = Time.now
  Algorithms.new.find_maximum_subarray(a, 0, a.length - 1)
  finish = Time.now
  elapsed_divide = (finish - start) * (10 ** 6)
  start = Time.now
  Algorithms.new.find_maximum_subarray_brute(a)
  finish = Time.now
  elapsed_brute = (finish - start) * (10 ** 6)
  print "n: " + i.inspect
  print " divide_time: " + elapsed_divide.inspect + "ms"
  print " brute_time: " + elapsed_brute.inspect + "ms"
  print " fastest: " + ((elapsed_brute <= elapsed_divide)? "Brute": "Divide")
  print "\n"
end

puts "------------------------------------------------------------\n"
