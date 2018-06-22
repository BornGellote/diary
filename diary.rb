require 'fileutils' #gem fileutils

current_path = File.dirname(__FILE__)

=begin
ветка, считать или записть ?доделать?
для чтения выводить весь список записей - год-месяц-день, показывать выброанный файл, после предлагать оставить его/переписать/удалить)
для записи, все попрятать в классы/методы
=end
puts "Hi, i'm your diary. Tell me, what's bothering you today? Or you want to read old  record?"
sleep 1
puts "Make your choice - read or write?"
hi = STDIN.gets.encode("UTF-8").chomp
if hi == "read" || hi == "Read" || hi == "READ" || hi == "r"
  sleep 1
  puts "Ok, how you want read record? "
elsif hi == "write" || hi == "Write" || hi == "WRITE" || hi == "w"
  puts "I'm save all in file. If you told all, please write 'end' that close me..."
end

all_folder_y = []
all_folder_y << Dir.new(current_path + '/data/' ).entries.reject { |f|  File.directory? f }.join( ', ' )

#Найти последную запись алгоритмом "Пузырька"?
puts "Your last entry saved in file -  #{all_folder_y}"

line = nil
all_lines = []

# Конец общения с дневником
while line != "_end_" do
  line = STDIN.gets.encode("UTF-8").chomp
  all_lines << line
end

time = Time.now
dir_y = time.strftime("%Y") #year
dir_m = time.strftime("%m") #mouth
file_name = time.strftime("%d")       #day
time_str = time.strftime("%H:%M")    #time
separetor = "-----------------------------"

new_path = current_path + "/data/" + dir_y + "/" + dir_m
unless File.directory?(new_path)
  FileUtils::mkdir_p new_path
end

file = File.new(new_path + "/" + file_name + ".txt", "a:UTF-8")
file.print("\n\r" + time_str + "\n\r")
all_lines.pop
for item in all_lines
  file.puts(item)
end
file.puts(separetor)
file.close

=begin Обязательно не забыть про исключения
rescue Errno::ENOENT => error   FileUtils.mkdir_p(dirname_m) unless File.directory?(dirname_m)
=end

puts "Your entry is saved to a file #{file_name}.txt inside folder 'data'. "
puts "You recorded at #{time_str}."
puts "Goodbye. See you late ;-)"

#Постить в соц.сети?