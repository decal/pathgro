* check files for useless use of `use-modules`

* use `guile-coroutines` for `lazy-flatten`

* support date string formatting
  - `~d/~y` => 31/18
  - `~b/~A/~Y` => Sun/Mar/2018

* alternate case (change upper to lower case and/or vice versa)

* generate percent-encoded paths

* split and combine on variable length substrings specified by the user

* split and combine on camelCase, PascalCase, Title Case, snake_case, etc.

* modify naming syntax, i.e.
  - camelCase => PascalCase
  - snake_case => TitleCase
  - etc.

* include support for configuration file `pathgro.conf`

* operate on `GET` query variables and/or values
  - also operate on `GET` query fragment sub-values

* include support for queries specified in the fragment identifier
  - i.e. [RFC7111](https://tools.ietf.org/html/RFC71111 "URI Fragment Identifiers for the text/csv Media Type"), [RFC5147](https://tools.ietf.org/html/RFC5147 "URI Fragment Identifiers for the text/plain Media Type"), LiveURL's, Media Fragments, etc. 

* split and combine on dashes, underscores, backslashes, semi-colons possibly other delimiters/seperators/etc.
  - by default, but also allow user-specified split/combine chars
  - also recombine by just dropping the delimiter
  - Some examples of URL paths that the above techniques would be useful upon:
    * `/adi/N2347.wanadoo.ttbuy.capmg/B1063564;sz=468x60;click=http://ads.wanadooregie.com/event.ng/Type=click&FlightID=9238&AdID=19124&TargetID=3378&Segments=5,6,9,10,461,1350,1351,1529,2066,2067,2471,2635,2636,2638,2811,3272,3625,4125,4288,4342,4345,4392,4394,4435,4465,4470,4502,4561,4566,4567,4572,4635,4722&Targets=407,163,1588,1919,1186,2945,3378,3251,3170,3450&Values=31,43,50,60,77,81,90,100,110,132,150,197,210,213,242,823,855,925,1092,1524,1582,3368,5053,6285,6336,6594,7005&RawValues=SN,wanadoo,IP,210.8.79.2,NGUSERID,a01082f-29005-1035172292-1,PN,communiquer.w&Redirect=;ord=`
    * `/adi/N2434.Yahoo/B1959828.10;sz=300x250;dcopt=rcl;click=http://us.ard.yahoo.com/SIG=12ggambn5/M=537404.8896214.9989463.1414694/D=mail/S=150500014:LREC/Y=YAHOO/EXP=1157706882/A=3956373/R=0/*;ord=1157699682852950`
    * `/adi/N2524.burstmedia/B1065355.2;sz=468x60;click=http://www.burstnet.com/ads/ad2180a-map.cgi/BCPG13814.28969.29400/BURSTURL=;siteid=C82;ord=65709`

* use a command-line option for random and/or semi-random shuffles

* implement derangements as set operation in addition to `power-set`, `n-choose-r`, etc.

* string insertion features
  1. prefixes
    - prepend period for "hidden" paths
  2. infixes (at end of basename, and/or before start of extension)
    - implement double file-extensions, like `.tar.gz` for example
  3. suffixes
    - i.e. like editor backup files: `file~`, `file.bak`, etc.
  4. combinations of the above
    - like vim swap files: `file.ext` *=>* `.file.ext.swp`

* speed optimization through conversion of Scheme list operations to vectors 

* force case settings
  - all upper-case, or
  - all lower-case, or
  - generate various multi-case combinations 
    - `admin_home_page`
    - `Admin_home_page`
    - `Admin_Home_page`
    - `Admin_Home_Page`
    - `Admin_home_Page`
    - `admin_Home_Page`
    - `admin_Home_page`
    - `ADMIN_home_page`
    - `ADMIN_Home_page`
    - `ADMIN_Home_Page`
    - `ADMIN_home_Page`
    - `ADMIN_home_PAGE`
    - `ADMIN_Home_PAGE`
    - `ADMIN_HOME_page`
    - `ADMIN_HOME_Page`
    - `ADMIN_HOME_PAGE`
    - generate same as above, but with underscore instead of dash..
    - generate same as above, but with no dash or underscore..
    - generate same as above, but with forward slash delimiter
    - generate same as above, but with backslash delimiter
    - generate same as above, but with period delimiter
    - `aDmin_home_page`
    - `adMin_home_page`
    - `admIn_home_page`
    - `admiN_home_page`
    - `ADmin_home_page`
    - `AdMin_home_page`
    - `AdmIn_home_page`
    - `AdmiN_home_page`
    - ...
    - you get the idea!
    - these are the types of operations to write in C and expose as Scheme procedures for speed purposes

