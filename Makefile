# Copyright © 2019 Derek Callaway
#
# This file is part of pathgro.
#
# This program comes with ABSOLUTELY NO WARRANTY. It is free software and you 
# are welcome to redistribute it under certain conditions. See the COPYING.txt
# file in the root directory of the source repository for details.
#
# You should have received a copy of the GNU General Public License
# along with pathgro. If not, see <https://www.gnu.org/licenses/>.
# 

PROGNAME := pathgro

PREFIX := ${HOME}

SCRIPTDIR := scripts

CONFIG         := pathgro.conf
CONFIG_DESTDIR := ${HOME}/share

GUILEINC := ${DESTDIR}$(shell guile -c "(display (%site-dir))")
GUILELIB := ${DESTDIR}$(shell guile -c "(display (%site-ccache-dir))")

GUILEC := guild compile

SUBDIRS := $(shell find ${PROGNAME} -type d -print)
SRC := $(foreach subdir, ${SUBDIRS}, $(wildcard ${subdir}/*.scm))
OBJ := ${SRC:.scm=.go}

.SILENT: OBJ

export GUILE_AUTO_COMPILE = 0
export GUILE_LOAD_PATH = ${CURDIR}

OBJ: ${SRC}
	$(foreach object, ${OBJ}, ${GUILEC} -o ${object} ${object:.go=.scm} 2>/dev/null;)

all:
	${OBJ}

install:
#	@mkdir -p ${GUILEINC}
#	@echo installing source files in ${GUILEINC}/${PROGNAME}
#	@cp -a ${SRC} ${GUILEINC}
	
#	@mkdir -p ${GUILELIB}
#	@echo installing object files in ${GUILELIB}/${PROGNAME}
#	@cp -a ${OBJ} ${GUILELIB}

	@echo
	@echo "Installing object files in ${HOME}/pathgro"
	@echo 
	@cp -av -- pathgro "${HOME}/pathgro"
	@chmod -- 0700 "${HOME}/pathgro"
	
	@mkdir -p -- "${HOME}/bin"
	@chmod -- 0700 "${HOME}/bin"
	@echo 
	@echo "Installing executable script from ${SCRIPTDIR}/${PROGNAME} into ${HOME}/bin"
	@cp -a -- "${SCRIPTDIR}/${PROGNAME}" "${HOME}/bin"
	@echo
	@echo "Don't forget to add these statements to your shell initialization:"
	@echo
	@echo export GUILE_LOAD_PATH=${HOME}/pathgro
	@echo export PATH=${PATH}:${HOME}/bin
	@echo 

uninstall:
	-rm -rf ${GUILEINC}/${PROGNAME}
	-rm -rf ${GUILELIB}/${PROGNAME} 
	-rm -f  ${DESTDIR}${PREFIX}/bin/${PROGNAME} 

clean:
	-rm -f ${OBJ} 2>/dev/null

test: testall

testall: testbad testdirs testfiles testpaths testqueries testurls testwords testwww

testpaths:
	-pathgro -b tests/test-paths.txt
	-pathgro -d tests/test-paths.txt
	-pathgro -e tests/test-paths.txt
	-pathgro -f tests/test-paths.txt
	-pathgro -x tests/test-paths.txt
	-pathgro -bd tests/test-paths.txt
	-pathgro -be tests/test-paths.txt
	-pathgro -bf tests/test-paths.txt
	-pathgro -bx tests/test-paths.txt
	-pathgro -de tests/test-paths.txt
	-pathgro -df tests/test-paths.txt
	-pathgro -dx tests/test-paths.txt
	-pathgro -ef tests/test-paths.txt
	-pathgro -ex tests/test-paths.txt
	-pathgro -fx tests/test-paths.txt
	-pathgro -bde tests/test-paths.txt
	-pathgro -bdf tests/test-paths.txt
	-pathgro -bdx tests/test-paths.txt
	-pathgro -def tests/test-paths.txt
	-pathgro -dex tests/test-paths.txt
	-pathgro -efx tests/test-paths.txt
	-pathgro -bdef tests/test-paths.txt
	-pathgro -bdex tests/test-paths.txt
	-pathgro -bdefx tests/test-paths.txt
	-pathgro -bn tests/test-paths.txt
	-pathgro -dn tests/test-paths.txt
	-pathgro -en tests/test-paths.txt
	-pathgro -fn tests/test-paths.txt
	-pathgro -xn tests/test-paths.txt
	-pathgro -P1 tests/test-paths.txt
	-pathgro -bdefxn tests/test-paths.txt
	-pathgro -C1 tests/test-paths.txt
	-pathgro -K1 tests/test-paths.txt
	-pathgro -T1 tests/test-paths.txt
	-pathgro -T2 tests/test-paths.txt
	-pathgro -m tests/test-paths.txt
	-pathgro -v tests/test-paths.txt
	-pathgro -s tests/test-paths.txt
	-pathgro -mv tests/test-paths.txt
	-pathgro -mvs tests/test-paths.txt
	-pathgro -g tests/test-paths.txt
	-pathgro --1Grow tests/test-paths.txt
	-pathgro --2Grow tests/test-paths.txt
	-pathgro --3Grow tests/test-paths.txt
	-pathgro --4Grow tests/test-paths.txt
	-pathgro --5Grow tests/test-paths.txt
	-pathgro --6Grow tests/test-paths.txt
	-pathgro --7Grow tests/test-paths.txt
	-pathgro --8Grow tests/test-paths.txt

testqueries:
	-pathgro -b tests/test-queries.txt
	-pathgro -d tests/test-queries.txt
	-pathgro -e tests/test-queries.txt
	-pathgro -f tests/test-queries.txt
	-pathgro -x tests/test-queries.txt
	-pathgro -bd tests/test-queries.txt
	-pathgro -be tests/test-queries.txt
	-pathgro -bf tests/test-queries.txt
	-pathgro -bx tests/test-queries.txt
	-pathgro -de tests/test-queries.txt
	-pathgro -df tests/test-queries.txt
	-pathgro -dx tests/test-queries.txt
	-pathgro -ef tests/test-queries.txt
	-pathgro -ex tests/test-queries.txt
	-pathgro -fx tests/test-queries.txt
	-pathgro -bde tests/test-queries.txt
	-pathgro -bdf tests/test-queries.txt
	-pathgro -bdx tests/test-queries.txt
	-pathgro -def tests/test-queries.txt
	-pathgro -dex tests/test-queries.txt
	-pathgro -efx tests/test-queries.txt
	-pathgro -bdef tests/test-queries.txt
	-pathgro -bdex tests/test-queries.txt
	-pathgro -bdefx tests/test-queries.txt
	-pathgro -bn tests/test-queries.txt
	-pathgro -dn tests/test-queries.txt
	-pathgro -en tests/test-queries.txt
	-pathgro -fn tests/test-queries.txt
	-pathgro -xn tests/test-queries.txt
	-pathgro -P1 tests/test-queries.txt
	-pathgro -bdefxn tests/test-queries.txt
	-pathgro -C1 tests/test-queries.txt
	-pathgro -K1 tests/test-queries.txt
	-pathgro -T1 tests/test-queries.txt
	-pathgro -T2 tests/test-queries.txt
	-pathgro -m tests/test-queries.txt
	-pathgro -v tests/test-queries.txt
	-pathgro -s tests/test-queries.txt
	-pathgro -mv tests/test-queries.txt
	-pathgro -mvs tests/test-queries.txt
	-pathgro -g tests/test-queries.txt
	-pathgro --1Grow tests/test-queries.txt
	-pathgro --2Grow tests/test-queries.txt
	-pathgro --3Grow tests/test-queries.txt
	-pathgro --4Grow tests/test-queries.txt
	-pathgro --5Grow tests/test-queries.txt
	-pathgro --6Grow tests/test-queries.txt
	-pathgro --7Grow tests/test-queries.txt
	-pathgro --8Grow tests/test-queries.txt

testurls:
	-pathgro -b tests/test-urls.txt
	-pathgro -d tests/test-urls.txt
	-pathgro -e tests/test-urls.txt
	-pathgro -f tests/test-urls.txt
	-pathgro -x tests/test-urls.txt
	-pathgro -bd tests/test-urls.txt
	-pathgro -be tests/test-urls.txt
	-pathgro -bf tests/test-urls.txt
	-pathgro -bx tests/test-urls.txt
	-pathgro -de tests/test-urls.txt
	-pathgro -df tests/test-urls.txt
	-pathgro -dx tests/test-urls.txt
	-pathgro -ef tests/test-urls.txt
	-pathgro -ex tests/test-urls.txt
	-pathgro -fx tests/test-urls.txt
	-pathgro -bde tests/test-urls.txt
	-pathgro -bdf tests/test-urls.txt
	-pathgro -bdx tests/test-urls.txt
	-pathgro -def tests/test-urls.txt
	-pathgro -dex tests/test-urls.txt
	-pathgro -efx tests/test-urls.txt
	-pathgro -bdef tests/test-urls.txt
	-pathgro -bdex tests/test-urls.txt
	-pathgro -bdefx tests/test-urls.txt
	-pathgro -bn tests/test-urls.txt
	-pathgro -dn tests/test-urls.txt
	-pathgro -en tests/test-urls.txt
	-pathgro -fn tests/test-urls.txt
	-pathgro -xn tests/test-urls.txt
	-pathgro -P1 tests/test-urls.txt
	-pathgro -bdefxn tests/test-urls.txt
	-pathgro -C1 tests/test-urls.txt
	-pathgro -K1 tests/test-urls.txt
	-pathgro -T1 tests/test-urls.txt
	-pathgro -T2 tests/test-urls.txt
	-pathgro -m tests/test-urls.txt
	-pathgro -v tests/test-urls.txt
	-pathgro -s tests/test-urls.txt
	-pathgro -mv tests/test-urls.txt
	-pathgro -mvs tests/test-urls.txt
	-pathgro -g tests/test-urls.txt
	-pathgro --1Grow tests/test-urls.txt
	-pathgro --2Grow tests/test-urls.txt
	-pathgro --3Grow tests/test-urls.txt
	-pathgro --4Grow tests/test-urls.txt
	-pathgro --5Grow tests/test-urls.txt
	-pathgro --6Grow tests/test-urls.txt
	-pathgro --7Grow tests/test-urls.txt
	-pathgro --8Grow tests/test-urls.txt

testwww:
	-pathgro -b tests/test-www.txt
	-pathgro -d tests/test-www.txt
	-pathgro -e tests/test-www.txt
	-pathgro -f tests/test-www.txt
	-pathgro -x tests/test-www.txt
	-pathgro -bd tests/test-www.txt
	-pathgro -be tests/test-www.txt
	-pathgro -bf tests/test-www.txt
	-pathgro -bx tests/test-www.txt
	-pathgro -de tests/test-www.txt
	-pathgro -df tests/test-www.txt
	-pathgro -dx tests/test-www.txt
	-pathgro -ef tests/test-www.txt
	-pathgro -ex tests/test-www.txt
	-pathgro -fx tests/test-www.txt
	-pathgro -bde tests/test-www.txt
	-pathgro -bdf tests/test-www.txt
	-pathgro -bdx tests/test-www.txt
	-pathgro -def tests/test-www.txt
	-pathgro -dex tests/test-www.txt
	-pathgro -efx tests/test-www.txt
	-pathgro -bdef tests/test-www.txt
	-pathgro -bdex tests/test-www.txt
	-pathgro -bdefx tests/test-www.txt
	-pathgro -bn tests/test-www.txt
	-pathgro -dn tests/test-www.txt
	-pathgro -en tests/test-www.txt
	-pathgro -fn tests/test-www.txt
	-pathgro -xn tests/test-www.txt
	-pathgro -P1 tests/test-www.txt
	-pathgro -bdefxn tests/test-www.txt
	-pathgro -C1 tests/test-www.txt
	-pathgro -K1 tests/test-www.txt
	-pathgro -T1 tests/test-www.txt
	-pathgro -T2 tests/test-www.txt
	-pathgro -m tests/test-www.txt
	-pathgro -v tests/test-www.txt
	-pathgro -s tests/test-www.txt
	-pathgro -mv tests/test-www.txt
	-pathgro -mvs tests/test-www.txt
	-pathgro -g tests/test-www.txt
	-pathgro --1Grow tests/test-www.txt
	-pathgro --2Grow tests/test-www.txt
	-pathgro --3Grow tests/test-www.txt
	-pathgro --4Grow tests/test-www.txt
	-pathgro --5Grow tests/test-www.txt
	-pathgro --6Grow tests/test-www.txt
	-pathgro --7Grow tests/test-www.txt
	-pathgro --8Grow tests/test-www.txt

testbad:
	-pathgro -b tests/test-bad.txt
	-pathgro -d tests/test-bad.txt
	-pathgro -e tests/test-bad.txt
	-pathgro -f tests/test-bad.txt
	-pathgro -x tests/test-bad.txt
	-pathgro -bd tests/test-bad.txt
	-pathgro -be tests/test-bad.txt
	-pathgro -bf tests/test-bad.txt
	-pathgro -bx tests/test-bad.txt
	-pathgro -de tests/test-bad.txt
	-pathgro -df tests/test-bad.txt
	-pathgro -dx tests/test-bad.txt
	-pathgro -ef tests/test-bad.txt
	-pathgro -ex tests/test-bad.txt
	-pathgro -fx tests/test-bad.txt
	-pathgro -bde tests/test-bad.txt
	-pathgro -bdf tests/test-bad.txt
	-pathgro -bdx tests/test-bad.txt
	-pathgro -def tests/test-bad.txt
	-pathgro -dex tests/test-bad.txt
	-pathgro -efx tests/test-bad.txt
	-pathgro -bdef tests/test-bad.txt
	-pathgro -bdex tests/test-bad.txt
	-pathgro -bdefx tests/test-bad.txt
	-pathgro -bn tests/test-bad.txt
	-pathgro -dn tests/test-bad.txt
	-pathgro -en tests/test-bad.txt
	-pathgro -fn tests/test-bad.txt
	-pathgro -xn tests/test-bad.txt
	-pathgro -P1 tests/test-bad.txt
	-pathgro -bdefxn tests/test-bad.txt
	-pathgro -C1 tests/test-bad.txt
	-pathgro -K1 tests/test-bad.txt
	-pathgro -T1 tests/test-bad.txt
	-pathgro -T2 tests/test-bad.txt
	-pathgro -m tests/test-bad.txt
	-pathgro -v tests/test-bad.txt
	-pathgro -s tests/test-bad.txt
	-pathgro -mv tests/test-bad.txt
	-pathgro -mvs tests/test-bad.txt
	-pathgro -g tests/test-bad.txt
	-pathgro --1Grow tests/test-bad.txt
	-pathgro --2Grow tests/test-bad.txt
	-pathgro --3Grow tests/test-bad.txt
	-pathgro --4Grow tests/test-bad.txt
	-pathgro --5Grow tests/test-bad.txt
	-pathgro --6Grow tests/test-bad.txt
	-pathgro --7Grow tests/test-bad.txt
	-pathgro --8Grow tests/test-bad.txt

testfiles:
	-pathgro -b tests/test-files.txt
	-pathgro -d tests/test-files.txt
	-pathgro -e tests/test-files.txt
	-pathgro -f tests/test-files.txt
	-pathgro -x tests/test-files.txt
	-pathgro -bd tests/test-files.txt
	-pathgro -be tests/test-files.txt
	-pathgro -bf tests/test-files.txt
	-pathgro -bx tests/test-files.txt
	-pathgro -de tests/test-files.txt
	-pathgro -df tests/test-files.txt
	-pathgro -dx tests/test-files.txt
	-pathgro -ef tests/test-files.txt
	-pathgro -ex tests/test-files.txt
	-pathgro -fx tests/test-files.txt
	-pathgro -bde tests/test-files.txt
	-pathgro -bdf tests/test-files.txt
	-pathgro -bdx tests/test-files.txt
	-pathgro -def tests/test-files.txt
	-pathgro -dex tests/test-files.txt
	-pathgro -efx tests/test-files.txt
	-pathgro -bdef tests/test-files.txt
	-pathgro -bdex tests/test-files.txt
	-pathgro -bdefx tests/test-files.txt
	-pathgro -bn tests/test-files.txt
	-pathgro -dn tests/test-files.txt
	-pathgro -en tests/test-files.txt
	-pathgro -fn tests/test-files.txt
	-pathgro -xn tests/test-files.txt
	-pathgro -P1 tests/test-files.txt
	-pathgro -bdefxn tests/test-files.txt
	-pathgro -C1 tests/test-files.txt
	-pathgro -K1 tests/test-files.txt
	-pathgro -T1 tests/test-files.txt
	-pathgro -T2 tests/test-files.txt
	-pathgro -m tests/test-files.txt
	-pathgro -v tests/test-files.txt
	-pathgro -s tests/test-files.txt
	-pathgro -mv tests/test-files.txt
	-pathgro -mvs tests/test-files.txt
	-pathgro -g tests/test-files.txt
	-pathgro --1Grow tests/test-files.txt
	-pathgro --2Grow tests/test-files.txt
	-pathgro --3Grow tests/test-files.txt
	-pathgro --4Grow tests/test-files.txt
	-pathgro --5Grow tests/test-files.txt
	-pathgro --6Grow tests/test-files.txt
	-pathgro --7Grow tests/test-files.txt
	-pathgro --8Grow tests/test-files.txt

testdirs:
	-pathgro -b tests/test-dirs.txt
	-pathgro -d tests/test-dirs.txt
	-pathgro -e tests/test-dirs.txt
	-pathgro -f tests/test-dirs.txt
	-pathgro -x tests/test-dirs.txt
	-pathgro -bd tests/test-dirs.txt
	-pathgro -be tests/test-dirs.txt
	-pathgro -bf tests/test-dirs.txt
	-pathgro -bx tests/test-dirs.txt
	-pathgro -de tests/test-dirs.txt
	-pathgro -df tests/test-dirs.txt
	-pathgro -dx tests/test-dirs.txt
	-pathgro -ef tests/test-dirs.txt
	-pathgro -ex tests/test-dirs.txt
	-pathgro -fx tests/test-dirs.txt
	-pathgro -bde tests/test-dirs.txt
	-pathgro -bdf tests/test-dirs.txt
	-pathgro -bdx tests/test-dirs.txt
	-pathgro -def tests/test-dirs.txt
	-pathgro -dex tests/test-dirs.txt
	-pathgro -efx tests/test-dirs.txt
	-pathgro -bdef tests/test-dirs.txt
	-pathgro -bdex tests/test-dirs.txt
	-pathgro -bdefx tests/test-dirs.txt
	-pathgro -bn tests/test-dirs.txt
	-pathgro -dn tests/test-dirs.txt
	-pathgro -en tests/test-dirs.txt
	-pathgro -fn tests/test-dirs.txt
	-pathgro -xn tests/test-dirs.txt
	-pathgro -P1 tests/test-dirs.txt
	-pathgro -bdefxn tests/test-dirs.txt
	-pathgro -C1 tests/test-dirs.txt
	-pathgro -K1 tests/test-dirs.txt
	-pathgro -T1 tests/test-dirs.txt
	-pathgro -T2 tests/test-dirs.txt
	-pathgro -m tests/test-dirs.txt
	-pathgro -v tests/test-dirs.txt
	-pathgro -s tests/test-dirs.txt
	-pathgro -mv tests/test-dirs.txt
	-pathgro -mvs tests/test-dirs.txt
	-pathgro -g tests/test-dirs.txt
	-pathgro --1Grow tests/test-dirs.txt
	-pathgro --2Grow tests/test-dirs.txt
	-pathgro --3Grow tests/test-dirs.txt
	-pathgro --4Grow tests/test-dirs.txt
	-pathgro --5Grow tests/test-dirs.txt
	-pathgro --6Grow tests/test-dirs.txt
	-pathgro --7Grow tests/test-dirs.txt
	-pathgro --8Grow tests/test-dirs.txt

testwords:
	-pathgro -b tests/test-words.txt
	-pathgro -d tests/test-words.txt
	-pathgro -e tests/test-words.txt
	-pathgro -f tests/test-words.txt
	-pathgro -x tests/test-words.txt
	-pathgro -bd tests/test-words.txt
	-pathgro -be tests/test-words.txt
	-pathgro -bf tests/test-words.txt
	-pathgro -bx tests/test-words.txt
	-pathgro -de tests/test-words.txt
	-pathgro -df tests/test-words.txt
	-pathgro -dx tests/test-words.txt
	-pathgro -ef tests/test-words.txt
	-pathgro -ex tests/test-words.txt
	-pathgro -fx tests/test-words.txt
	-pathgro -bde tests/test-words.txt
	-pathgro -bdf tests/test-words.txt
	-pathgro -bdx tests/test-words.txt
	-pathgro -def tests/test-words.txt
	-pathgro -dex tests/test-words.txt
	-pathgro -efx tests/test-words.txt
	-pathgro -bdef tests/test-words.txt
	-pathgro -bdex tests/test-words.txt
	-pathgro -bdefx tests/test-words.txt
	-pathgro -bn tests/test-words.txt
	-pathgro -dn tests/test-words.txt
	-pathgro -en tests/test-words.txt
	-pathgro -fn tests/test-words.txt
	-pathgro -xn tests/test-words.txt
	-pathgro -P1 tests/test-words.txt
	-pathgro -bdefxn tests/test-words.txt
	-pathgro -C1 tests/test-words.txt
	-pathgro -K1 tests/test-words.txt
	-pathgro -T1 tests/test-words.txt
	-pathgro -T2 tests/test-words.txt
	-pathgro -m tests/test-words.txt
	-pathgro -v tests/test-words.txt
	-pathgro -s tests/test-words.txt
	-pathgro -mv tests/test-words.txt
	-pathgro -mvs tests/test-words.txt
	-pathgro -g tests/test-words.txt
	-pathgro --1Grow tests/test-words.txt
	-pathgro --2Grow tests/test-words.txt
	-pathgro --3Grow tests/test-words.txt
	-pathgro --4Grow tests/test-words.txt
	-pathgro --5Grow tests/test-words.txt
	-pathgro --6Grow tests/test-words.txt
	-pathgro --7Grow tests/test-words.txt
	-pathgro --8Grow tests/test-words.txt
