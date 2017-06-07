--- A faux network for clients to connect to
-- @module fauxnetwork
-- @author Keyhan Vakil
-- @license MIT
module 'lib.client.fauxnetwork', package.seeall

clients = {}

export *
--- register a client with the network
-- @tparam Client client the client to register
register = (client) -> table.insert clients, client
--- broadcast a packet to all clients
-- @tparam string packet the string to broadcast
broadcast = (packet) -> for client in *clients do client\receive(packet)
