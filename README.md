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
| `--0Grow`, `-0` | <details><summary>each command-line flag has a 50% chance of being enabled randomly</summary><br />`--basename`, `--dirname`, `--extname`, `--filename`, `--generate`, `--macos`, `--saves`, `--vimswap`, `--xtdirname`</details>
| `--1Grow`, `-1` | <details><summary>bases, extensions and full file names</summary>`--basename`, `--extname`, `--filename`</details>
| `--2Grow`, `-2` | <details><summary>file extensions as directories and standalone directories</summary>`--dirname`, `--xtdirname`</details>
| `--3Grow`, `-3` | <details><summary>bases, extensions, full file names, standalone directories and extensions as directories</summary>`--basename`, `--extname`, `--filename`, `--dirname`, `--xtdirname`</details> 
| `--4Grow`, `-4` | <details><summary>auto-save and backup file names</summary>`--macos`, `--saves`</details>
| `--5Grow`, `-5` | <details><summary>vim swap file names, one-byte base name appendages and extensions</summary>`--generate`, `--vimswap`</details>
| `--6Grow`, `-6` | <details><summary>`--4Grow` and `--5Grow` togther</summary>`--macos`, `--saves`, `--generate`, `--vimswap`</details>
| `--7Grow`, `-7` | <details><summary>combinations and permutations of folders two levels deep with traversals of same depth</summary>`--Combos 2`, `--Kperms 2`, `--Traverse 2`</details>
| `--8Grow`, `-8` | <details><summary>enable each individual flag while passing the value `1` to each set operation</summary>`--basename`, `--extname`, `--filename`, `--dirname`, `--xtdirname`, `--macos`, `--saves`, `--generate`, `--vimswap`, `--Combos`, `--Powerset`, `--Kperms`, `--Traverse`</summary> `--basename`, `--extname`, `--filename`, `--dirname`, `--xtdirname`, `--macos`, `--saves`, `--generate`, `--vimswap`, `--Combos`, `--Powerset`, `--Kperms`, `--Traverse`</details>

* * *

> Note that depending upon the command-line invocation's combined option flags, the results may still need to be uniqued by piping the output stream to `sort -u`. 

* * *

## Related

* [mgeeky / dirbuster](https://github.com/mgeeky/dirbuster "wfuzz, SecLists and john -based dirbusting / forceful browsing script intended to be used during web pentest assingments")

* * *

<br />
  
## License

`pathgro` is licensed under version 3 of the [GNU Lesser General Public License](https://www.gnu.org/licenses/lgpl.html). See [`COPYING.txt`](https://github.com/decal/pathgro/blob/master/COPYING.txt "GPLv3") for more information.

  
<br /><p align="right"><img height="20%" width="20%" src="https://raw.githubusercontent.com/decal/pathgro/master/assets/lgplv3-logo.png" name="lgplv3-logo" id="license-logo" alt="[ LGPLv3 ]" title="GNU Lesser General Public License" crossorigin="anonymous" integrity="sha512-P07UklyWF125WUM4hD18LQNbAfeAL4oSqsQhtaNQsWYZpgtsDaUfo4HIIX9OFQepwodXN2w+XA+oVS5LjQfGrA==" /></p>  

