#     Christopher Fields, July 24th, 2013     #
# Created with Ruby version 1.9.3p392         #
# *Should* work with Ruby 1.9 onward          #
#*********************************************#

def get_memory_usage
  `ps -o rss= -p #{Process.pid}`.to_i
end
def clean_string(input)
  input.strip # removes accidental whitepsace
end
def fact(m) # Create factorial from input
  (1..m).inject {|s,i| s *= i}
end

def make_hash(string) #Commandline input - creates |k,v| pair of characters to repetitions
  array = string.split("") # Convert string to array
  char_hash=Hash[array.group_by {|x| x}.map {|alphabet,values| [alphabet,values.count]}]
  Hash[char_hash.sort]
  # Convert String to hash,
  # STARS becomes {"s"=>2, "t"=>1, "a"=>1, "r"=>1}
end

def make_array(hash) # convert
  array = hash.values
  sum = array.inject{|sum,x| sum + x }
  [sum, array]
  # STARS becomes [5, [2,1,1,1]]
end

def outcomes_per_character(array)
  factorialized_array = array[1].map{ |x| fact(x) }
  multiplied_fa = factorialized_array[0..factorialized_array.length].inject(:*)
  outcomes = (fact(array[0]))/(multiplied_fa)
  outcomes / (array[0]) # per character
end

input_string = clean_string(ARGV[0])

# Observe starting conditions #
before = get_memory_usage
beginning = Time.now # Begin timer
# Observe starting conditions #

alpha_test = ( (input_string.length > 1 && input_string.length < 26) && (input_string.match(/^[[:upper:]]+$/)) && ((input_string.chars.to_a.uniq).count > 1) )

cache_sum = 0

if alpha_test == nil
  #puts "nil "
  puts "'#{input_string}' is invalid."
  puts "Please check the input. Input must contain uppercase characters A-Z. No numbers. No special characters"
  puts ""
else
  if alpha_test == false
    #puts "false "
    puts "'#{input_string}' is invalid"
    puts "Please check the input. Input must have 2 or more unique characters, and must be less than 26 characters"
    puts ""
  else
    while input_string.length > 0

      input_array = input_string.split("")
      hash = make_hash(input_string)
      array = make_array(hash)

      outcomes = outcomes_per_character(array)

      cache = hash.each {|k, v| hash[k] = v * outcomes }
      cache_keys = hash.keys
      cache_values = hash.values

      cache_upper = cache_values[0..cache_keys.index( input_array[0]) ].inject(:+)
      cache_lower = cache_upper - ( cache.fetch(input_array[0]))
      cache_sum = cache_sum + cache_lower #sum the lowest possible answer per factorial

      input_string.slice!(0) #discard first character from input
    end
    cache_sum += 1 # Add 1 to convert from cardinal number to ordinal number

    puts ""
    puts "The input '#{clean_string(ARGV[0])}' is ranked # #{cache_sum}"
  end

  # Observe ending conditions #
  after = get_memory_usage
  puts "---------------------------------------"
  puts "Time elapsed #{ ( (Time.now - beginning)*1000).round(3) } milliseconds, memory used: #{(after-before).to_s}KB " #Print elapsed time & memory useage.
  puts "---------------------------------------"
  puts ""
  # Observe ending conditions #
end
