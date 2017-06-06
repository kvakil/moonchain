Block = require 'lib.blockchain.block'

describe 'Block tests', ->
    it 'calculates difficulty based on leading zeros', ->
        class MockBlock extends Block
            new: => nil
            hash: => '0000deadbeef0000000012345678ffaa00001234'
        diff = MockBlock!\difficulty!
        assert.are.same 4, diff

    it 'calculates difficulty correctly when it is 0', ->
        class MockBlock extends Block
            new: => nil
            hash: => '1234deadbeef0000000012345678ffaa12341234'
        diff = MockBlock!\difficulty!
        assert.are.same 0, diff

    it 'calculates difficulty correctly when it is maximal', ->
        class MockBlock extends Block
            new: => nil
            hash: => '0000000000000000000000000000000000000000'
        diff = MockBlock!\difficulty!
        len = #MockBlock!\hash!
        assert.are.same len, diff

    it 'calculates the SHA1 hash correctly based on the tostring', ->
        class MockBlock extends Block
            new: => nil
            __tostring: => 'Hello world!'
        assert.are.same 'd3486ae9136e7856bc42212385ea797094475802',
                        MockBlock!\hash!

    it 'calculates the difficulty correctly based on the tostring', ->
        class MockBlock extends Block
            new: => nil
            __tostring: => 'i'
        assert.are.same 1, MockBlock!\difficulty!

    it 'can be converted to and from a string', ->
        b1 = Block 'Test Data'
        b2 = Block.from_string(tostring b1)
        assert.are.same b1, b2
