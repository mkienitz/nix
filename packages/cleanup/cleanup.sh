set -euo pipefail

export GUM_SPIN_PADDING="1 2"
export GUM_CONFIRM_PADDING="1 1"
export PADDING="1 2"

gum style \
  --foreground 212 \
  --border-foreground 212 \
  --border double \
  --margin "1 2" \
  --padding "1 4" \
  "Direnv Cleanup Helper"

find_direnvs() {
  sleep 1
  fd -t d -HI '.direnv' "$HOME"/git
}
export -f find_direnvs

found=$(gum spin --show-stdout --title "Looking for .direnv directories..." -- bash -c find_direnvs)

if [[ -z "$found" ]]; then
  gum style "No .direnv directories found"
else
  selected=$(echo "$found" | gum choose --padding "1 2" --no-limit --header "Found the following:")
  if [[ -z "$selected" ]]; then
    gum style --foreground 212 "No .direnv directories selected"
  else
    no_selected=$(echo "$selected" | wc -l)
    # shellcheck disable=SC2001
    gum format -- $'# Selected for deletion:\n'"$(echo "$selected" | sed 's/^/- /')"
    gum confirm --selected.background 1 "Delete $no_selected directories?" ||
    exit 0
    echo "$selected" | xargs -I {} -- rm -rf "{}" &&
    gum style --foreground 212 "✓ Deleted $no_selected directories"
  fi
fi

gum confirm "Run garbage collection now? [requires sudo]" &&
sudo -v &&
gum spin --show-stdout --title $'Collecting garbage (sudo)...' -- sudo nix-collect-garbage -d --quiet 2>/dev/null |
tail -n 1 | gum style --foreground 157 &&
gum spin --show-stdout --title "Collecting garbage (user)..." -- nix-collect-garbage -d --quiet 2>/dev/null |
tail -n 1 | gum style --foreground 157 &&
gum style --foreground 212 "✓ Garbage collected"

gum confirm "Run store optimisation now? [requires sudo]" &&
sudo -v &&
gum spin --show-stdout --title "Optimising store..." -- sudo nix store optimise 2>/dev/null &&
gum style --foreground 212 "✓ Store optimised"

gum style --foreground 212 "✓ Cleanup finished"
