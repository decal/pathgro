<table translate="no" title="PathGro" name="pathgro-table" id="pgtable" style="border-color: yellow; border-collapse: separate; border-spacing: 8px; display: table">
  <tr>
    <td>
      <p align="center">
        <img height="32%" width="32%" src="https://raw.githubusercontent.com/decal/pathgro/master/assets/pathgro-logo.png" alt="PathGro Logo: DirBuster Path Food" crossorigin="anonymous" />
      </p>
    </td>
  </tr>
</table>

## Introduction

`pathgro` takes a brief list of path strings as input and "grows" them into much
larger sets. It is a tool that freely commingles pathname pieces to generate new
omnifarious string mappings. It is designed to maximize attack surface coverage
when testing software components that take pathnames as input, ie. "dirbusting."
It is a set of GNU Guile modules with a command-line interface.

## Examples

General overview of the functionality:

<img height="65%" width="65%" src="https://raw.githubusercontent.com/decal/pathgro/master/assets/pathgro-demo.gif" alt="Terminal Command Line Typescript Demonstrating Execution of PathGro Tool" crossorigin="anonymous" />

Note that `pathgro -C1` and `pathgro -K1` will generate equivalent lists according to their definitions.

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
# don't forget to add ~/.linuxbrew/Cellar/guile/2.x.x/bin to PATH

# clone the reposityory:
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

<img height="50%" width="50%" src="https://raw.githubusercontent.com/decal/pathgro/master/assets/pathgro-usage.png" alt="PathGro Command Line Usage" crossorigin="anonymous" />

## License

`pathgro` is licensed under the GNU Lesser General Public License v3.0. [See COPYING.txt for more information](https://github.com/decal/pathgro/blob/master/COPYING.txt "GPLv3").
