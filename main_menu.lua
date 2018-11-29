-- main_menu.lua
-- Created by: Sascha Motz
-- Date: November 12, 2018
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local bkg
local playButton
local creditsButton
local instructionsButton
local muteButton
local muteTransition
local soundOn = 1

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "fade", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "flip", time = 1000})
end    
----------------------------------------------------------------------------------------

-- Creating Transition Function to Instructions Page
local function InstructionsScreenTransition( )       
    composer.gotoScene( "instructions_screen", {effect = "fromLeft", time = 500})
end 

local function MuteButton()
    if (soundOn) then
        audio.setVolume(0)
        soundOn = 0
    else
        audio.setVolume(1)
        soundOn = 1
    end
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------
    -- added bkg colour
    bkg = display.setDefault("background", 204/255, 204/255, 255/255)

    -- Insert the background image and set it to the center of the screen (dont have the image)
    --bkg_image = display.newImage("Images/main_menu.png")
    --bkg_image.x = display.contentCenterX
    --bkg_image.y = display.contentCenterY
    --bkg_image.width = display.contentWidth
    --bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    --sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    --bkg_image:toBack()

    ----------------------------------------------------------------------------------------
    -- SOUNDS
    ----------------------------------------------------------------------------------------
    -- play sound effect
    -- Logo sound
    local bkgMusic = audio.loadSound("Sounds/bkgMusic.mp3" ) 
    -- Setting a variable to an mp3 file
    local bkgMusicChannel = audio.play(bkgMusic, {loops= 10})
    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/StartUnpressed.png",
            overFile = "Images/StartPressed.png",

            width = 200,
            height = 150,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*7/8,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/CreditsUnpressedSaschaM.png",
            overFile = "Images/CreditsPressedSaschaM.png",

            width = 200,
            height = 150,

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    -----------------------------------------------------------------------------------------
        -- Creating instructions Button
    instructionsButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/6,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/InstrucUnpressedSM.png",
            overFile = "Images/InstrucPressedSM.png",

            width = 200,
            height = 150,

            -- When the button is released, call the Level1 screen transition function
            onRelease = InstructionsScreenTransition          
        } )
    -----------------------------------------------------------------------------------------
    -- Creating mute Button
    muteButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.5/10,
            y = display.contentHeight*1.3/10,

            -- Insert the images here
            defaultFile = "Images/MuteUnpressed.png",
            overFile = "Images/MutePressed.png",

            width = 200,
            height = 110,

            --When the button is released, call the Credits transition function
            onRelease = MuteButton
        } )
      ------------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( muteButton )

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).   
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    -- start the bkg music
    bkgMusicChannel = audio.play(bkgMusic)

    elseif ( phase == "did" ) then       
        

    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
