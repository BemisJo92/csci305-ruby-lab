#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# John Bemis
# bidinc.33@gmail.com
#
###############################################################

$bigrams = Hash.new # The Bigram data structure
$name = "John Bemis"
$title
$index = 1
$titleList = Array.new
$createTitle = ""
$createCounter = 0

#Calls extract which calls the preceding methods in steps 1-4.
#cleanup_title itself does step 5
def cleanup_title(song_title)

	extract(song_title)
	$title.downcase!
	return $title

end

#Retrieves only the characters after the third <SEP>, aka the song.
#These could all be in one method probably, but I was doing these
#step by step and was putting each step in a different method.
def extract(song_title)

	pattern = /<SEP>/

	if pattern =~ song_title
		$title = "#{$'}"
	end
	#pattern2 = /<SEP>/

	if pattern =~ $title
		$title = "#{$'}"
	end
	#pattern3 = /<SEP>/

	if pattern =~ $title
		$title = "#{$'}"
	end

	elim_text()

end

#Removes the garbage after the actual song that we want
def elim_text

	pattern = /[(\[\{\\\/_\-:"`+=*]|feat./

	if pattern =~ $title
		$title = "#{$`}"
	else
		$title = $title
	end

	punct()

end

#Removes all the punctuation in each song and replaces it with whitespace
def punct

	pattern = /[?¿!¡.;&@%#|]/

	if pattern =~ $title
		$title.gsub!(pattern, "")
	end

end

#Finds only the english character songs
def english_chars(song_title)

	pattern = /\w*\s*/

	if pattern =~ song_title
		second_title = "#{$&}"
	else
		final_title = song_title
	end

	$title = second_title

end

#Creates the bigram for a specfic word, and the words that follow that one specific word
# def wordBigram(word)
# 	$titleList.each do |title|
# 		pattern = /#{word}/
# 		if pattern =~ title
# 			secondWord = "#{$'}"
# 			#$bigrams = {"#{word}": $index}
# 		end
# 		pattern2 = /\A \w* /
# 		if pattern2 =~ secondWord
# 			removeSpaces = "#{$&}"
# 		end
# 		pattern3 = /\S\w*\S/
# 		if pattern3 =~ removeSpaces
# 			if $bigrams[word] == nil
# 				$bigrams[word] = Hash.new(0)
# 			end
# 			$bigrams[word]["#{$&}"] += 1
# 		end
# 	end
# end

#Builds a bigram for every word in every title and the words following each word
def wholeBigram(title)

	#Common words that we don't want to be repeated.
	stopWords = /a\b|an\b|and\b|by\b|for\b|from\b|in\b|of\b|on\b|or\b|out\b|the\b|to\b|with\b/
	title.gsub!(stopWords, "")
	$titleList = title.split

	#Add the current word the the hash
	for i in 0..$titleList.length - 2
		$bigrams[$titleList[i]]

		#If no 2D hash exists for the current word, create one and add the second word
		#to it
		if $bigrams[$titleList[i]] == nil
			$bigrams[$titleList[i]] = Hash.new(0)
		end

		#Increase the key of the 2D hash by one everytime one is added
		$bigrams[$titleList[i]][$titleList[i+1]] += 1
	end

end

#Finds the most common word following a word that is passed in
def mcw(word)

	mostCommon = 0
	key = ""
	$bigrams[word].each do |secondWord, frequency|

		if frequency > mostCommon
			mostCommon = frequency
			key = secondWord
		end

	end
	return key

end

#This create_title works when the program is run, but not
#for the tests for some reason
# def create_title(startWord)
# 	begin
# 		$createTitle << "#{startWord} "
# 		$createCounter += 1
# 		begin
# 			nextWord = mcw(startWord)
# 			if($createCounter >= 21)
# 				return
# 			else
# 				create_title(nextWord)
# 			end
# 		end
# 		$createTitle.chop
# 		return $createTitle
# 		#If there is no next word, rescue
# 	rescue
# 		$createTitle.chop
# 		return $createTitle
# 	end
# end

#This method works the exact same as the method above, but the
#former does not pass the tests or answer the questions
def create_title(startWord)

	begin
		createTitle = startWord
		titleLength = 0
		previousWord = createTitle
		usedWords = Array.new
		until titleLength == 19
			currentWord = mcw(previousWord)

			#If the current word is in the array of words that have been used already,
			#break out and return the current title.
			if(usedWords.include?(currentWord))
				break
			else
				usedWords.push(currentWord)
			end

			#If the word we are looking at is not the empty string or nothing,
			#add it to the current title, and increase the title length counter by 1
			if (currentWord != "" && currentWord != nil)
				titleLength += 1
				createTitle.concat(" ")
				createTitle.concat(currentWord)
				previousWord = currentWord
			else
				return creatTitle
			end

		end
		return createTitle

	rescue
		return createTitle
	end

end

# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "

	begin

		if RUBY_PLATFORM.downcase.include? 'mswin'
			file = File.open(file_name)

			unless file.eof?
				file.each_line do |line|
					title = cleanup_title(line)
				end
			end
			file.close

		else
			IO.foreach(file_name, encoding: "utf-8") do |line|
				title = cleanup_title(line)
				wholeBigram(title)
			end
		end

		puts "Finished. Bigram model built.\n"
	rescue
		STDERR.puts "Could not open file"
		exit 4
	end

end

# Executes the program
def main_loop()
	puts "CSCI 305 Ruby Lab submitted by #{$name}"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])

	stop = 0
	while(stop == 0)
		puts "Enter a choice [Enter q for quit]:"
		choice = STDIN.gets.chomp

		if choice == 'q'
			stop = 1
		else
			$createTitle = ""
			$createCounter = 0
			puts create_title(choice)
		end

	end

end

if __FILE__==$0
	main_loop()
end
