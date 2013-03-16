def merge_sort(unsorted)
  if unsorted.length < 2
    return unsorted
  else
    lower = 0
    upper = unsorted.length - 1
    return merge_sort_inner(unsorted, lower, upper)
  end
end

def merge_sort_inner(unsorted, lower, upper)
  if lower < upper
    mid = (lower + upper)/2
    merge_sort_inner(unsorted, lower, mid)
    merge_sort_inner(unsorted, mid+1, upper)
    merge(unsorted, lower, mid, upper)
  end
end

# = Merge
# == Loop Invariant
# Given an array A which subarrays a = A[low..mid] and b = A[mid+1..upper] are sorted.
# The subarray A[low..k-1] will always be sorted and it'll contain the lesser
# elements from a and b.
#
# *Initialization: before entering the for loop k = low, therefore the subarray
# A[low..low-1] is empty, hence it is sorted.
#
# *Maintenance: Before an iteration, A[low..k-1] is sorted. In the next iteration
# the smallest element between the front of a and b is chosen. This element is bigger
# than A[k-1] because in the previous iteration it was the smallest between the front
# of a and b. Therefore A[low..k] is sorted and contains the smallest elements from
# a and b.
#
# *Termination: When the algorithm exits the for loop, it contains at least all the elements
# of a or exclusively all the elements of b, but it can't contain all the elements of both.
# Since both a and b are sorted, the remaining elements from one of these arrays are
# inserted in A[j+1..upper], where j is the sum of the amount of elements
# from a and b that are already in A.
#
def merge(unsorted, low, mid, upper)
  if low == mid and upper == mid+1 # received only 2 digits to sort
    swap(unsorted, low, upper) if unsorted[low] > unsorted[upper]
    return unsorted
  end
  a = unsorted[low..mid]
  b = unsorted[mid+1..upper]
  i = j = 0
  for k in (low..upper)
    if a[i] > b[j]
      unsorted[k] = b[j]
      j += 1
    else
      unsorted[k] = a[i]
      i += 1
    end
    break if i == a.length or j == b.length
  end
  (k+1..upper).each do |q|
    unsorted[q] = a[i] if i < a.length
    unsorted[q] = b[j] if j < b.length
    i += 1
    j += 1
  end
  return unsorted
end

def swap(arr, i, j)
  arr[i], arr[j] = arr[j], arr[i]
end

a = 9.times.map { Random.rand(1000) }
puts "---------------- testing merge_sort ---------------"
puts a.inspect
puts merge_sort(a).inspect
puts "---------------------------------------------------\n"
