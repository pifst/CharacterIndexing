Christopher Fields
7/25/2013

Contents
  1. ranking.rb [the answer]
  2. ranking_dictionary_lookup.rb [lookup via dictionary of alphabetically sorted results]
  3. readme.txt [explanation of results & observations]

I first created [ranking_dictionary_lookup.rb] to solve the problem in the way the technical interview problem suggested it could be done.  The main equation for solving this problem is (total number of letters)! / (number of repeats)!  For example, to solve for STARS we would have (5!) / (2! * 1! * 1! * 1!) which equals 60 possible results.  I then alphabetically generated all possible combinations, removing duplicates.  Searched the array for the input, to find the index, and I found my answer.  However, the dictionary method is very slow, after 10 or 11 unique characters it becomes nearly impossible to calculate all possibilities, certinatinly going over the restrictions of 500ms & 1GB of memory usage.

By first solving this problem with the dictionary lookup method, I began to notice patterns.  Continuing to use the input string "STARS", I began to notice that by dividing the array length (60) by the input length (5), I could find the # of results (12) per character.  If a character was repeated I could simply multiply the # of results per character (12) by the times it was repeated.  In this case, I set out to generate an alphabetized hash in which the key was each unique letter of the input, and the value was the amount of times it appeared ex. STARS {"A"=>1, "R"=>1, "S"=>2, "T"=>1} -> {"A"=>12, "R"=>12, "S"=>24, "T"=>12}.  Knowing S was the first letter of the input, now knew that the low range of the rank was between 24 (value of A + R) with the upper range of 48 (values of A + R + S).  Next by iteratively removing the leading character from the input string, and repeating this process I could add up the low ranges until the input string was empty.  After iteratively summing the low range numbers, and adding 1 (which adjusts the number from cardinal to ordinal) we find our answer.  This solution is found inside [ranking.rb].

Testing [ranking.rb] with the highest rank (worst case scenario), 25 unique characters in reverse alphabetical order "YXWVUTSRQPONMLKJIHGFEDCBA".  The rank can be calculated in a total of 10.928 milliseconds, using only 196KB of memory.  Well underneeth the requierment of 500ms and 1GB of memory.

However, one of the requirements is that the rank be stored inside a single 64bit integer.  An unsigned 64bit integer can hold a maximum value of 2^64 - 1, which is 1.84467440737095 x 10^19.

In this "worstcase scenario", 25 unique characters is 25! which is 1.5511210043331 x 10^25.  This means for this case, 25 unique characters cannot satisfy the requirements of fitting into a single unsigned 64bit integer.  For a 25 character worst case (reverse alphabetical) string to fit inside a 64bit unsigned integer, it must have one letter duplicated 10 times, for a rank of 4.27447366714368 x 10^18.  The maximum all unique character worst case (reverse alphabetical), input string is 20 characters long at 2.43290200817664 x 10^18.

The code was created with, and confirmed to work with Ruby v1.9.3p392.  However, while untested should work with versions of Ruby v1.9XX.

This code was created by Christopher Fields.
http://www.linkedin.com/in/csffsc
