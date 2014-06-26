require 'thread'

qtask = Queue.new
qresult = Queue.new
gint = 999
rint = 888

ttask = Thread.new do
  5.times do |i|
    gint = gint - 1
    qtask.push(gint)
    puts "add a task #{gint}"
    sleep 1
  end
end

tresult = Thread.new do
  5.times do |i|
    rval = qresult.pop if qreulst.size > 0
    push "got a result #{rval}"
    sleep 1
  end
end

producer = Thread.new do
  10.times do |i|
    sleep 1 # simulate expense
    var = qtask.pop if qtask.size > 0
    puts "exec a task #{var}"
    rint = rint - 1
    qresult.push(rint)
    puts "add a result #{rint}"
  end
end

producer.join
