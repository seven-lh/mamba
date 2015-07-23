Mamba = require './mamba'
settings = require './settings'
{keyhandler, renderer} = require './util'

_ = require 'underscore'
$ = window.$


class Game
  ###
    Has-one Renderer
    Has-one Keyhandler
  ###

  @motion_keys =
    37:
      x: -1
      y: 0
    38:
      x: 0
      y: 1
    39:
      x: 1
      y: 0
    40:
      x: 0
      y: -1

  @method_keys =
    82: '__restart'

  constructor: (grid_node) ->
    @_reset_mamba()
    @_keyhandler = keyhandler
      .from_handler(@_keyup, $)
      .handle()
    @_renderer = renderer
      .mount(grid_node)
      .loop(@_renderprops)

  _reset_mamba: ->
    @_mamba = Mamba.at_position(settings.GRID.start_position())

  _keyup: (keycode) =>
    impulse = @constructor.motion_keys[keycode]
    control = @constructor.method_keys[keycode]
    if impulse?
      (!@_renderer.looping()) && @_renderer.loop(@_renderprops)
      @_mamba.impulse(impulse)
    else if control?
      @[control]()

  __restart: ->
    @_reset_mamba()
    @_renderer.reset(@_renderprops())

  _renderprops: =>
    mamba: @_mamba
    mode: settings.MODE.easy


if $?
  new Game $('#mamba')[0]
else
  throw new Error "Couldn't find window.$, are you sure jQuery is loaded?"