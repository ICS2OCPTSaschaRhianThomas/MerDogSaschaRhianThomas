-----------------------------------------------------------------------------------------
-- you_win.lua
-- SceneTemplate.lua
-- Scene Template (Composer API)
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Calling Composer Library
local composer = require( "composer" )

local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "you_win"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- SOUNDS
---------------------------------------------------------------------------------------
-- win sound 
local winSound = audio.loadSound("Sounds/you_win.mp3" ) 
-- Setting a variable to an mp3 file
local winSoundChannel

-----------------------------------------------------------------------------------------
-- FORWARD REFERENCES
-----------------------------------------------------------------------------------------

-- local variables for the scene
local bkg
local level = 1
----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "flip", time = 1000})
end 

-- Creating Transition to Level1 Screen
local function Level2ScreenTransition( )
    level = 2 
    composer.gotoScene( "level2_screen", {effect = "flip", time = 1000})
end

-- Creating Transition to Level1 Screen
local function Level3ScreenTransition( )
    level = 3
    composer.gotoScene( "level3_screen", {effect = "flip", time = 1000})
end

local function NextLevel( )
    if ( level == 1 ) then
        level = 2
        composer.gotoScene( "level2_screen", {effect = "flip", time = 1000})

    elseif ( level == 2 ) then
        level = 3
        composer.gotoScene( "level3_screen", {effect = "flip", time = 1000})

    elseif ( level == 3 ) then
        composer.gotoScene( "complete_game", {effect = "flip", time = 1000})
    end
end

local function RetryLevel( )
    if ( level == 1 ) then

        composer.gotoScene( "level1_screen", {effect = "flip", time = 1000})

    elseif ( level == 2 ) then

        composer.gotoScene( "level2_screen", {effect = "flip", time = 1000})

    elseif ( level == 3 ) then

        composer.gotoScene( "level3_screen", {effect = "flip", time = 1000})
    end
end

--------------------------------------------------------------------------------------
-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Display background
    bkg = display.newImage("Images/YouWin.png")
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight
   
    -- Associating display objects with this scene 
    sceneGroup:insert( bkg )
    sceneGroup:insert( retryButton )
    sceneGroup:insert( nextLevelButton )
end    

   -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating retry Button
    retryButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*2/10,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/RetryLevelUnpressed.png",
            overFile = "Images/RetryLevelPressed.png",

            width = 200,
            height = 150,

            -- When the button is released, call the Level1 screen transition function
            onRelease = RetryLevel
        } )
--------------------------------------------------------------------------------------------------
 -- Creating next level Button
    nextLevelButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*8/10,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/NextLevelUnpressed.png",
            overFile = "Images/NextLevelPressed.png",

            width = 200,
            height = 150,

            -- When the button is released, call the Level1 screen transition function
            onRelease = NextLevel
        } )
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        --win sound
        winSoundChannel = audio.play(winSound)
    end

end

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
        audio.stop()

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


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