import os
import subprocess
import time
import a2s

import set_constants as constants

"""
Script to bootstrap container.
Downloads game client then starts game client
"""


def download_client():
    command = constants.DOWNLOAD_CLIENT
    print(f"Download Client Command: {command}")

    process = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)

    while True:
        print(process.stdout.readline().decode())
        if process.poll() == 0:
            break
        time.sleep(30)

    print("Finished downloading client")


def form_start_command():
    command = f"{constants.STEAM_APP_DIR}/x64/server_linux -name {constants.SERVER_NAME} -port {constants.PORT} -map {constants.MAP} -limit {constants.LIMIT}"

    if constants.WEB_ADMIN:
        command = f"{command} -webadmin"
    if constants.WEB_DOMAIN != None:
        command = f'{command} -webdomain "{constants.WEB_DOMAIN}"'
    if constants.WEB_USER != None:
        command = f"{command} -webuser {constants.WEB_USER}"
    if constants.WEB_PASSWORD != None:
        command = f"{command} -webpassword {constants.WEB_PASSWORD}"

    if constants.SPECTATOR_LIMIT != None:
        command = f"{command} -speclimit {constants.SPECTATOR_LIMIT}"

    if constants.CONFIG_PATH != None:
        command = f"{command} -config_path {constants.CONFIG_PATH}"

    if constants.LOG_DIR != None:
        command = f"{command} -logdir {constants.LOG_DIR}"

    if constants.MODS != None:
        command = f"{command} -mods {constants.MODS}"

    if constants.MOD_STORAGE != None:
        command = f"{command} -modstorage {constants.MOD_STORAGE}"

    return command


def start_client():
    app_location = constants.STEAM_APP_DIR
    os.chdir(app_location)

    command = form_start_command()

    print("Starting client")

    subprocess.Popen(command, shell=True)

    ping_server(constants.ADDRESS, constants.QUERY_PORT)


def ping_server(address, query_port):
    attempts = 0
    while True:
        try:
            a2s.info((address, query_port))
        except Exception as error:
            if attempts == 10:
                raise Exception(error)
            attempts = attempts + 1
        finally:
            break


def main():
    print("Bootstraping")
    download_client()
    start_client()
    while True:
        time.sleep(1000)


if __name__ == "__main__":
    main()
