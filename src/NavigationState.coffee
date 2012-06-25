###
* NavigationState
###

window.NavigationState = class NavigationState
    constructor: (@path) ->

    getPath: -> @path

    getSegments: ->
        result = @path.split('/')
        result.splice(0, 1)
        result

    getSegment: (index) ->
        segments = @getSegments()
        segments[index]

    getFirstSegment: ->
        segments = @getSegments()
        segments[0]

    getLastSegment: ->
        segments = @getSegments()
        segments[segments.length - 1]