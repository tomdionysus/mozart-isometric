class App.IsometricGameView extends Mozart.View
  skipTemplate: true
  tag: 'canvas'
  width: 1200
  height: 600
  viewXBinding: "App.mainController.viewX"
  viewYBinding: "App.mainController.viewY"

  init: =>
    super

    window.addEventListener 'keydown', @checkKeyDown
    window.addEventListener 'keyup', @checkKeyUp
    window.addEventListener 'blur', @clearKeys

    @keysDown = {}

    @widthHtml = "#{@width}"
    @heightHtml = "#{@height}"

    @tileW = @width/64
    @tileH = (@height/16)+1

    @bggrass = $('<img>')
    @bggrass.attr('src','/img/grassland_tiles.png').load(=>
      window.requestAnimationFrame(@draw)
    )
    @fps = 0
    @lastFps = '--'
    @miss = 0
    @lastMiss = '--'

    @world = {}

    @addTile(0,0,6,5,0)
    @addTile(4,2,6,5,2)
    @addTile(4,3,6,5,1)
    @addTile(4,4,6,5,0)

    @addTile(0,0,5,6,0)
    @addTile(5,2,5,6,2)
    @addTile(5,3,5,6,1)
    @addTile(5,4,5,6,0)

    @addTile(0,0,5,5,0)
    @addTile(8,2,5,5,2)
    @addTile(8,3,5,5,1)
    @addTile(8,4,5,5,0)

    @midY = Math.round(@height/32)
    @midX = Math.round(@width/64)

    console.log @midX, @midY

    @set('viewX',0)
    @set('viewY',0)

  afterRender: =>
    @ctx = @element[0].getContext('2d')
    window.setTimeout(@resetFps,1000)
    _.delay(@runLoop,5)
    @element.on 'mousemove', @mouseMove

  resetFps: =>
    @lastFps = @fps
    @fps = 0
    @lastMiss = @miss
    @miss =0
    window.setTimeout(@resetFps,1000)

  runLoop: =>
    for code,nv of @keysDown
      switch code
        when "37"
          @set 'viewX', @viewX+1
          @set 'viewY', @viewY-1
        when "39"
          @set 'viewX', @viewX-1
          @set 'viewY', @viewY+1
        when "38"
          @set 'viewY', @viewY-1
          @set 'viewX', @viewX-1
        when "40"
          @set 'viewY', @viewY+1
          @set 'viewX', @viewX+1
        else
          console.log(code)

    _.delay(@runLoop,30)

  draw: =>
    return unless @ctx?

    # Clear Canvas
    @ctx.fillStyle = "#000"
    @ctx.fillRect(0,0,@width,@height)

    # Draw current Viewport
    for x in [-@midX..@midX]
      for y in [-1..@midY*2]
        wx = x + @viewX + 0
        wy = y + @viewY - @midY
        unless wx<0 or wy<0 or wx>50 or wy>50
          if !@world[wx]? or !@world[wx][wy]?
            @drawTile(14,5,x,y,0)
          else
            for h, tiles of @world[wx][wy]
              for tile in tiles 
                @drawTile(tile.x,tile.y, x, y, h)

          if wx == @mouseX and wy == @mouseY 
            @drawTile(15, 5, x, y, 0)
    
    # HUD
    @drawHud()

    # FPS Count
    @fps++

    # Next!
    window.requestAnimationFrame(@draw)

  drawTile: (tileX, tileY, wx, wy, wz) =>
    sy = scrY % 2
    tileX *= 64
    tileY *= 32
 
    scrX = (wy*32)-(wx*32)
    scrY = (wy*16)+(wx*16)-(wz*32)

    if scrX < -64 or scrX > @width or scrY < -32 or scrY > @height
      @miss++
      return

    @ctx.drawImage(@bggrass[0], tileX, tileY, 64, 32, scrX, scrY, 64, 32)

  drawHud: =>
    #FPS
    @ctx.fillStyle    = '#fff'
    @ctx.font         = '12px sans-serif'
    @ctx.textBaseline = 'top'
    @ctx.fillText("View: X:#{@viewX} Y:#{@viewY}, Mouse: X: #{@mouseX} Y: #{@mouseY}, #{@lastFps} fps", 1, @height-13)
    # Outline
    @ctx.strokeStyle = '#555555'
    @ctx.lineWidth = 1
    @ctx.strokeRect(0, 0, @width, @height)



  addTile: (tx,ty, x, y, z) =>
    @world[x] ?= {}
    @world[x][y] ?= {}
    @world[x][y][z] ?= []
    @world[x][y][z].push {x:tx, y:ty}

  # Mouse

  mouseMove: (e) =>
    mx = Math.round((e.offsetX-32)/32)
    my = Math.round((e.offsetY-16)/16)

    @mouseY = Math.round(((my + mx) - @midY*2)/2)+ @viewY
    @mouseX = Math.round((0-(mx - my))/2)+@viewX

  # Keys

  checkKeyDown: (evt) =>
    @keysDown[evt.keyCode]=1
    true

  checkKeyUp: (evt) =>
    delete @keysDown[evt.keyCode]
    false

  clearKeys: (evt) =>
    @keysDown = {}

  scroll: (e) =>
    console.log e
    e.preventDefault()

  click: =>
    @addTile(0,0,@mouseX, @mouseY, 0)
