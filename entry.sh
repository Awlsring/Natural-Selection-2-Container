#!/bin/bash
mkdir -p "${SERVERDIR}" || true  

echo "installing / updating server"
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$SERVERDIR" +login anonymous +app_update "$STEAMAPPID" +quit
else
	steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$SERVERDIR" +login anonymous +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

cd "${SERVERDIR}"

command="${SERVERDIR}/x64/server_linux"
command+=" -name \"${NAME}\""
command+=" -port \"${PORT}\""
command+=" -map ${MAP}"
command+=" -limit ${LIMIT}"
command+=" -speclimit ${SPECTATOR_LIMIT}"
command+=" -config_path \"${CONFIG_PATH}\""
command+=" -logdir \"${LOG_DIR}\""
command+=" -modstorage \"${MOD_DIR}\""

if [[ -n "${PASSWORD}" ]]; then
    command+=" -password \"${PASSWORD}\""
fi

if [[ -n "${MODS}" ]]; then
    command+=" -mods \"${MODS}\""
fi

if [[ -n "${WEB_ADMIN}" ]]; then
    command+=" -webadmin"
fi

if [[ -n "${WEB_PORT}" ]]; then
    command+=" -webport ${WEB_PORT}"
fi

if [[ -n "${WEB_DOMAIN}" ]]; then
    command+=" -webdomain \"${WEB_DOMAIN}\""
fi

if [[ -n "${WEB_USER}" ]]; then
    command+=" -webuser \"${WEB_USER}\""
fi

if [[ -n "${WEB_PASSWORD}" ]]; then
    command+=" -webpassword \"${WEB_PASSWORD}\""
fi

echo "starting server with command: ${command}"

eval "$command"
