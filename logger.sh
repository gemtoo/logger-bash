#!/bin/bash

RED='\x1b[0;31;1m'
GRN='\x1b[0;32;1m'
YLW='\x1b[0;33;1m'
BLU='\x1b[0;34;1m'
MAG='\x1b[0;35;1m'
CYA='\x1b[0;36;1m'
WHI='\x1b[0;37;1m'
RST='\x1b[0m'

info() {
	echo -e "${WHI}[${RST} $(date --rfc-3339=s) ${GRN}INFO${RST}  ${WHI}]${RST} ${WHI}$@${RST}"
}

warn() {
	echo -e "${WHI}[${RST} $(date --rfc-3339=s) ${YLW}WARN${RST}  ${WHI}]${RST} ${WHI}$@${RST}"
}

debug() {
	echo -e "${WHI}[${RST} $(date --rfc-3339=s) ${MAG}DEBUG${RST} ${WHI}]${RST} ${WHI}$@${RST}"
}

trace() {
	echo -e "${WHI}[${RST} $(date --rfc-3339=s) ${BLU}TRACE${RST} ${WHI}]${RST} ${WHI}$@${RST}"
}

error() {
	echo -e "${WHI}[${RST} $(date --rfc-3339=s) ${RED}ERROR${RST} ${WHI}]${RST} ${WHI}$@${RST}"
}

die() {
	error $@
	exit 1
}

check_deps() {
	for DEP in $1; do
		command -v "$DEP" &> /dev/null || die "Command ${GRN}${DEP}${RST} not found."
	done
}

msg() {
	info "Logger has been initialized."
}

test_logger() {
	info "This is a test INFO  message."
	warn "This is a test WARN  message."
	debug "This is a test DEBUG message."
	trace "This is a test TRACE message."
	error "This is a test ERROR message."
}

time_test_logger() {
	time (
		TIMES=10000
		for ITER in $(seq 0 ${TIMES}); do
			printf "Iteration ${ITER} / ${TIMES} ...\r"
			test_logger
		done
	)
}

check_deps "date printf" && msg
