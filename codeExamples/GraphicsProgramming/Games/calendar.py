import calendar
from datetime import *

def mainCalendar():
  #month = requestInteger("What month were you born?")
  month = 2
  #day = requestInteger("What day were you born?")
  day = 9
  #year = requestInteger("What year were you born?")
  year = 1984
  
  # Character formatting
  lengthSpacing = 0
  widthSpacing = 0
  
  print 'Here is your birthday month\n'
  print calendar.prmonth(year,month)
  print '\n'
  print date.today()
  print date.days
  print (date.today() - date(year,month,day)).days