--- A class for the P2P client
-- @classmod Client
-- @author Keyhan Vakil
-- @license MIT
module 'lib.client.client', package.seeall
Blockchain = require 'lib.blockchain.blockchain'
network = require 'lib.client.fauxnetwork'

class Client
    --- create a new client and register with the network
    new: =>
        @blockchain = Blockchain!
        network.register @

    --- broadcast the blockchain to the network
    send: => network.broadcast tostring @blockchain

    --- update blockchain if the received one is longer
    -- @tparam string data a string describing the new blockchain
    receive: (data) =>
        proposed = Blockchain.from_string data
        if not proposed then return
        if not proposed\is_valid! then return
        if proposed\length! > @blockchain\length!
            @blockchain = proposed

    --- mine to add data at the end of my blockchain
    -- @tparam string data to append
    mine: (data) =>
        @blockchain\append data
        @blockchain\mine!
        @send!
