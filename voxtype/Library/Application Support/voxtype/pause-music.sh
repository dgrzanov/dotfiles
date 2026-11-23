#!/bin/sh
# GUI apps may start without Homebrew on PATH.
PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
now_playing() {
    media-control get --no-artwork --allow-missing-title
}

player=$(now_playing | jq -er 'select(.playing == true) | .bundleIdentifier // empty') || exit 0
media-control pause || exit 1

# Let Voxtype process the hotkey release while we wait for capture to end.
(
    while true; do
        case "$(voxtype status)" in
            recording|streaming) sleep 0.15 ;;
            *)
                sleep 2
                # Keep music paused if another recording started during the delay.
                case "$(voxtype status)" in
                    recording|streaming) continue ;;
                    *) break ;;
                esac
                ;;
        esac
    done
    if now_playing | jq -e --arg player "$player" '.bundleIdentifier == $player and .playing == false' >/dev/null; then
        media-control play
    fi
) </dev/null >/dev/null 2>&1 &
