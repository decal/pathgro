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
	@echo export GUILE_LOAD_PATH=${HOME}/pathgro > .pathgrorc
	@echo export PATH=${PATH}:${HOME}/bin
	@echo export PATH=${PATH}:${HOME}/bin >> .pathgrorc
	@echo  
	@echo "You may execute them in your current shell process via:"
	@echo 
	@echo source .pathgrorc
	@echo 

reinstall:
	-scripts/clear-cache
	-scripts/fresh-make
	-pathgro

uninstall:
	-rm -rf ${GUILEINC}/${PROGNAME}
	-rm -rf ${GUILELIB}/${PROGNAME} 
	-rm -f  ${DESTDIR}${PREFIX}/bin/${PROGNAME} 

clean:
	-rm -f ${OBJ} 2>/dev/null

test: testall

testall: testbad testdirs testfiles testpaths testqueries testurls testwords testwww

testpaths:
	-pathgro -b tests/paths.txt
	-pathgro -d tests/paths.txt
	-pathgro -e tests/paths.txt
	-pathgro -f tests/paths.txt
	-pathgro -x tests/paths.txt
	-pathgro -bd tests/paths.txt
	-pathgro -be tests/paths.txt
	-pathgro -bf tests/paths.txt
	-pathgro -bx tests/paths.txt
	-pathgro -de tests/paths.txt
	-pathgro -df tests/paths.txt
	-pathgro -dx tests/paths.txt
	-pathgro -ef tests/paths.txt
	-pathgro -ex tests/paths.txt
	-pathgro -fx tests/paths.txt
	-pathgro -bde tests/paths.txt
	-pathgro -bdf tests/paths.txt
	-pathgro -bdx tests/paths.txt
	-pathgro -def tests/paths.txt
	-pathgro -dex tests/paths.txt
	-pathgro -efx tests/paths.txt
	-pathgro -bdef tests/paths.txt
	-pathgro -bdex tests/paths.txt
	-pathgro -bdefx tests/paths.txt
	-pathgro -bn tests/paths.txt
	-pathgro -dn tests/paths.txt
	-pathgro -en tests/paths.txt
	-pathgro -fn tests/paths.txt
	-pathgro -xn tests/paths.txt
	-pathgro -P1 tests/paths.txt
	-pathgro -bdefxn tests/paths.txt
	-pathgro -C1 tests/paths.txt
	-pathgro -K1 tests/paths.txt
	-pathgro -T1 tests/paths.txt
	-pathgro -T2 tests/paths.txt
	-pathgro -m tests/paths.txt
	-pathgro -v tests/paths.txt
	-pathgro -s tests/paths.txt
	-pathgro -mv tests/paths.txt
	-pathgro -mvs tests/paths.txt
	-pathgro -g tests/paths.txt
	-pathgro --1Grow tests/paths.txt
	-pathgro --2Grow tests/paths.txt
	-pathgro --3Grow tests/paths.txt
	-pathgro --4Grow tests/paths.txt
	-pathgro --5Grow tests/paths.txt
	-pathgro --6Grow tests/paths.txt
	-pathgro --7Grow tests/paths.txt
	-pathgro --8Grow tests/paths.txt

testqueries:
	-pathgro -b tests/queries.txt
	-pathgro -d tests/queries.txt
	-pathgro -e tests/queries.txt
	-pathgro -f tests/queries.txt
	-pathgro -x tests/queries.txt
	-pathgro -bd tests/queries.txt
	-pathgro -be tests/queries.txt
	-pathgro -bf tests/queries.txt
	-pathgro -bx tests/queries.txt
	-pathgro -de tests/queries.txt
	-pathgro -df tests/queries.txt
	-pathgro -dx tests/queries.txt
	-pathgro -ef tests/queries.txt
	-pathgro -ex tests/queries.txt
	-pathgro -fx tests/queries.txt
	-pathgro -bde tests/queries.txt
	-pathgro -bdf tests/queries.txt
	-pathgro -bdx tests/queries.txt
	-pathgro -def tests/queries.txt
	-pathgro -dex tests/queries.txt
	-pathgro -efx tests/queries.txt
	-pathgro -bdef tests/queries.txt
	-pathgro -bdex tests/queries.txt
	-pathgro -bdefx tests/queries.txt
	-pathgro -bn tests/queries.txt
	-pathgro -dn tests/queries.txt
	-pathgro -en tests/queries.txt
	-pathgro -fn tests/queries.txt
	-pathgro -xn tests/queries.txt
	-pathgro -P1 tests/queries.txt
	-pathgro -bdefxn tests/queries.txt
	-pathgro -C1 tests/queries.txt
	-pathgro -K1 tests/queries.txt
	-pathgro -T1 tests/queries.txt
	-pathgro -T2 tests/queries.txt
	-pathgro -m tests/queries.txt
	-pathgro -v tests/queries.txt
	-pathgro -s tests/queries.txt
	-pathgro -mv tests/queries.txt
	-pathgro -mvs tests/queries.txt
	-pathgro -g tests/queries.txt
	-pathgro --1Grow tests/queries.txt
	-pathgro --2Grow tests/queries.txt
	-pathgro --3Grow tests/queries.txt
	-pathgro --4Grow tests/queries.txt
	-pathgro --5Grow tests/queries.txt
	-pathgro --6Grow tests/queries.txt
	-pathgro --7Grow tests/queries.txt
	-pathgro --8Grow tests/queries.txt

testurls:
	-pathgro -b tests/urls.txt
	-pathgro -d tests/urls.txt
	-pathgro -e tests/urls.txt
	-pathgro -f tests/urls.txt
	-pathgro -x tests/urls.txt
	-pathgro -bd tests/urls.txt
	-pathgro -be tests/urls.txt
	-pathgro -bf tests/urls.txt
	-pathgro -bx tests/urls.txt
	-pathgro -de tests/urls.txt
	-pathgro -df tests/urls.txt
	-pathgro -dx tests/urls.txt
	-pathgro -ef tests/urls.txt
	-pathgro -ex tests/urls.txt
	-pathgro -fx tests/urls.txt
	-pathgro -bde tests/urls.txt
	-pathgro -bdf tests/urls.txt
	-pathgro -bdx tests/urls.txt
	-pathgro -def tests/urls.txt
	-pathgro -dex tests/urls.txt
	-pathgro -efx tests/urls.txt
	-pathgro -bdef tests/urls.txt
	-pathgro -bdex tests/urls.txt
	-pathgro -bdefx tests/urls.txt
	-pathgro -bn tests/urls.txt
	-pathgro -dn tests/urls.txt
	-pathgro -en tests/urls.txt
	-pathgro -fn tests/urls.txt
	-pathgro -xn tests/urls.txt
	-pathgro -P1 tests/urls.txt
	-pathgro -bdefxn tests/urls.txt
	-pathgro -C1 tests/urls.txt
	-pathgro -K1 tests/urls.txt
	-pathgro -T1 tests/urls.txt
	-pathgro -T2 tests/urls.txt
	-pathgro -m tests/urls.txt
	-pathgro -v tests/urls.txt
	-pathgro -s tests/urls.txt
	-pathgro -mv tests/urls.txt
	-pathgro -mvs tests/urls.txt
	-pathgro -g tests/urls.txt
	-pathgro --1Grow tests/urls.txt
	-pathgro --2Grow tests/urls.txt
	-pathgro --3Grow tests/urls.txt
	-pathgro --4Grow tests/urls.txt
	-pathgro --5Grow tests/urls.txt
	-pathgro --6Grow tests/urls.txt
	-pathgro --7Grow tests/urls.txt
	-pathgro --8Grow tests/urls.txt

testwww:
	-pathgro -b tests/www.txt
	-pathgro -d tests/www.txt
	-pathgro -e tests/www.txt
	-pathgro -f tests/www.txt
	-pathgro -x tests/www.txt
	-pathgro -bd tests/www.txt
	-pathgro -be tests/www.txt
	-pathgro -bf tests/www.txt
	-pathgro -bx tests/www.txt
	-pathgro -de tests/www.txt
	-pathgro -df tests/www.txt
	-pathgro -dx tests/www.txt
	-pathgro -ef tests/www.txt
	-pathgro -ex tests/www.txt
	-pathgro -fx tests/www.txt
	-pathgro -bde tests/www.txt
	-pathgro -bdf tests/www.txt
	-pathgro -bdx tests/www.txt
	-pathgro -def tests/www.txt
	-pathgro -dex tests/www.txt
	-pathgro -efx tests/www.txt
	-pathgro -bdef tests/www.txt
	-pathgro -bdex tests/www.txt
	-pathgro -bdefx tests/www.txt
	-pathgro -bn tests/www.txt
	-pathgro -dn tests/www.txt
	-pathgro -en tests/www.txt
	-pathgro -fn tests/www.txt
	-pathgro -xn tests/www.txt
	-pathgro -P1 tests/www.txt
	-pathgro -bdefxn tests/www.txt
	-pathgro -C1 tests/www.txt
	-pathgro -K1 tests/www.txt
	-pathgro -T1 tests/www.txt
	-pathgro -T2 tests/www.txt
	-pathgro -m tests/www.txt
	-pathgro -v tests/www.txt
	-pathgro -s tests/www.txt
	-pathgro -mv tests/www.txt
	-pathgro -mvs tests/www.txt
	-pathgro -g tests/www.txt
	-pathgro --1Grow tests/www.txt
	-pathgro --2Grow tests/www.txt
	-pathgro --3Grow tests/www.txt
	-pathgro --4Grow tests/www.txt
	-pathgro --5Grow tests/www.txt
	-pathgro --6Grow tests/www.txt
	-pathgro --7Grow tests/www.txt
	-pathgro --8Grow tests/www.txt

testbad:
	-pathgro -b tests/bad.txt
	-pathgro -d tests/bad.txt
	-pathgro -e tests/bad.txt
	-pathgro -f tests/bad.txt
	-pathgro -x tests/bad.txt
	-pathgro -bd tests/bad.txt
	-pathgro -be tests/bad.txt
	-pathgro -bf tests/bad.txt
	-pathgro -bx tests/bad.txt
	-pathgro -de tests/bad.txt
	-pathgro -df tests/bad.txt
	-pathgro -dx tests/bad.txt
	-pathgro -ef tests/bad.txt
	-pathgro -ex tests/bad.txt
	-pathgro -fx tests/bad.txt
	-pathgro -bde tests/bad.txt
	-pathgro -bdf tests/bad.txt
	-pathgro -bdx tests/bad.txt
	-pathgro -def tests/bad.txt
	-pathgro -dex tests/bad.txt
	-pathgro -efx tests/bad.txt
	-pathgro -bdef tests/bad.txt
	-pathgro -bdex tests/bad.txt
	-pathgro -bdefx tests/bad.txt
	-pathgro -bn tests/bad.txt
	-pathgro -dn tests/bad.txt
	-pathgro -en tests/bad.txt
	-pathgro -fn tests/bad.txt
	-pathgro -xn tests/bad.txt
	-pathgro -P1 tests/bad.txt
	-pathgro -bdefxn tests/bad.txt
	-pathgro -C1 tests/bad.txt
	-pathgro -K1 tests/bad.txt
	-pathgro -T1 tests/bad.txt
	-pathgro -T2 tests/bad.txt
	-pathgro -m tests/bad.txt
	-pathgro -v tests/bad.txt
	-pathgro -s tests/bad.txt
	-pathgro -mv tests/bad.txt
	-pathgro -mvs tests/bad.txt
	-pathgro -g tests/bad.txt
	-pathgro --1Grow tests/bad.txt
	-pathgro --2Grow tests/bad.txt
	-pathgro --3Grow tests/bad.txt
	-pathgro --4Grow tests/bad.txt
	-pathgro --5Grow tests/bad.txt
	-pathgro --6Grow tests/bad.txt
	-pathgro --7Grow tests/bad.txt
	-pathgro --8Grow tests/bad.txt

testfiles:
	-pathgro -b tests/files.txt
	-pathgro -d tests/files.txt
	-pathgro -e tests/files.txt
	-pathgro -f tests/files.txt
	-pathgro -x tests/files.txt
	-pathgro -bd tests/files.txt
	-pathgro -be tests/files.txt
	-pathgro -bf tests/files.txt
	-pathgro -bx tests/files.txt
	-pathgro -de tests/files.txt
	-pathgro -df tests/files.txt
	-pathgro -dx tests/files.txt
	-pathgro -ef tests/files.txt
	-pathgro -ex tests/files.txt
	-pathgro -fx tests/files.txt
	-pathgro -bde tests/files.txt
	-pathgro -bdf tests/files.txt
	-pathgro -bdx tests/files.txt
	-pathgro -def tests/files.txt
	-pathgro -dex tests/files.txt
	-pathgro -efx tests/files.txt
	-pathgro -bdef tests/files.txt
	-pathgro -bdex tests/files.txt
	-pathgro -bdefx tests/files.txt
	-pathgro -bn tests/files.txt
	-pathgro -dn tests/files.txt
	-pathgro -en tests/files.txt
	-pathgro -fn tests/files.txt
	-pathgro -xn tests/files.txt
	-pathgro -P1 tests/files.txt
	-pathgro -bdefxn tests/files.txt
	-pathgro -C1 tests/files.txt
	-pathgro -K1 tests/files.txt
	-pathgro -T1 tests/files.txt
	-pathgro -T2 tests/files.txt
	-pathgro -m tests/files.txt
	-pathgro -v tests/files.txt
	-pathgro -s tests/files.txt
	-pathgro -mv tests/files.txt
	-pathgro -mvs tests/files.txt
	-pathgro -g tests/files.txt
	-pathgro --1Grow tests/files.txt
	-pathgro --2Grow tests/files.txt
	-pathgro --3Grow tests/files.txt
	-pathgro --4Grow tests/files.txt
	-pathgro --5Grow tests/files.txt
	-pathgro --6Grow tests/files.txt
	-pathgro --7Grow tests/files.txt
	-pathgro --8Grow tests/files.txt

testdirs:
	-pathgro -b tests/dirs.txt
	-pathgro -d tests/dirs.txt
	-pathgro -e tests/dirs.txt
	-pathgro -f tests/dirs.txt
	-pathgro -x tests/dirs.txt
	-pathgro -bd tests/dirs.txt
	-pathgro -be tests/dirs.txt
	-pathgro -bf tests/dirs.txt
	-pathgro -bx tests/dirs.txt
	-pathgro -de tests/dirs.txt
	-pathgro -df tests/dirs.txt
	-pathgro -dx tests/dirs.txt
	-pathgro -ef tests/dirs.txt
	-pathgro -ex tests/dirs.txt
	-pathgro -fx tests/dirs.txt
	-pathgro -bde tests/dirs.txt
	-pathgro -bdf tests/dirs.txt
	-pathgro -bdx tests/dirs.txt
	-pathgro -def tests/dirs.txt
	-pathgro -dex tests/dirs.txt
	-pathgro -efx tests/dirs.txt
	-pathgro -bdef tests/dirs.txt
	-pathgro -bdex tests/dirs.txt
	-pathgro -bdefx tests/dirs.txt
	-pathgro -bn tests/dirs.txt
	-pathgro -dn tests/dirs.txt
	-pathgro -en tests/dirs.txt
	-pathgro -fn tests/dirs.txt
	-pathgro -xn tests/dirs.txt
	-pathgro -P1 tests/dirs.txt
	-pathgro -bdefxn tests/dirs.txt
	-pathgro -C1 tests/dirs.txt
	-pathgro -K1 tests/dirs.txt
	-pathgro -T1 tests/dirs.txt
	-pathgro -T2 tests/dirs.txt
	-pathgro -m tests/dirs.txt
	-pathgro -v tests/dirs.txt
	-pathgro -s tests/dirs.txt
	-pathgro -mv tests/dirs.txt
	-pathgro -mvs tests/dirs.txt
	-pathgro -g tests/dirs.txt
	-pathgro --1Grow tests/dirs.txt
	-pathgro --2Grow tests/dirs.txt
	-pathgro --3Grow tests/dirs.txt
	-pathgro --4Grow tests/dirs.txt
	-pathgro --5Grow tests/dirs.txt
	-pathgro --6Grow tests/dirs.txt
	-pathgro --7Grow tests/dirs.txt
	-pathgro --8Grow tests/dirs.txt

testwords:
	-pathgro -b tests/words.txt
	-pathgro -d tests/words.txt
	-pathgro -e tests/words.txt
	-pathgro -f tests/words.txt
	-pathgro -x tests/words.txt
	-pathgro -bd tests/words.txt
	-pathgro -be tests/words.txt
	-pathgro -bf tests/words.txt
	-pathgro -bx tests/words.txt
	-pathgro -de tests/words.txt
	-pathgro -df tests/words.txt
	-pathgro -dx tests/words.txt
	-pathgro -ef tests/words.txt
	-pathgro -ex tests/words.txt
	-pathgro -fx tests/words.txt
	-pathgro -bde tests/words.txt
	-pathgro -bdf tests/words.txt
	-pathgro -bdx tests/words.txt
	-pathgro -def tests/words.txt
	-pathgro -dex tests/words.txt
	-pathgro -efx tests/words.txt
	-pathgro -bdef tests/words.txt
	-pathgro -bdex tests/words.txt
	-pathgro -bdefx tests/words.txt
	-pathgro -bn tests/words.txt
	-pathgro -dn tests/words.txt
	-pathgro -en tests/words.txt
	-pathgro -fn tests/words.txt
	-pathgro -xn tests/words.txt
	-pathgro -P1 tests/words.txt
	-pathgro -bdefxn tests/words.txt
	-pathgro -C1 tests/words.txt
	-pathgro -K1 tests/words.txt
	-pathgro -T1 tests/words.txt
	-pathgro -T2 tests/words.txt
	-pathgro -m tests/words.txt
	-pathgro -v tests/words.txt
	-pathgro -s tests/words.txt
	-pathgro -mv tests/words.txt
	-pathgro -mvs tests/words.txt
	-pathgro -g tests/words.txt
	-pathgro --1Grow tests/words.txt
	-pathgro --2Grow tests/words.txt
	-pathgro --3Grow tests/words.txt
	-pathgro --4Grow tests/words.txt
	-pathgro --5Grow tests/words.txt
	-pathgro --6Grow tests/words.txt
	-pathgro --7Grow tests/words.txt
	-pathgro --8Grow tests/words.txt
