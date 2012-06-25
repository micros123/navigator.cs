###
* NavigationState
###
window.NavigationState = class NavigationState
  this.DELIMITER = '/'
  _path : ''

  constructor: (segments) ->
    if segments instanceof Array
      console.log 'segments is array'
      segments = segments.join NavigationState.DELIMITER

    #console.log segments
    @setPath segments

  setPath: (path) ->
    @_path = NavigationState.DELIMITER + path.toLowerCase() + NavigationState.DELIMITER;

    removeDoubleSlashes = new RegExp "\/+", "g"
    @_path = @_path.replace removeDoubleSlashes, "/";
    @_path = @_path.replace /\s+/g, "-";

    console.log @_path

  getPath: ->
    @_path