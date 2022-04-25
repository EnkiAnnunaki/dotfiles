#!/usr/bin/env bash

YADM_SCRIPTS=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/../scripts" &> /dev/null && pwd )

source "${YADM_SCRIPTS}/colors.sh"
source "${YADM_SCRIPTS}/install-vim-plugin.sh"

if [ "$(command -v vim)" -o "$(command -v nvim)" ]; then
  urls=(
    'https://github.com/airblade/vim-gitgutter'
    'https://github.com/AndrewRadev/splitjoin.vim'
    'https://github.com/bfontaine/Brewfile.vim'
    'https://github.com/editorconfig/editorconfig-vim'
    'https://github.com/farmergreg/vim-lastplace'
    'https://github.com/francoiscabrol/ranger.vim'
    'https://github.com/junegunn/fzf'
    'https://github.com/junegunn/fzf.vim'
    'https://github.com/junegunn/vim-easy-align'
    'https://github.com/kdheepak/lazygit.nvim.git'
    'https://github.com/mtdl9/vim-log-highlighting'
    'https://github.com/gruvbox-community/gruvbox'
    'https://github.com/nathanaelkane/vim-indent-guides'
    'https://github.com/neoclide/coc.nvim@release'
    'https://github.com/nishigori/increment-activator'
    'https://github.com/preservim/nerdcommenter'
    'https://github.com/rmagatti/auto-session'
    'https://github.com/RRethy/vim-illuminate'
    'https://github.com/ruanyl/vim-gh-line'
    'https://github.com/ryanoasis/vim-devicons'
    'https://github.com/skywind3000/asyncrun.vim'
    'https://github.com/tpope/vim-abolish'
    'https://github.com/tpope/vim-commentary'
    'https://github.com/tpope/vim-dispatch'
    'https://github.com/tpope/vim-endwise'
    'https://github.com/tpope/vim-eunuch'
    'https://github.com/tpope/vim-fugitive'
    'https://github.com/tpope/vim-repeat'
    'https://github.com/tpope/vim-sensible'
    'https://github.com/tpope/vim-sleuth'
    'https://github.com/tpope/vim-speeddating'
    'https://github.com/tpope/vim-surround'
    'https://github.com/tpope/vim-unimpaired'
    'https://github.com/tpope/vim-vinegar'
    'https://github.com/vim-airline/vim-airline'
    'https://github.com/vim-airline/vim-airline-themes'
    'https://github.com/vim-test/vim-test'
    'https://github.com/wsdjeg/vim-fetch'
  )
  plugins_installed=0

  DEST_PATH="${HOME}/.vim/pack/bundle/start"
  if [[ $(ls -1 "${DEST_PATH}" 2>/dev/null | wc -l) -ne ${#urls[@]} ]]; then
    printf "${YELLOW}%s${NC}\n" 'Change in number of Vim plugins detected, repaving...'

    rm -rf "${DEST_PATH}"
  fi

  for url in ${urls[@]}; do
    install-vim-plugin "${url}"
    if [[ $? -eq 1 ]]; then
      plugins_installed=1
    fi
  done

  if [[ $plugins_installed -gt 0 ]]; then
    source "${YADM_SCRIPTS}/apply-vim-plugin-patches.sh"

    #printf "${YELLOW}%s${NC}\n" 'Updating documentation for Vim plugins...'
    #nvim -u NONE -c 'helptags ALL | qa!'
  fi
fi
