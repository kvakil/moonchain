--- A class for a single block in the chain
-- @classmod Block
-- @author Keyhan Vakil
-- @license MIT
-- @see Chain
module "blockchain.block", package.seeall
export ^

class Block
    hash: => evp.digest "sha1", @__tostring!

    __tostring: =>
        string = 'Block['
        string ..= @index .. '\n'
        string ..= @prev_hash .. '\n'
        string ..= @timestamp .. '\n'
        string ..= @data .. '\n'
        string ..= @nonce .. '\n'
        string ..= ']'
        string

    difficulty: => #(@hash!\match('^0*'))
