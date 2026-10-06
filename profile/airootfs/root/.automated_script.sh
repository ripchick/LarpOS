#!/bin/bash

script_cmdline() {
    local param
    for param in $(</proc/cmdline); do
        case "${param}" in
            script=*)
                echo "${param#*=}"
                return 0
                ;;
        esac
    done
}

automated_script() {
    local script rt
    script="$(script_cmdline)"
    if [[ -n "${script}" && ! -f "/tmp/.automated_script.sh" ]]; then
        if [[ "${script}" == "http://"* || "${script}" == "https://"* || "${script}" == "ftp://"* ]]; then
            printf '%s: downloading %s\n' "$0" "${script}"
            curl -Ls "${script}" > "/tmp/.automated_script.sh"
        else
            cp "${script}" "/tmp/.automated_script.sh"
        fi
        printf '\n'
        printf '%s: executing %s\n' "$0" "${script}"
        chmod +x "/tmp/.automated_script.sh"
        rt=0
        . "/tmp/.automated_script.sh" 2>/dev/null || rt=$?
        printf '\n'
        if [ "${rt}" -ne 0 ]; then
            echo "Script execution failed. Exiting to emergency shell."
            exit ${rt}
        fi
        touch "/tmp/.automated_script.sh"
    fi
}

if [[ "$(tty)" == "/dev/tty1" ]]; then
    automated_script
fi
