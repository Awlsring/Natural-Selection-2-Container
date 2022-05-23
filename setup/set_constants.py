import os
import requests

print("LOADING DEFAULTS")

ADDRESS = os.environ.get(
    "ADDRESS", requests.get("http://checkip.amazonaws.com").text.strip()
)
PORT = os.environ.get("PORT", 27015)
QUERY_PORT = PORT + 1

STEAM_APP = "ns2"
STEAM_APP_ID = 4940

STEAM_APP_DIR = os.environ.get("STEAM_APP_DIR", "/home/steam/ns2-server")
STEAM_DIR = os.environ.get("STEAM_DIR", "/home/steam/steamcmd")

# Server start variables
# https://wiki.naturalselection2.com/view/Dedicated_Server#Server_Configuration
LIMIT = os.environ.get("LIMIT", 24)
PASSWORD = os.environ.get("PASSWORD")
SERVER_NAME = os.environ.get("SERVER_NAME", "NS2")
SPECTATOR_LIMIT = os.environ.get("SPECTATOR_LIMIT", 0)
MAP = os.environ.get("MAP", "ns2_summit")
CONFIG_PATH = os.environ.get("CONFIG_PATH", None)
LOG_DIR = os.environ.get("LOG_DIR", None)
MODS = os.environ.get("MODS", None)
MOD_STORAGE = os.environ.get("MOD_STORAGE", None)

WEB_ADMIN = False
if os.environ.get("WEB_ADMIN", False):
    WEB_ADMIN = True
WEB_DOMAIN = os.environ.get("WEB_DOMAIN", None)
WEB_USER = os.environ.get("WEB_USER", None)
WEB_PASSWORD = os.environ.get("WEB_PASSWORD", None)

DOWNLOAD_CLIENT = f"{STEAM_DIR}/steamcmd.sh +login anonymous \
        +force_install_dir {STEAM_APP_DIR} \
        +app_update {STEAM_APP_ID} \
        +quit"