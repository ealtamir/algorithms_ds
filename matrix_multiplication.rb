require_relative 'functional'

class Algorithms
  def square_matrix_multiplication(a, b)
    n = a.length
    result = []
    n.times { |i| result << [] }
    (0...n).each do |i| # rows from a
      (0...n).each do |j| # columns from b
        c = 0
        (0...n).each do |k| # rows from b and columns from a
          c += a[i][k] * b[k][j]
        end
        result[i] << c
      end
    end
    return result
  end
end

puts "----------- testing square_matrix_multiplication ------------"
## multiplying by the identity matrix
#a = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
#b = [[-14, 34, -34], [-7, -13, 13], [38, 8, 28]]

n = 1000
a = n.times.map do |i|
  n.times.map do |j|
    Random.rand(1000.0) * [1, -1][Random.rand(2)]
  end
end
b = n.times.map do |i|
  n.times.map do |j|
    Random.rand(1000.0) * [1, -1][Random.rand(2)]
  end
end
puts a.inspect
puts b.inspect
puts Algorithms.new.square_matrix_multiplication(a, b).inspect
puts "------------------------------------------------------------\n"
