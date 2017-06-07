Client = require 'lib.client.client'
network = require 'lib.client.fauxnetwork'

describe 'Client tests', ->
    it 'broadcasts its blockchain', ->
        client = Client!
        spy.on network, 'broadcast'
        for i = 1, 3
            client\mine tostring i
        expected = tostring client.blockchain
        assert.spy(network.broadcast).was_called_with(expected)

    it 'can receive new blocks', ->
        client1 = Client!
        stub client1, 'send'
        stub client1, 'receive'
        client2 = Client!
        stub client2, 'send'
        stub client2, 'receive'

        for i = 1, 3
            client1\mine tostring i
            client2\mine tostring i

        client1.send\revert!
        client2.receive\revert!
        client1\mine '4'

        assert.are.same client1.blockchain, client2.blockchain

    it 'can reconcile forks', ->
        client1 = Client!
        stub client1, 'send'
        stub client1, 'receive'
        client2 = Client!
        stub client2, 'send'
        stub client2, 'receive'

        for i = 1, 3
            client1\mine tostring i
            client2\mine tostring i

        client1\mine '4'

        client1.send\revert!
        client2.receive\revert!
        client2\mine '6'
        client1\mine '5'

        assert.are.same client1.blockchain, client2.blockchain

    it 'validates received blockchains', ->
        client1 = Client!
        stub client1, 'send'
        stub client1, 'receive'
        client2 = Client!
        stub client2, 'send'
        stub client2, 'receive'

        for i = 1, 3
            client1\mine tostring i
            client2\mine tostring i

        old_chain = client2.blockchain

        client1\mine '4'
        client1.send\revert!        
        client2.receive\revert!

        with client1.blockchain
            .blocks[\length!].data = '11'
        client1\send!

        assert.are.same old_chain, client2.blockchain

    it 'prefers its own blockchain to others', ->
        client1 = Client!
        stub client1, 'send'
        stub client1, 'receive'
        client2 = Client!
        stub client2, 'send'
        stub client2, 'receive'

        for i = 1, 3
            client1\mine tostring(i + 3)
            client2\mine tostring(i)

        client2\mine '4'
        client1.send\revert!
        client2.receive\revert!
        client1\mine '-5'

        assert.are_not.same client1.blockchain, client2.blockchain
