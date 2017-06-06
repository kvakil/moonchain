--- The Blockchain class
-- @classmod Blockchain
-- @author Keyhan Vakil
-- @license MIT
module "lib.blockchain.blockchain", package.seeall

Block = require "lib.blockchain.block"
Constants = require "lib.blockchain.constants"

class Blockchain
    --- creates a new Blockchain starting from the Genesis block
    new: => @blocks = { [1]: Constants.GENESIS }

    --- checks if this Blockchain is valid
    -- @treturn bool if this chain is valid
    valid: =>
        for i = 2, #@blocks
            if @blocks[i].prev_hash != @blocks[i - 1]\hash!
                return false
        return true

    --- fixes this Blockchain to be valid
    fix: =>
        for i = 2, #@blocks
            with @blocks[i]
                correct_prev = @blocks[i - 1]\hash!
                if .prev_hash != correct_prev
                    .prev_hash = correct_prev
                    \fix!

    --- appends data at the end of the Blockchain, may invalidate
    -- @tparam string data the data to append
    append: (data) =>
        previous = @blocks[#@blocks]
        tail = Block data
        @blocks[#@blocks + 1] = tail

    --- returns the number of blocks in this chain
    -- @treturn int the number of blocks in this chain
    length: => #@blocks

    --- returns a string representation of this blockchain
    -- @treturn string a string representation of this blockchain
    __tostring: =>
        string = ''
        for _, block in ipairs @blocks
            string ..= "#{block}\n"
        return string
