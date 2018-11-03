* if read file misses slash at beginning of line, then add one..
  - `pathgro -k1 ~/repos/SecLists/Discovery/Web-Content/coldfusion.txt`

* fix exceptions
  - `pathgro -p1 sunas.txt`
  - `pathgro -k1 sap.txt`

* use `guile-coroutines` for `lazy-flatten`

* support date string formatting
  - `~d/~y` => 31/18
  - `~b/~A/~Y` => Sun/Mar/2018

* split and combine on dashes and underscores 
  - by default, but also allow user-specified split/combine chars
  - also recombine by just dropping the delimiter

* alternate case (change upper to lower case and/or vice versa)

* force case settings
  - all upper-case, or
  - all lower-case

* generate directory traversal strings

* generate percent-encoded paths

* split and combine on variable length substrings specified by the user

* split and combine on camelCase, PascalCase, Title Case, snake_case, etc.

* modify naming syntax, i.e.
  - camelCase => PascalCase
  - snake_case => TitleCase
  - etc.

* include support for configuration file `pathgro.conf`

* operate on GET query variables and/or values

* include support for queries specified in the fragment identifier
  - i.e. RFC7111, RFC5147, LiveURL's, Media Fragments, etc. 

* use a command-line option for random and/or semi-random shuffles

* implement derangements

* accept a command-line flag for each expansion type (and create useful groups of these)
  - --Type1, -T1 (--basename, --extname, --filename)
  - --Type2, -T2 (--dirname, --xtdirname)
  - --Type3, -T3 (--basename, --extname, --filename, --dirname, --xtdirname)
  - --Type4, -T4 (--macos, --saves)
  - --Type5, -T5 (--generate, --vimswap)
  - --Type6, -T6 (--macos, --saves, --generate, --vimswap)
  - --Type7, -T7 (--Combos 1, --Powerset 1, --Kperms 1)

* string insertion features
  1. prefixes
    - prepend period for "hidden" paths
  2. infixes (at end of basename, and/or before start of extension)
    - implement double file-extensions, like `.tar.gz` for example
  3. suffixes
    - i.e. like editor backup files: `file~`, `file.bak`, etc.
  4. combinations of the above
    - like vim swap files: `file.ext` *=>* `.file.ext.swp`
