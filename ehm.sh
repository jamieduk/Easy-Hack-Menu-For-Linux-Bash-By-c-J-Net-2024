#!/bin/bash
# Easy Hack Menu For Linux Bash By (c) J~Net 2024
# https://github.com/jamieduk/Easy-Hack-Menu-For-Linux-Bash-By-c-J-Net-2024
#
# ./ehm.sh
#


# Function to display the main menu
main_menu() {
    clear
    echo -e "\033[1;32mEasy Hack Menu For Linux Bash By (c) J~Net 2024"
    echo ""
    echo "### Main Menu ###"
    echo "1. Reconnaissance Commands"
    echo "2. Enumeration Commands"
    echo "3. Exploitation Commands"
    echo "4. Post-Exploitation Commands"
    echo "5. Miscellaneous Commands"
    echo "6. Analysis Commands"
    echo "7. Cracking Commands"
    echo "8. Fun Commands"
    echo "9. Exit"
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
        8) fun_menu ;;
        9) exit ;;
        *) echo "Invalid choice. Please enter a number between 1 and 9." && sleep 2 ;;
    esac
}

# Function to display and execute reconnaissance commands
reconnaissance_menu() {
    clear
    echo "### Reconnaissance Commands ###"
    echo "1. hping3 -S -V --flood"
    echo "2. hping3 --traceroute -S -V -p 80"
    echo "3. ping"
    echo "4. nmap -sL"
    echo "5. nmap --script vuln"
    echo "6. ping -s"
    echo "7. nmap --script malware"
    echo "8. ping -s -f"
    echo "9. nmap -A"
    echo "10. nmap -f"
    echo "11. nmap --source-port"
    echo "12. hping3 --traceroute -V -1"
    echo "13. nmap -D RND:10"
    echo "14. masscan -p"
    echo "15. tcpdump -i any icmp"
    echo "16. masscan -p0-65535"
    echo "17. masscan -p80,443"
    echo "18. masscan -p23"
    echo "19. masscan -p23"
    echo "20. masscan -p23"
    echo "21. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "hping3 -S -V --flood" ;;
        2) custom_command "hping3 --traceroute -S -V -p 80" ;;
        3) custom_command "ping" ;;
        4) custom_command "nmap -sL" ;;
        5) custom_command "nmap --script vuln" ;;
        6) custom_command "ping -s" ;;
        7) custom_command "nmap --script malware" ;;
        8) custom_command "ping -s -f" ;;
        9) custom_command "nmap -A" ;;
        10) custom_command "nmap -f" ;;
        11) custom_command "nmap --source-port" ;;
        12) custom_command "hping3 --traceroute -V -1" ;;
        13) custom_command "nmap -D RND:10" ;;
        14) custom_command "masscan -p" ;;
        15) custom_command "tcpdump -i any icmp" ;;
        16) custom_command "masscan -p0-65535" ;;
        17) custom_command "masscan -p80,443" ;;
        18) custom_command "masscan -p23" ;;
        19) custom_command "masscan -p23" ;;
        20) custom_command "masscan -p23" ;;
        21) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 21." && sleep 2 ;;
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
    echo "9. amass enum -passive -d"
    echo "10. searchsploit"
    echo "11. Return to Main Menu"
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
        9) custom_command "amass enum -passive -d" ;;
        10) custom_command "searchsploit" ;;
        11) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 11." && sleep 2 ;;
    esac
}


# Function to execute a custom command after customization
custom_command() {
    command=$1

    # Print help information for the selected program
    echo "Help information for $command:"
    $command --help

    # Prompt for customization
    read -p "Enter any customization (e.g., -p port IP ): " customization

    # Execute the customized command
    echo "Executing command: $command $customization"
    sudo $command $customization

    # Wait for user input before returning to the main menu
    read -p "Press Enter to continue..."
    #bash ehm.sh
    main_menu
}


# Function to display and execute exploitation commands
exploitation_menu() {
    clear
    echo "### Exploitation Commands ###"
    echo "1. ssh"
    echo "2. git"
    echo "3. nc reverse shell"
    echo "4. nc simple chat server"
    echo "5. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "ssh" ;;
        2) custom_command "git" ;;
        3) custom_command "nc reverse shell" ;;
        4) custom_command "nc simple chat server" ;;
        5) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 5." && sleep 2 ;;
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
    echo "7. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "nc -e /bin/sh" ;;
        2) custom_command "nc -lvp" ;;
        3) custom_command "nc -v" ;;
        4) custom_command "ssh -D" ;;
        5) custom_command "ssh user@remote_host" ;;
        6) custom_command "sudo chmod +s /bin/bash" ;;
        7) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 7." && sleep 2 ;;
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
    echo "15. Return to Main Menu"
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
        15) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 15." && sleep 2 ;;
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
    echo "5. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "tcpdump -w" ;;
        2) custom_command "tcpdump -e ip.src -e ip.dst -e frame.protocols -T fields -r" ;;
        3) custom_command "tcpdump -r -q -z follow,tcp,ascii,0" ;;
        4) custom_command "wpscan" ;;
        5) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 5." && sleep 2 ;;
    esac
}

# Function to display and execute cracking commands
cracking_menu() {
    clear
    echo "### cracking Commands ###"
    echo "1. sudo apt install seclists"
    echo "2. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "sudo apt install -y seclists" ;;
        2) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 2." && sleep 2 ;;
    esac
}

# Function to display and execute fun commands
fun_menu() {
    clear
    echo "### Fun Commands ###"
    echo "1. sl"
    echo "2. Ollama Dolphin-Mixtral"
    echo "3. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "sl" ;;
        2) ollama Dolphin-Mixtral ;;
        3) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 3." && sleep 2 ;;
    esac
}


# Main program
main_menu



