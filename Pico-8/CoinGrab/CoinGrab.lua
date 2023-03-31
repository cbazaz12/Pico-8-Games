--Code for CoinGrab game on my Lexaloffle page
-- Created by Christian Bazaz and Taegon Park
--https://www.lexaloffle.com/bbs/?uid=73304

started=false
function _init()
	if(started==true) then
	music(0)
	player={
	sprite=1,
	x=59,
	y=10,
	sprh=8,
	sprw=8,
	dx=0,
	dy=0,
	acc=0.5,
	jump=8,
	flp=false,
	running=false,
	jumping=false,
	falling=false,
	landed=false,
	}
	coin={
	sprite=5,
	x=20,
	y=20,
	touch=false,
	}
	coinloc(coin)
	gravity=0.7
	friction=0.85
	end
end

function _update()
	if(started==false) then
		if(btn(4))then
			started=true
			_init()
		end
	elseif(started==true) then
	if(coin.touch==false) then
	player.y+=gravity
	player_update()
	end
	cointouch(player,coin)
	if(coin.touch==true)then
		if(btn(4))then
			_init()
		end
		if(btn(5)) then
			started=false
			music(2)
			_init()
		end
	end
	end
end

function _draw()
	if(started==false) then
		menu()
	end
	if(started==true) then
	cls()
	rectfill(0,0,127,127,15)
	map(0,0)
	spr(player.sprite,player.x,player.y,1,1,player.flp)
	spr(coin.sprite,coin.x,coin.y)
	if(coin.touch==true) then
		gameend()
	end
	end
end

function gameend()
	spr(16,48,30)
	spr(17,56,30)
	spr(18,64,30)
	spr(19,72,30)
	
	spr(20,16,90)
	spr(21,32,90)
	spr(22,40,90)
	spr(23,56,90)
	spr(19,64,90)
	spr(24,72,90)
	spr(25,80,90)
	spr(17,88,90)
	spr(26,96,90)
	
	spr(48,24,102)
	spr(49,40,102)
	spr(22,48,102)
	spr(23,56,102)
	spr(18,72,102)
	spr(19,80,102)
	spr(50,88,102)
	spr(51,96,102)
end

function map_col(player,dir,flag)
	local x1=0 local y1=0
	local x2=0 local y2=0
	local x=player.x
	local y=player.y
	local h=player.sprh
	local w=player.sprw
	
	if(dir=="left") then
		x1=x-1 y1=y
		x2=x   y2=y+h-1
	elseif(dir=="right") then
		x1=x+w-1 y1=y
		x2=x+w   y2=y+h-1
	elseif(dir=="up") then
		x1=x+1   y1=y-1
		x2=x+w-1 y2=y
	elseif(dir=="down") then
		x1=x   y1=y+h
		x2=x+w y2=y+h
	end
	
	x1/=8 y1/=8 x2/=8 y2/=8
	
	if(fget(mget(x1,y1), flag))
	or(fget(mget(x1,y2), flag))
	or(fget(mget(x2,y1), flag))
	or(fget(mget(x2,y2), flag))
		then return true
	else return false
	end
end

function player_update()
	player.dy+=gravity
	player.dx*=friction
	
	if(btn(0)) then
		player.dx-=player.acc
		player.running=true
		player.flip=true
	end
	if(btn(1)) then
		player.dx+=player.acc
		player.running=true
		player.flip=false
	end
	if(btn(2) and player.landed) then
		sfx(0)
		player.dy-=player.jump
		player.landed=false
	end
	
	if(player.dy>0) then
		player.falling=true
		player.landed=false
		player.jumping=false
		if(map_col(player, "down",0)) then
			player.landed=true
			player.falling=false
			player.dy=0
			player.y-=(player.y+player.sprh+1)%8-1
		end
	elseif(player.dy<0) then
		player.jumping=true
		if(map_col(player,"up",1)) then
			player.dy=0
		end
	end
	
	if(player.dx<0) then
		if(map_col(player,"left",1)) then
			player.dx=0
		end
	elseif(player.dx>0) then
		if(map_col(player,"right",1)) then
			player.dx=0
		end
	end
	
	player.x+=player.dx
	player.y+=player.dy
end

function coinloc(coin)
	r=flr(rnd(5))
	if(r==0) then
		coin.x=20
		coin.y=25
	elseif(r==1) then
		coin.x=30
		coin.y=110
	elseif(r==2) then
		coin.x=64
		coin.y=72
	elseif(r==3) then
		coin.x=110
		coin.y=20
	elseif(r==4) then
		coin.x=95
		coin.y=5
	end
end

function cointouch(player,coin)
	local x=player.x
	local y=player.y
	local cx=coin.x
	local cy=coin.y
	if((x>cx-8 and x<cx+8) and
			(y>cy-8 and y<cy+8)) then
			music(2)
			coin.touch=true
			player.landed=true
			player.falling=true
			player.jumping=false
			player.running=false
	end
end

function menu()
	rectfill(0,0,127,127,8)
	spr(32,40,20)
	spr(22,48,20)
	spr(25,56,20)
	spr(25,64,20)
	spr(19,72,20)
	spr(32,80,20)
	spr(21,88,20)
	
	spr(21,48,28)
	spr(33,56,28)
	spr(19,64,28)
	
	spr(35,80,28)
	
	spr(20,24,90)
	
	spr(21,40,90)
	spr(22,48,90)
	
	spr(34,64,90)
	spr(21,72,90)
	spr(17,80,90)
	spr(23,88,90)
	spr(21,96,90)
end
