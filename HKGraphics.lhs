Graphics
--------
A bunch of wrappers to draw things

> module HKGraphics where
> import Prelude
> import Graphics.UI.SDL as SDL
> import Graphics.UI.SDL.Image 
> import Graphics.UI.SDL.Rotozoomer 

First, initialising things like displays, etc.

> makeFullScreen :: IO Surface
> makeFullScreen = do
>   setVideoMode 0 0 32 [DoubleBuf, HWSurface, Fullscreen]
>   getVideoSurface
>
> makeSizedScreen :: Int -> Int -> IO Surface
> makeSizedScreen swidth sheight = do
>   setVideoMode swidth sheight 32 [DoubleBuf, HWSurface]
>   getVideoSurface
> 
> -- Resize surface to given dimensions
> resizeSurface :: Int -> Int -> Surface -> IO Surface
> resizeSurface newW newH surf = do
>   let oldW = SDL.surfaceGetWidth surf
>   let oldH = SDL.surfaceGetHeight surf
>   zoom surf ( (fromIntegral newW) / (fromIntegral oldW) )
>         ( (fromIntegral newH) / (fromIntegral oldH) ) True

Now drawing primitives

> -- Draw a wallpaper on surface. Resize image to surface size
> drawWallpaper :: Surface -> FilePath -> IO ()
> drawWallpaper surface path = do
>   bg <- load path >>= (resizeSurface width height) 
>   blitSurface bg Nothing surface Nothing 
>   return ()
>   where       
>     width = SDL.surfaceGetWidth surface
>     height = SDL.surfaceGetHeight surface



