import urllib
import os
import re

def tryUrl():
  trying = true
  urlString = []
  while (trying):
    urlString = requestString("What address ('no' quits):")
    #urlString = 'http://www.google.com'
    
    # Check to see if the user wants to continue
    if (urlString == 'no'):
      trying = false
    else:
      if (urlString[0:5] == 'https'):
        print 'still working on ssl'
      elif (urlString[0:4] != 'http'):
        print urlString[0:4]
        print 'Please re-enter address correctly'
      else:
        print 'opening connection'
        httpSocket = urllib.urlopen(urlString)
        httpRead = httpSocket.read()
        print httpRead

def buildPage(filename):
  