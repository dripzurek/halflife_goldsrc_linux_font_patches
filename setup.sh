#!/usr/bin/env bash

BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"

SYM_SUCCESS=$GREEN✔$NORMAL
SYM_FAIL=$RED✘$NORMAL


echo -e
echo -e "############################################"
echo -e "## $YELLOW Half-Life GoldSrc Linux Font Patches $NORMAL"
echo -e "############################################"
echo -e "$NORMAL"
echo -e "➜ Action: $GREEN${ACTION}$NORMAL"
echo



STEAM_PATH=/home/user/.steam/debian-installation
STEAM_PATH_CSTRIKE=${STEAM_PATH}/steamapps/common/Half-Life/cstrike
STEAM_PATH_DOD=${STEAM_PATH}/steamapps/common/Half-Life/dod

FONT_DESTINATION=/usr/share/fonts/Retro\ Gaming.ttf

CSTRIKE_DESTINATION_1=$STEAM_PATH_CSTRIKE/resource/ClientScheme.res
CSTRIKE_DESTINATION_2=$STEAM_PATH_CSTRIKE/resource/TrackerScheme.res
DOD_DESTINATION_1=$STEAM_PATH_DOD/resource/ClientScheme.res
DOD_DESTINATION_2=$STEAM_PATH_DOD/resource/TrackerScheme.res



if [ "$ACTION" == "install" ]; then
  echo -e "➜ Downloading files ..."

  cd /tmp
  rm -rf hl_font_patches
  mkdir hl_font_patches
  cd hl_font_patches

  curl -sS https://raw.githubusercontent.com/magynhard/halflife_goldsrc_linux_font_patches/master/fonts/Retro%20Gaming.ttf -o RetroGaming.ttf

  curl -sS https://raw.githubusercontent.com/magynhard/halflife_goldsrc_linux_font_patches/master/cstrike/resource/TrackerScheme.res -o TrackerScheme.res.cstrike
  curl -sS https://raw.githubusercontent.com/magynhard/halflife_goldsrc_linux_font_patches/master/cstrike/resource/ClientScheme.res -o ClientScheme.res.cstrike

  curl -sS https://raw.githubusercontent.com/magynhard/halflife_goldsrc_linux_font_patches/master/dod/resource/TrackerScheme.res -o TrackerScheme.res.dod
  curl -sS https://raw.githubusercontent.com/magynhard/halflife_goldsrc_linux_font_patches/master/dod/resource/ClientScheme.res -o ClientScheme.res.dod
  echo


  echo -e "➜ Installing font ..."
  sudo rm -rf "$FONT_DESTINATION"
  sudo cp ./RetroGaming.ttf "$FONT_DESTINATION"
  if [ -f "$FONT_DESTINATION" ]; then
    sudo fc-cache -f
    echo -e "  $SYM_SUCCESS Installed successfully"
  else
    echo -e "  $SYM_FAIL Error when installing"
    exit 1
  fi
  echo

  echo -e "➜ Locating Steam installation ..."
  if [ -d "$STEAM_PATH" ]; then
      echo -e "  $SYM_SUCCESS Steam found at ${STEAM_PATH}"
      echo
      # CSTRIKE
      echo -e "➜ Locating Counter-Strike 1.6 installation ..."
      if [ -d "$STEAM_PATH_CSTRIKE" ]; then
          echo -e "  $SYM_SUCCESS Counter-Strike 1.6 found at ${STEAM_PATH_CSTRIKE}"
          echo -e "  ➜ Installing ClientScheme ..."
          if [ -f "${CSTRIKE_DESTINATION_1}.backup" ]; then
            echo -e "    $SYM_FAIL Backup of ClientScheme exists already"
          else
            mv $CSTRIKE_DESTINATION_1 ${CSTRIKE_DESTINATION_1}.backup
            echo -e "    $SYM_SUCCESS Created backup of original ClientScheme"
          fi
          rm -rf $CSTRIKE_DESTINATION_1
          cp ./ClientScheme.res.cstrike $CSTRIKE_DESTINATION_1
          if [ -f "$CSTRIKE_DESTINATION_1" ]; then
            echo -e "    $SYM_SUCCESS Installed ClientScheme successfully"
          else
            echo -e "    $SYM_FAIL Error when installing ClientScheme"
          fi
          echo -e "  ➜ Installing TrackerScheme ..."
          rm -rf $CSTRIKE_DESTINATION_2
          cp ./TrackerScheme.res.cstrike $CSTRIKE_DESTINATION_2
          if [ -f "$CSTRIKE_DESTINATION_2" ]; then
            echo -e "    $SYM_SUCCESS Installed TrackerScheme successfully"
          else
            echo -e "    $SYM_FAIL Error when installing TrackerScheme"
          fi
      else
          echo -e "  $SYM_FAIL Counter-Strike 1.6 not found. Skipping ..."
      fi
      echo
      # DOD
      echo -e "➜ Locating Day of Defeat 1.2 installation ..."
      if [ -d "$STEAM_PATH_DOD" ]; then
          echo -e "  $SYM_SUCCESS Day of Defeat 1.2 found at ${STEAM_PATH_DOD}"
          echo -e "  ➜ Installing ClientScheme ..."
          if [ -f "${DOD_DESTINATION_1}.backup" ]; then
            echo -e "    $SYM_FAIL Backup of ClientScheme exists already"
          else
            mv $DOD_DESTINATION_1 ${DOD_DESTINATION_1}.backup
            echo -e "    $SYM_SUCCESS Created backup of original ClientScheme"
          fi
          rm -rf $DOD_DESTINATION_1
          cp ./ClientScheme.res.cstrike $DOD_DESTINATION_1
          if [ -f "$DOD_DESTINATION_1" ]; then
            echo -e "    $SYM_SUCCESS Installed ClientScheme successfully"
          else
            echo -e "    $SYM_FAIL Error when installing ClientScheme"
          fi
          echo -e "  ➜ Installing TrackerScheme ..."
          rm -rf $DOD_DESTINATION_2
          cp ./TrackerScheme.res.cstrike $DOD_DESTINATION_2
          if [ -f "$DOD_DESTINATION_2" ]; then
            echo -e "    $SYM_SUCCESS Installed TrackerScheme successfully"
          else
            echo -e "    $SYM_FAIL Error when installing TrackerScheme"
          fi
      else
          echo -e "  $SYM_FAIL Day of Defeat 1.2 not found. Skipping ..."
      fi
  else
      echo -e "  $SYM_FAIL Steam not found. Aborting ..."
      exit 1
  fi
elif [ "$ACTION" == "uninstall" ]; then
    # FONT
    echo -e "➜ Locating font installation ..."
    if [ -f "$FONT_DESTINATION" ]; then
      echo -e "  $SYM_SUCCESS Font found at ${FONT_DESTINATION}"
      echo -e "  ➜ Uninstalling font ..."
      sudo rm -rf "$FONT_DESTINATION"
      if [ -f "$FONT_DESTINATION" ]; then
        echo -e "    $SYM_FAIL Error when uninstalling"
        exit 1
      else
        sudo fc-cache -f
        echo -e "    $SYM_SUCCESS Uninstalled successfully"
      fi
    else
      echo -e "  $SYM_FAIL Font not installed. Skipping ..."
    fi
    echo
    # CSTRIKE
    echo -e "➜ Locating Counter-Strike 1.6 installation ..."
    if [ -d "$STEAM_PATH_CSTRIKE" ]; then
      echo -e "  $SYM_SUCCESS Counter-Strike 1.6 found at ${STEAM_PATH_CSTRIKE}"
      #   ClientScheme
      echo -e "  ➜ Uninstalling ClientScheme ..."
      if [ -f "${CSTRIKE_DESTINATION_1}.backup" ]; then
        echo -e "    $SYM_SUCCESS ClientScheme backup found at ${CSTRIKE_DESTINATION_1}.backup"
        rm -rf "$CSTRIKE_DESTINATION_1"
        if [ -f "$CSTRIKE_DESTINATION_1" ]; then
          echo -e "    $SYM_FAIL Error when uninstalling ClientScheme (1/2)"
          exit 1
        else
          mv ${CSTRIKE_DESTINATION_1}.backup $CSTRIKE_DESTINATION_1
          if [ -f "$CSTRIKE_DESTINATION_1" ]; then
            echo -e "    $SYM_SUCCESS Uninstalled ClientScheme successfully"
          else
            echo -e "    $SYM_FAIL Error when uninstalling ClientScheme (2/2)"
            exit 1
          fi
        fi
      else
        echo -e "    $SYM_FAIL ClientScheme backup not installed. Skipping ..."
      fi
      #   TrackerScheme
      echo -e "  ➜ Uninstalling TrackerScheme ..."
      if [ -f "$CSTRIKE_DESTINATION_2" ]; then
        echo -e "    $SYM_SUCCESS TrackerScheme found at ${CSTRIKE_DESTINATION_2}"
        rm -rf "$CSTRIKE_DESTINATION_2"
        if [ -f "$CSTRIKE_DESTINATION_2" ]; then
          echo -e "    $SYM_FAIL Error when uninstalling TrackerScheme"
          exit 1
        else
          echo -e "    $SYM_SUCCESS Uninstalled TrackerScheme successfully"
        fi
      else
        echo -e "    $SYM_FAIL TrackerScheme not installed. Skipping ..."
      fi
    else
        echo -e "  $SYM_FAIL Counter-Strike 1.6 not found. Skipping ..."
    fi
    echo
    # DOD
    echo -e "➜ Locating Day of Defeat 1.2 installation ..."
    if [ -d "$STEAM_PATH_DOD" ]; then
      echo -e "  $SYM_SUCCESS Counter-Strike 1.6 found at ${STEAM_PATH_DOD}"
      #   ClientScheme
      echo -e "  ➜ Uninstalling ClientScheme ..."
      if [ -f "${DOD_DESTINATION_1}.backup" ]; then
        echo -e "    $SYM_SUCCESS ClientScheme backup found at ${DOD_DESTINATION_1}.backup"
        rm -rf "$DOD_DESTINATION_1"
        if [ -f "$DOD_DESTINATION_1" ]; then
          echo -e "    $SYM_FAIL Error when uninstalling ClientScheme (1/2)"
          exit 1
        else
          mv ${DOD_DESTINATION_1}.backup $DOD_DESTINATION_1
          if [ -f "$DOD_DESTINATION_1" ]; then
            echo -e "    $SYM_SUCCESS Uninstalled ClientScheme successfully"
          else
            echo -e "    $SYM_FAIL Error when uninstalling ClientScheme (2/2)"
            exit 1
          fi
        fi
      else
        echo -e "    $SYM_FAIL ClientScheme backup not installed. Skipping ..."
      fi
      #   TrackerScheme
      echo -e "  ➜ Uninstalling TrackerScheme ..."
      if [ -f "$DOD_DESTINATION_2" ]; then
        echo -e "    $SYM_SUCCESS TrackerScheme found at ${DOD_DESTINATION_2}"
        rm -rf "$DOD_DESTINATION_2"
        if [ -f "$DOD_DESTINATION_2" ]; then
          echo -e "    $SYM_FAIL Error when uninstalling TrackerScheme"
          exit 1
        else
          echo -e "    $SYM_SUCCESS Uninstalled TrackerScheme successfully"
        fi
      else
        echo -e "    $SYM_FAIL TrackerScheme not installed. Skipping ..."
      fi
    else
        echo -e "  $SYM_FAIL Day of Defeat 1.2 not found. Skipping ..."
    fi
else
  echo "Unknown action '$ACTION'. Aborting ..."
  exit 1
fi



echo
echo -e "############################################"
echo -e "## ${YELLOW}Script finished${NORMAL}"
echo -e "############################################"
