Block = require 'lib.blockchain.block'
Blockchain = require 'lib.blockchain.blockchain'

describe 'Blockchain tests', ->
    it 'allows for data to be appended', ->
        with Blockchain!
            \append 'test data append'
            assert.truthy \__tostring!\match('test data append')

    it 'remains valid after appends', ->
        with Blockchain!
            for i = 1, 5
                \append(tostring i)
            \mine!
            assert.True \valid!

    it 'detects changed blocks', ->
        with Blockchain!
            for i = 1, 5
                \append(tostring i)
            \mine!
            .blocks[3].data = '4'
            assert.False \valid!
            \mine!
            assert.True \valid!

    it 'can be converted from a string', ->
        bc1 = with Blockchain!
            for i = 1, 5
                \append(tostring i)
            \mine!
        bc2 = Blockchain.from_string(tostring bc1)
        assert.are.same bc1, bc2
