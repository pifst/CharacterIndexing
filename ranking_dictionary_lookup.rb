#     Christopher Fields, July 20th, 2013     #
# Created with Ruby version 1.9.3p392         #
# *Should* work with Ruby 1.9 onward          #
#*********************************************#

def get_memory_usage
  `ps -o rss= -p #{Process.pid}`.to_i
end

def clean_string(input)
  input.strip # removes accidental whitepsace
end

def uniquecharacters(count)
  (count).to_a.permutation.map(&:join)
end
def fact(m)
  (1..m).inject {|s,i| s *= i}
end
def create_hash(input)
  array = input.split("") # Convert string to array
  char_hash=Hash[array.group_by {|x| x}.map {|alphabet,values| [alphabet,values.count]}] # Convert String to hash,
  # STARS becomes {"s"=>2, "t"=>1, "a"=>1, "r"=>1}
end
def hashvalues_to_array(sort_num) # ex. [sum, highest -> lowest]
  num_set = sort_num.values.sort.reverse # Convert hash values to array, sort descending
  num_set.insert(0, num_set.inject(0) {|sum, i| sum + i}) # Place sum of array at [0]
  # [SUM, Char_Values]
end
def permutation(string_array)
  fact_array = string_array.map{ |x| fact(x) } # Factorializes the entire array
  (fact_array[0]) / (fact_array[1..fact_array.length].inject(:*))
  # Output of hash_values_to_array ex.[5, 2, 1, 1, 1] to determine # of unique outcomes
end

## Print to Console ##
def print_input(input)
  puts "---------------------------------------"
  puts "The input '#{input}' is #{input.length} characters long."
  #puts "---------------------------------------"
end

def print_outcomes(string, dict_unique, array)
  puts "---------------------------------------"
  puts "The input '#{string}', is ranked # #{dict_unique.index(string) + 1} of #{permutation(array)} in the alphabetically sorted array of outcomes"
  puts "---------------------------------------"
end

def predict_index(string, array)
  puts " There are #{  permutation(array) / (string.length) } choices per unique letter"
  puts "---------------------------------------"
end

before = get_memory_usage

beginning = Time.now # Begin timer

formatted_string = clean_string(ARGV[0])

alpha_test = ( (formatted_string.length > 1 && formatted_string.length < 26) && (formatted_string.match(/^[[:upper:]]+$/)) && ((formatted_string.chars.to_a.uniq).count > 1) )

if alpha_test == nil
  puts "nil "
  puts "'#{formatted_string}' is invalid."
  puts "Doublecheck input. Input must contain uppercase characters A-Z. No numbers. No special characters"
  puts ""
else
  if alpha_test == false
    puts "false "
    puts "'#{formatted_string}' is invalid"
    puts "Doublecheck input. Input must have 2 or more unique characters, and must be less than 26 characters"
    puts ""
  else
    formatted_hash = create_hash(formatted_string)

    array = hashvalues_to_array(formatted_hash)

    abc = formatted_string.split("")

    dict_unique = uniquecharacters(abc.sort).uniq

    print_outcomes(formatted_string, dict_unique, array)

    puts " #{dict_unique} "
  end

  # Observe ending conditions #
  after = get_memory_usage
  puts "---------------------------------------"
  puts "Time elapsed #{ ( (Time.now - beginning)*1000).round(3) } milliseconds, memory used: #{(after-before).to_s}KB " #Print elapsed time & memory useage.
  puts "---------------------------------------"
  puts ""
  # Observe ending conditions #
end
