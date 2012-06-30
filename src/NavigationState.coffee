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

  getPath: -> @_path

  setSegments: (segments) ->
    @setPath segments.join '/'

  getSegments: ->
    segments = @_path.split("/")

    segments.pop()
    segments.shift()
    segments

  getSegment: (index) -> @getSegments()[index]

  getFirstSegment: -> @getSegment(0)

  getLastSegment: ->
    segments = @getSegments()
    @getSegment(segments.length - 1)

  contains: (foreignState) ->
    foreignSegments = foreignState.getSegments()
    nativeSegments = @getSegments()

    return false if foreignSegments.length > nativeSegments.length

    for foreignSegment, index in foreignSegments
      nativeSegment = nativeSegments[index]
      return false if not (foreignSegment == "*" or nativeSegment == "*") and foreignSegment != nativeSegment

    return true

  equals: (state) ->
    subtracted = @subtract(state)

    if(subtracted==null)
      return false;

    return subtracted.getSegments().length == 0

  subtract: (operand) ->
    if(!@contains(operand))
      return null

    subtractedSegments = @getSegments()
    subtractedSegments.splice 0, operand.getSegments().length

    new NavigationState subtractedSegments

  append: (stringOrState) ->
    path = stringOrState
    path = stringOrState.getPath() if stringOrState instanceof NavigationState

    @setPath @getPath() + path

  prepend: (stringOrState) ->
    path = stringOrState
    path = stringOrState.getPath() if stringOrState instanceof NavigationState

    @setPath path + @getPath()

  clone: -> new NavigationState @getPath()

  mask: (source) ->
    unmaskedSegments = @getSegments()
    sourceSegments = source.getSegments()

    index = 0
    length = Math.min unmaskedSegments.length, sourceSegments.length
    while index < length
      unmaskedSegments[index] = sourceSegments[index] if unmaskedSegments[index] == "*"
      index++

    new NavigationState unmaskedSegments