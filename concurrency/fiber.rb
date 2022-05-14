consumer = Fiber.new do |producer, queue|
  5.times do
    while queue.size < 2
      queue = producer.resume queue
    end
    puts "Pop: [#{queue.shift}, #{queue.shift}]"
  end
end

producer = Fiber.new do |queue|
  value = 1
  loop do
    3.times { queue << value; value += 1}
    puts queue.inspect
    Fiber.yield queue
  end
end

consumer.resume(producer, [])