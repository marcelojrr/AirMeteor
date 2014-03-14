display.setStatusBar(display.HiddenStatusBar)

local physics = require 'physics'
physics.start()

local screen_width = display.contentWidth
local screen_height = display.contentHeight
local center_x = display.contentCenterX
local center_y = display.contentCenterY

local background
local nave
local arrow_up
local arrow_down
local fire
local HP
local shoot
local numBullets = 300


local function init()
     background = display.newImage( 'imagens/background.jpg', true)
     background.x = display.contentWidth /2
     background.y = display.contentHeight /2
	 
	 HP = display.newImage('imagens/HP.png')
	 
     nave = display.newImage( 'imagens/nave.png')
     nave.xScale = 0.40
     nave.yScale = 0.40
     nave.y = display.contentWidth/3.2
     nave.x = display.contentWidth/11
	 nave.y_speed = 0

     arrow_up = display.newImage( 'imagens/arrow_up.png')
     arrow_up.y = display.contentWidth/ 22
     arrow_up.x = display.contentWidth/ 15
	 arrow_up.xScale = 0.2
	 arrow_up.yScale = 0.2
	
     arrow_down = display.newImage( 'imagens/arrow_down.png')
     arrow_down.y = display.contentWidth/ 2
     arrow_down.x = display.contentWidth/ 15
	 arrow_down.xScale = 0.2
	 arrow_down.yScale = 0.2
	 
	 fire_button = display.newImage('imagens/fire_button.png', 10, 10)
	 fire_button.x = display.contentWidth/1.07
	 fire_button.y = display.contentWidth/2
	 fire_button.xScale = 0.3
     fire_button.yScale = 0.3
	 
end

local function update()
	nave.y = nave.y + nave.y_speed	
end

local function touch_up( event )
	if event.phase == 'began' then
		nave.y_speed = -11
	elseif event.phase == 'ended' then
		nave.y_speed = 0
	end
end  

local function touch_down( event )
	if event.phase == 'began' then
		nave.y_speed = 11
	elseif event.phase == 'ended' then
		nave.y_speed = 0
	end
end

local function create_meteor()
	local meteor = display.newImage( 'imagens/meteor.png')
	meteor.y = math.random( 0, screen_height )
	meteor.x = 900	
	meteor.xScale = 0.1
	meteor.yScale = 0.1
	meteor.name = 'meteor'	
	transition.to ( meteor, { time = 5000, x = math.random( 0, screen_height ), x =-100} )
end
function shoot(event)
 
	if (numBullets ~= 0) then
		numBullets = numBullets - 1
		local bullet = display.newImage("imagens/shot.png")
		physics.addBody(bullet, "static", {density = 1, friction = 0, bounce = 0});
		bullet.x = nave.x
		bullet.y = nave.y
		bullet.xScale = 0.05
		bullet.yScale = 0.1
		bullet.myName = "bullet"
		transition.to ( bullet, { time = 1000, x = nave.y, x =1000} )
		end 
 
	end
	
local function add_listeners()
	arrow_up:addEventListener( 'touch', touch_up )
	arrow_down:addEventListener( 'touch', touch_down )
	Runtime:addEventListener( 'enterFrame', update )
	fire_button:addEventListener ( "tap", shoot )
end

local function init_physics()
	physics.addBody( nave, 'static' )
end

init()
init_physics()
add_listeners()

timer.performWithDelay( 2000, create_meteor, 0 )

