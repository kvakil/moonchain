--- The Blockchain class
-- @classmod Blockchain
-- @author Keyhan Vakil
-- @license MIT
module 'lib.blockchain.blockchain', package.seeall

Block = require 'lib.blockchain.block'
Constants = require 'lib.blockchain.constants'

class Blockchain
    --- creates a new Blockchain starting from the Genesis block
    new: => @blocks = { [1]: Constants.GENESIS }

    --- creates chain from string
    -- (WARNING: ldoc will incorrectly document this)
    -- @treturn Blockchain the new blockchain
    @from_string: (str) ->
        with Blockchain!
            for block_string in str\gfind('(.-)\n')
                table.insert .blocks, Block.from_string(block_string)

    --- checks if this Blockchain is valid
    -- @treturn bool if this chain is valid
    valid: =>
        for i = 2, #@blocks
            if @blocks[i].prev_hash != @blocks[i - 1]\hash!
                return false
        return true

    --- fixes this Blockchain to be valid
    mine: =>
        for i = 2, #@blocks
            with @blocks[i]
                correct_prev = @blocks[i - 1]\hash!
                if .prev_hash != correct_prev
                    .prev_hash = correct_prev
                    \mine!

    --- appends data at the end of the Blockchain, may invalidate
    -- @tparam string data the data to append
    append: (data) => table.insert @blocks, Block data

    --- returns the number of blocks in this chain
    -- @treturn int the number of blocks in this chain
    length: => #@blocks

    --- returns a string representation of this blockchain
    -- @treturn string a string representation of this blockchain
    __tostring: =>
        string = ''
        for i = 2, #@blocks
            string ..= "#{@blocks[i]}\n"
        return string
