#!/usr/bin/env bash
set -ue

link_to_homedir() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
    local dotdir=$(dirname "${script_dir}")

    for f in "${dotdir}"/.??*; do
        local bf="$(basename ${f})" # Basename Filename
        echo $f
        [[ ${bf} == ".git" ]] && continue
        [[ ${bf} == ".gitignore" ]] && continue
        [[ ${bf} == ".gitattributes" ]] && continue 
        [[ ${bf} == ".gitmodules" ]] && continue
        if [[ -L "${HOME}/${bf}" ]]; then # is symlink
            command rm -f "${HOME}/.config/${bf}"
        fi
        command ln -sfnv "${f}" "${HOME}/.config"
    done
}

link_to_homedir
