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

logo.alpha = 0
timer.performWithDelay( 10, animateLogo, 300) -- calling the function animateLogo to do something.









