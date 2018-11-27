# Copyright © 2018 Derek Callaway
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

	@echo "installing object files in ${HOME}/pathgro"
	@echo "This environment variable assignment must be in your shell initialization: GUILE_LOAD_PATH=\"$HOME/pathgro\""
	@cp -av -- pathgro "${HOME}/pathgro"
	@chmod -- 0700 "${HOME}/pathgro"
	
	@mkdir -p -- "${HOME}/bin"
	@chmod -- 0700 "${HOME}/bin"
	@echo installing executable script in ${HOME}/bin
	@cp -a -- "${SCRIPTDIR}/${PROGNAME}" "${HOME}/bin"

uninstall:
	@rm -rf ${GUILEINC}/${PROGNAME}
	@rm -rf ${GUILELIB}/${PROGNAME}
	@rm -f  ${DESTDIR}${PREFIX}/bin/${PROGNAME}
	#@rm -rf ${CONFIG_DESTDIR}

clean:
	@rm ${OBJ}

test:
	-scripts/pathgro -b tests/test-paths.txt
	-scripts/pathgro -d tests/test-paths.txt
	-scripts/pathgro -e tests/test-paths.txt
	-scripts/pathgro -f tests/test-paths.txt
	-scripts/pathgro -x tests/test-paths.txt
	-scripts/pathgro -bd tests/test-paths.txt
	-scripts/pathgro -be tests/test-paths.txt
	-scripts/pathgro -bf tests/test-paths.txt
	-scripts/pathgro -bx tests/test-paths.txt
	-scripts/pathgro -de tests/test-paths.txt
	-scripts/pathgro -df tests/test-paths.txt
	-scripts/pathgro -dx tests/test-paths.txt
	-scripts/pathgro -ef tests/test-paths.txt
	-scripts/pathgro -ex tests/test-paths.txt
	-scripts/pathgro -fx tests/test-paths.txt
	-scripts/pathgro -bde tests/test-paths.txt
	-scripts/pathgro -bdf tests/test-paths.txt
	-scripts/pathgro -bdx tests/test-paths.txt
	-scripts/pathgro -def tests/test-paths.txt
	-scripts/pathgro -dex tests/test-paths.txt
	-scripts/pathgro -efx tests/test-paths.txt
	-scripts/pathgro -bdef tests/test-paths.txt
	-scripts/pathgro -bdex tests/test-paths.txt
	-scripts/pathgro -bdefx tests/test-paths.txt
	-scripts/pathgro -bn tests/test-paths.txt
	-scripts/pathgro -dn tests/test-paths.txt
	-scripts/pathgro -en tests/test-paths.txt
	-scripts/pathgro -fn tests/test-paths.txt
	-scripts/pathgro -xn tests/test-paths.txt
	-scripts/pathgro -P1 tests/test-paths.txt
	-scripts/pathgro -bdefxn tests/test-paths.txt
	-scripts/pathgro -C1 tests/test-paths.txt
	-scripts/pathgro -K1 tests/test-paths.txt
	-scripts/pathgro -T1 tests/test-paths.txt
	-scripts/pathgro -T2 tests/test-paths.txt
	-scripts/pathgro -m tests/test-paths.txt
	-scripts/pathgro -v tests/test-paths.txt
	-scripts/pathgro -s tests/test-paths.txt
	-scripts/pathgro -mv tests/test-paths.txt
	-scripts/pathgro -mvs tests/test-paths.txt
	-scripts/pathgro -g tests/test-paths.txt
	-scripts/pathgro --1Grow tests/test-paths.txt
	-scripts/pathgro --2Grow tests/test-paths.txt
	-scripts/pathgro --3Grow tests/test-paths.txt
	-scripts/pathgro --4Grow tests/test-paths.txt
	-scripts/pathgro --5Grow tests/test-paths.txt
	-scripts/pathgro --6Grow tests/test-paths.txt
	-scripts/pathgro --7Grow tests/test-paths.txt
	-scripts/pathgro --8Grow tests/test-paths.txt
