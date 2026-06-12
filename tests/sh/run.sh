#!/bin/sh
#
# Aggregate runner for repository shell-script tests.
# Executes every *_test.sh suite under tests/sh/skills/ and reports
# an overall pass/fail result.
#
# Usage: sh tests/sh/run.sh

# shellcheck disable=SC1091
. "$(dirname -- "$0")/common.sh"

# Runs all shell test suites and aggregates exit status.
#
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Suite output to STDOUT/STDERR and final summary line
# Returns:
#   0 if every suite passed, 1 if any suite failed
run_all() {
	ra_dir=$(cd -- "$(dirname -- "$0")" && pwd)
	ra_status=0
	ra_found=0
	ra_list=$(new_tmp_file run_sh_tests)

	find "${ra_dir}/skills" -type f -name "*_test.sh" | sort > "${ra_list}"

	while IFS= read -r ra_suite; do
		[ -n "${ra_suite}" ] || continue
		ra_found=1
		echo "=== ${ra_suite} ==="
		sh "${ra_suite}" || ra_status=1
	done < "${ra_list}"

	if [ "${ra_found}" -eq 0 ]; then
		echo "run.sh: no test suites found under ${ra_dir}/skills/" >&2
		return 1
	fi

	if [ "${ra_status}" -eq 0 ]; then
		echo "ALL SUITES PASSED"
	else
		echo "SOME SUITES FAILED" >&2
	fi

	return "${ra_status}"
}

case "$0" in
	*run.sh) run_all "$@" ;;
esac
