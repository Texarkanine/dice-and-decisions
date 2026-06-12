#!/bin/sh
#
# Common test utilities for the gm dice-roller test suite.
# Sourced by every unit test file; provides a single helper for loading the
# script under test without triggering its main execution.

# Sources the script under test for in-process function testing.
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
