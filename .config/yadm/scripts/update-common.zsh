#!/usr/bin/env zsh

YADM_SCRIPTS=$( cd -- "$( dirname -- ${(%):-%x} )/../scripts" &> /dev/null && pwd )

source "${YADM_SCRIPTS}/colors.sh"

printf "${YELLOW}%s${NC}" "Updating tldr... "
tldr --update
echo

# Update Oh-my-zsh custom themes and plugins
DISABLE_AUTO_UPDATE=true source "${HOME}/.oh-my-zsh/oh-my-zsh.sh"
omz update
find "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes" -mindepth 1 -maxdepth 1 -type d -print0 | \
  xargs -r -0 -P 8 -I {} git -C {} pull --prune --stat -v --ff-only
find "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins" -mindepth 1 -maxdepth 1 -type d -print0 | \
  xargs -r -0 -P 8 -I {} git -C {} pull --prune --stat -v --ff-only

printf "${YELLOW}%s${NC}\n" "Testing shell instantiation performance..."
hf_file="$(mktemp)"
hyperfine --warmup=1 --max-runs 5 'zsh -i -c exit' --export-json "${hf_file}"
mean_time=$(jq '.results[].median' "${hf_file}")
if [[ $mean_time -ge 0.6 ]]; then
  printf "${RED}%s${NC}\n" "Zsh performance is too slow!"
fi
rm -f "${hf_file}"

printf "${YELLOW}%s${NC}\n" "Updating vim plugins..."
find "${HOME}/.vim/pack" -type d -name .git -print0 | \
  xargs -r -0 -P 8 -I {} bash -c 'git -C {}/.. reset --hard && git -C {}/.. pull --prune --stat -v --ff-only' && \
  source "${YADM_SCRIPTS}/apply-vim-plugin-patches.sh" && \
  printf "${GREEN}%s${NC}\n" "Done"
