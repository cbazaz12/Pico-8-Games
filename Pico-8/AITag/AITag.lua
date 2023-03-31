--code for AITag game on my Lexaloffle page
-- Created by Christian Bazaz and Taegon Park
--https://www.lexaloffle.com/bbs/?uid=73304
x=32 y=64
zx=96 zy=64
gamerunning=1
function _update()
	touch() 
	if(gamerunning==1) then
	if(btn(0)) and x>0 then x=x-2 end
	if(btn(1)) and x<120 then x=x+2 end
	if(btn(2)) and y>0 then y=y-2 end
	if(btn(3)) and y<120 then y=y+2 end
	aimove()
	end
	if(gamerunning==0) then
		if(btn(4)) then
			x=32 y=64
			zx=96 zy=64
			gamerunning=1
		end
	end
end
	
function aimove()
	z=flr(rnd(4))
	if(z==0 and zx>0) then zx=zx-6 end
	if(z==1 and zx<120) then zx=zx+6 end
	if(z==2 and zy>0) then zy=zy-6 end
	if(z==3 and zy<120) then zy=zy+6 end
end

function _draw()
	rectfill(0,0,64,127,12)
	rectfill(64,0,127,127,8)
	spr(1,x,y)
	spr(2,zx,zy)
	if(gamerunning==0) then
		spr(3,48,30)
		spr(4,56,30)
		spr(5,64,30)
		spr(6,72,30)
	
		spr(7,16,90)
		spr(8,32,90)
		spr(9,40,90)
		spr(10,56,90)
		spr(6,64,90)
		spr(11,72,90)
		spr(12,80,90)
		spr(4,88,90)
		spr(13,96,90)
	end
end

function touch()
	if((x>zx-4 and x<zx+4)
	and(y>zy-4 and y<zy+4)) then
	gamerunning=0
	end
end
