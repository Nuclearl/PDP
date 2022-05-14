a = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]
b = [
  [10, 11, 12],
  [13, 14, 15],
  [16, 17, 18]
]


start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
mutex = Mutex.new

size = a.length
result = Array.new(size) {Array.new(size) {0}}

threads = []
size.times do |row|
  size.times do |col|
    threads << Thread.new do
      size.times do |i|
        mutex.synchronize do
          result[row][i] += a[row][col]*b[col][i]
        end
      end
    end
  end
end

threads.each(&:join)

end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

puts result.inspect

print("Time execution: ", start_time - end_time)