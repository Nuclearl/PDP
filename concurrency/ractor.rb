first_ractor = Ractor.new do
  loop do
    msg = Ractor.receive
    puts "first_ractor received: #{msg}"
    Ractor.yield(msg, move: true)
  end
end

second_ractor = Ractor.new do
  loop do
    msg = Ractor.receive
    puts "second_ractor received: #{msg}"
    Ractor.yield(msg, move: true)
  end
end

Ractor.new(first_ractor, second_ractor) do |first_ractor, second_ractor|
  Thread.new do
    loop do
      msg = first_ractor.take
      puts "first_thread[first_ractor]: #{msg}"
    end
  end

  Thread.new do
    loop do
      msg = second_ractor.take
      puts "second_thread[second_ractor]: #{msg}"
    end
  end

  sleep
end

3.times do |i|
  Thread.new do
    first_ractor.send("#{i} was sent to first_ractor")
  end
  Thread.new do
    second_ractor.send("#{i} was sent to second_ractor")
  end
end

sleep(10)

