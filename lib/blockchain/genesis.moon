--- A class for the singleton Genesis block
-- @module GenesisBlock
-- @author Keyhan Vakil
-- @license MIT
-- @see Chain
module "lib.blockchain.genesis", package.seeall

Block = require "lib.blockchain.block"

(class GenesisBlock extends Block
    new: => nil
    hash: => '0000000000000000000000000000000000000000'
    index: 1
    prev_hash: nil
    data: ''
    __tostring: => 'genesis_block'
)!
