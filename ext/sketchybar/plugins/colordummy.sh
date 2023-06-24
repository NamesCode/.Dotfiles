#!/usr/bin/env bash

ROSEWATER="f5e0dc"
FLAMINGO="f2cdcd"
PINK="f5c2e7"
MAUVE="cba6f7"
RED="f38ba8"
MAROON="eba0ac"
PEACH="fab387"
YELLOW="f9e2af"
GREEN="a6e3a1"
TEAL="94e2d5"
SKY="89dceb"
SAPPHIRE="74c7ec"
BLUE="89b4fa"
LAVENDER="b4befe"
TEXT="cdd6f4"
SUBTEXT1="bac2de"
SUBTEXT0="a6adc8"
OVERLAY2="9399b2"
OVERLAY1="7f849c"
OVERLAY0="6c7086"
SURFACE2="585b70"
SURFACE1="45475a"
SURFACE0="313244"
BASE="1e1e2e"
MANTLE="181825"
CRUST="11111b"

function color() {
    alpha=${2:-255}
    color="$1"

    case $1 in
        rosewater) color=$ROSEWATER ;;
        flamingo) color=$FLAMINGO ;;
        pink) color=$PINK ;;
        mauve) color=$MAUVE ;;
        red) color=$RED ;;
        maroon) color=$MAROON ;;
        peach) color=$PEACH ;;
        yellow) color=$YELLOW ;;
        green) color=$GREEN ;;
        teal) color=$TEAL ;;
        sky) color=$SKY ;;
        sapphire) color=$SAPPHIRE ;;
        blue) color=$BLUE ;;
        lavender) color=$LAVENDER ;;
        text) color=$TEXT ;;
        subtext1) color=$SUBTEXT1 ;;
        subtext0) color=$SUBTEXT0 ;;
        overlay2) color=$OVERLAY2 ;;
        overlay1) color=$OVERLAY1 ;;
        overlay0) color=$OVERLAY0 ;;
        surface2) color=$SURFACE2 ;;
        surface1) color=$SURFACE1 ;;
        surface0) color=$SURFACE0 ;;
        crust) color=$CRUST ;;
        mantle) color=$MANTLE ;;
        base) color=$BASE ;;
        *) color=$BASE ;;
    esac
    printf -v alpha "%02x" "$alpha"
    echo "0x${alpha}${color}"
}

sketchybar \
    --bar \
    color=$(color mantle 180) \
    --default \
    icon.color=$(color red) \
    label.color=$(color red) \
    --set /space/ \
    icon.color=$(color red 170) \
    icon.highlight_color=$(color red) \
    --set window_title \
    icon.color=$(color overlay2) \
    label.color=$(color overlay2) \
    --set battery \
    icon.color=$(color blue) \
    label.color=$(color blue) \
    --set mic \
    icon.color=$(color peach) \
    label.color=$(color peach) \
    --set wifi \
    label.color=$(color teal) \
    --set sound \
    icon.color=$(color green) \
    label.color=$(color green) \
    --set time \
    icon.color=$(color yellow) \
    label.color=$(color yellow) \
    --set date \
    background.color=$(color yellow) \
    --set cpu_label \
    label.color=$(color maroon) \
    --set cpu_percent \
    label.color=$(color maroon) \
    --set apple.logo \
    icon.color=$(color yellow) \
    --set vpn \
    icon.color=$(color subtext1) \
    --set packages \
    label.color=$(color overlay0)

#Winston is sacred
