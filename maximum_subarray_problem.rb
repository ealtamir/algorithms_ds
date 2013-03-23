require_relative 'functional'

class Algorithms
  extend RecursionTracker

  def find_maximum_subarray(arr, low, high)
    if high == low
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
  recursion_tracker(:find_maximum_subarray)

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
end


a = 10.times.map { Random.rand(40) * [-1, -1][Random.rand(2)] }
puts "----------- testing find_maximum_crossing_subarray -----------"
puts a.inspect
puts Algorithms.new.find_maximum_subarray(a, 0, a.length-1).inspect
puts "------------------------------------------------------------\n"
