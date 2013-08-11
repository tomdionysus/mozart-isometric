App.mainController = App.MainController.create()

Mozart.root = window

App.Application = Mozart.MztObject.create()

App.Application.set 'layout', Mozart.Layout.create(
  rootElement: '#main'
  states: [
    Mozart.Route.create
      viewClass: App.MainView
      path: "/"
  ]
)

App.Application.ready = ->
  App.Application.set 'domManager', Mozart.DOMManager.create(
    rootElement: 'body'
    layouts: [ 
      App.Application.layout
    ]
  )

  App.Application.layout.bindRoot()
  App.Application.layout.start()

  $(document).trigger('Mozart:loaded')

$(document).ready(App.Application.ready)
    
