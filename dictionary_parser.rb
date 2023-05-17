# frozen_string_literal: true

def parse(filename = 'dictionaires/test.txt')
  # The data structure that best serves the needs of performant search and uses memory efficiently is a nested hash
  # where keys are characters, and values are words from which we get these characters.
  # Therefore, we will start by initializing it.
  tree = {}

  File.foreach(filename, chomp: true) do |word|
    # downcase the word and split it to array of chars
    chars_array = word.downcase.split('')

    # We will iterate through the split word.
    (0..(chars_array.size - 4)).each do |starting_index|
      # set all four keys first
      a, b, c, d = chars_array.slice(starting_index, 4)
      # regex could be qute 'heavy' so to use it once concat the chart to word
      next unless "#{a}#{b}#{c}#{d}".match(/^[a-z]+$/)

      # set first three keys if they not exist yet
      tree[a] ||= {}
      tree[a][b] ||= {}
      tree[a][b][c] ||= {}
      # if we keys combination exists, set it as duplicate,
      # if not set it to word
      tree[a][b][c][d] = if tree[a][b][c][d]
                           :duplicate
                         else
                           word
                         end
    end
  end

  # Now lets open the files to output the records
  sequenses = File.open('output/sequences.txt', 'w')
  words = File.open('output/words.txt', 'w')

  # iterate throuh our tree in alphabetical order
  tree.keys.sort.each do |l1|
    tree[l1].keys.sort.each do |l2|
      tree[l1][l2].keys.sort.each do |l3|
        tree[l1][l2][l3].keys.sort.each do |l4|
          word = tree[l1][l2][l3][l4]
          # skip this keys if word is a duplicate
          next if word == :duplicate

          # write concated keys and value to files
          sequenses.puts "#{l1}#{l2}#{l3}#{l4}"
          words.puts word
        end
      end
    end
  end

  # close the files
  sequenses.close
  words.close
end
