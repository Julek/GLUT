{-
   Hello.hs (adapted from hello.c which is (c) Silicon Graphics, Inc.)
   Copyright (c) Sven Panne 2003 <sven_panne@yahoo.com>
   This file is part of HOpenGL and distributed under a BSD-style license
   See the file libraries/GLUT/LICENSE

   This is a simple, introductory OpenGL program.
-}

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT as GLUT

display :: DisplayCallback
display = do
   -- clear all pixels
   clear [ ColorBuffer ]

   -- draw white polygon (rectangle) with corners at
   -- (0.25, 0.25, 0.0) and (0.75, 0.75, 0.0)
   color (Color3 1.0 1.0 (1.0 :: GLfloat))
   withBeginMode Polygon $ mapM_ vertex [
      Vertex3 0.25 0.25 0.0,
      Vertex3 0.75 0.25 0.0,
      Vertex3 0.75 0.75 0.0,
      Vertex3 0.25 0.75 (0.0 :: GLfloat)]

   -- don't wait!
   -- start processing buffered OpenGL routines
   flush

myInit :: IO () 
myInit = do
   -- select clearing color
   clearColor $= Color4 0.0 0.0 0.0 0.0

   -- initialize viewing values
   matrixMode $= Projection
   loadIdentity
   ortho 0.0 1.0 0.0 1.0 (-1.0) 1.0

{-
   Declare initial window size, position, and display mode
   (single buffer and RGBA).  Open window with "hello"
   in its title bar.  Call initialization routines.
   Register callback function to display graphics.
   Enter main loop and process events.
-}
main :: IO ()
main = do
   getArgsAndInitialize
   setInitialDisplayMode [ Single, GLUT.RGB ]
   setInitialWindowSize (WindowSize 250 250)
   setInitialWindowPosition (WindowPosition 100 100)
   createWindow "hello"
   myInit
   setDisplayCallback display
   mainLoop