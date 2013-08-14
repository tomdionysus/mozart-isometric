class App.MainController extends Mozart.Controller

  init: ->
    @models = {
      'grass1': {
        name: 'Grass #1'
        tiles: [ { ox:0, oy:0, oz:0, tx:0, ty:0 } ]
      },
      'grass2': {
        name: 'Grass #2'
        tiles: [ { ox:0, oy:0, oz:0, tx:1, ty:0 } ]
      }
      'road1': {
        name: 'Road #1'
        tiles: [ { ox:0, oy:0, oz:0, tx:0, ty:1 } ]
      }
      'road2': {
        name: 'Road #2'
        tiles: [ { ox:0, oy:0, oz:0, tx:1, ty:1 } ]
      }
      'wallN': { 
        name: 'Wall (N)'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:4, ty:4 }
          { ox:0, oy:0, oz:1, tx:4, ty:3 }
          { ox:0, oy:0, oz:2, tx:4, ty:2 }
        ]
      }
      'wallE': { 
        name: 'Wall (E)'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:5, ty:4 }
          { ox:0, oy:0, oz:1, tx:5, ty:3 }
          { ox:0, oy:0, oz:2, tx:5, ty:2 }
        ]
      }
      'wallNE': { 
        name: 'Wall (NE)'
        tiles: [ 
          { ox:0, oy:0, oz:0, tx:0, ty:0 }
          { ox:0, oy:0, oz:0, tx:8, ty:4 }
          { ox:0, oy:0, oz:1, tx:8, ty:3 }
          { ox:0, oy:0, oz:2, tx:8, ty:2 }
        ]
      }
    }

    @modelNames = _.keys(@models)

  getModelByIndex: (idx) =>
    @models[@modelNames[idx]]

  prevModelIndex: (idx) =>
    return Math.max(idx-1, 0)

  nextModelIndex: (idx) =>
    return Math.min(idx+1, @modelNames.length-1)

