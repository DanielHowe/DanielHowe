def simplePaddedCopy(source, padding):
  print 'Starting padding of '
  print source
  print padding
  #make the new image to be the size of the source plus padding
  height = getHeight(source) + padding * 2
  width = getWidth(source) + padding * 2
  newPicture = makeEmptyPicture(width, height)
  for x in range(0, getWidth(source)):
    for y in range(0, getHeight(source)):
      p = getPixel(source, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      #set the new image location at the padding distance
      newPix = getPixel(newPicture, x + padding, y + padding)
      setRed(newPix, r)
      setGreen(newPix, g)
      setBlue(newPix, b)
  #show(newPicture)
  writePictureTo(pic, "/Users/danielhowe/Google Drive/Personal Folder/School/CST205 Graphic Programming/Lab5/simplePaddedCopyOutput.png")
  return(newPicture)

def simplePaddedTest():
  filename = pickAFile()
  pic = makePicture(filename)
  pic = simplePaddedCopy(pic, 100)

def pyCopy(source, target, targetX, targetY):
  #target = makeEmptyPicture(getWidth(source) + targetX * 2, getHeight(source) + targetY * 2)
  print 'Starting copy of '
  print source
  print 'To target '
  print target
  #print source
  #print 'Copying to '
  #print target
  #print 'X Offset '
  #print targetX
  #print 'Y Offset'
  #print targetY
  for x in range(0, getWidth(source)):
    for y in range(0, getHeight(source)):
      p = getPixel(source, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      if (x + targetX > getWidth(target)) or (y + targetY > getHeight(target)):
        print 'image too large, skipping pixels'
      else:
        newPix = getPixel(target, x + targetX, y + targetY)
        setRed(newPix, r)
        setGreen(newPix, g)
        setBlue(newPix, b)
  #show(newPicture)
  return(target)

def shrink(source, percent):
  print 'Shrinking image '
  #original code to create new picture file that is half the size
  #width = getWidth(source)/2
  #height = getHeight(source)/2
  
  #new code to accept percentage and convert back to int for newPicture function
  newWidth = getWidth(source) * percent
  newWidth = int(newWidth)
  newHeight = getHeight(source) * percent
  newHeight = int(newHeight)
  print 'Shinking image to %d x %d' % (newWidth,newHeight)
  newPicture = makeEmptyPicture(newWidth, newHeight)
  for x in range (0, getWidth(source), 2):
    for y in range (0, getHeight(source), 2):
      pix = getPixel(source, x, y)
      color = getColor(pix)
      if (x == 0 and y != 0):
        #old code
        #newPix = getPixel(newPicture, x / 2, y / 2 - 1)
        newPix = getPixel(newPicture, int(x * (percent / 100)), int(y * (percent / 100) - 1))
        setColor(newPix, color)
      elif (x != 0 and y == 0):
        #old code
        #newPix = getPixel(newPicture, x / 2 - 1, y / 2)
        newPix = getPixel(newPicture, int(x * (percent / 100) - 1), int(y * (percent / 100)))
        setColor(newPix, color)
      elif (x != 0 and y != 0):
        #old code
        #newPix = getPixel(newPicture, x / 2 - 1, y / 2 - 1)
        newPix = getPixel(newPicture, int(x * (percent / 100) - 1), int(y * (percent / 100) - 1))
        setColor(newPix, color)
      else:
        #old code
        #newPix = getPixel(newPicture, x / 2, y / 2)
        newPix = getPixel(newPicture, int(x * (percent / 100)), int(y * (percent / 100)))
        setColor(newPix, color)
  #show(newPicture)
  #writePictureTo(newPicture, "/Users/danielhowe/Desktop/testImage")
  return(newPicture)

def horizontalMirrorTopHalf(source):
  print 'Starting horizontal mirror of '
  print source
  for x in range(0, getWidth(source)):
    for y in range(0, getHeight(source) / 2):
      #make a new pixel object storing the current position
      p = getPixel(source, x, y)
      #store the colors of the pixel
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      yNew = getHeight(source) - ( y + 1)
      offset = getPixel(source, x, yNew)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  print 'Completed mirroring'
  return(source)

def halfRed(source):
  print 'Starting removal of half red colors of '
  print source
  pixels = getPixels(source)
  for p in pixels:
    r = getRed(p)
    setRed(p, r * 0.5)
  return(source)

def quadMirror(source):
  print 'Starting quad mirror of '
  print source
  #mirror left
  for x in range(0, getWidth(source) / 2):
    for y in range(0, getHeight(source)):
      p = getPixel(source, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      xNew = getWidth(source) - (x + 1)
      offset = getPixel(source, xNew, y)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  #mirror top
  for x in range(0, getWidth(source)):
    for y in range(0, getHeight(source) / 2):
      p = getPixel(source, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      yNew = getHeight(source) - ( y + 1)
      offset = getPixel(source, x, yNew)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  return(source)

def verticalMirrorLeftHalf(source):
  print 'Starting vertical mirror of '
  print source
  for x in range(0, getWidth(source) / 2):
    for y in range(0, getHeight(source)):
      p = getPixel(source, x, y)
      r = getRed(p)
      g = getGreen(p)
      b = getBlue(p)
      xNew = getWidth(source) - (x + 1)
      offset = getPixel(source, xNew, y)
      setRed(offset, r)
      setGreen(offset, g)
      setBlue(offset, b)
  return(source)

def makeCollage():
  height = 3300
  width = 2550
  print 'New collage target image size is %d x %d' % (width, height)
  print 'Each image should be no greater than %d x %d' % (width / 2, height / 4)
  lastX = 0
  lastY = 0
  newImage = makeEmptyPicture(width, height, black)
  #show(newImage)
  #Get images and insert in new image
  for i in range(1, 9):
    filename = pickAFile()
    pic = makePicture(filename)
    #show(pic)
    print 'Importing image %d x %d' % (getWidth(pic), getHeight(pic))
    while (getWidth(pic) > width / 2.0 or getHeight(pic) > height / 4.0):
      print 'Image exceeded specifications, attempting to resize to correct size'
      if (getWidth(pic) > width / 2.0):
        print 'Width was outside boundaries'
        extraSize = getWidth(pic) - (width / 2.0)
        extraSize = extraSize / getWidth(pic)
      elif (getHeight(pic) > height / 4.0):
        print 'Height was outside boundaries'
        extraSize = getHeight(pic) - (height / 4.0)
        extraSize = extraSize / getHeight(pic)
      pic = shrink(pic, extraSize)
      print 'Image size reduced!'
      #repaint(pic)
    if i == 1:
      print 'Working on picture: %d' % (i,)
      pic = horizontalMirrorTopHalf(pic)
      newImage = pyCopy(pic, newImage, lastX, lastY)
      lastX = getWidth(pic) + lastX
      #repaint(newImage)
    elif i == 2:
      print 'Working on picture: %d' % (i,)
      pic = halfRed(pic)
      newImage = pyCopy(pic, newImage, lastX, lastY)
      #adjusting starting position for next row of pictures
      lastX = 0
      lastY = getHeight(pic)
      #repaint(newImage)
    elif i == 3:
      print 'Working on picture: %d' % (i,)
      pic = quadMirror(pic)
      newImage = pyCopy(pic, newImage, lastX, lastY)
      lastX = getWidth(pic) + lastX
      #repaint(newImage)
    elif i == 4:
      print 'Working on picture: %d' % (i,)
      pic = verticalMirrorLeftHalf(pic)
      newImage = pyCopy(pic, newImage, lastX, lastY)
      lastX = 0
      lastY = getHeight(pic) + lastY
      #repaint(newImage)
    elif i == 5:
      print 'Working on picture: %d' % (i,)
      pic = horizontalMirrorTopHalf(pic)
      newImage = pyCopy(pic, newImage, lastX, lastY)
      lastX = getWidth(pic) + lastX
      #repaint(newImage)
    elif i == 6:
      print 'Working on picture: %d' % (i,)
      pic = halfRed(pic)
      newImage = pyCopy(pic, newImage, lastX, lastY)
      lastX = 0
      lastY = getHeight(pic) + lastY      
      #repaint(newImage)
    elif i == 7:
      print 'Working on picture: %d' % (i,)
      pic = quadMirror(pic)
      newImage = pyCopy(pic, newImage, lastX, lastY)
      lastX = getWidth(pic) + lastX
      #repaint(newImage)
    elif i == 8:
      print 'Working on picture: %d' % (i,)
      pic = verticalMirrorLeftHalf(pic)
      newImage = pyCopy(pic, newImage, lastX, lastY)
      #lastX = getWidth(pic) + lastX
      #repaint(newImage)
  print 'Completed collage will now save..' 
  repaint(newImage)
  writePictureTo(newImage, "/Users/danielhowe/Desktop/collageOutput.jpg")
  print 'Done!'