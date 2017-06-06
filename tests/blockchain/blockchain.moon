Block = require 'lib.blockchain.block'
Blockchain = require 'lib.blockchain.blockchain'

describe 'Blockchain tests', ->
    it 'allows for data to be appended', ->
        with Blockchain!
            \append 'test data append'
            assert.truthy \__tostring!\match('test data append')

    it 'remains valid after appends', ->
        with Blockchain!
            for i = 1, 5 do \append(i)
            assert.True \valid!

    it 'detects changed blocks', ->
        with Blockchain!
            for i = 1, 5 do \append(i)
            .blocks[3].data = 4
            assert.False \valid!
