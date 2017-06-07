# Moonchain

A minimal-viable blockchain written in MoonScript.

This currently works, although there several more things I would like
to implement.

## MoonScript

Moonchain is written in [MoonScript], a language with transpiles to
Lua.

## Documentation

Documentation is [available here](doc).

It can also be generated using [ldoc], which can be installed from
[luarocks]. To build documentation run `ldoc .` in the root directory.

## Testing

Unit and integration tests are done through [busted], which can be
installed from [luarocks]. To test, run `busted` in the root
directory.

[moonscript]: https://moonscript.org/
[luarocks]: https://luarocks.org/
[ldoc]: https://stevedonovan.github.io/ldoc/
[doc]: https://kvakil.github.io/moonchain/index.html
[busted]: https://olivinelabs.com/busted/
