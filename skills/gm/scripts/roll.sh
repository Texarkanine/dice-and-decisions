#!/bin/sh
#
# roll.sh - the lite-rpg engine dice roller.
#
# Real RNG, seedable, reproducible, with per-roll context logging. This is the
# only sanctioned source of randomness for the engine: models never roll dice.
#
# A roll is a pure deterministic function of (seed, label, sides):
#   face = (hash("<seed>:<label>:<sides>") % sides) + 1
# The per-roll label is BOTH the logged context AND the reproducibility nonce,
# so an entire session replays from a single seed with no on-disk state. Labels
# must be unique per roll within a session (e.g. "<stage>-<actor>-<purpose>").
#
# Usage: roll.sh --label TEXT [--seed SEED] [--sides N] [--count N]
#   --label TEXT   required; per-roll context (also the reproducibility nonce)
#   --seed  SEED   optional; if omitted, drawn from /dev/urandom and reported
#   --sides N      optional, default 6; positive integer
#   --count N      optional, default 1; positive integer (NdS)
#
# Output:
#   stdout - face value(s), space-separated, single line
#   stderr - one log line per roll: "roll seed=<s> label=<l> die=d<n> => <r>"
#
# Note: arithmetic assumes a shell with >=64-bit integers (cksum yields a
# 32-bit value that exceeds the signed 32-bit range); the face formula is
# written to stay in [1, sides] regardless of the hash's sign.

# Maps an arbitrary string to a non-negative integer, deterministically.
#
# Uses cksum's CRC (the first whitespace-delimited field of its output), a
# POSIX-standard, machine-portable checksum.
#
# Globals:
#   None
# Arguments:
#   $1 - Input string (required)
# Outputs:
#   The integer to STDOUT
# Returns:
#   0 on success
hash_to_int() {
	hti_sum=$(printf '%s' "${1}" | cksum)
	# cksum prints "<crc> <bytecount>"; keep the CRC.
	echo "${hti_sum%% *}"
}

# Computes a single die face, deterministically, from (seed, label, sides).
#
# Globals:
#   None
# Arguments:
#   $1 - Seed (required)
#   $2 - Label (required)
#   $3 - Number of sides (required, positive integer)
# Outputs:
#   The face value in [1, sides] to STDOUT
# Returns:
#   0 on success
roll_die() {
	rd_hash=$(hash_to_int "${1}:${2}:${3}")
	# Double-mod keeps the result in [1, sides] even if the hash is read as
	# a negative value on a hypothetical signed/narrow-integer shell.
	echo "$(( (rd_hash % ${3} + ${3}) % ${3} + 1 ))"
}

# Draws a fresh random seed from the system entropy source.
#
# Reads four bytes from /dev/urandom. Falls back to a clock/PID-derived value
# if /dev/urandom is unavailable, so unseeded mode still produces a reported,
# replayable seed in constrained sandboxes.
#
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   A non-negative integer seed to STDOUT
# Returns:
#   0 on success
generate_seed() {
	gs_seed=""
	if [ -r /dev/urandom ]; then
		gs_seed=$(od -An -N4 -tu4 < /dev/urandom 2>/dev/null | tr -d ' ')
	fi
	if [ -z "${gs_seed}" ]; then
		echo "roll.sh: /dev/urandom unavailable; using clock/PID seed" >&2
		gs_seed=$(( $(date +%s) ^ $$ ))
	fi
	echo "${gs_seed}"
}

# Validates that a value is a positive integer (>= 1).
#
# Globals:
#   None
# Arguments:
#   $1 - Value to validate (required)
# Outputs:
#   None
# Returns:
#   0 if the value is a positive integer, 1 otherwise
validate_positive_int() {
	case "${1}" in
		''|*[!0-9]*) return 1 ;;
	esac
	[ "${1}" -ge 1 ] || return 1
	return 0
}

# Emits a structured, machine-parseable log line for one roll to STDERR.
#
# The grammar is a stable contract (the seed of the gm transcript journal):
#   roll seed=<seed> label=<label> die=d<sides> => <result>
#
# Globals:
#   None
# Arguments:
#   $1 - Seed
#   $2 - Label
#   $3 - Sides
#   $4 - Result
# Outputs:
#   The log line to STDERR
# Returns:
#   0 on success
log_roll() {
	echo "roll seed=${1} label=${2} die=d${3} => ${4}" >&2
}

# Parses arguments, performs the roll(s), prints faces and logs context.
#
# Globals:
#   None
# Arguments:
#   $@ - Command-line arguments (see usage)
# Outputs:
#   Face value(s) to STDOUT; one log line per roll to STDERR; errors to STDERR
# Returns:
#   0 on success, 2 on invalid input
main() {
	m_seed=""
	m_label=""
	m_sides=6
	m_count=1

	while [ "$#" -gt 0 ]; do
		case "${1}" in
			--seed)
				m_seed="${2:-}"
				shift 2 || shift
				;;
			--label)
				m_label="${2:-}"
				shift 2 || shift
				;;
			--sides)
				m_sides="${2:-}"
				shift 2 || shift
				;;
			--count)
				m_count="${2:-}"
				shift 2 || shift
				;;
			-h|--help)
				echo "Usage: roll.sh --label TEXT [--seed SEED]" \
					"[--sides N] [--count N]"
				return 0
				;;
			*)
				echo "roll.sh: unknown argument '${1}'" >&2
				return 2
				;;
		esac
	done

	if [ -z "${m_label}" ]; then
		echo "roll.sh: --label is required" >&2
		return 2
	fi
	if ! validate_positive_int "${m_sides}"; then
		echo "roll.sh: --sides must be a positive integer (got" \
			"'${m_sides}')" >&2
		return 2
	fi
	if ! validate_positive_int "${m_count}"; then
		echo "roll.sh: --count must be a positive integer (got" \
			"'${m_count}')" >&2
		return 2
	fi

	if [ -z "${m_seed}" ]; then
		m_seed=$(generate_seed)
	fi

	m_results=""
	m_i=1
	while [ "${m_i}" -le "${m_count}" ]; do
		if [ "${m_count}" -eq 1 ]; then
			m_dielabel="${m_label}"
		else
			m_dielabel="${m_label}#${m_i}"
		fi
		m_face=$(roll_die "${m_seed}" "${m_dielabel}" "${m_sides}")
		log_roll "${m_seed}" "${m_dielabel}" "${m_sides}" "${m_face}"
		if [ -z "${m_results}" ]; then
			m_results="${m_face}"
		else
			m_results="${m_results} ${m_face}"
		fi
		m_i=$(( m_i + 1 ))
	done

	echo "${m_results}"
	return 0
}

# Only run main if executed directly, not when sourced for testing.
case "$0" in
	*roll.sh) main "$@" ;;
esac
