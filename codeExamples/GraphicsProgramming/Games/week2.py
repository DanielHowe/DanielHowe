def horizontalMirrorTopHalf():
  filename = pickAFile()
  pic = makePicture(filename)
  for x in range(0, getWidth(pic)):
    for y in range(0, getHeight(pic) / 2):
      #make a new pixel object storing the current position
      p = getPixel(pic, x, y)
      #store the colors of the pixel
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      yNew = getHeight(pic) - ( y + 1)
      offset = getPixel(pic, x, yNew)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  repaint(pic)
  writePictureTo(pic, "/Users/danielhowe/Desktop/testImage")
  
def horizontalMirrorBottomHalf():
  filename = pickAFile()
  pic = makePicture(filename)
  for x in range(0, getWidth(pic)):
    for y in range(0, getHeight(pic) / 2):
      #make a new pixel object storing the position offset
      yBottom = getHeight(pic) - (y + 1)
      p = getPixel(pic, x, yBottom)
      #store the colors of the current pixel
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      #make a new pixel object storing the position in the for loop
      offset = getPixel(pic, x, y)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  repaint(pic)
  writePictureTo(pic, "/Users/danielhowe/Desktop/testImage")

def verticalMirrorLeftHalf():
  filename = pickAFile()
  pic = makePicture(filename)
  for x in range(0, getWidth(pic) / 2):
    for y in range(0, getHeight(pic)):
      p = getPixel(pic, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      xNew = getWidth(pic) - (x + 1)
      offset = getPixel(pic, xNew, y)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  repaint(pic)
  writePictureTo(Pic, "/Users/danielhowe/Desktop/testImage")

def verticalMirrorRightHalf():
  filename = pickAFile()
  pic = makePicture(filename)
  for x in range(getWidth(pic) / 2, getWidth(pic)):
    for y in range(0, getHeight(pic)):
      p = getPixel(pic, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      xNew = x - getWidth(pic) / 2
      xNew = getWidth(pic) / 2 - xNew
      offset = getPixel(pic, xNew, y)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  repaint(pic)
  writePictureTo(Pic, "/Users/danielhowe/Desktop/testImage")
  
def quadMirror():
  filename = pickAFile()
  pic = makePicture(filename)
  #mirror left
  for x in range(0, getWidth(pic) / 2):
    for y in range(0, getHeight(pic)):
      p = getPixel(pic, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      xNew = getWidth(pic) - (x + 1)
      offset = getPixel(pic, xNew, y)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  #mirror top
  for x in range(0, getWidth(pic)):
    for y in range(0, getHeight(pic) / 2):
      p = getPixel(pic, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      yNew = getHeight(pic) - ( y + 1)
      offset = getPixel(pic, x, yNew)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  repaint(pic)
  writePictureTo(pic, "/Users/danielhowe/Desktop/testImage")

def simplePic():
  mypic = makeEmptyPicture(100, 100)
  for x in range(0, getWidth(mypic)):
    for y in range(0, getHeight(mypic)):
      setColor(getPixel(mypic, x, y), blue)
  show(mypic)
  return(mypic)

def simpleCopy(picture):
  height = getHeight(picture)
  width = getWidth(picture)
  newPicture = makeEmptyPicture(width, height)
  for x in range(0, width):
    for y in range(0, height):
      p = getPixel(picture, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      newPix = getPixel(newPicture, x, y)
      setRed(newPix, r)
      setGreen(newPix, g)
      setBlue(newPix, b)
  show(newPicture)
  writePictureTo(newPicture, "/Users/danielhowe/Desktop/testImage")
  return(newPicture)

def rotatePic(picture):
  #start with making copy of dimensions
  width = getWidth(picture)
  height = getHeight(picture)
  #added change of dimensions to flip for convenience
  newWidth = height
  newHeight = width
  #make new picture with rotated dimensions
  newPicture = makeEmptyPicture(newWidth, newHeight)
  for x in range(0, width):
    for y in range(0, height):
      #get color for current pixel
      p = getPixel(picture, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      #determine where to place
      newX = y
      newY = newHeight - (x + 1)
      #set color on new image
      newPix = getPixel(newPicture, newX, newY)
      setRed(newPix, r)
      setGreen(newPix, g)
      setBlue(newPix, b)
  show(newPicture)
  writePictureTo(newPicture, "/Users/danielhowe/Desktop/testImage")
  return(newPicture)
  
def shrink():
  filename = pickAFile()
  pic = makePicture(filename)
  #create new picture file that is half the size
  width = getWidth(pic)/2
  height = getHeight(pic)/2
  newPicture = makeEmptyPicture(width, height)
  newX = 1
  newY = 1
  for x in range (0, getWidth(pic), 2):
    for y in range (0, getHeight(pic), 2):
      p = getPixel(pic, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      newPix = getPixel(newPicture, newX, newY)
      setRed(newPix, r)
      setGreen(newPix, g)
      setBlue(newPix, b)
      newY = newY + 1
      if (newY >= width):
        newY = 1
        print 'reset y'
    newX = newX + 1
    if (newX >= height):
        newX = 1
        print 'reset x'
  show(newPicture)
  writePictureTo(newPicture, "/Users/danielhowe/Desktop/testImage")
  return(newPicture)