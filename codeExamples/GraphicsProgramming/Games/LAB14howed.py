# Lab14
# Daniel Howe

def main():
  print 'Choose the eggs.txt file to use as a source for words'
  filename = pickAFile() # Choose the file to be read
  rFile = open(filename, 'r')
  wordsAllString = rFile.read() # Saves the words to string
  rFile.close() # File no longer needed
  
  wordsUnique = dict() # Saved unique words
  wordsAll = [] # Saved words go to array
  totalCount = 0 # Store count of total words
  wordsAll, totalCount = vocabSlicer(wordsAllString, wordsAll)
  print 'There are ' + str(totalCount) + ' words in the source file'

  wordsUnique = uniqueWords(wordsAll, wordsUnique)
  common = str(sorted(wordsUnique, key=wordsUnique.get, reverse=True)[0])  # https://stackoverflow.com/questions/7197315/5-maximum-values-in-a-python-dictionary
  count = wordsUnique.get(common)  # Number of times most common word occurs.
  print "The most commonly occurring word is '" + common + "' occurring " + str(count) + " times."
  
  print '\nEOF'
  return 0

###
# Prepares text by removing punctuation and storing in an array
# Parameters: Source file, and word list
# Returns: list coverted, total number of words, and list of unique words
def vocabSlicer(source, wordList):
  print 'Checking wordList for punctuation marks..'
  totalWords = 0
  tempWord = ''
  for char in source:
    # Check each character to ensure no punctuation marks are allowed
    if (char.isalpha() or char == '-'):
      tempWord = tempWord + char
    else:
      wordList.append(tempWord)
      tempWord = ''
  
  # For some reason there are empty sets
  for element in wordList:
    if (element == ''):
      wordList.remove(element)
  wordList.remove('')
  print 'Checking total word count'
  tempWord = ''
  for char in wordList:
    if (char.isalpha()):
      tempWord = tempWord + char
      totalWords = totalWords + 1
    else:
      tempWord = ''
  
  return wordList, totalWords
  
###
# Determines the unique words in a list
# Parameters: array of words, dictionary to save unique words
# Returns: dictionary with the number of times a word has been used
def uniqueWords(wordList, wordDictionary):
  
  tempWord = ''  
  for tempWord in wordList:
    tempWord = tempWord.lower()
    if (tempWord not in wordDictionary):
      wordDictionary[tempWord] = 1
    elif (tempWord in wordDictionary):
      count = int(wordDictionary[tempWord])
      wordDictionary[tempWord] = str(count + 1)     
  return wordDictionary