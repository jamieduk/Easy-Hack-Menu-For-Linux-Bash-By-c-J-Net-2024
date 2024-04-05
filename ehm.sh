#!/bin/bash
# Easy Hack Menu For Linux Bash By (c) J~Net 2024
# https://github.com/jamieduk/Easy-Hack-Menu-For-Linux-Bash-By-c-J-Net-2024
#
# ./ehm.sh
#
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
# Function to display the main menu
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
            8) extra_menu ;;
            9) exit ;;
            *) echo "Invalid choice. Please enter a number between 1 and 9." ;;
        esac
    done
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
    echo "14. masscan -p0-65535"
    echo "15. masscan -p80,443"
    echo "16. masscan -p23"
    echo "17. tcpdump -i any icmp"
    echo "18. Return to Main Menu"
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
        14) custom_command "masscan -p0-65535" ;;
        15) custom_command "masscan -p80,443" ;;
        16) custom_command "masscan -p23" ;;
        17) custom_command "tcpdump -i any icmp" ;;
        18) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 18." && sleep 2 ;;
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
            touch disclaimer_accepted
            ;;
        *)
            self_destruct
            ;;
    esac
}

# Function to execute a custom command after customization
	custom_command() {
	if ! check_disclaimer; then
		    display_disclaimer
    fi
    echo "Disclaimer Accepted!"

    command=$1
    # Verify permissions if sudo is required
    if [[ $command == *"sudo"* && $(id -u) -ne 0 ]]; then
        echo "Error: This command requires elevated privileges. Please run the script with sudo."
        return
    fi

    # Print help information for the selected program
    echo "Help information for $command:"
    $command --help

    # Prompt for customization
    read -p "Enter Customization (e.g. -p port IP): " customization

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
    echo "1. Install Seclists"
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
extra_menu() {
    clear
    echo "### Fun Commands ###"
    echo "1. sl"
    echo "2. Ollama Dolphin-Mixtral"
    echo "3. Change Text Colour"
    echo "4. Return to Main Menu"
    echo "------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) custom_command "sl" ;;
        2) sudo apt install -y ollama && ollama run Dolphin-Mixtral ;;
        3) if [ -f custom_col.set ]; then rm custom_col.set; fi && set_custom_color ;;
        4) main_menu ;;
        *) echo "Invalid choice. Please enter a number between 1 and 3." && sleep 2 ;;
    esac
}

# Function to install netcat package on Raspbian OS
install_netcat() {
    echo "netcat (nc) not found. Attempting to install it..."
    if sudo apt update -y && sudo apt install -y netcat-openbsd; then
        echo "netcat (nc) installed successfully."
    elif sudo apt update -y && sudo apt install -y netcat-traditional; then
        echo "netcat (nc) installed successfully."
    else
        echo "Error: Failed to install netcat (nc)."
        # Handle specific error cases here, if needed
    fi
}
# Install nc
install_netcat
# Main program
main_menu


