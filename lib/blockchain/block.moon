--- A class for a single block in the chain
-- @classmod Block
-- @author Keyhan Vakil
-- @license MIT
module 'lib.blockchain.block', package.seeall

crypto = require 'crypto'
Constants = require 'lib.blockchain.constants'

class Block
    --- creates a new block with the given data
    -- @tparam string data the data to use
    new: (data) =>
        @prev_hash = ''
        @data = data
        @nonce = -1

    --- creates block from string
    -- (WARNING: ldoc will incorrectly document this)
    -- @treturn Block a new block with the same `tostring`
    @from_string: (str) ->
        with Block!
            .prev_hash, .data, .nonce = str\match('Block%[(%x*), ([^,]*), (.*)%]')
            .nonce = tonumber .nonce

    --- returns the SHA1 hash of this block
    -- @treturn string the hex digest of the hash
    hash: => crypto.digest 'sha1', tostring @

    --- returns the string representation of this block
    -- @treturn string the string representation of this block
    __tostring: => "Block[#{@prev_hash}, #{@data}, #{@nonce}]"

    --- returns the difficulty of this block
    -- @treturn int the number of leading zeros of this block
    difficulty: => #(@hash!\match('^0*'))

    --- finds a nonce such that this block's difficultly is high enough
    mine: =>
        @nonce = 0
        while @difficulty! < Constants.DIFFICULTY do @nonce += 1
