Random = require './random'


class XY

  @value_of: (x, y) ->
    xy = new @
    xy.x = x
    xy.y = y
    xy

  toString: ->
    "{x: #{@x}, y: #{@y}}"


all_xy = {}

module.exports =

  value_of: (row, col) ->
    unless all_xy[row]?[col]?
      all_xy[row] ||= {}
      # ideally we'd freeze the instance, but immutable-js
      # complains on browsers that don't have WeakMap
      all_xy[row][col] = XY.value_of(row, col)
    all_xy[row][col]

  random: (max) ->
    row = Random.int(0, max)
    col = Random.int(0, max)
    @value_of(row, col)

  add: (xy1, xy2) ->
    @value_of(xy1.x + xy2.x, xy1.y + xy2.y)

  negate: (xy) ->
    @value_of(-xy.x, -xy.y)

  left: ->
    @value_of(0, -1)

  down: ->
    @value_of(+1, 0)

  right: ->
    @value_of(0, +1)

  up: ->
    @value_of(-1, 0)

