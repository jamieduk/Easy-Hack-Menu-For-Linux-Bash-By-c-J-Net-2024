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
    "freerdp2-x11"
    "remmina"
    "krdc"
    "hping3"
    "nmap"
    "sqlmap"
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
# Function to display and execute SQLmap commands
sqlmap_menu() {
    clear
    echo "### SQLmap Commands ###"
    echo "1. Basic SQLmap scan"
    echo "2. SQLmap with a specific URL"
    echo "3. SQLmap with custom user-agent"
    echo "4. SQLmap with a specific payload"
    echo "5. SQLmap with enumeration of databases"
    echo "6. SQLmap with enumeration of tables"
    echo "7. SQLmap with enumeration of columns"
    echo "8. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "sqlmap -u http://example.com/vulnerable.php?id=1 --batch" ;;
        2) read -p "Enter the URL: " url && custom_command "sqlmap -u $url --batch" ;;
        3) read -p "Enter the User-Agent: " user_agent && custom_command "sqlmap -u http://example.com/vulnerable.php?id=1 --user-agent \"$user_agent\" --batch" ;;
        4) read -p "Enter the payload: " payload && custom_command "sqlmap -u http://example.com/vulnerable.php?id=1 --payload \"$payload\" --batch" ;;
        5) custom_command "sqlmap -u http://example.com/vulnerable.php?id=1 --dbs --batch" ;;
        6) read -p "Enter the database name: " db_name && custom_command "sqlmap -u http://example.com/vulnerable.php?id=1 -D $db_name --tables --batch" ;;
        7) read -p "Enter the database name: " db_name && read -p "Enter the table name: " table_name && custom_command "sqlmap -u http://example.com/vulnerable.php?id=1 -D $db_name -T $table_name --columns --batch" ;;
        8) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 8." && sleep 2 ;;
    esac
}


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
            echo "User $USER agreed to the terms on $(date)" > agreement.log
        fi
    fi
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

# Define the remote menu functions
remote_menu() {
    echo "Remote Menu"
    echo "1. Connect to RDP"
    echo "2. Brute Force RDP"
    echo "3. Exit"
}

connect_rdp() {
    read -p "Enter IP address: " ip
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo
    xfreerdp /u:$username /p:$password /v:$ip
}

brute_force_rdp() {
    read -p "Enter file with IP addresses: " ip_file
    read -p "Enter file with usernames: " username_file
    read -p "Enter file with passwords: " password_file

    while IFS= read -r ip; do
        while IFS= read -r username; do
            while IFS= read -r password; do
                echo "Attempting $username:$password on $ip"
                # Use a tool like xfreerdp or custom script to attempt connection
                # Example command, replace with actual brute force command:
                xfreerdp /u:$username /p:$password /v:$ip
                # Implement your logic to check if the connection was successful
            done < "$password_file"
        done < "$username_file"
    done < "$ip_file"
}

execute_remote_menu() {
    while true; do
        remote_menu
        read -p "Select an option [1-3]: " option
        case $option in
            1)
                connect_rdp
                ;;
            2)
                brute_force_rdp
                ;;
            3)
                main_menu
                ;;
            *)
                echo "Invalid option. Please try again."
                ;;
        esac
    done
}

# Call this function when needed to run the remote menu
# Example usage:
# execute_remote_menu


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

GREEN='\033[0;32m'
NC='\033[0m' # No color (reset)
echo -e "${GREEN} Welcome To 
                  _____ _   _ __  __ 
                 | ____| | | |  \/  |
                 |  _| | |_| | |\/| |
                 | |___|  _  | |  | |
                 |_____|_| |_|_|  |_|

Easy Hack Menu (c) J~Net 2024"


# Main menu function
main_menu() {
    clear
    GREEN='\033[0;32m'
    NC='\033[0m' # No color (reset)
    echo -e "${GREEN} Welcome To 
                  _____ _   _ __  __ 
                 | ____| | | |  \/  |
                 |  _| | |_| | |\/| |
                 | |___|  _  | |  | |
                 |_____|_| |_|_|  |_|

Easy Hack Menu (c) J~Net 2024"
    echo ""
    echo "### Main Menu ###"
    echo "1. Exploitation"
    echo "2. Post-Exploitation"
    echo "3. Miscellaneous"
    echo "4. Analysis"
    echo "5. Cracking"
    echo "6. Extra"
    echo "7. Reconnaissance"
    echo "8. Enumeration"
    echo "9. SQLmap"  # Added SQLmap option
    echo "10. Remote Menu" # New option for Remote Menu
    echo "11. Exit"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) exploitation_menu ;;
        2) post_exploitation_menu ;;
        3) miscellaneous_menu ;;
        4) analysis_menu ;;
        5) cracking_menu ;;
        6) extra_menu ;;
        7) reconnaissance_menu ;;
        8) enumeration_menu ;;
        9) sqlmap_menu ;;  # Added SQLmap menu
        10) execute_remote_menu ;; # Call the remote menu function
        11) exit 0 ;;
        *) echo "Invalid choice. Please enter a number between 1 and 11." && sleep 2 ;;
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
display_agreement
# Start the script
main_menu

