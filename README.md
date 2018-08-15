AnyStyle Command Line Interface
===============================

anystyle --help
---------------
    NAME
        anystyle - Finds and parses bibliographic references

    SYNOPSIS
        anystyle [global options] command [command options] [arguments...]

    VERSION
        1.1.0 (cli 1.0.2, data 1.2.0)

    GLOBAL OPTIONS
        -F, --finder-model=file - Set the finder model file (default: none)
        -P, --parser-model=file - Set the parser model file (default: none)
        --adapter=name          - Set the dictionary adapter (default: ruby)
        -f, --format=name       - Set the output format (default: ["json"])
        --help                  - Show this message
        --[no-]stdout           - Print results directly to stdout
        --[no-]verbose          - Print status messages to stderr
        --version               - Display the program version
        -w, --[no-]overwrite    - Allow overwriting existing files

    COMMANDS
        check   - Check tagged documents or references
        find    - Find and extract references from text documents
        help    - Shows a list of commands or help for one command
        license - Print license information
        parse   - Parse and convert references
        train   - Create a new finder or parser model

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

        anystyle find --crop 72 thesis.pdf -

        Extract references from `thesis.pdf' cropping away one inch (72pt) from
        each page border and print the results to STDOUT.

        anystyle find --crop 72,28 thesis.pdf -

        Extract references from `thesis.pdf' cropping away one inch (72pt) from
        each page's left and right border, approx. 1cm (28pt) from the top
        and bottom.


    COMMAND OPTIONS
        -C, --crop=pt - Set cropping boundary for text extraction (default: none)
        --[no-]layout - Use layout mode for PDF text extraction (default: enabled)
        --[no-]solo   - Include references outside of reference sections


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


anystyle help check
-------------------
    NAME
        check - Check tagged documents or references

    SYNOPSIS
        anystyle [global options] check input

    DESCRIPTION
        This manual page documents the AnyStyle `check' command. AnyStyle `check'
        analyzes tagged text documents or references.

        The input argument can be a single TTX or XML document, or a folder
        containing multiple documents.

        AnyStyle `check' supports the following input formats:
            ttx     Tagged document format, used for training the finder model;
            xml     References only, XML, suitable for training the parser model.

    EXAMPLES
        anystyle check training-data.xml

        Checks all references in the XML file and prints a report to STDOUT.


anystyle help train
-------------------
    NAME
        train - Create a new finder or parser model

    SYNOPSIS
        anystyle [global options] train input [output]

    DESCRIPTION
        This manual page documents the AnyStyle `train' command. AnyStyle `train'
        creates a new finder or parser model based on the supplied training sets.

        The input argument can be a XML document, or a folder containing multiple
        TTX documents.

    EXAMPLES
        anystyle train data.xml my-model.mod

        Creates a new parser model based on the XML training set and saves it
        as `my-model.mod'. To use your model use the global `--finder-model'
        or `--parser-model' flags.


License
-------
Copyright 2011-2018 Sylvester Keil. All rights reserved.

AnyStyle is distributed under a BSD-style license.
See LICENSE for details.
