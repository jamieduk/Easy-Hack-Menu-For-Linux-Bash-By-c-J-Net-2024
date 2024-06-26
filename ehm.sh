#!/bin/bash
# Easy Hack Menu For Linux Bash By (c) J~Net 2024
# https://github.com/jamieduk/Easy-Hack-Menu-For-Linux-Bash-By-c-J-Net-2024
#
# ./ehm.sh
#
# Optional fr you to get
#https://github.com/trustedsec/social-engineer-toolkit
#https://github.com/topics/wpscan
#https://github.com/owasp-amass/amass
#https://github.com/galkan/crowbar
#https://github.com/blackploit/hash-identifier
#https://blog.didierstevens.com/category/forensics/
#https://github.com/gophish/gophish
#https://github.com/inAudible-NG/RainbowCrack-NG.git
#https://github.com/net-snmp/net-snmp


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


set_custom_color() {
	clear
    # Check if custom_col.set exists
    if [ ! -f "custom_col.set" ]; then
        # Define available colors with names and ANSI escape codes
        declare -A color_map=(
            ["black"]="\033[0;30m" ["red"]="\033[0;31m" ["green"]="\033[0;32m" ["yellow"]="\033[0;33m"
            ["blue"]="\033[0;34m" ["magenta"]="\033[0;35m" ["cyan"]="\033[0;36m" ["white"]="\033[0;37m"
            ["bright_black"]="\033[1;30m" ["bright_red"]="\033[1;31m" ["bright_green"]="\033[1;32m"
            ["bright_yellow"]="\033[1;33m" ["bright_blue"]="\033[1;34m" ["bright_magenta"]="\033[1;35m"
            ["bright_cyan"]="\033[1;36m" ["bright_white"]="\033[1;37m"
        )

		# Print color options with color names and numbers
		echo "Custom color not set. Please select a color from the following list:"
		index=1
		for color_name in "${!color_map[@]}"; do
			color_code="${color_map[$color_name]}"
			# Print the option number without color
			echo -n "$index. "
			# Print the color name with its respective color
			echo -e "$color_code$color_name\033[0m"  # Reset color after printing color name
			((index++))
		done


        # Prompt user to select a color by number or name
        read -p "Enter the number or name of the desired color: " selected_color
        # Check if the input is a number
        if [[ "$selected_color" =~ ^[0-9]+$ ]]; then
            # Convert the number to an index
            selected_color_index=$((selected_color-1))
            # Check if the selected index is valid
            if [ "$selected_color_index" -ge 0 ] && [ "$selected_color_index" -lt "${#color_map[@]}" ]; then
                # Get the color name corresponding to the selected index
                selected_color=$(printf '%s\n' "${!color_map[@]}" | sed -n "${selected_color}p")
            else
                echo "Invalid color selection."
                return 1
            fi
        fi

        # Check if the selected color exists
        if [ -n "${color_map[$selected_color]}" ]; then
            # Save selected color name and ANSI escape code to custom_col.set
            echo "${color_map[$selected_color]}${color_map[$selected_color]}" > custom_col.set
            echo "Custom color set to $selected_color."
        else
            echo "Invalid color selection."
        fi
    else
        echo ""
        clear
    fi
    clear
    main_menu
}

# Test Colour
#set_custom_color

#
main_menu() {
    while true; do
        custom_color=""
        if [ -f "custom_col.set" ]; then
            custom_color=$(<custom_col.set)
            if [ -n "$custom_color" ]; then
                colour=$custom_color
            else
                colour="\033[1;32m"
            fi
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
            3) exploitation_menu ;;
            4) post_exploitation_menu ;;
            5) miscellaneous_menu ;;
            6) analysis_menu ;;
            7) cracking_menu ;;
            8) extra_menu ;;
            9) msfconsole ;;
            10) exit ;;
            *) echo "Invalid choice. Please enter a number between 1 and 10." ;;
        esac
    done
}



reconnaissance_menu() {
    clear
    echo "### Reconnaissance Commands ###"
    echo "1. nmap 192.168.1.0/24"
    echo "2. nmap -sL"
    echo "3. nmap --script vuln"
    echo "4. nmap --script malware"
    echo "5. nmap -A"
    echo "6. nmap -f"
    echo "7. nmap --source-port"
    echo "8. nmap -D RND:10"
    echo "9. hping3 -S -V --flood"
    echo "10. hping3 --traceroute -S -V -p 80"
    echo "11. hping3 --traceroute -V -1"
    echo "12. ping"
    echo "13. ping -s"
    echo "14. ping -s -f"
    echo "15. masscan -p0-65535"
    echo "16. masscan -p80,443"
    echo "17. masscan -p23"
    echo "18. tcpdump -i any icmp"
    echo "19. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "nmap -p- 192.168.1.0/24" ;;
        2) custom_command "nmap -sL" ;;
        3) custom_command "nmap --script vuln" ;;
        4) custom_command "nmap --script malware" ;;
        5) custom_command "nmap -A" ;;
        6) custom_command "nmap -f" ;;
        7) custom_command "nmap --source-port" ;;
        8) custom_command "nmap -D RND:10" ;;
        9) custom_command "hping3 -S -V --flood" ;;
        10) custom_command "hping3 --traceroute -S -V -p 80" ;;
        11) custom_command "hping3 --traceroute -V -1" ;;
        12) custom_command "ping" ;;
        13) custom_command "ping -s" ;;
        14) custom_command "ping -s -f" ;;
        15) custom_command "masscan -p0-65535" ;;
        16) custom_command "masscan -p80,443" ;;
        17) custom_command "masscan -p23" ;;
        18) custom_command "tcpdump -i any icmp" ;;
        19) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 19." && sleep 2 ;;
    esac
}


# Function to display and execute enumeration commands
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


# Function to check if disclaimer has been accepted
check_disclaimer() {
    if [ -f "disclaimer_accepted" ]; then
        return 0
    else
        return 1
    fi
}

# Function to self-destruct script and scrub if disclaimer is rejected
self_destruct() {
    echo "Disclaimer Rejected. Self-destructing!..."
    # Insert your scrubbing command here to securely delete sensitive data
    # Example: shred -u -z -n 10 sensitive_file
    # Note: Be extremely careful with the command you use to avoid unintended consequences
    rm -rf "$0"
    exit 1
}

# Display disclaimer and prompt for acceptance
display_disclaimer() {
    echo "====================================================="
    echo "                 CYBER SECURITY DISCLAIMER           "
    echo "====================================================="
    echo "WARNING: This script is intended for ethical hacking,"
    echo "Penetration testing, and white-hat security purposes"
    echo "                     ONLY!                           "
    echo "Any unauthorized use is strictly prohibited!"
    echo ""
    read -p "Do you accept the terms of use? (y/n): " choice
    case "$choice" in
        [yY]|[yY][eE][sS])
            echo "$(date +'%d/%m/%Y') $USER Accepted Disclaimer For Using Easy Hack Menu Made By J~Net (c)2024 And Is Now Authorised For Ethical Use! " > disclaimer_accepted
            ;;
        *)
            self_destruct
            ;;
    esac
}



# Function to display and execute exploitation commands
exploitation_menu() {
    clear
    echo "### Exploitation Commands ###"
    echo "1. ssh"
    echo "2. git"
    echo "3. nc"
    echo "4. telnet"
    echo "5. exploitdb"
    echo "6. searchsploit"
    echo "7. <Include options for privilege escalation exploits>"
    echo "8. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "ssh" ;;
        2) custom_command "git" ;;
        3) custom_command "nc" ;;
        4) custom_command "telnet" ;;
        5) custom_command "<exploitdb command>" ;;
        6) custom_command "searchsploit" ;;
        7) custom_command "<Privilege Escalation Exploit command>" ;;
        8) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 8." && sleep 2 ;;
    esac
}


# Function to display and execute post-exploitation commands
post_exploitation_menu() {
    clear
    echo "### Post-Exploitation Commands ###"
    echo "1. nc -e /bin/sh"
    echo "2. nc -lvp"
    echo "3. nc -v"
    echo "4. ssh -D"
    echo "5. ssh user@remote_host"
    echo "6. sudo chmod +s /bin/bash"
    echo "7. <Include more post-exploitation frameworks like Empire or Cobalt Strike>"
    echo "8. <Include tools for data exfiltration, lateral movement, and persistence>"
    echo "9. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "nc -e /bin/sh" ;;
        2) custom_command "nc -lvp" ;;
        3) custom_command "nc -v" ;;
        4) custom_command "ssh -D" ;;
        5) custom_command "ssh user@remote_host" ;;
        6) custom_command "sudo chmod +s /bin/bash" ;;
        7) custom_command "<Post-Exploitation Framework command>" ;;
        8) custom_command "<Data Exfiltration command>" ;;
        9) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 9." && sleep 2 ;;
    esac
}

# Function to display and execute miscellaneous commands
miscellaneous_menu() {
    clear
    echo "### Miscellaneous Commands ###"
    echo "1. cat /dev/urandom"
    echo "2. iftop"
    echo "3. ptunnel"
    echo "4. tcpdump -i any icmp"
    echo "5. curl"
    echo "6. curl with custom header"
    echo "7. nikto"
    echo "8. wget"
    echo "9. gobuster"
    echo "10. tshark"
    echo "11. tmux"
    echo "12. timeout"
    echo "13. grep"
    echo "14. alias"
    echo "15. hexedit"
    echo "16. Bless (hex editor)"
    echo "17. Midnight Commander (mc)"
    echo "18. Vim (text editor)"
    echo "19. nano (text editor)"
    echo "20. aircrack-ng"
    echo "21. reaver"
    echo "22. setoolkit"
    echo "23. gophish"
    echo "24. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "cat /dev/urandom" ;;
        2) custom_command "iftop" ;;
        3) custom_command "ptunnel" ;;
        4) custom_command "tcpdump -i any icmp" ;;
        5) custom_command "curl" ;;
        6) custom_command "curl with custom header" ;;
        7) custom_command "nikto" ;;
        8) custom_command "wget" ;;
        9) custom_command "gobuster" ;;
        10) custom_command "tshark" ;;
        11) custom_command "tmux" ;;
        12) custom_command "timeout" ;;
        13) custom_command "grep" ;;
        14) custom_command "alias" ;;
        15) custom_command "hexedit" ;;
        16) custom_command "bless" ;;
        17) custom_command "mc" ;;
        18) custom_command "vim" ;;
        19) custom_command "nano" ;;
        20) custom_command "aircrack-ng" ;;
        21) custom_command "reaver" ;;
        22) custom_command "setoolkit" ;;
        23) custom_command "gophish" ;;
        24) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 24." && sleep 2 ;;
    esac
}



# Function to display and execute analysis commands
analysis_menu() {
    clear
    echo "### Analysis Commands ###"
    echo "1. tcpdump -w"
    echo "2. tcpdump -e ip.src -e ip.dst -e frame.protocols -T fields -r"
    echo "3. tcpdump -r -q -z follow,tcp,ascii,0"
    echo "4. wpscan"
    echo "5. <Include more tools for log analysis like logstash, splunk, or graylog>"
    echo "6. Install Volatility Memory Forensics tool"
    echo "7. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "tcpdump -w" ;;
        2) custom_command "tcpdump -e ip.src -e ip.dst -e frame.protocols -T fields -r" ;;
        3) custom_command "tcpdump -r -q -z follow,tcp,ascii,0" ;;
        4) custom_command "wpscan" ;;
        5) custom_command "<Log Analysis tool command>" ;;
        6) install_volatility ;;
        7) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 7." && sleep 2 ;;
    esac
}


# Function to display and execute cracking commands
cracking_menu() {
    clear
    echo "### Cracking Commands ###"
    echo "1. Install Seclists"
    echo "2. hashcat"
    echo "3. John the Ripper"
    echo "4. Hydra"
    echo "5. Medusa"
    echo "6. Crowbar"
    echo "7. RainbowCrack"
    echo "8. Crunch"
    echo "9. CeWL"
    echo "10. RarCrack"
    echo "11. Hash-Identifier"
    echo "12. Pass the Hash Toolkit"
    echo "13. Jack the Ripper"
    echo "14. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "sudo apt install -y seclists" ;;
        2) custom_command "hashcat" ;;
        3) custom_command "john" ;;
        4) custom_command "hydra" ;;
        5) custom_command "medusa" ;;
        6) custom_command "crowbar" ;;
        7) custom_command "rainbowcrack" ;;
        8) custom_command "crunch" ;;
        9) custom_command "cewl" ;;
        10) custom_command "rarcrack" ;;
        11) custom_command "hash-identifier" ;;
        12) custom_command "pth-toolkit" ;;  # Added "Pass the Hash Toolkit"
        13) custom_command "johntheripper" ;;
        14) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 14." && sleep 2 ;;
    esac
}



# Function to display and execute fun commands
check_install_xfreerdp() {
    if ! command -v xfreerdp &>/dev/null; then
        echo "Installing xfreerdp..."
        sudo apt install -y freerdp2-x11
    fi
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


install_volatility() {
    # Clone the Volatility repository
    git clone https://github.com/volatilityfoundation/volatility.git
    # Move into the Volatility directory
    cd volatility || exit
    # Install Volatility
    sudo python setup.py install
    # Check if Volatility is installed
    if command -v python &>/dev/null && python vol.py -h &>/dev/null; then
        echo "Volatility installation successful!"
    else
        echo "Volatility installation failed."
    fi
}

# Call the function to install Volatility
#install_volatility


# Function to install netcat package on Raspbian OS
install_netcat() {
    #echo "Checking if netcat (nc) is installed..."
    if [ -x "$(command -v nc)" ]; then
        echo ""
    else
        echo "netcat (nc) not found. Attempting to install it..."
        if sudo apt update -y && sudo apt install -y netcat-openbsd; then
            echo "netcat (nc) installed successfully."
        elif sudo apt update -y && sudo apt install -y netcat-traditional; then
            echo "netcat (nc) installed successfully."
        else
            echo "Error: Failed to install netcat (nc)."
            # Handle specific error cases here, if needed
        fi
    fi
}

# Install nc
install_netcat

custom_command() {
    if ! check_disclaimer; then
        display_disclaimer
        return
    fi
    #echo "Disclaimer Accepted!"

    # Extract the first word in the command for help lookup
    command=$(echo "$1" | awk '{print $1}')

    # Verify permissions if sudo is required
    if [[ $command == *"sudo"* && $(id -u) -ne 0 ]]; then
        echo "Error: This command requires elevated privileges. Please run the script with sudo."
        return
    fi

    # Check if the command is installed
    if ! command -v "$command" &>/dev/null; then
        # Prompt the user to install the missing command
        read -p "$command is not installed. Do you want to install it? (y/n): " install_choice
        if [[ $install_choice == "y" || $install_choice == "Y" ]]; then
            sudo apt install -y "$command"
            echo "$command installed successfully!"
        else
            echo "$command is required for this command. Aborting."
            return
        fi
    fi

    # Print help information for the selected program
    echo "Help information for $command:"
    # Try --help option first
    if ! $command --help ; then
        # If --help fails, try -help option
        if ! $command -help ; then
            echo "Error: Help information not available for $command"
            return
        fi
    fi

    # Prompt for customization
    read -p "Enter Customization (e.g. -p port IP): " customization

    # Execute the customized command
    echo "Executing command: $1 $customization"
    sudo $1 $customization

    # Wait for user input before returning to the main menu
    read -p "Press Enter to continue..."
    #bash ehm.sh
    main_menu
}

# Main program
main_menu



