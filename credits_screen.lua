-----------------------------------------------------------------------------------------
--
-- credits_screen.lua
-- Created by: Your Name
-- Special thanks to Wal Wal for helping in the design of this framework.
-- Date: Month Day, Year
-- Description: This is the credits page, displaying a back button to the main menu.
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- SOUND
-----------------------------------------------------------------------------------------
-- bkg game music
local creditsSound = audio.loadSound("Sounds/Credits.mp3" ) 
-- Setting a variable to an mp3 file
local creditsChannel
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "credits_screen"

-- Creating Scene Object
scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image
local backButton
local sascha 
local kaitlyn
local thomas
local rhian
local phoebe

-----------------------------------------------------------------------------------------
--PHOTOSHOPED CHARACTERS
-----------------------------------------------------------------------------------------

 local sascha = display.newImageRect("Images/Sascha.png", 200, 500)
sascha.x = display.contentWidth * 2.2/ 8
sascha.y = display.contentHeight  * 4/ 8
sascha.width = 200
sascha.height = 200

 local thomas = display.newImageRect("Images/Thomas.png", 400, 500)
thomas.x = display.contentWidth * 4/ 8
thomas.y = display.contentHeight  * 4/ 8
thomas.width = 200
thomas.height = 200

 local rhian = display.newImageRect("Images/Rhian.png", 300, 200)
rhian.x = display.contentWidth * 6/ 8
rhian.y = display.contentHeight  * 4/ 8
rhian.width = 200
rhian.height = 200

 local kaitlyn = display.newImageRect("Images/Kaitlyn.png", 300, 100)
kaitlyn.x = display.contentWidth * 4.5/ 8
kaitlyn.y = display.contentHeight  *1.8/ 8
kaitlyn.width = 200
kaitlyn.height = 200
 
 local phoebe = display.newImageRect("Images/Phoebe.png", 200, 500)
phoebe.x = display.contentWidth * 4.5/ 8
phoebe.y = display.contentHeight  * 6.4/ 8
phoebe.width = 200
phoebe.height = 200

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND AND DISPLAY OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImageRect("Images/CreditsBackground.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( sascha )
    sceneGroup:insert( thomas )
    sceneGroup:insert( rhian )
    sceneGroup:insert( kaitlyn )
    sceneGroup:insert( phoebe )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*2/8,
        y = display.contentHeight*14/16,

        -- Setting Dimensions
         width = 250,
         height = 100,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedSaschaM.png",
        overFile = "Images/BackButtonPressedSaschaM.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )
    
end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

            creditsSoundChannel = audio.play(creditsSound)


    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    audio.stop()

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end --function scene:destroy( event )

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


