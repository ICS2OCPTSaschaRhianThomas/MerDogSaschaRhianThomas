
-----------------------------------------------------------------------------------------
-- level2_screen.lua
-- level2_screen.lua
-- Created by: Gil Robern
-- Modified by: Your Name
-- Date: Month Day, Year
-- Description: This is the level 2 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
    -- SOUNDS
    ----------------------------------------------------------------------------------------
local level2Sound = audio.loadSound( "Sounds/Level2.mp3" )
local level2SoundChannel
    ----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg


-- determine the range for the numbers to add
local MIN_NUM = 1
local MAX_NUM = 13

-- the variables containing the first and second numbers to add for the equation
local firstNumber
local secondNumber

-- the variables that will hold the correct answer and the wrong answers
local userAnswer
local answer 
local wrongAnswer1
local wrongAnswer2
local temp

-- the text object that will hold the addition equation
local addEquationTextObject 

-- the text objects that will hold the correct answer and the wrong answers
local answerTextObject 
local wrongAnswer1TextObject
local wrongAnswer2TextObject
local wrongAnswer3TextObject

-- displays the number correct that the user has
--local numberCorrectText 

-- displays the number incorrect that the user has
--local numberIncorrectText 

-- displays the lives
local livesText 
local lives = 4
local numberCorrect = 0


local heart1
local heart2
local heart3
local heart4


-- character
local character
local character2

-- the text displaying congratulations
local congratulationText 

-- Displays text that says correct.
local correct 

-- Displays the level text of time text
local level2Text 

-- Boolean variable that states if user clicked the answer or not
local alreadyClickedAnswer = false
soundOn = true 
local muteButton
-----------------------------------------------------------------------------------------
-- SOUND
-----------------------------------------------------------------------------------------

-- corect sound
local correctSound = audio.loadSound("Sounds/Correct.mp3" ) 
-- Setting a variable to an mp3 file
local correctSoundChannel

-- incorect sound
local incorrectSound = audio.loadSound("Sounds/Incorrect.mp3" ) 
-- Setting a variable to an mp3 file
local incorrectSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function DetermineAnswers()

    -- calculate the correct answer as well as the wrong answers

    answer = firstNumber - secondNumber

    wrongAnswer1 = answer + math.random(1,3)
    
    wrongAnswer2 = answer - math.random(1,3)
    wrongAnswer3 = answer + math.random(4,8)
end

-- Function that changes the answers for a new question and places them randomly in one of the positions
local function DisplayAnswers( )

    local answerPosition = math.random(1,4)

    answerTextObject.text = tostring( answer )
    wrongAnswer1TextObject.text = tostring( wrongAnswer1 )
    wrongAnswer2TextObject.text = tostring( wrongAnswer2 )
    wrongAnswer3TextObject.text = tostring( wrongAnswer3 )

    if (answerPosition == 1) then                
        
        answerTextObject.x = display.contentWidth*.8        
        wrongAnswer1TextObject.x = display.contentWidth*.6
        wrongAnswer2TextObject.x = display.contentWidth*.5
        wrongAnswer3TextObject.x = display.contentWidth*.7


    elseif (answerPosition == 2) then
       
        answerTextObject.x = display.contentWidth*.6        
        wrongAnswer1TextObject.x = display.contentWidth*.5
        wrongAnswer2TextObject.x = display.contentWidth*.8
        wrongAnswer3TextObject.x = display.contentWidth*.7 

    elseif (answerPosition == 3) then
       
        answerTextObject.x = display.contentWidth*.7       
        wrongAnswer1TextObject.x = display.contentWidth*.5
        wrongAnswer2TextObject.x = display.contentWidth*.8
        wrongAnswer3TextObject.x = display.contentWidth*.6 


    else
       
        answerTextObject.x = display.contentWidth*.5        
        wrongAnswer1TextObject.x = display.contentWidth*.6
        wrongAnswer2TextObject.x = display.contentWidth*.8
        wrongAnswer3TextObject.x = display.contentWidth*.7 
    end

end

-- make the correct object visible
local function HideCorrect()
    correctObject.isVisible = false
    AskQuestion()
end

-- make the incorrect object visible
local function HideIncorrect()
    incorrectObject.isVisible = false
    AskQuestion()
end

-- Function that transitions to Lose Screen
local function LoseScreenTransition( )        
    composer.gotoScene( "you_lose", {effect = "zoomInOutFade", time = 1000})
end 

-- Function that transitions to Lose Screen
local function WinScreenTransition( )        
    composer.gotoScene( "you_win", {effect = "zoomInOutFade", time = 1000})
end 


local function DisplayAddEquation()

    -- choose the numbers to add randomly
    firstNumber = math.random(MIN_NUM, MAX_NUM)
    secondNumber = math.random(MIN_NUM, MAX_NUM)

        -- if the first number is smaller then second number 
        if (firstNumber < secondNumber) then 
            -- switch them 
            temp = secondNumber
            secondNumber = firstNumber
            firstNumber = temp
        end 
        -- create the subtraction equation to display
        addEquationTextObject.text = firstNumber .. " - " .. secondNumber .. " = "
    end 
-- function that operates update hearts
local function UpdateHearts()

    -- Cancel the timer remove the third heart by making it invisible
    if (lives == 4) then
        heart1.isVisible = true
        heart2.isVisible = true 
        heart3.isVisible = true
        heart4.isVisible = true
    elseif (lives == 3) then
        heart1.isVisible = false
        heart2.isVisible = true
        heart3.isVisible = true
        heart4.isVisible = true
    elseif (lives == 2) then
        heart1.isVisible = false
        heart2.isVisible = false
        heart3.isVisible = true
        heart4.isVisible = true
    elseif (lives == 1) then
        heart1.isVisible = false
        heart2.isVisible = false
        heart3.isVisible = false
        heart4.isVisible = true

    end
end

local function RestartScene()

    alreadyClickedAnswer = false
    
    correct.isVisible = false
    incorrect.isVisible = false

    -- if they have 0 lives, go to the You Lose screen
    if (lives == 0) then
        composer.gotoScene("you_lose")

    elseif (numberCorrect == 5) then
        composer.gotoScene("you_win")
    else
        DisplayAddEquation()
        DetermineAnswers()
        DisplayAnswers()
        UpdateHearts()
    end
end



-- Functions that checks if the buttons have been clicked.
local function TouchListenerAnswer(touch)

    

    if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

        -- get the user answer from the text object that was clicked on
        userAnswer = answerTextObject.text

         -- set that they clicked an answer
        alreadyClickedAnswer = true
        
        -- if the user gets the answer right, display Correct and call RestartSceneRight
        if (answer == tonumber(userAnswer)) then     
            correct.isVisible = true
            -- play correct sound
            correctSoundChannel = audio.play(correctSound)
            -- increase the number correct by 1
            numberCorrect = numberCorrect + 1
            -- call RestartScene after 1 second
            timer.performWithDelay( 1000, RestartScene )
        end        

    end
end

local function TouchListenerWrongAnswer1(touch)
    -- get the user answer from the text object that was clicked on
    userAnswer = wrongAnswer1TextObject.text

    if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

         -- set that they clicked an answer
        alreadyClickedAnswer = true     

        if (answer ~= tonumber(userAnswer)) then
            -- decrease a life
            lives = lives - 1
            -- call update hearts
            UpdateHearts()
            -- display wrong text
            incorrect.isVisible = true

            --play wrong sound
            incorrectSoundChannel = audio.play(incorrectSound)
            -- call RestartScene after 1 second
            timer.performWithDelay( 1000, RestartScene )            
        end        

    end
end

local function TouchListenerWrongAnswer2(touch)
    -- get the user answer from the text object that was clicked on
    userAnswer = wrongAnswer2TextObject.text

      
        if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

            -- set that they clicked an answer
            alreadyClickedAnswer = true

            if (answer ~= tonumber(userAnswer)) then
                -- decrease a life
                lives = lives - 1
                -- call update hearts
                UpdateHearts()

                -- displays wrong text
                incorrect.isVisible = true
                --play wrong sound
                incorrectSoundChannel = audio.play(incorrectSound)
                -- call RestartScene after 1 second
                timer.performWithDelay( 1000, RestartScene )            
            end        
    
        end
end

local function TouchListenerWrongAnswer3(touch)
    -- get the user answer from the text object that was clicked on
    userAnswer = wrongAnswer3TextObject.text

      
        if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

        -- set that they clicked an answer
        alreadyClickedAnswer = true

            if (answer ~= tonumber(userAnswer)) then
                -- decrease a life
                lives = lives - 1
                -- call update hearts
                UpdateHearts()

                -- displays wrong text
                incorrect.isVisible = true
                --play wrong sound
                incorrectSoundChannel = audio.play(incorrectSound)
                -- call RestartScene after 1 second
                timer.performWithDelay( 1000, RestartScene )            
            end        
    
        end
end

local function MuteButton()
    if (soundOn == true) then
        audio.setVolume(0)
        soundOn = false
        muteButton.defaultFile = "Images/MutePressed.png"
        muteButton.overFile = "Images/MutePressed.png"
    else
        audio.setVolume(1)
        soundOn = true
    end
end
    --------------------------------
    -- Creating mute Button
    muteButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*5/10,
            y = display.contentHeight*9.3/10,

            -- Insert the images here
            defaultFile = "Images/MuteUnpressed.png",
            overFile = "Images/MutePressed.png",

            width = 150,
            height = 100,

            --When the button is released, call the Credits transition function
            onRelease = MuteButton
        } )
-- Function that adds the touch listeners to each of the answer objects
local function AddTextObjectListeners()

    answerTextObject:addEventListener("touch", TouchListenerAnswer)
    wrongAnswer1TextObject:addEventListener("touch", TouchListenerWrongAnswer1)
    wrongAnswer2TextObject:addEventListener("touch", TouchListenerWrongAnswer2)
    wrongAnswer3TextObject:addEventListener("touch", TouchListenerWrongAnswer3)

end

-- Function that removes the touch listeners from each of the answer objects
local function RemoveTextObjectListeners()

    answerTextObject:removeEventListener("touch", TouchListenerAnswer)
    wrongAnswer1TextObject:removeEventListener("touch", TouchListenerWrongAnswer1)
    wrongAnswer2TextObject:removeEventListener("touch", TouchListenerWrongAnswer2)
    wrongAnswer3TextObject:removeEventListener("touch", TouchListenerWrongAnswer3)

end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg = display.newImageRect("Images/Level 2 Screen.png", display.contentWidth, display.contentHeight)
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight

    -------------------------------------------------
    -- Creat lives and characters
    ------------------------------------------------
    --create the lives to display on the screen
    heart1 = display.newImageRect("Images/heart.png", 100, 100)
    heart1.x = display.contentWidth * 7.4 / 8
    heart1.y = display.contentHeight * 1 / 13

    --create the lives to display on the screen
    heart2 = display.newImageRect("Images/heart.png", 100, 100)
    heart2.x = display.contentWidth * 6.6 / 8
    heart2.y = display.contentHeight * 1 / 13

    --create the lives to display on the screen
    heart3 = display.newImageRect("Images/heart.png", 100, 100)
    heart3.x = display.contentWidth * 5.8 / 8
    heart3.y = display.contentHeight * 1 / 13

    --create the lives to display on the screenF
    heart4 = display.newImageRect("Images/heart.png", 100, 100)
    heart4.x = display.contentWidth * 5 / 8
    heart4.y = display.contentHeight * 1 / 13

    character = display.newImageRect("Images/Mermaid.png", 100, 150)
    character.x = display.contentWidth * 1.2/ 8
    character.y = display.contentHeight  * 4.7/ 8
    character.width = 400
    character.height = 400
    --timer.performWithDelay( 2000, character ) 

    character2 = display.newImageRect("Images/Dog.png", 100, 150)
    character2.x = display.contentWidth * 6.7/ 8
    character2.y = display.contentHeight  * 6/ 8
    character2.width = 300
    character2.height = 300

    -- create the text object that will hold the add equation. Make it empty for now.
    addEquationTextObject = display.newText( "", display.contentWidth*5.5/10, display.contentHeight*2/10, nil, 90 )

    -- sets the color of the add equation text object
    addEquationTextObject:setTextColor(255/255, 255/255, 100/255)

    -- create the text objects that will hold the correct answer and the wrong answers
    answerTextObject = display.newText("", display.contentWidth*.8, display.contentHeight*3.5/10, nil, 65 )
    wrongAnswer1TextObject = display.newText("", display.contentWidth*.7, display.contentHeight*3.5/10, nil, 65 )
    wrongAnswer2TextObject = display.newText("", display.contentWidth*.6, display.contentHeight*3.5/10, nil, 65 )
    wrongAnswer3TextObject = display.newText("", display.contentWidth*.5, display.contentHeight*3.5/10, nil, 65 )

    -- create the text object that will hold the number of lives
    livesText = display.newText("", display.contentWidth*4/5, display.contentHeight*8/9, nil, 30) 

    -- create the text object that will say Correct, set the colour and then hide it
    correct = display.newText("Correct!", display.contentWidth*3/10, display.contentHeight*4/10, nil, 70 )
    correct:setTextColor(0/255, 255/255, 0/255)
    correct.isVisible = false

        -- create the text object that will say Incorrect, set the colour and then hide it
    incorrect = display.newText("Incorrect!", display.contentWidth*3/10, display.contentHeight*4/10, nil, 70 )
    incorrect:setTextColor(255/255, 0/255, 0/255)
    incorrect.isVisible = false

    -- display the level text of time text and set the colour
    level2Text = display.newText("LEVEL 2", display.contentWidth*2/12, display.contentHeight*11/12, nil, 50)
    level2Text:setTextColor(0, 0, 0)
    
    -- Insert objects into scene group
    sceneGroup:insert( bkg ) 
    -- add hearts and characters 
    sceneGroup:insert( heart1 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( heart4 )
    sceneGroup:insert( character )
    sceneGroup:insert( character2 )
    sceneGroup:insert( livesText )
    sceneGroup:insert( addEquationTextObject )
    sceneGroup:insert( answerTextObject )
    sceneGroup:insert( wrongAnswer1TextObject )
    sceneGroup:insert( wrongAnswer2TextObject )
    sceneGroup:insert( wrongAnswer3TextObject )
    sceneGroup:insert( correct )
    sceneGroup:insert( incorrect )
    sceneGroup:insert( level2Text )
end
-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    --local sceneGroup = self.view
    local phase = event.phase

    

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- initialize the number of lives and number correct 
        lives = 4
        numberCorrect = 0
        level = 2
        -- play bkg music
        level2SoundChannel = audio.play(level2Sound)

        -- listeners to each of the answer text objects
        AddTextObjectListeners()        

        -- call the function to restart the scene
        RestartScene()
    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        audio.stop(level2SoundChannel)


        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        
        -- remove the listeners when leaving the scene
        RemoveTextObjectListeners()

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
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

-- Adding Event Listeners for Scene
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene