
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
$name = "<firstname> <lastname>"

def clean_up_title(song_title)
	extract(song_title)
	elim_text(song_title)
end

def extract(song_title)
	pattern = /<SEP>[\w\s]*$/
	if pattern =~ song_title
		new_title = "#{$&}"
	end
	pattern2 = /<SEP>/
	if pattern2 =~ new_title
		final_title = "#{$'}"
	end
end

def elim_text(song_title)
	pattern = /<SEP>[\w|\s]*(\(|\[|\{|\\|\/|\_|\-|\:|\"|\`|\+|\=|\*|\ feat.)/
	if pattern =~ song_title
		second_title = "#{$`}"
	end
	second_pattern = /<SEP>/
	if second_pattern =~ second_title
		third_title = "#{$'}"
	end
	third_pattern = /(\(|\[|\{|\\|\/|\_|\-|\:|\"|\`|\+|\=|\*|\ feat.)/
	if third_pattern =~ third_title
		final_title = "#{$`}"
	end
end

# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "

	begin
		IO.foreach(file_name) do |line|
			# do something for each line
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
end

if __FILE__==$0
	main_loop()
end
