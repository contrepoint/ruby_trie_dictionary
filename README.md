## Ruby implementation of a trie that stores a dictionary
* The dictionary can be used to spellcheck words and to suggest words that begin with a particular prefix
* Associated [presentation](https://docs.google.com/presentation/d/1Zg0H-cHZjt-VvDdVxR1zdb1WsC3dfgkVVe_eXnP0uyM/edit?usp=sharing)

### Dictionary format
* each word is on a separate line
* no empty lines
* character set: uppercase and lowercase English alphabet, single apostrophe

### Format of text to be spellchecked
* Multiple words in a line
* Has empty lines
* character set: uppercase and lowercase English alphabet, single apostrophe, some punctuation marks

### Usage
* To spellcheck only: `./run`
* To spellcheck and find words with a certain prefix: `./run $PREFIX` (eg: `./run super`)
* Misspelled words are in `misspelled_words.txt`
* Words that start with the given prefix are in `words_with_prefix.txt`
* Total number of misspelled words and words that start with a given prefix are printed to the terminal
* Time taken is benchmarked with ruby's `benchmark` gem

### Notes
* `SpellChecker.new('large.txt').spellcheck_lines('sonnets.txt')`
  * If needed, swap out `large.txt` for another dictionary and/or `sonnets.txt` for another text file
