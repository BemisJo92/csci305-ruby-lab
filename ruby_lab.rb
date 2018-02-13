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

def cleanup_title(song_title)
	extract(song_title)
	$title.downcase!
	#print song_title
	#puts $title
	return $title
end

#Retrieves only the characters after the third <SEP>, aka the song
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
	#puts third_title
	#pattern4 = /[\w*\s*]/
	#if pattern4 =~ third_title
		#final_title = "#{$&}"
	#end
	elim_text()
end

#Removes the garbage after the actual song that we want
def elim_text
	#pattern = /\(|\[|\{|\\|\/|\_|\-|\:|\"|\`|\+|\=|\*|feat./
	pattern = /[(\[\{\\\/_\-:"`+=*]|feat./
	#pattern = /\(/
	if pattern =~ $title
		$title = "#{$`}"
	else
		$title = $title
	end
	punct()
	#$title = final_title
end

#Removes all the punctuation in each song and replaces it with whitespace
def punct
	#pattern = /\?|¿|!|¡|\.|;|&|@|%|#\|/
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
def buildBigram(word)
	$titleList.each do |title|
		pattern = /#{word}/
		if pattern =~ title
			secondWord = "#{$'}"
			#$bigrams = {"#{word}": $index}
		end
		pattern2 = /\A \w* /
		if pattern2 =~ secondWord
			removeSpaces = "#{$&}"
		end
		pattern3 = /\S\w*\S/
		if pattern3 =~ removeSpaces
			if $bigrams[word] == nil
				$bigrams[word] = Hash.new(0)
			end
			$bigrams[word]["#{$&}"] += 1
		end
	end
end

#Builds a bigram for every word in every title and the words following each word
def testBigram(title)
	$titleList = title.split
	for i in 0..$titleList.length - 2
		$bigrams[$titleList[i]]
		if $bigrams[$titleList[i]] == nil
			$bigrams[$titleList[i]] = Hash.new(0)
		end
		$bigrams[$titleList[i]][$titleList[i+1]] += 1
	end
end

#Finds the most common word following a word that is passed in
def mcw(word)
	#buildBigram(word)
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

def create_title(startWord)
	$createTitle << "#{startWord} "
	$createCounter += 1
	begin
		nextWord = mcw(startWord)
		if($createCounter >= 20)
			return
		else
			create_title(nextWord)
		end
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
					# do something for each line (if using windows)
					title = cleanup_title(line)
				end
				#$bigrams.inspect
			end
			file.close
		else
			IO.foreach(file_name, encoding: "utf-8") do |line|
				# do something for each line (if using macos or linux)
				#print line
				title = cleanup_title(line)
				testBigram(title)
				#$titleList.push(title)
			end
			#create_title("jim")
			#puts $createTitle
			#puts mcw("happy")
			#puts $bigrams.inspect
			#puts $bigrams[keys[0]]
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

	# Get user input
	choice = a
	puts "Enter a choice [Enter q for quit]:"
	while(choice != q)
		case choice
		when
end

if __FILE__==$0
	main_loop()
end
