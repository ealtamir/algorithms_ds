# = Selection Sort
# == Iterative
# === Loop Invariant
# Given an unsorted array A, after each iteration of the outer loop, A[0..i-1]
# contains the same elements as before the iteration, but in sorted order. i <= A.length.
#
# *Initialization: Before finishing the first iteration i = 1, therefore
# A[0..i-1] = A[0], since this subarray has only a single element, it is sorted.
#
# *Maintenance: Before finishing an iteration A[0..i-1] is sorted and non of the remaining
# (i..A.length-1) elements are lesser than the ones in (0..i-1), because each of these
# was selected consecutively as the next smallest element of the array. In the current
# iteration the smallest element of the subarray A[i..A.length-1] is chosen and placed
# in A[i]. Before finishing the iteration A[0..i] is a sorted subarray of A.
#
# *Termination: After the algorithm terminates A[0..i-1] is sorted and i = A.length.
# Since the array indexing starts at 0, A[0..i-1] includes all elements from A,
# then A is sorted.
#
def selection_iterative(a)
  # When all the smallest elements are sorted, the last 
  # one will be the biggest.
  (a.length-1).times do |i|
    smallest = i
    (i...a.length).each do |j|
      if a[j] < a[smallest]
        smallest = j
      end
    end
    a[smallest], a[i] = a[i], a[smallest] #swap
  end
  return a
end

a = 15.times.map { Random.rand(10000) }
puts "----------- testing insertion_recursive -----------"
puts a.inspect
puts selection_iterative(a).inspect
puts "---------------------------------------------------\n"


