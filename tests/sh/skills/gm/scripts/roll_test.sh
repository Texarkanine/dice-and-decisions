#!/bin/sh
#
# Unit tests for roll.sh (the engine dice roller).
# Run directly (`sh roll_test.sh`) or via `tests/sh/run.sh`.

TEST_DIR=$(cd -- "$(dirname -- "$0")" && pwd)

# shellcheck source=../../../common.sh
. "${TEST_DIR}/../../../common.sh"

ROLL_SH="${TEST_DIR}/../../../../../skills/gm/scripts/roll.sh"

# Source the script under test so its functions can be exercised in-process.
# The entry-point guard must keep this from running main (verified separately).
source_script "${ROLL_SH}" || fail "could not source ${ROLL_SH}"

# Counts the distinct characters (single-digit faces) in a string.
distinct_digit_count() {
	printf '%s' "${1}" | tr -cd '0-9' | fold -w1 | sort -u | grep -c .
}

# Determinism: same (seed,label,sides) yields the same face every time.
test_roll_die_is_deterministic() {
	td_r1=$(roll_die 42 unit 6)
	td_r2=$(roll_die 42 unit 6)
	assertEquals "repeated rolls must match" "${td_r1}" "${td_r2}"
	assertEquals "pinned face for (42,unit,6)" "5" "${td_r1}"
	return 0
}

# Range: every face lies within [1, sides] across several die sizes.
test_roll_die_in_range() {
	for tr_sides in 2 6 20 100; do
		for tr_label in a b c d e; do
			tr_f=$(roll_die 42 "${tr_label}" "${tr_sides}")
			assertTrue "face >= 1 (${tr_sides},${tr_label})=${tr_f}" \
				"[ \"${tr_f}\" -ge 1 ]"
			assertTrue "face <= ${tr_sides} (${tr_label})=${tr_f}" \
				"[ \"${tr_f}\" -le ${tr_sides} ]"
		done
	done
	return 0
}

# Label independence: distinct labels (same seed/sides) can produce
# distinct faces (the label actually feeds the result).
test_distinct_labels_can_differ() {
	tl_faces=""
	for tl_label in 1 2 3 4 5 6 7 8 9; do
		tl_faces="${tl_faces}$(roll_die 42 "${tl_label}" 6)"
	done
	assertTrue "labels must not all map to one face" \
		"[ $(distinct_digit_count "${tl_faces}") -gt 1 ]"
	return 0
}

# Seed independence: distinct seeds (same label/sides) can produce
# distinct faces (the seed actually feeds the result).
test_distinct_seeds_can_differ() {
	ts_faces=""
	for ts_seed in 1 2 3 4 5 6 7 8 9; do
		ts_faces="${ts_faces}$(roll_die "${ts_seed}" unit 6)"
	done
	assertTrue "seeds must not all map to one face" \
		"[ $(distinct_digit_count "${ts_faces}") -gt 1 ]"
	return 0
}

# Algorithm lock: hash_to_int on a known string yields a known integer,
# pinning the PRNG so reproducibility cannot silently drift.
test_hash_to_int_is_pinned() {
	assertEquals "pinned hash of 'lock-test'" \
		"1159130431" "$(hash_to_int lock-test)"
	return 0
}

# Seed reporting + replay: when --seed is omitted a seed is generated and
# logged; re-running with that reported seed reproduces the original result.
test_unseeded_reports_replayable_seed() {
	tu_out=$(mktemp)
	tu_err=$(mktemp)
	sh "${ROLL_SH}" --label rep --sides 6 >"${tu_out}" 2>"${tu_err}"
	tu_orig=$(cat "${tu_out}")
	tu_seed=$(sed -n 's/.*seed=\([0-9][0-9]*\).*/\1/p' "${tu_err}")
	assertTrue "a numeric seed was reported" "[ -n \"${tu_seed}\" ]"
	tu_replay=$(sh "${ROLL_SH}" --label rep --sides 6 --seed "${tu_seed}" \
		2>/dev/null)
	assertEquals "reported seed replays the original roll" \
		"${tu_orig}" "${tu_replay}"
	rm -f "${tu_out}" "${tu_err}"
	return 0
}

# Distribution sanity (deterministic): with a fixed seed and labels 1..60,
# every face 1..6 appears at least once. Seeded => never flaky.
test_distribution_covers_all_faces() {
	tc_faces=""
	tc_i=1
	while [ "${tc_i}" -le 60 ]; do
		tc_faces="${tc_faces} $(roll_die 42 "${tc_i}" 6)"
		tc_i=$(( tc_i + 1 ))
	done
	for tc_want in 1 2 3 4 5 6; do
		case " ${tc_faces} " in
			*" ${tc_want} "*) : ;;
			*) fail "face ${tc_want} never appeared over 60 labels" ;;
		esac
	done
	return 0
}

# CLI happy path: a single roll prints one in-range integer to stdout and
# an exactly-formatted log line to stderr.
test_cli_single_roll_stdout_and_log() {
	ts_out=$(mktemp)
	ts_err=$(mktemp)
	sh "${ROLL_SH}" --seed 42 --sides 6 --label unit \
		>"${ts_out}" 2>"${ts_err}"
	assertEquals "exit 0 on happy path" 0 "$?"
	assertEquals "stdout is the pinned face" "5" "$(cat "${ts_out}")"
	assertEquals "stderr log matches exact grammar" \
		"roll seed=42 label=unit die=d6 => 5" "$(cat "${ts_err}")"
	rm -f "${ts_out}" "${ts_err}"
	return 0
}

# Count: --count N prints N in-range, deterministic faces.
test_cli_count_rolls_multiple() {
	tm_out=$(sh "${ROLL_SH}" --seed 42 --sides 6 --count 3 --label multi \
		2>/dev/null)
	assertEquals "three faces emitted" 3 "$(printf '%s' "${tm_out}" | wc -w)"
	tm_out2=$(sh "${ROLL_SH}" --seed 42 --sides 6 --count 3 --label multi \
		2>/dev/null)
	assertEquals "count rolls are deterministic" "${tm_out}" "${tm_out2}"
	return 0
}

# Entry-point protection: sourcing roll.sh runs no main, prints nothing.
test_sourcing_does_not_run_main() {
	# shellcheck disable=SC1090
	tp_out=$(. "${ROLL_SH}"; echo SOURCED_OK)
	assertEquals "sourcing must not emit main output" "SOURCED_OK" "${tp_out}"
	return 0
}

# Validation: bad/missing inputs exit non-zero with no stdout face.

test_cli_rejects_zero_sides() {
	tz_out=$(sh "${ROLL_SH}" --seed 42 --sides 0 --label x 2>/dev/null)
	assertNotEquals "zero sides must fail" 0 "$?"
	assertEquals "no face on error" "" "${tz_out}"
	return 0
}

test_cli_rejects_negative_sides() {
	tn_out=$(sh "${ROLL_SH}" --seed 42 --sides -1 --label x 2>/dev/null)
	assertNotEquals "negative sides must fail" 0 "$?"
	assertEquals "no face on error" "" "${tn_out}"
	return 0
}

test_cli_rejects_nonnumeric_sides() {
	ta_out=$(sh "${ROLL_SH}" --seed 42 --sides abc --label x 2>/dev/null)
	assertNotEquals "non-numeric sides must fail" 0 "$?"
	assertEquals "no face on error" "" "${ta_out}"
	return 0
}

test_cli_rejects_zero_count() {
	tzc_out=$(sh "${ROLL_SH}" --seed 42 --sides 6 --count 0 --label x \
		2>/dev/null)
	assertNotEquals "zero count must fail" 0 "$?"
	assertEquals "no face on error" "" "${tzc_out}"
	return 0
}

test_cli_rejects_missing_label() {
	tml_out=$(sh "${ROLL_SH}" --seed 42 --sides 6 2>/dev/null)
	assertNotEquals "missing label must fail" 0 "$?"
	assertEquals "no face on error" "" "${tml_out}"
	return 0
}

# shellcheck source=../../../vendor/shunit2
. "${TEST_DIR}/../../../vendor/shunit2"
