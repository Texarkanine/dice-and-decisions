#!/bin/sh
#
# Common test utilities for shell-script test suites.
# Sourced by test files; provides a helper for loading scripts under test
# without triggering their main execution blocks.

# Sources a script under test for in-process function testing.
#
# Relies on the script's entry-point guard: sourcing must NOT run main.
#
# Globals:
#   None
# Arguments:
#   $1 - Path to the script under test (required)
# Outputs:
#   Error message to STDERR on failure
# Returns:
#   0 on success, 1 if the path is missing or cannot be sourced
source_script() {
	cs_script="${1}"

	if [ -z "${cs_script}" ] || [ ! -r "${cs_script}" ]; then
		echo "source_script: cannot read '${cs_script}'" >&2
		return 1
	fi

	# shellcheck disable=SC1090
	. "${cs_script}" || {
		echo "source_script: failed to source '${cs_script}'" >&2
		return 1
	}

	return 0
}

# Creates a unique temporary file path and an empty file at that path.
#
# Uses mktemp when available; otherwise a POSIX fallback (PID + timestamp +
# counter + noclobber create). No cleanup is required — files live in /tmp
# until the host clears them.
#
# Globals:
#   None
# Arguments:
#   $1 - Filename prefix (optional, default: lite-rpg)
# Outputs:
#   Absolute path to the new empty file on STDOUT
# Returns:
#   0 on success, 1 if no file could be created
new_tmp_file() {
	ntf_prefix="${1:-lite-rpg}"
	ntf_base="${TMPDIR:-/tmp}"
	ntf_ts=$(date +%s 2>/dev/null || echo 0)
	ntf_i=0

	if command -v mktemp >/dev/null 2>&1; then
		mktemp "${ntf_base}/${ntf_prefix}.XXXXXX"
		return $?
	fi

	while :; do
		ntf_path="${ntf_base}/${ntf_prefix}.${ntf_ts}.$$.$ntf_i.tmp"
		if ( set -C; : > "${ntf_path}" ) 2>/dev/null; then
			echo "${ntf_path}"
			return 0
		fi
		ntf_i=$(( ntf_i + 1 ))
	done
}
