--- Constants used for blockchain
-- @module constants
-- @author Keyhan Vakil
-- @license MIT
module 'lib.blockchain.constants', package.seeall

Block = require 'lib.blockchain.block'

{
    DIFFICULTY: 3 -- the difficulty of the blockchain
    GENESIS: -- the genesis block
    (class GenesisBlock extends Block
        new: => nil
        hash: => '0'\rep 40
        prev_hash: '0'\rep 40
        nonce: '0'\rep 40
        data: ''
        __tostring: => 'genesis_block')!
}
