# = Insertion Sort
# == Iterative
# === Loop Invariant
# Given an unsorted array A, after each iteration of the outer loop, A[0..i-1]
# contains the same elements as before the iteration, but in sorted order. i <= A.length.
#
# *Initialization: Before finishing the first iteration i = 1, therefore
# A[0..i-1] = A[0], since this subarray has only a single element, it is sorted.
#
# *Maintenance: Before finishing an iteration A[0..i-1] is sorted. The inner
# loop checks that A[i] is lesser than any other element in A[0..i-1], if it is,
# then the algorithm places it in A[k] with 0 <= k <= i-1. The subarray
# increases its size by 1 and is sorted, hence A[0..i] is sorted
#
# *Termination: After the algorithm terminates A[0..i-1] is sorted and i = A.length.
# Since the array indexing starts at 0, A[0..i-1] includes all elements from A,
# then A is sorted.
def insertion_iterative(unsorted)
  (1...unsorted.length).each do |i|
    key = unsorted[i]
    j = i - 1
    while j > 0 and unsorted[j] > key
      unsorted[j+1] = unsorted[j]
      j -= 1
    end
    unsorted[j+1] = key
  end
  return unsorted
end

# == Recursive
# === Loop Invariant
# The recursive version can be proven correct similarly to the iterative one.
# The difference is that each iteration is started by the call of the function.
def insertion_recursive(a, i=0)
  if i < a.length
    k = i
    while k > 0 and a[k] < a[k-1]
      a[k], a[k-1] = a[k-1], a[k]   #swap
      k = k - 1
    end
    insertion_recursive(a, i+1)
  else
    return a
  end
end

a = 15.times.map { Random.rand(10000) }
puts "----------- testing insertion_iterative -----------"
puts a.inspect
puts insertion_iterative(a).inspect
puts "---------------------------------------------------\n"

a = 15.times.map { Random.rand(10000) }
puts "----------- testing insertion_recursive -----------"
puts a.inspect
puts insertion_recursive(a).inspect
puts "---------------------------------------------------\n"
