class App.MainController extends Mozart.Controller

  init: ->
    @modelArray = [
      {
        id: 'grass1'
        name: 'Grass #1'
        tiles: [ { ox:0, oy:0, oz:0, tx:0, ty:0 } ]
      }
      {
        id: 'grass2'
        name: 'Grass #2'
        tiles: [ { ox:0, oy:0, oz:0, tx:1, ty:0 } ]
      }
      {
        id: 'road1'
        name: 'Road #1'
        tiles: [ { ox:0, oy:0, oz:0, tx:0, ty:1 } ]
      }
      {
        id: 'road2'
        name: 'Road #2'
        tiles: [ { ox:0, oy:0, oz:0, tx:1, ty:1 } ]
      }
      {
        id: 'shrub1'
        name: 'Shrub #1'
        tiles: [ { ox:0, oy:0, oz:0, tx:0, ty:11 } ]
      }
      {
        id: 'shrub2'
        name: 'Shrub #2'
        tiles: [ { ox:0, oy:0, oz:0, tx:1, ty:11 } ]
      }
      {
        id: 'shrub3'
        name: 'Shrub #3'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:2, ty:11 } 
          { ox:0, oy:0, oz:1, tx:2, ty:10 } 
        ]
      }
      { 
        id: 'wall1N'
        name: 'Wall (N) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:0, ty:4 }
          { ox:0, oy:0, oz:1, tx:0, ty:3 }
          { ox:0, oy:0, oz:2, tx:0, ty:2 }
        ]
      }
      { 
        id: 'wall1NE'
        name: 'Wall (NE)'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:8, ty:4 }
          { ox:0, oy:0, oz:1, tx:8, ty:3 }
          { ox:0, oy:0, oz:2, tx:8, ty:2 }
        ]
      }
      { 
        id: 'wall1E'
        name: 'Wall (E) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:1, ty:4 }
          { ox:0, oy:0, oz:1, tx:1, ty:3 }
          { ox:0, oy:0, oz:2, tx:1, ty:2 }
        ]
      }
      { 
        id: 'wall1SE'
        name: 'Wall (SE) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:9, ty:4 }
          { ox:0, oy:0, oz:1, tx:9, ty:3 }
          { ox:0, oy:0, oz:2, tx:9, ty:2 }
        ]
      }
      { 
        id: 'wall1S'
        name: 'Wall (S) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:2, ty:4 }
          { ox:0, oy:0, oz:1, tx:2, ty:3 }
          { ox:0, oy:0, oz:2, tx:2, ty:2 }
        ]
      }
      { 
        id: 'wall1SW'
        name: 'Wall (SW) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:10, ty:4 }
          { ox:0, oy:0, oz:1, tx:10, ty:3 }
          { ox:0, oy:0, oz:2, tx:10, ty:2 }
        ]
      }
      { 
        id: 'wall1W'
        name: 'Wall (W) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:3, ty:4 }
          { ox:0, oy:0, oz:1, tx:3, ty:3 }
          { ox:0, oy:0, oz:2, tx:3, ty:2 }
        ]
      }
      { 
        id: 'wall1NW'
        name: 'Wall (NW) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:11, ty:4 }
          { ox:0, oy:0, oz:1, tx:11, ty:3 }
          { ox:0, oy:0, oz:2, tx:11, ty:2 }
        ]
      }
      { 
        id: 'wcnr1NE'
        name: 'Corner (NE) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:0, ty:7 }
          { ox:0, oy:0, oz:1, tx:0, ty:6 }
          { ox:0, oy:0, oz:2, tx:0, ty:5 }
        ]
      }
      { 
        id: 'wcnr1SE'
        name: 'Corner (SE) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:1, ty:7 }
          { ox:0, oy:0, oz:1, tx:1, ty:6 }
          { ox:0, oy:0, oz:2, tx:1, ty:5 }
        ]
      }
      { 
        id: 'wcnr1SW'
        name: 'Corner (SW) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:2, ty:7 }
          { ox:0, oy:0, oz:1, tx:2, ty:6 }
          { ox:0, oy:0, oz:2, tx:2, ty:5 }
        ]
      }
      { 
        id: 'wcnr1NW'
        name: 'Corner (NW) #1'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:3, ty:7 }
          { ox:0, oy:0, oz:1, tx:3, ty:6 }
          { ox:0, oy:0, oz:2, tx:3, ty:5 }
        ]
      }
      { 
        id: 'wall2N'
        name: 'Wall (N) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:4, ty:4 }
          { ox:0, oy:0, oz:1, tx:4, ty:3 }
          { ox:0, oy:0, oz:2, tx:4, ty:2 }
        ]
      }
      { 
        id: 'wall2NE'
        name: 'Wall (NE) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:12, ty:4 }
          { ox:0, oy:0, oz:1, tx:12, ty:3 }
          { ox:0, oy:0, oz:2, tx:12, ty:2 }
        ]
      }
      { 
        id: 'wall2E'
        name: 'Wall (E) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:5, ty:4 }
          { ox:0, oy:0, oz:1, tx:5, ty:3 }
          { ox:0, oy:0, oz:2, tx:5, ty:2 }
        ]
      }
      { 
        id: 'wall2SE'
        name: 'Wall (SE) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:13, ty:4 }
          { ox:0, oy:0, oz:1, tx:13, ty:3 }
          { ox:0, oy:0, oz:2, tx:13, ty:2 }
        ]
      }
      { 
        id: 'wall2S'
        name: 'Wall (S) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:6, ty:4 }
          { ox:0, oy:0, oz:1, tx:6, ty:3 }
          { ox:0, oy:0, oz:2, tx:6, ty:2 }
        ]
      }
      { 
        id: 'wall2SW'
        name: 'Wall (SW) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:14, ty:4 }
          { ox:0, oy:0, oz:1, tx:14, ty:3 }
          { ox:0, oy:0, oz:2, tx:14, ty:2 }
        ]
      }
      { 
        id: 'wall2W'
        name: 'Wall (W) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:7, ty:4 }
          { ox:0, oy:0, oz:1, tx:7, ty:3 }
          { ox:0, oy:0, oz:2, tx:7, ty:2 }
        ]
      }
      { 
        id: 'wcnr1NE'
        name: 'Corner (NE) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:4, ty:7 }
          { ox:0, oy:0, oz:1, tx:4, ty:6 }
          { ox:0, oy:0, oz:2, tx:4, ty:5 }
        ]
      }
      { 
        id: 'wcnr1SE'
        name: 'Corner (SE) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:5, ty:7 }
          { ox:0, oy:0, oz:1, tx:5, ty:6 }
          { ox:0, oy:0, oz:2, tx:5, ty:5 }
        ]
      }
      { 
        id: 'wcnr1SW'
        name: 'Corner (SW) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:6, ty:7 }
          { ox:0, oy:0, oz:1, tx:6, ty:6 }
          { ox:0, oy:0, oz:2, tx:6, ty:5 }
        ]
      }
      { 
        id: 'wcnr1NW'
        name: 'Corner (NW) #2'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:7, ty:7 }
          { ox:0, oy:0, oz:1, tx:7, ty:6 }
          { ox:0, oy:0, oz:2, tx:7, ty:5 }
        ]
      }
    ]
    
    @models = {}
    for model in @modelArray
      @models[model.id] = model

  getModelById: (id) =>
    @models[id]

  getModelByIndex: (idx) =>
    @modelArray[idx]

  prevModelIndex: (idx) =>
    return Math.max(idx-1, 0)

  nextModelIndex: (idx) =>
    return Math.min(idx+1, @modelArray.length-1)

