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

  def find_maximum_subarray_linear(arr)
    max = arr[0]
    init_index = final_index = 0
    minus = false
    subarrays = []
    (1...arr.length).each do |i|
      if not minus and arr[i] + max >= max
        final_index += 1
        max += arr[i]
      elsif arr[i] + max < max
        minus = true
      else
        if arr[init_index..i].inject(:+) > max
          final_index = i
          max = arr[init_index..i].inject(:+)
        else
          subarrays << [[init_index, final_index], max]
          init_index = final_index = i
          max = arr[i]
        end
        minus = false
      end
    end
    if subarrays.empty?
      subarrays << [[init_index, final_index], max]
    end
    max = subarrays[0]
    subarrays.each do |subarray|
      if max[1] < subarray[1]
        max = subarray
      end
    end
    return subarrays
    # left_index, right_index, sum of max subarray
    #return max[0][0], max[0][1], max[1]
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


a = 15.times.map { Random.rand(40) * [1, -1][Random.rand(2)] }
#puts "----------- testing find_maximum_crossing_subarray -----------"
#puts a.inspect
#puts Algorithms.new.find_maximum_subarray(a, 0, a.length-1).inspect
#puts "------------------------------------------------------------\n"
#

#puts "----------- testing find_maximum_subarray_brute ------------"
#puts a.inspect
#puts Algorithms.new.find_maximum_subarray_brute(a).inspect
#puts "------------------------------------------------------------\n"

#puts "----------- testing for fastest algorithms for input n ------------"
#(1..100).each do |i|
#  a = i.times.map { Random.rand(40) * [1, -1][Random.rand(2)] }
#  start = Time.now
#  Algorithms.new.find_maximum_subarray(a, 0, a.length - 1)
#  finish = Time.now
#  elapsed_divide = (finish - start) * (10 ** 6)
#  start = Time.now
#  Algorithms.new.find_maximum_subarray_brute(a)
#  finish = Time.now
#  elapsed_brute = (finish - start) * (10 ** 6)
#  print "n: " + i.inspect
#  print " divide_time: " + elapsed_divide.inspect + "ms"
#  print " brute_time: " + elapsed_brute.inspect + "ms"
#  print " fastest: " + ((elapsed_brute <= elapsed_divide)? "Brute": "Divide")
#  print "\n"
#end
#puts "------------------------------------------------------------\n"

puts "----------- testing find_maximum_subarray_linear ------------"
#a = [13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -4, 7]
puts a.inspect
puts Algorithms.new.find_maximum_subarray_linear(a).inspect
puts Algorithms.new.find_maximum_subarray_brute(a).inspect
puts Algorithms.new.find_maximum_subarray(a, 0, a.length-1).inspect
puts "------------------------------------------------------------\n"
