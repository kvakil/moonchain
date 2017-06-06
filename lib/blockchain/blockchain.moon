--- The Blockchain class
-- @classmod Blockchain
-- @author Keyhan Vakil
-- @license MIT
-- @see Chain
module "lib.blockchain.blockchain", package.seeall

Block = require "lib.blockchain.block"
genesis = require "lib.blockchain.genesis"

class Blockchain
    new: =>
        @blocks = { }
        @blocks[1] = genesis

    valid: =>
        for i = 2, #@blocks
            if @blocks[i].prev_hash != @blocks[i - 1]\hash!
                return false
        return true

    DIFFICULTY = 3

    append: (data) =>
        previous = @blocks[#@blocks]
        tail = Block(previous, data)
        nonce = 0
        while tail\difficulty! < DIFFICULTY
            nonce += 1
            tail\set_nonce(nonce)
        @blocks[#@blocks + 1] = tail

    __tostring: =>
        string = ''
        for _, block in ipairs @blocks
            string ..= "#{block}\n"
        return string
