-----------------------------------------------------------------------------------------
-- CompanyLogoAnimation
-- Course: ICS2O
-- Name: Thomas Wehbi
-- Description: This program will display my clients on the screen that will move around etc.


display.setStatusBar(display.HiddenStatusBar)				 -- Hide status bar

counter = 0

-- sets the background color 
display.setDefault("background", 242/255, 5/255, 181/255) -- setting the color of the background.

-- Adding the Logo Image
local logo = display.newImageRect("Images/pumpkinSpiceLogo.png", 500, 500) -- displaying the image on screen.

-- add border to logo
logo:setStrokeColor(0, 0, 0) -- setting the border of the Image 
logo.strokeWidth = 5 			-- width of bordre

-- Logo X and Y
logo.x = 600					-- setting the coordinates of the Image
logo.y = display.contentHeight/2


local function moveLogo()
	logo.x = logo.x + math.random(-10,10)  -- making the image move the X and Y on the screen to another very quickly from numbers between -10 and 10.
	logo.y = logo.y + math.random(-10,10)
end

local function shrinkLogo()  				-- Used from internet
	logo.width = logo.width * 0.99
	logo.height = logo.height * 0.99
end

local function increaseAlpha()
	logo.alpha = logo.alpha + 0.01 -- transparency of Image 
end

local function animateLogo() -- used some from internet
	counter = counter +1

	if (counter < 100) then
		increaseAlpha()
	elseif (counter < 200) then
		shrinkLogo()
	else
		moveLogo()
	end
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" , {effect = "flip", time = 1000})
end

logo.alpha = 0
timer.performWithDelay( 10, animateLogo, 300) -- calling the function animateLogo to do something.

-- Go to the main menu screen after the given time.
timer.performWithDelay ( 3000, gotoMainMenu)


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
        transition.to( logo, { rotation = logo.rotation-1940, time=13000, onComplete=spinImage } )
        transition.to( logo, {x= 9000, time= 13000 })


        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 1500, gotoMainMenu)          
        
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
        gotoMainMenu()

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

-------------------------------------------------------------------
return scene