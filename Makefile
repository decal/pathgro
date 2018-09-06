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
CONFIG_DESTDIR := ${DESTDIR}${PREFIX}/share/${PROGNAME}

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

	@mkdir -p ${CONFIG_DESTDIR}
	@echo installing default config in ${CONFIG_DESTDIR}
	@cp -p ${CONFIG} ${CONFIG_DESTDIR}/${CONFIG}

uninstall:
	@rm -rf ${GUILEINC}/${PROGNAME}
	@rm -rf ${GUILELIB}/${PROGNAME}
	@rm -f  ${DESTDIR}${PREFIX}/bin/${PROGNAME}
	@rm -rf ${CONFIG_DESTDIR}

clean:
	@rm ${OBJ}

test:
	-pathgro -l2 -bx tests/test-paths.txt > tests/output/base-exts-permute-level2.txt
	-pathgro -l3 -bx tests/test-paths.txt > tests/output/base-exts-permute-level3.txt
	-pathgro -l4 -bx tests/test-paths.txt > tests/output/base-exts-permute-level4.txt
