#!/bin/bash
# Easy Hack Menu For Linux Bash By (c) J~Net 2024
# https://github.com/jamieduk/Easy-Hack-Menu-For-Linux-Bash-By-c-J-Net-2024
#
# ./ehm.sh
#
#https://github.com/trustedsec/social-engineer-toolkit
#https://github.com/topics/wpscan
#https://github.com/owasp-amass/amass
#https://github.com/galkan/crowbar
#https://github.com/blackploit/hash-identifier
#https://blog.didierstevens.com/category/forensics/
#https://github.com/gophish/gophish
#https://github.com/inAudible-NG/RainbowCrack-NG.git
#https://github.com/net-snmp/net-snmp
#
# List of packages to install
packages=(
    "netcat-openbsd"
    "hping3"
    "nmap"
    "whatweb"
    "dirb"
    "dirsearch"
    "ffuf"
    "hashcat"
    "john"
    "hydra"
    "medusa"
    "crunch"
    "cewl"
    "rarcrack"
    "sl"
    "iftop"
    "ptunnel"
    "tcpdump"
    "curl"
    "nikto"
    "wget"
    "gobuster"
    "tshark"
    "tmux"
    "grep"
    "hexedit"
    "bless"
    "mc"
    "vim"
    "nano"
    "aircrack-ng"
    "reaver"
    "socat"
)

# Function to check if a package is installed
package_installed() {
    dpkg -l "$1" &> /dev/null
}

# Function to install a package if not already installed
install_package() {
    if ! package_installed "$1"; then
        sudo apt update -y
        sudo apt install -y "$1"
    fi
}

# Loop through each package and install if necessary
for package in "${packages[@]}"; do
    install_package "$package"
done

# Function to set custom color for the menu
set_custom_color() {
    clear
    declare -A color_map=(
        ["black"]="\033[0;30m" ["red"]="\033[0;31m" ["green"]="\033[0;32m"
        ["yellow"]="\033[0;33m" ["blue"]="\033[0;34m" ["magenta"]="\033[0;35m"
        ["cyan"]="\033[0;36m" ["white"]="\033[0;37m" ["bright_black"]="\033[1;30m"
        ["bright_red"]="\033[1;31m" ["bright_green"]="\033[1;32m" ["bright_yellow"]="\033[1;33m"
        ["bright_blue"]="\033[1;34m" ["bright_magenta"]="\033[1;35m" ["bright_cyan"]="\033[1;36m"
        ["bright_white"]="\033[1;37m"
    )
    
    echo "Please select a color:"
    index=1
    for color_name in "${!color_map[@]}"; do
        color_code="${color_map[$color_name]}"
        echo -n "$index. "
        echo -e "$color_code$color_name\033[0m"
        ((index++))
    done
    
    read -p "Enter the number or name of the color: " selected_color
    if [[ "$selected_color" =~ ^[0-9]+$ ]]; then
        selected_color_index=$((selected_color - 1))
        selected_color=$(printf '%s\n' "${!color_map[@]}" | sed -n "$selected_color_index"p)
    fi
    
    if [ -n "${color_map[$selected_color]}" ]; then
        echo "${color_map[$selected_color]}" > custom_col.set
        echo "Color set to $selected_color."
    else
        echo "Invalid color."
    fi
}

# File where agreement status will be saved
AGREEMENT_FILE="user_agreement_accepted.txt"

# Function to display the user agreement
display_agreement() {
    if [ -f "agreement.log" ]; then
        return  # Exit the function if the file exists
    else
        clear
        echo "### User Agreement ###"
        echo "Please read the following agreement carefully."
        echo ""
        echo "By using this script, you agree to the following terms:"
        
        # ANSI color codes for green and reset (no color)
        GREEN='\033[0;32m'
        NC='\033[0m' # No color (reset)

        # Display the user agreement in green
        echo -e "${GREEN}1. You will use this script responsibly and ethically."
        echo -e "2. You acknowledge that this script is provided as-is without any warranty."
        echo -e "3. You agree to follow all applicable laws when using this script."
        echo -e "4. The authors of this script are not responsible for any misuse.${NC}"
        echo ""

        # Ask the user if they agree to the terms
        read -p "Do you accept the agreement? (yes/no): " AGREEMENT

        if [[ "$AGREEMENT" != "yes" ]]; then
            echo "You did not agree to the terms. Exiting."
            exit 1  # Exit if the user does not agree
        else
            echo "Thank you for agreeing to the terms."
            # Save agreement to a file
            echo "User agreed to the terms on $(date)" > agreement.log
        fi
    fi
}


# Function to display custom command
custom_command() {
    clear
    echo "Executing: $1"
    eval "$1"
    read -p "Press Enter to continue..."
}

# Function to display the extra menu
extra_menu() {
    clear
    echo "### Extra Commands ###"
    echo "1. sl"
    echo "2. Ollama Dolphin-Mistral"
    echo "3. Change Text Colour"
    echo "4. ifconfig"
    echo "5. netstat"
    echo "6. iptables"
    echo "7. top"
    echo "8. htop"
    echo "9. nload"
    echo "10. iftop"
    echo "11. xfreerdp (Remote Desktop Connection)"
    echo "12. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "sl" ;;
        2) sudo apt install -y ollama && ollama run Dolphin-Mistral ;;
        3) if [ -f custom_col.set ]; then rm custom_col.set; fi && set_custom_color ;;
        4) custom_command "ifconfig" ;;
        5) custom_command "netstat" ;;
        6) custom_command "iptables" ;;
        7) custom_command "top" ;;
        8) custom_command "htop" ;;
        9) custom_command "nload" ;;
        10) custom_command "iftop" ;;
        11) check_install_xfreerdp && custom_command xfreerdp ;;
        12) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 12." && sleep 2 ;;
    esac
}


# Reconnaissance menu
reconnaissance_menu() {
    clear
    echo "### Reconnaissance Commands ###"
    echo "1. nmap -sV 127.0.0.1 | grep open"
    echo "2. curl --head 127.0.0.1:80"
    echo "3. nmap -sL"
    echo "4. nmap --script vuln"
    echo "5. nmap --script malware"
    echo "6. nmap -A"
    echo "7. nmap -f"
    echo "8. nmap --source-port"
    echo "9. nmap -D RND:10"
    echo "10. hping3 -S -V --flood"
    echo "11. masscan -p0-65535"
    echo "12. tcpdump -i any icmp"
    echo "13. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "nmap -sV 127.0.0.1 | grep open" ;;
        2) custom_command "curl --head 127.0.0.1:80" ;;
        3) custom_command "nmap -sL" ;;
        4) custom_command "nmap --script vuln" ;;
        5) custom_command "nmap --script malware" ;;
        6) custom_command "nmap -A" ;;
        7) custom_command "nmap -f" ;;
        8) custom_command "nmap --source-port" ;;
        9) custom_command "nmap -D RND:10" ;;
        10) custom_command "hping3 -S -V --flood" ;;
        11) custom_command "masscan -p0-65535" ;;
        12) custom_command "tcpdump -i any icmp" ;;
        13) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 13." && sleep 2 ;;
    esac
}

# Enumeration menu
enumeration_menu() {
    clear
    echo "### Enumeration Commands ###"
    echo "1. nmap -sn"
    echo "2. nmap -sV"
    echo "3. whatweb"
    echo "4. nmap -O"
    echo "5. nmap -Pn"
    echo "6. wpscan --url --enumerate u"
    echo "7. wpscan --url --enumerate p"
    echo "8. amass enum -passive -d"
    echo "9. onesixtyone"
    echo "10. snmp-check"
    echo "11. dirb"
    echo "12. dirsearch"
    echo "13. ffuf"
    echo "14. searchsploit"
    echo "15. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "nmap -sn" ;;
        2) custom_command "nmap -sV" ;;
        3) custom_command "whatweb" ;;
        4) custom_command "nmap -O" ;;
        5) custom_command "nmap -Pn" ;;
        6) custom_command "wpscan --url --enumerate u" ;;
        7) custom_command "wpscan --url --enumerate p" ;;
        8) custom_command "amass enum -passive -d" ;;
        9) custom_command "onesixtyone" ;;
        10) custom_command "snmp-check" ;;
        11) custom_command "dirb" ;;
        12) custom_command "dirsearch" ;;
        13) custom_command "ffuf" ;;
        14) custom_command "searchsploit" ;;
        15) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 15." && sleep 2 ;;
    esac
}

# Main menu function
main_menu() {
    while true; do
        custom_color=""
        if [ -f "custom_col.set" ]; then
            custom_color=$(<custom_col.set)
            colour=$custom_color
        else
            colour="\033[1;32m"
        fi

        echo -e "${colour}Easy Hack Menu For Linux Bash By (c) J~Net 2024"
        echo ""
        echo "### Main Menu ###"
        echo "1. Reconnaissance Commands"
        echo "2. Enumeration Commands"
        echo "3. Exploitation Commands"
        echo "4. Post-Exploitation Commands"
        echo "5. Miscellaneous Commands"
        echo "6. Analysis Commands"
        echo "7. Cracking Commands"
        echo "8. Extra Commands & Settings"
        echo "9. Launch Metasploit Console"
        echo "10. Exit"
        echo "------------------"
        read -p "Enter your choice: " choice

        case $choice in
            1) reconnaissance_menu ;;
            2) enumeration_menu ;;
            3) exploitation_menu ;;  # Placeholder, to be implemented
            4) post_exploitation_menu ;;  # Placeholder, to be implemented
            5) miscellaneous_menu ;;  # Placeholder, to be implemented
            6) analysis_menu ;;  # Placeholder, to be implemented
            7) cracking_menu ;;  # Placeholder, to be implemented
            8) extra_menu ;;  # Placeholder, to be implemented
            9) custom_command "msfconsole" ;;
            10) echo "Exiting..." && break ;;
            *) echo "Invalid choice. Please enter a number between 1 and 10." && sleep 2 ;;
        esac
    done
}

# Start the script
main_menu

