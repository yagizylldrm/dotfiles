#!/usr/bin/env bash
curr_workspace="$(hyprctl activeworkspace -j | jq -r ".id")"
dispatcher="$1"
shift ## The target is now in $1, not $2

if [[ -z "${dispatcher}" || "${dispatcher}" == "--help" || "${dispatcher}" == "-h" || -z "$1" ]]; then
  echo "Usage: $0 <dispatcher> <target>"
  exit 1
fi

target="$1"
if [[ "$target" =~ ^[0-9]+$ ]]; then
  target=$((((curr_workspace - 1) / 10 ) * 10 + target))
fi

dispatch_action() {
  local disp="$1"
  local tgt="$2"

  if [[ "$disp" == "workspace" ]]; then
    if [[ "$tgt" =~ ^[0-9]+$ ]]; then
      hyprctl dispatch "hl.dsp.focus({ workspace = ${tgt} })"
    else
      hyprctl dispatch "hl.dsp.focus({ workspace = '${tgt}' })"
    fi
  elif [[ "$disp" == "movetoworkspacesilent" ]]; then
    if [[ "$tgt" =~ ^[0-9]+$ ]]; then
      hyprctl dispatch "hl.dsp.window.move({ workspace = ${tgt}, follow = false })"
    else
      hyprctl dispatch "hl.dsp.window.move({ workspace = '${tgt}', follow = false })"
    fi
  elif [[ "$disp" == "movetoworkspace" ]]; then
    if [[ "$tgt" =~ ^[0-9]+$ ]]; then
      hyprctl dispatch "hl.dsp.window.move({ workspace = ${tgt} })"
    else
      hyprctl dispatch "hl.dsp.window.move({ workspace = '${tgt}' })"
    fi
  else
    hyprctl dispatch "${disp}" "${tgt}"
  fi
}

dispatch_action "${dispatcher}" "${target}"
qs -c "${qsConfig:-ii}" ipc call search toggleReleaseInterrupt >/dev/null 2>&1 &
