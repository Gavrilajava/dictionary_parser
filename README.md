#Dictionary Parser

This program parses a text file containing a list of words and creates two output files: one containing sequences of four characters that occur in the words in alphabetical order and another containing the words that contain these sequences.

## Usage

To use the program, go to the program directory in the console and call ruby with the following parameters. If no filename is provided, the program will default to dictionaries/test.txt.

```bash
  ruby -r "./dictionary_parser.rb" -e "parse 'dictionaires/full_dictionary.txt'"  
```
The program will generate two output files in the output directory: sequences.txt and words.txt.

## Data Structure

The program uses a nested hash data structure where keys are characters, and values are words from which we get these characters. This structure allows for performant search and efficient use of memory.

## Algorithm

The program iterates through each word in the input file and splits it into an array of characters. It then iterates through the array, creating a sequence of four characters starting from each character in the array. If the sequence contains non-alphabetic characters, it is skipped. Otherwise, the program adds the sequence to the nested hash data structure, with each character in the sequence representing a level of the hash. If the sequence already exists in the hash, the word is marked as a duplicate. If not, the word is added to the hash.

Once the hash is populated with all the sequences and words, the program iterates through the hash in alphabetical order and writes each sequence and word to their respective output files. Duplicates are skipped.

## Tests

The program comes with tests. To run them, you need to install RSpec and RSpec-Benchmark. Be aware that performance tests depend on your hardware and Ruby configuration and are more benchmarks than tests (you need to figure out benchmarks for your machine before changing the code). To run the tests:

```bash
  rspec
```

## License
This program is licensed under the MIT License.