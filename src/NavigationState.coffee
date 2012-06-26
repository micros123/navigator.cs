###
* NavigationState
###
window.NavigationState = class NavigationState
  constructor: (segments) ->
    segments = segments.join '/' if segments instanceof Array

    @setPath segments

  setPath: (path) ->
    @_path = '/' + path.toLowerCase() + '/';

    @_path = @_path.replace (new RegExp "\/+", "g"), "/";
    @_path = @_path.replace /\s+/g, "-";

    #console.log @_path

  getPath: ->
    @_path

  setSegments: (segments) ->
    @setPath segments.join '/'

  getSegments: ->
    segments = @_path.split("/")

    segments.pop()
    segments.shift()
    segments

  getSegment: (index) ->
    @getSegments()[index]

  getFirstSegment: ->
    @getSegment(0)

  getLastSegment: ->
    segments = @getSegments()
    @getSegment(segments.length - 1)

  contains: (foreignState) ->
    foreignSegments = foreignState.getSegments()
    nativeSegments = @getSegments()

    return false if foreignSegments.length > nativeSegments.length

    for foreignSegment, index in foreignSegments
      nativeSegment = nativeSegments[index]
      return false if foreignSegment != nativeSegment and (foreignSegment!="*" or nativeSegment!="*")

    return true