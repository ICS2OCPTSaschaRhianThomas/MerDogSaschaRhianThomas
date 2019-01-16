-- main.lua
-- Title: SampleVideoGame
-- Name: Sascha Motz
-- Course: ICS2O/3C
-- This program This calls the splash screen of the app to load itself.
-- Date: November 12, 2018
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

--get time in seconds
local now = os.time()

--and milliseconds since app was opened
local millis = system.getTimer()

--concatenate to make a longer unique number
local newSeed = tostring(now)..tostring(millis)

--convert tonumber just to make sure randomseed accepts it
--this seems to round to an int which is fine as number should still be unique
newSeed = tonumber(newSeed)

--set randomseed
math.randomseed(tonumber(newSeed))

--code this to make sure it is random on the iPad
math.randomseed(os.time())

-- Go to the intro screen
composer.gotoScene( "Level3_Screen" )