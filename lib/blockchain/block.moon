--- A class for a single block in the chain
-- @classmod Block
-- @author Keyhan Vakil
-- @license MIT
-- @see Chain
module "lib.blockchain.block", package.seeall
export ^

crypto = require "crypto"

class Block
    new: (previous, data, nonce=0) =>
        @index = previous.index + 1
        @prev_hash = previous\hash!
        @data = data
        @nonce = nonce

    hash: => crypto.digest "sha1", tostring @

    __tostring: => "Block[#{@index}, #{@prev_hash}, #{@data}, #{@nonce}]"

    difficulty: => #(@hash!\match('^0*'))

    set_nonce: (new_nonce) => @nonce = new_nonce
