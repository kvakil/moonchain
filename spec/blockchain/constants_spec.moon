Constants = require 'lib.blockchain.constants'

describe 'Constant tests', ->
    it 'describes a valid genesis block', ->
        assert.True Constants.GENESIS\is_valid!