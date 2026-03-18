#!/data/data/com.termux/files/usr/bin/bash

# Colors
white="\e[1;37m"
green="\e[1;32m"
red="\e[1;31m"
blue="\e[1;34m"
cyan="\e[1;36m"
reset="\e[0m"

clear

# Banner
echo -e "${cyan}"
echo " ███╗   ██╗ █████╗ ███╗   ██╗ ██████╗ "
echo " ████╗  ██║██╔══██╗████╗  ██║██╔═══██╗"
echo " ██╔██╗ ██║███████║██╔██╗ ██║██║   ██║"
echo " ██║╚██╗██║██╔══██║██║╚██╗██║██║   ██║"
echo " ██║ ╚████║██║  ██║██║ ╚████║╚██████╔╝"
echo " ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ "
echo -e "${white}          NanoURL Pro Masker${reset}"
echo -e "${blue}========================================${reset}"

# Input section
echo -e "${white}[+] Enter your link to mask:${reset}"
read -p "    > " phish_link

echo -e "\n${white}[+] Enter Mask Domain (e.g. google.com):${reset}"
read -p "    > " mask_domain

# Clean input
phish_link=$(echo $phish_link | tr -d ' ')
mask_domain=$(echo $mask_domain | sed -e 's|^[^/]*//||' -e 's|/.*$||')

echo -e "\n${green}[*] Masking url... Please wait${reset}"

# Shorten URL
short_url=$(curl -s "https://tinyurl.com/api-create.php?url=${phish_link}")

if [[ -z "$short_url" ]] || [[ "$short_url" == *"Error"* ]]; then
    echo -e "${red}[!] Primary failed, switching to backup...${reset}"
    short_url=$(curl -s "https://da.gd/s?url=${phish_link}")
fi

if [[ -z "$short_url" ]]; then
    echo -e "${red}[!] Fatal Error: Unable to shorten URL.${reset}"
    exit 1
fi

# Masking
final_short=${short_url#https://}
final_short=${final_short#http://}
masked_url="https://${mask_domain}@${final_short}"

# Output
echo -e "\n${blue}========================================${reset}"
echo -e "${green}[✔] Masked URL Generated Successfully${reset}"
echo -e "${white}${masked_url}${reset}"
echo -e "${blue}========================================${reset}"
echo -e "${cyan}Developed by:Cyber75${reset}"
