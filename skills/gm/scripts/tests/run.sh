#!/bin/sh
#
# Test runner for the gm dice-roller suite.
# Executes every unit test file under tests/unit/ and reports an aggregate
# pass/fail. Each unit file is a self-contained shunit2 suite.
#
# Usage: tests/run.sh

# Runs all unit test suites and aggregates their exit status.
#
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Each suite's output to STDOUT/STDERR; a final summary line to STDOUT
# Returns:
#   0 if every suite passed, 1 if any suite failed
run_all() {
	ra_dir=$(cd -- "$(dirname -- "$0")" && pwd)
	ra_status=0
	ra_found=0

	for ra_suite in "${ra_dir}"/unit/*_test.sh; do
		[ -f "${ra_suite}" ] || continue
		ra_found=1
		echo "=== ${ra_suite} ==="
		sh "${ra_suite}" || ra_status=1
	done

	if [ "${ra_found}" -eq 0 ]; then
		echo "run.sh: no test suites found under ${ra_dir}/unit/" >&2
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
