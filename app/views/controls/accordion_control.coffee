class App.AccordionControl extends Mozart.Collection
  viewClassLookup: "App.AccordionPanelControl"
  activeClassName: 'active'
  idPrefix: 'accordion'
  idField: 'id'
  tag: 'div'

  init: ->
    super
    @bind 'change:value', @markActive

  draw: =>
    super
    @markActive()

  markActive: =>
    #iterate visible view items and add/remove @activeClassName if the content.id is our value
    for id, view of @itemViews when view.element?
      view.element.toggleClass(@activeClassName, view.content[@idField] == @value) 
      
