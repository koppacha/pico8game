pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
  scr_w = 128
  scr_h = 128

  p = {
    w = 8,
    h = 8,
    x = 0,
    y = scr_h - 8,
    
    vx = 0,
    vy = 0,
    
    accel = 0.2,
    max_vx = 1.6,
    friction = 0.85,
    
    grav = 0.25,
    jump_v = -3.2,
    on_ground = true,
    
    spd = 1.5,
    spr = 1,
    flip = false,
    spr_idle = 1,
    spr_walk = {2, 3},
    anim_t = 0,
    anim_interval = 6,
    moving = false
  }
end

function _update()
  local ax = 0
  if btn(0) then ax -= p.accel end
  if btn(1) then ax += p.accel end

  p.vx += ax

  if ax == 0 then
    p.vx *= p.friction
    if abs(p.vx) < 0.02 then p.vx = 0 end
  end

  p.vx = mid(-p.max_vx, p.vx, p.max_vx)

  if p.vx < -0.01 then p.flip = true end
  if p.vx >  0.01 then p.flip = false end

  if btnp(4) and p.on_ground then
    p.vy = p.jump_v
    p.on_ground = false
  end

  p.vy += p.grav

  p.x += p.vx
  p.y += p.vy

  if p.x < -p.w then p.x = scr_w end
  if p.x > scr_w then p.x = -p.w end

  local ground_y = scr_h - p.h
  if p.y >= ground_y then
    p.y = ground_y
    p.vy = 0
    p.on_ground = true
  end

  if p.on_ground and abs(p.vx) > 0.1 then
    p.anim_t += 1
    local idx = flr(p.anim_t / p.anim_interval) % 2 + 1
    p.spr = p.spr_walk[idx]
  else
    p.anim_t = 0
    p.spr = p.spr_idle
  end
end

function _draw()
  cls()

  line(0, scr_h - 1, scr_w - 1, scr_h - 1, 3)

  spr(p.spr, flr(p.x), flr(p.y), 1, 1, p.flip, false)

  print("x:"..flr(p.x), 1, 1, 7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077007700770077007700770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700077777700777777007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000077171700771717007717170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000077777700777777007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700077777700777777007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070000700700007007000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070000700770007777000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
