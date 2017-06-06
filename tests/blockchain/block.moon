Block = require 'lib.blockchain.block'

describe 'Block tests', ->
    it 'calculates difficulty based on leading zeros', ->
        class MockBlock extends Block
            hash: => '0000deadbeef0000000012345678ffaa'
        diff = MockBlock!\difficulty!
        assert.are.same diff, 4

    it 'calculates difficulty correctly when it is 0', ->
        class MockBlock extends Block
            hash: => '1234deadbeef0000000012345678ffaa'
        diff = MockBlock!\difficulty!
        assert.are.same diff, 0
