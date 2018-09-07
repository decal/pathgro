* split and combine on dashes and underscores 
  - by default, but also allow user-specified split/combine chars
  - also recombine by just dropping the delimiter

* split and combine on variable length substrings specified by the user

* split and combine on camelCase, PascalCase, Title Case, snake_case, etc.

* include support for a configuration file, `pathgro.conf` perhaps?

* operate on GET query variables and/or values

* include support for queries specified in the fragment identifier
  - i.e. RFC7111, RFC5147, LiveURL's, Media Fragments, etc. 

* accept a command-line flag for each expansion type (and create useful groups of these)

* string insertion features
  1. prefixes
    - prepend period for "hidden" paths
  2. infixes (at end of basename, and/or before start of extension)
    - implement double file-extensions, like `.tar.gz` for example
  3. suffixes
    - i.e. like editor backup files: `file~`, `file.bak`, etc.
  4. combinations of the above
    - like vim swap files: `file.ext` *=>* `.file.ext.swp`
