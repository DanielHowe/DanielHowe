# Lab 15
# Howe Daniel

#############
# Problem 1 #
#############
import random

def craps():
  print 'Playing craps is so much fun'
  win = 0
  playing = false
  a, b = rollDice()
  print 'You rolled ' + str(a) + ' ' + str(b)
  # First play of the game has different scoring
  points, playing = winningNumbers(a, b, playing)
  print 'You need to make ' + str(points) + ' points on the next roll.  Right? ' + str(playing)
  if (playing == false):
    print 'You roll unlucky..'
    print 'You have ' + str(win) + ' wins'
  else:
    print 'Ok.  Your point to match is ' + str(points)
    win = 1
  # Start play with normal scoring
  
  while (playing):
    print 'Rolling..'
    a, b = rollDice()
    print 'You rolled ' + str(a) + ' ' + str(b)
    points, playing = winningNumbers(a, b, playing)
    if (a + b == points and win == 1):
      print 'Looks like your luck is ever increasing...'
      win = win + 1
    #elif (playing == true):
      #print 'You rolled, %, and %' % (a, b)
    # Does the user want to continue game?
    userContinue = requestString("Continue?")
    if (userContinue[0] == 'n' and playing == true):
      playing = false
      print 'You have let us down'
    elif (playing == false):
      print 'For some, walking away is the hardest thing to do..'
    else:
      print 'Ok then.  We continue.'
      print 'You have ' + str(win) + ' wins'
  #print 'Wins: '+str(win)
  #print 'Losses: 1'

def winningNumbers(a, b, playing):
  sum = a + b
  if (sum == 7 or sum == 11):
    # look a winner
    return sum, true
  elif (sum == 2 or sum == 3 or sum == 12):
    # better luck next time
    return sum, false
  elif (playing == false and sum > 3 and sum < 11):
    # First time playing they get to set the point if they dont win immediately
    return sum, true
  else:
    return sum, false
    
def rollDice():
  
  a = random.randint(1,6)
  b = random.randint(1,6)
  return a, b

#############
# Problem 2 #
#############

