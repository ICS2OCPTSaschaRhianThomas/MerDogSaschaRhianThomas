-- splash_screen.lua
-- Created by: Sascha Motz
-- Date: November 12, 2018
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-- Create Scene Object
local scene = composer.newScene( sceneName )

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)


--------------------------------------------
--SOUNDS
--------------------------------------------
-- play sound effect
-- Logo sound
local logoSound = audio.loadSound("Sounds/logoSound2.mp3" ) 
-- Setting a variable to an mp3 file
local logoSoundChannel = audio.play(logoSound)

--------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
--------------------------------------------------------------------------------------------
--add the logo image
local logo
-- controls if logo is more or less transparent
local fadeLogo = 1
-- controls the x direction of the logo
local directionLogo = 1


-- variable for speed of the logo
local scrollSpeedLogo = 9


-----------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

--Function: MoveLogo
-- Input: this function accepts and event listener
--Description: This function adds the scroll speed to the x-value of the logo
local function MoveLogo (event)
    -- make the logo more transparent if it is fully visible
    if  logo.alpha == 1 then
        fadeLogo = 0
    end
    -- make the logo less transparent if it is fully transparent
    if logo.alpha == 0 then
        fadeLogo = 1
    end

    -- change the transparency of the logo based on fadeLogo
    if fadeLogo == 1 then
        logo.alpha = logo.alpha + 0.02
    else
       logo.alpha = logo.alpha - 0.02
    end

    -- change x position of logo based on directionLogo
    if directionLogo == 1 then
        logo.x = logo.x + scrollSpeedLogo
    else
        logo.x = logo.x - scrollSpeedLogo
    end
end



-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- sets the background colour
    display.setDefault("background", 192/255, 192/255, 192/255 )

    -- Insert the logo image    
    logo = display.newImageRect("Images/CompanyLogoSaschaM.png", 600, 600)

    --set initial x and y position of the logo
    logo.x = -500
    logo.y = display.contentHeight/2

    -- set the transparency of the Logo
    logo.alpha = 0

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

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

    elseif ( phase == "did" ) then
        -- start the splash screen music
        logoSoundChannel = audio.play(logoSound)

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveLogo)



        --make logo spin
        transition.to( logo, { rotation = logo.rotation-1440, time=17000, onComplete=spinImage } )


        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        Runtime:removeEventListener("enterFrame", MoveLogo)
        
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
