<p align="center">
  <a href="https://github.com/decal/pathgro/blob/master/COPYING.txt" name="pathgro-copying" id="license-link"><img src="https://img.shields.io/badge/license-LGPLv3-yellow.svg?maxAge=2592000" name="pathgro-license" id="license-image" title="LGPLv3" alt="[ GNU Lesser General Public License ]" crossorigin="anonymous" integrity="sha512-LglCDw+0y0npKqEXzPJQc74NiCCphVtNICdc61slXEiZbt3j6RAwHf52ysL4Eg7B0mbss1VlsL10GdvAZ+82zA==" /></a>
</p>

<table translate="no" title="PathGro" name="pathgro-table" id="pgtable" style="border-color: yellow; border-collapse: separate; border-spacing: 8px; display: table">
  <tr>
    <td>
      <p align="center">
        <img height="32%" width="32%" src="https://raw.githubusercontent.com/decal/pathgro/master/assets/pathgro-logo.png" alt="[ PathGro Logo | Miracle-Gro(tm) Spoof ]" title="DirBuster Path Food" crossorigin="anonymous" integrity="sha384-n6Qkb58C/K/kkDL0LNpsU9Vx0z6vTSQ9bjZx4VlrRE3FS7LH6J0TKqpm9h1S1L/1" />
      </p>
    </td>
  </tr>
</table>

## Introduction

`pathgro` takes a brief list of path strings as input and "grows" them into much
larger sets. It is a tool that freely commingles pathname pieces to generate new
omnifarious string mappings. It is designed to maximize attack surface coverage
when testing software components that take pathnames as input, ie. "dirbusting."
It is a set of [GNU Guile](https://gnu.org/software/guile "GNU's programming and extension language") modules with a command-line interface.

## Examples

General overview of the functionality:

[![PathGro Usage Examples](https://asciinema.org/a/InUx4vKTr0cUYyVYA5jlzVtZi.svg "Terminal Recording Demonstrating Command Line Execution of PathGro Tool")](https://asciinema.org/a/InUx4vKTr0cUYyVYA5jlzVtZi "Various Examples of Growing Path Lists")

Note that `pathgro --Combos 1` and `pathgro --Kperms 1` will generate equivalent lists according to their definitions.

## Dependencies

* **GNU Guile 2.x**

* **NOTE:** you must make sure that you have both `guile` and `guild` executables installed.\
Some distributions (e.g. *Debian*) provide `guild` separately from `guile`, so simply\
installing a package called `guile` may not be sufficient.\
(*Debian* provides `guild` in a package called `guile-2.x-dev`)

## Installation

``` shell
# install the required guile binaries
$ sudo apt install guile guile-2.0-dev
# or alternatively..
$ sudo apt install linuxbrew-wrapper && brew install guile 
# don't forget to add `~/.linuxbrew/Cellar/guile/2.x.x/bin` to `PATH`
# on macOS you can simply `brew install guile` after installing Homebrew from brew.sh

# clone the repository:
$ git clone https://github.com/decal/pathgro

# change working directory to pathgro:
$ cd pathgro

# compile the source using the Makefile:
$ make

# execute tests using the Makefile:
$ make test

# install pathgro using the Makefile (probably requires root):
$ sudo make install
```

## Usage

<img height="80%" width="80%" src="https://raw.githubusercontent.com/decal/pathgro/master/assets/pathgro-usage.png" name="pathgro-usage" id="usage-image" alt="[ PathGro Tool Usage Summary ]" title="PathGro Command Line Options" crossorigin="anonymous" integrity="sha384-JohFyrL8uTZrufLN1XfVqcfhdngDWP2l/KJffx/D7PYtNNzohlEIO/biKyW2N6A8" />

* * *

|&nbsp;&nbsp;&nbsp;_Command&nbsp;Line&nbsp;Flag_&nbsp;&nbsp;| _Description of Grow Level_ 
|:-------------------------------------------|-----------------------------------------------------------------------
| `--Grow 0`, `-G0` | <br /><details><summary>each command-line flag has a 50% chance of being enabled randomly</summary><br />`--basename`, `--dirname`, `--extname`, `--filename`, `--generate`, `--macos`, `--saves`, `--vimswap`, `--xtdirname`</details><br />
| `--Grow 1`, `-G1` | <br /><details><summary>bases, extensions and full file names</summary><br />`--basename`, `--extname`, `--filename`</details><br />
| `--Grow 2`, `-G2` | <br /><details><summary>file extensions as directories and standalone directories</summary><br />`--dirname`, `--xtdirname`</details><br />
| `--Grow 3`, `-G3` | <br /><details><summary>bases, extensions, full file names, standalone directories and extensions as directories</summary><br />`--basename`, `--extname`, `--filename`, `--dirname`, `--xtdirname`</details><br />
| `--Grow 4`, `-G4` | <br /><details><summary>auto-save and backup file names</summary><br />`--macos`, `--saves`</details><br />
| `--Grow 5`, `-G5` | <br /><details><summary>vim swap file names, one-byte base name appendages and extensions</summary><br />`--generate`, `--vimswap`</details><br />
| `--Grow 6`, `-G6` | <br /><details><summary>`-G4` and `-G5` togther</summary><br />`--macos`, `--saves`, `--generate`, `--vimswap`</details><br />
| `--Grow 7`, `-G7` | <br /><details><summary>combinations and permutations of folders two levels deep with traversals of same depth</summary><br />`--Combos 2`, `--Kperms 2`, `--Traverse 2`</details><br />
| `--Grow 8`, `-G8` | <br /><details><summary>enable each individual flag while passing the value `1` to each set operation</summary><br />`--basename`, `--extname`, `--filename`, `--dirname`, `--xtdirname`, `--macos`, `--saves`, `--generate`, `--vimswap`, `--Combos`, `--Powerset`, `--Kperms`, `--Traverse`</summary> `--basename`, `--extname`, `--filename`, `--dirname`, `--xtdirname`, `--macos`, `--saves`, `--generate`, `--vimswap`, `--Combos`, `--Powerset`, `--Kperms`, `--Traverse`</details><br />

* * *

> Note that depending upon the command-line invocation's combined option flags, the results may still need to be uniqued by piping the output stream to `sort -u`. 

<br />

* * *

<br />

## Related

<br />

### Utilities

* [mortalis13 / List-Folders](https://github.com/mortalis13/List-Folders "Lists files and subfolders of a selected local directory")
> Lists files and subfolders of a selected local directory

* [kdomasze / Folder-List](https://github.com/kdomasze/Folder-List "Lists all files and folders in a directory.")
> Lists all files and folders in a directory.

<br />

* * * 

<br />

### Listers

* [mgeeky / dirbuster](https://github.com/mgeeky/dirbuster "wfuzz, SecLists and john -based dirbusting / forceful browsing script intended to be used during web pentest assingments")
* [DominikSchlecht / WordLGen](https://github.com/DominikSchlecht/WordLGen "A program that combines given words.")
* [sc0tfree / mentalist](https://github.com/sc0tfree/mentalist "Mentalist is a graphical tool for custom wordlist generation. It utilizes common human paradigms for constructing passwords and can output the full wordlist as well as rules compatible with Hashcat and John the Ripper.")
* [BlackArch / wordlistctl](https://github.com/BlackArch/wordlistctl "Fetch, install and search wordlist archives from websites and torrent peers.")
* [imkzh / webwordlist](https://github.com/imkzh/webwordlist "a small wordlist that can be used for learning.")

<br />

* * *

<br />

### Lists

* [fuzzdb-project / fuzzdb](https://github.com/fuzzdb-project/fuzzdb "Dictionary of attack patterns and primitives for black-box application fault injection and resource discovery.")
* [danielmiessler / SecLists](https://github.com/danielmiessler/SecLists "SecLists is the security tester's companion. It's a collection of multiple types of lists used during security assessments, collected in one place. List types include usernames, passwords, URLs, sensitive data patterns, fuzzing payloads, web shells, and many more.")
* [cujanovic / Content-Bruteforcing-Wordlist](https://github.com/cujanovic/Content-Bruteforcing-Wordlist "Wordlist for content(directory) bruteforce discovering with Burp or dirsearch")
* [1N3 / IntruderPayloads](https://github.com/1N3/IntruderPayloads "A collection of Burpsuite Intruder payloads, BurpBounty payloads, fuzz lists, malicious file uploads and web pentesting methodologies and checklists.")
* [decal / werdlists](https://github.com/decal/werdlists "Wordlists, Dictionaries and Other Data Sets for Writing Software Security Test Cases")
* [samduy / path_traversal_payloads.txt](https://gist.github.com/samduy/8034b3227d472968e23f3817612a6729 "List of common path traversal attacks (can be used with BurpSuite Instruder)")

<br />

* * *

<br />

### Busters

* [TomNomNom / meg](https://github.com/tomnomnom/meg "Fetch many paths for many hosts - without killing the hosts")
* [EdOverflow / megplus](https://github.com/EdOverflow/megplus "Automated reconnaissance wrapper — TomNomNom's meg on steroids.")
* [maurosoria / dirsearch](https://github.com/maurosoria/dirsearch "Web path scanner")
* [NoobieDog / Dir-Xcan](https://github.com/NoobieDog/Dir-Xcan "Python version of OWASP's DirBuster Application.")
* [phra / nodebuster](https://github.com/phra/nodebuster "DirBuster for Node.js")

<br />

* * *

<br />
  
## License

`pathgro` is licensed according to version 3 of the [GNU Lesser General Public License](https://www.gnu.org/licenses/lgpl.html). See [`COPYING.txt`](https://github.com/decal/pathgro/blob/master/COPYING.txt "GPLv3") for more information.

  
<br /><p align="right"><img height="20%" width="20%" src="https://raw.githubusercontent.com/decal/pathgro/master/assets/lgplv3-logo.png" name="lgplv3-logo" id="license-logo" alt="[ LGPLv3 ]" title="GNU Lesser General Public License" crossorigin="anonymous" integrity="sha512-P07UklyWF125WUM4hD18LQNbAfeAL4oSqsQhtaNQsWYZpgtsDaUfo4HIIX9OFQepwodXN2w+XA+oVS5LjQfGrA==" /></p>  

