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

#CONFIG         := pathgro.conf 
#CONFIG_DESTDIR := ${DESTDIR}${PREFIX}/share/${PROGNAME}

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
	@mkdir -p ${GUILEINC}
	@echo installing source files in ${GUILEINC}/${PROGNAME}
	@cp -p --parents ${SRC} ${GUILEINC}
	
	@mkdir -p ${GUILELIB}
	@echo installing object files in ${GUILELIB}/${PROGNAME}
	@cp -p --parents ${OBJ} ${GUILELIB}
	
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@echo installing executable script in ${DESTDIR}${PREFIX}/bin
	@cp -p ${SCRIPTDIR}/${PROGNAME} ${DESTDIR}${PREFIX}/bin/${PROGNAME}

	#@mkdir -p ${CONFIG_DESTDIR}
	#@echo installing default config in ${CONFIG_DESTDIR}
	#@cp -p ${CONFIG} ${CONFIG_DESTDIR}/${CONFIG}

uninstall:
	@rm -rf ${GUILEINC}/${PROGNAME}
	@rm -rf ${GUILELIB}/${PROGNAME}
	@rm -f  ${DESTDIR}${PREFIX}/bin/${PROGNAME}
	#@rm -rf ${CONFIG_DESTDIR}

clean:
	@rm ${OBJ}

test:
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
