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

    @selectedModelIndex = 0

    @addModelByName('wall1N',1,0,0)
    @addModelByName('wall1E',0,1,0)
    @addModelByName('wall1NE',0,0,0)

    @midY = Math.round(@height/32)
    @midX = Math.round(@width/64)

    @mouseX = 0
    @mouseY = 0
    @mouseZ = 0

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
    @keysLocked = {} if _.keys(@keysDown).length == 0

    for code,nv of @keysDown when !@keysLocked[code]?
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

        when "81"
          @set 'mouseZ', @mouseZ+1
          @keysLocked[code] = 1

        when "65"
          @set 'mouseZ', @mouseZ-1
          @keysLocked[code] = 1

        when "71"
          # grass
          @addTile(0,0, @mouseX, @mouseY, @mouseZ)
        when "87"
          #water
          @addTile(0,19, @mouseX, @mouseY, @mouseZ)
        when "68"
          # delete
          @clearTile(@mouseX, @mouseY, @mouseZ)

        when "83"
          # Paint Current Model
          @addModel(App.mainController.getModelByIndex(@selectedModelIndex), @mouseX, @mouseY, @mouseZ)

        when "79"
          # Previous Model
          @selectedModelIndex = App.mainController.prevModelIndex(@selectedModelIndex)
          @keysLocked[code] = 1

        when "80"
          # Next Model
          @selectedModelIndex = App.mainController.nextModelIndex(@selectedModelIndex)
          @keysLocked[code] = 1

        else
          console.log(code)

    _.delay(@runLoop,30)

  click: =>
    @addModel(App.mainController.getModelByIndex(@selectedModelIndex), @mouseX, @mouseY, @mouseZpppp)

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
            @drawTile(14,5,x,y,@mouseZ)
          else
            for z, tiles of @world[wx][wy]
              if z == @mouseZ and !z?
                @drawTile(14,5,x,y,@mouseZ)
              else
                for tile in tiles 
                  @drawTile(tile.x,tile.y, x, y, z)

          if wx == @mouseX and wy == @mouseY 
            @drawTile(13, 5, x, y, 0)
            @drawTile(15, 5, x, y, @mouseZ)
    
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
    @drawHudFps(10, @height-30)
    @drawHudCurrentTile(@width-110, @height-150)
    @drawHudSelectedModel(@width-220, @height-150)
    # Outline
    @ctx.strokeStyle = '#555555'
    @ctx.lineWidth = 1
    @ctx.strokeRect(0, 0, @width, @height)

  drawHudCurrentTile: (x,y) =>
    @ctx.fillStyle = '#000'
    @ctx.strokeStyle = '#555'
    @ctx.lineWidth = 1
    @ctx.fillRect(x, y, 100, 140)
    @ctx.strokeRect(x, y, 100, 140)
    
    @current = @getTileStack(@mouseX, @mouseY)

    if @current?
      for z, tiles of @current
        for tile in tiles
          @ctx.drawImage(@bggrass[0], tile.x*64, tile.y*32, 64, 32, x+20, y+100-(z*32), 64, 32)
    else
      @ctx.fillStyle    = '#fff'
      @ctx.font         = '12px sans-serif'
      @ctx.textBaseline = 'top'
      @ctx.fillText("No Tiles", x+25, y+8)

  drawHudSelectedModel: (x,y) =>
    @ctx.fillStyle = '#000'
    @ctx.strokeStyle = '#555'
    @ctx.lineWidth = 1
    @ctx.fillRect(x, y, 100, 140)
    @ctx.strokeRect(x, y, 100, 140)
    
    selectedModel = App.mainController.getModelByIndex(@selectedModelIndex)

    for tile in selectedModel.tiles
      @ctx.drawImage(@bggrass[0], tile.tx*64, tile.ty*32, 64, 32, x+20, y+100-(tile.oz*32), 64, 32)

    @ctx.fillStyle    = '#fff'
    @ctx.font         = '12px sans-serif'
    @ctx.textBaseline = 'top'
    @ctx.fillText(selectedModel.name, x+25, y+8)

  drawHudFps: (x,y) =>
    @ctx.fillStyle = '#000'
    @ctx.strokeStyle = '#555'
    @ctx.lineWidth = "1px"
    @ctx.fillRect(x, y, 250, 20)
    @ctx.strokeRect(x, y, 250, 20)

    #FPS
    @ctx.fillStyle    = '#fff'
    @ctx.font         = '12px sans-serif'
    @ctx.textBaseline = 'top'
    @ctx.fillText("View: X:#{@viewX} Y:#{@viewY}, Mouse: X: #{@mouseX} Y: #{@mouseY}, Z: #{@mouseZ}, #{@lastFps} fps",
      x+5, y+3)

  addModelByName: (modelname, x,y,z) =>
    @addModel(App.mainController.getModelById(modelname),x,y,z)

  addModel: (model, x, y, z) =>
    for tile in model.tiles
      @addTile(tile.tx,tile.ty,x+tile.ox,y+tile.oy,z+tile.oz)

    @world[x][y][z].modelId = model.id

  addTile: (tx,ty, x, y, z) =>
    @world[x] ?= {}
    @world[x][y] ?= {}
    @world[x][y][z] ?= []
    for ex in @world[x][y][z]
      return if ex.x == tx and ex.y == ty 
    @world[x][y][z].push {x:tx, y:ty}

  getTile: (x,y,z = 0) =>
    return null unless @world[x]? and @world[x][y]? and @world[x][y][z]?
    @world[x][y][z]

  getTileStack: (x,y) =>
    return null unless @world[x]? and @world[x][y]?
    @world[x][y]

  clearTile: (x,y,z) =>
    return unless @world[x]? and @world[x][y]? and @world[x][y][z]?

    if @world[x][y][z].modelId? 
      # Tile is a model
      model = App.mainController.getModelById(@world[x][y][z].modelId)
      @clearModel(model, x,y, z)
    else
      # Tile is generic
      @clearWorld(x,y,z)
      
  clearWorld: (x,y,z) =>
    return unless @world[x]? and @world[x][y]? and @world[x][y][z]?

    t = @world[x][y]
    delete t[z]
    if _.keys(@world[x][y]).length == 0
      t = @world[x]
      delete t[y]
    if _.keys(@world[x]).length == 0
      delete @world[x]

  clearModel: (model, x, y, z) =>
    for tile in model.tiles
      @clearWorld(x+tile.ox,y+tile.oy,z+tile.oz)

  # Mouse
  mouseMove: (e) =>
    mx = Math.round((e.offsetX-32)/32)
    my = Math.round((e.offsetY+(@mouseZ*32)-32)/16)

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
    @keysLocked = {}
