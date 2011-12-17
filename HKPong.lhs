Hong Kong Pong
--------------

Hong Kong Pong is a zany pong version written in Haskell, using SDL. 

> import Graphics.UI.SDL as SDL
> import Graphics.UI.SDL.Framerate as FPS
> import qualified Physics.Hipmunk as H
> import HKGraphics

Some initialisation routines:

> initSDL :: IO Surface
> initSDL = do 
>   SDL.init [InitEverything]
>   surf <- makeFullScreen 
>   -- surf <- makeSizedScreen swidth sheight
>   drawWallpaper surf bg_path
>   return surf
>   where 
>      -- swidth  = 640
>      -- sheight = 480
>      bg_path = "data/bg/sunrise0.jpg"
>
> initPhysics :: IO H.Space
> initPhysics = do 
>   H.initChipmunk
>   H.newSpace 
>
> initFPS :: IO FPSManager
> initFPS = do 
>   fps <- FPS.new
>   FPS.set fps rate
>   FPS.init fps
>   return fps
>   where rate = 60

The main event loop:

> runGame :: SDL.Surface -> H.Space -> FPSManager -> IO ()
> runGame screen space fps = do
>   e <- pollEvent
>   case e of 
>     Quit -> return ()
>     KeyDown (Keysym SDLK_q _ _) -> return ()
>     KeyDown k -> do
>       keyPressHandler k
>       runGame screen space fps
>     otherwise -> do
>       FPS.delay fps
>       SDL.flip screen
>       runGame screen space fps

The keypress handler, of course,

> keyPressHandler :: Keysym -> IO ()
> keyPressHandler (Keysym key modKeys unicode) = return ()

> main :: IO ()
> main = do
>   print "Initialising..."
>   screen <- initSDL
>   space  <- initPhysics
>   fps <- initFPS
>   SDL.flip screen
>
>   -- TODO: Load config
>
>   print "Go!"
>   runGame screen space fps
>   

