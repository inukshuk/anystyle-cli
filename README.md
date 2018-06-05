AnyStyle Command Line Interface
===============================

Synopsis
--------

    $ anystyle --help
    NAME
        anystyle - Finds and parses bibliographic references

    SYNOPSIS
        anystyle [global options] command [command options] [arguments...]

    VERSION
        1.0.0 (cli 1.0.0, data 1.0.0)

    GLOBAL OPTIONS
        --adapter=name       - Set the dictionary adapter (default: gdbm)
        -f, --format=name    - Set the output format (default: ["json"])
        --help               - Show this message
        --[no-]stdout        - Print results directly to stdout
        --[no-]verbose       - Print status messages to stderr
        --version            - Display the program version
        -w, --[no-]overwrite - Allow overwriting existing files

    COMMANDS
        find    - Find and extract references from text documents
        help    - Shows a list of commands or help for one command
        license - Print license information
        parse   - Parse and convert references

License
-------
Copyright 2011-2018 Sylvester Keil. All rights reserved.

AnyStyle is distributed under a BSD-style license.
See LICENSE for details.
