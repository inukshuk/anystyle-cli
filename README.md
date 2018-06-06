AnyStyle Command Line Interface
===============================

anystyle --help
---------------
    NAME
        anystyle - Finds and parses bibliographic references

    SYNOPSIS
        anystyle [global options] command [command options] [arguments...]

    VERSION
        1.0.0 (cli 1.0.0, data 1.2.0)

    GLOBAL OPTIONS
        --adapter=name       - Set the dictionary adapter (default: ruby)
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

anystyle help find
------------------
    NAME
        find - Find and extract references from text documents

    SYNOPSIS
        anystyle [global options] find [command options] input [output]

    DESCRIPTION
        This manual page documents the AnyStyle `find' command. AnyStyle `find'
        analyzes PDF or text documents and extracts all references it finds.

        The input argument can be a single PDF or text document, or a folder
        containing multiple documents. The (optional) output argument specifies
        the folder where the results shall be saved; if no output folder is
        specified, results will be saved in the folder containing the input.

        AnyStyle `find' supports the following formats:
            bib     BibTeX (references only);
            csl     CSL/JSON (references only);
            json    AnyStyle JSON (references only);
            ref     One reference per line, suitable for parser input;
            txt     Plain text document;
            ttx     Tagged document format, used for training the finder model;
            xml     References only, XML, suitable for training the parser model.

        You can specify multiple output formats, separated by commas.

        Anlyzing PDF documents currently depends on `pdftotext' which must be
        installed separately.

    EXAMPLES
        anystyle -f csl,xml find thesis.pdf

        Extract references from `thesis.pdf' and save them in `thesis.csl' and
        `thesis.xml'.

        anystyle -f bib find --no-layout thesis.pdf bib

        Extract references from `thesis.pdf' in `no-layout' mode (e.g., use this
        if your document uses a multi-column layout) and save them in BibTeX in
        `./bib/thesis.bib'.

anystyle help parse
-------------------
    COMMAND OPTIONS
        --[no-]layout - Use layout mode for PDF text extraction (default: enabled)
    NAME
        parse - Parse and convert references

    SYNOPSIS
        anystyle [global options] parse input [output]

    DESCRIPTION
        This manual page documents the AnyStyle `parse' command. AnyStyle `parse'
        segments references (one per line) and converts them into structured
        formats.

        The input argument can be a single text document containing one full
        reference per line (blank lines will be ignored), or a folder containing
        multiple documents. The (optional) output argument specifies
        the folder where the results shall be saved; if no output folder is
        specified, results will be saved in the folder containing the input.

        AnyStyle `parse' supports the following formats:
            bib     BibTeX (normalized);
            csl     CSL/JSON (normalized);
            json    AnyStyle JSON (normalized);
            ref     One reference per line, suitable for parser input;
            txt     Same as `ref';
            xml     XML, suitable for training the parser model.

        You can specify multiple output formats, separated by commas.

    EXAMPLES
        anystyle -f json,xml parse biblio.txt

        Extract references from `biblio.txt' and save them in `biblio.json' and
        `biblio.xml'.

        anystyle --stdout -f csl parse input.txt

        Extract references from `input.txt' and print them to STDOUT in CSL/JSON.

License
-------
Copyright 2011-2018 Sylvester Keil. All rights reserved.

AnyStyle is distributed under a BSD-style license.
See LICENSE for details.
