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

-- Go to the intro screen
composer.gotoScene( "splash_screen" )


