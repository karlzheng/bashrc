#!/bin/bash -

#http://www.linuxquestions.org/questions/programming-9/bash-case-with-arrow-keys-and-del-backspace-etc-523441/
#http://mywiki.wooledge.org/ReadingFunctionKeysInBash
#set -o nounset
set -o errexit

function ord()
{
	printf -v "${1?Missing Dest Variable}" "${3:-%d}" "'${2?Missing Char}"
}

function ord.eascii()
{
	LC_CTYPE=C ord "${@}"
}

###############################
##
##    READ KEY CRAP
##
###############################

KeyModifiers=(
[2]="S"   [3]="A"   [4]="AS"   [5]="C"   [6]="CS"  [7]="CA"    [8]="CAS"
[9]="M" [10]="MS" [11]="MA" [12]="MAS" [13]="MC" [14]="MCS" [15]="MCA" [16]="MCAS"
)

KeybFntKeys=(
[1]="home" [2]="insert" [3]="delete"  [4]="end"   [5]="pageUp" [6]="pageDown"
[11]="f1"  [12]="f2"    [13]="f3"     [14]="f4"   [15]="f5"
[17]="f6"  [18]="f7"    [19]="f8"     [20]="f9"   [21]="f10"
[23]="f11" [24]="f12"   [25]="f13"    [26]="f14"  [28]="f15"
[29]="f16" [31]="f17"   [32]="f18"    [33]="f19"  [34]="f20"
)

KeybFntKeysAlt=(
# A          B              C               D             E                   F             H
[0x41]="up" [0x42]="down" [0x43]="right" [0x44]="left" [0x45]="keypad-five" [0x46]="end" [0x48]="home"
# I               O
[0x49]="InFocus" [0x4f]="OutOfFocus"
# P           Q           R           S             Z
[0x50]="f1" [0x51]="f2" [0x52]="f3" [0x53]="f4"  [0x5a]="S-HT"
)

C0CtrlChars=(
[0x00]="Null" [0x01]="SOH" [0x02]="STX" [0x03]="ETX" [0x04]="EOT" [0x05]="ENQ" [0x06]="ACK"
[0x07]="BEL"  [0x08]="BS"  [0x09]="HT"  [0x0A]="LF"  [0x0B]="VT"  [0x0C]="FF"  [0x0D]="CR"
[0x0E]="SO"   [0x0F]="SI"  [0x10]="DLE" [0x11]="DC1" [0x12]="DC2" [0x13]="DC3" [0x14]="DC4"
[0x15]="NAK"  [0x16]="SYN" [0x17]="ETB" [0x18]="CAN" [0x19]="EM"  [0x1A]="SUB" [0x1B]="ESC"
[0x1C]="FS"   [0x1D]="GS"  [0x1E]="RS"  [0x1F]="US"  [0x20]="SP"  [0x7F]="DEL"
)

C1CtrlCharsAlt=(
[0x01]="CA-A" [0x02]="CA-B" [0x03]="CA-C" [0x04]="CA-D"  [0x05]="CA-E" [0x06]="CA-F" [0x07]="CA-G"
[0x08]="CA-H" [0x09]="CA-I" [0x0a]="CA-J" [0x0b]="CA-K"  [0x0c]="CA-L" [0x0d]="CA-M" [0x0e]="CA-N"
[0x0f]="CA-O" [0x10]="CA-P" [0x11]="CA-Q" [0x12]="CA-R"  [0x13]="CA-S" [0x14]="CA-T" [0x15]="CA-U"
[0x16]="CA-V" [0x17]="CA-W" [0x18]="CA-X" [0x19]="CA-Y"  [0x1a]="CA-Z" [0x1b]="CA-[" [0x1c]="CA-]"
[0x1d]="CA-}" [0x1e]="CA-^" [0x1f]="CA-_" [0x20]="CA-SP" [0x7F]="A-DEL"
)

function ReadKey()
{
	unset UInput[@]
	local escapeSequence
	local REPLY

	if IFS='' read -srN1 ${1:-} escapeSequence; then
		case "${escapeSequence}" in
			[^[:cntrl:]])
				UInput[0]="${escapeSequence}"
				;;
			$'\e')
				while IFS='' read -srN1 -t0.0001 ; do
					escapeSequence+="${REPLY}"
				done
				case "${escapeSequence}" in
				$'\e'[^[:cntrl:]]) echo -n "A-${escapeSequence:1}"
					;;
				${CSI}[0-9]*[ABCDEFHIOZPQRSz~])
					local CSI_Params=( ${escapeSequence//[!0-9]/ } )
					local CSI_Func="${escapeSequence:${#escapeSequence}-1}"
					case "${CSI_Func}" in
						'~') # Function Keys
							UInput[0]="${KeybFntKeys[${CSI_Params[0]}]-}"
							if [ -n "${UInput[0]}" ]; then
								[ ${#CSI_Params[@]} -le 1 ] ||  UInput[0]="${KeyModifiers[${CSI_Params[1]}]}-${UInput[0]}"
							else
								UInput[0]="CSI ${CSI_Params[*]} ${CSI_Func}"
							fi
							;;
						A|B|C|D|E|F|H|I|O|Z|P|Q|R|S)
							ord.eascii CSI_Func "${CSI_Func}"
							UInput[0]="${KeybFntKeysAlt[${CSI_Func}]}"
							if [ -n "${UInput[0]}" ]; then
								[ ${#CSI_Params[@]} -le 1 ] ||  UInput[0]="${KeyModifiers[${CSI_Params[1]}]}-${UInput[0]}"
							else
								UInput[0]="CSI ${CSI_Params[*]} ${CSI_Func}"
							fi
							;;
						*)
							UInput[0]="CSI ${CSI_Params[*]} ${CSI_Func}"
							;;
					esac ;;
				${SS3}*[ABCDEFHPQRSIO~])
					local SS3_Params=( ${escapeSequence//[!0-9]/ } )
					local SS3_Func="${escapeSequence:${#escapeSequence}-1}"
					case "${SS3_Func}" in
						A|B|C|D|E|F|H|P|Q|R|S|~)
							ord.eascii SS3_Func "${SS3_Func}"
							UInput[0]="${KeybFntKeysAlt[${SS3_Func}]-}"
							if [ -n "${UInput[0]}" ]; then
								[ ${#SS3_Params[@]} -lt 1 ] ||  UInput[0]="${KeyModifiers[${SS3_Params[0]}]}-${UInput[0]}"
							else
								UInput[0]="SS3 ${SS3_Params[*]-} ${SS3_Func}"
							fi
							;;
						*)
							UInput[0]="SS3 ${SS3_Params[*]-} ${SS3_Func}"
							;;
					esac
					;;
				$'\e'[[:cntrl:]])
					ord.eascii UInput[0] "${escapeSequence:1:1}"
					UInput[0]="${C1CtrlCharsAlt[${UInput[0]}]:-}"
					[ -n "${UInput[0]:-}" ] ||  UInput[0]="$(printf "%q" "${escapeSequence}")"
					;;
				$'\e')
					UInput[0]="ESC"
					;;
				*)
					UInput[0]="$(printf "%q" "${escapeSequence}")"
					;;
				esac
				;;
			*)
				ord.eascii UInput[0] "${escapeSequence}"
				UInput[0]="${C0CtrlChars[${UInput[0]}]:-}"
				[ -n "${UInput[0]:-}" ] ||  UInput[0]="$(printf '%q' "'${escapeSequence}")"
				;;
			esac
		fi
}

function HandleKey()
{
	local -a UInput
	if ReadKey ; then
		case "${UInput[0]:-}" in
			up)
				echo UP
				;;
			down)
				echo DOWN
				;;
			CR|LF)
				echo "CR"
				;;
			' ')
				echo "SPACE"
				;;
			*)
				echo "${UInput[0]:-}"
				;;
		esac
	fi
}

#HandleKey
keycode=$(HandleKey)
#echo $keycode > /dev/shm/keycode.txt
echo $keycode

