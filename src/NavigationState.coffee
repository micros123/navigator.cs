###
* NavigationState
###

window.NavigationState = class NavigationState
    constructor: (path) ->
        @_setPath(path)

    # take care of the trailing and ending slashes, and replaces spaces with dashes
    _setPath: (path) ->
        # if the input is an array, join them with slashes
        path = path.join('/') if Array.isArray(path)
        # add a slash in the begin if it isn't present
        path = '/' + path if path.charAt(0) isnt '/'
        # add a slash at the end if it isn't present
        path = path + '/' if path.charAt(path.length - 1) isnt '/'
        # replace double slashes
        path = path.replace(/\/+/g, '/')
        # replace white spaces with dashes
        path = path.replace(/\s/g, '-')

        # save the validated value in the @path instance variable
        @path = path

    getPath: -> @path

    getSegments: ->
        result = @path.split('/')
        result.shift()
        result.pop()
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

    prepend: (foreignState) ->
        # is foreign state of class NavigationState
        foreignState = new NavigationState(foreignState) if foreignSegment instanceof NavigationState is false

        segments = @getSegments()

        #watch out for unshift && reverse!
        segments.unshift(foreignSegment) for foreignSegment in foreignState.getSegments().reverse()

        @_setPath(segments)

    append: (foreignState) ->
        # is foreign state of class NavigationState
        foreignState = new NavigationState(foreignState) if foreignSegment instanceof NavigationState is false

        segments = @getSegments()
        segments.push(foreignSegment) for foreignSegment in foreignState.getSegments()

        @_setPath(segments)