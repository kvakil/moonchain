--- A class for the CLI frontend
-- @classmod CLIFrontend
-- @author Keyhan Vakil
-- @license MIT
module 'lib.client.clifrontend', package.seeall
Client = require 'lib.client.client'

class CLIFrontend
    --- initalize the frontend
    new: => @clients = {}

    --- start a repl loop
    repl: =>
        while true
            line = @get_line!

            return if line == nil
            return if @parse_quit line
            continue if @parse_new_client line
            continue if @parse_print line
            continue if @parse_mine line

            @help!

    --- gets a line of input from the client
    -- @treturn string
    get_line: =>
        io.write '> '
        io.flush!
        io.read!
    
    QUIT_PATTERN = '^quit$'
    --- determine if the input is a quit command
    -- @treturn bool
    parse_quit: (line) =>
        return line\match(QUIT_PATTERN) != nil

    NEW_CLIENT_PATTERN = '^new (%w+)$'
    --- determine if the input is a new client and execute it if it is
    -- @treturn bool true if the input was a new client command
    parse_new_client: (line) =>
        name = line\match NEW_CLIENT_PATTERN
        if name
            @clients[name] = Client!
            return true
        return false
    
    PRINT_PATTERN = '^print (%w+)$'
    --- determine if the input is a print command and execute it if it is
    -- @treturn bool true if the input was a print command
    parse_print: (line) =>
        name = line\match PRINT_PATTERN
        if name and @clients[name]
            print @clients[name].blockchain
            return true
        return false
    
    MINE_PATTERN = '^mine (%w+) ([^|]+)$'
    --- determine if the input is a mine and execute it if it is
    -- @treturn bool true if the input was a mine command
    parse_mine: (line) =>
        name, data = line\match MINE_PATTERN
        if name and @clients[name]
            @clients[name]\mine data
            return true
        return false

    --- prints the help for this frontend
    help: =>
        print 'To make a new client: new <ClientName>'
        print 'To have a client print its blockchain: print <ClientName>'
        print 'To have a client mine a new block: mine <ClientName> <data>'
        print 'To quit: quit'
