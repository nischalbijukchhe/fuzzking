#!/bin/bash
echo "Made by NEPAX - Thanks to LOSTSEC!"
sleep 1

expand_path() {
    local path="$1"
    if [[ $path == ~* ]]; then
        path="${path/#\~/$HOME}"
    fi
    echo "$path"
}

handle_sigint() {
    echo -e "\nCtrl+C detected."
    echo "Choose an option:"
    echo "1) Exit"
    echo "2) Save output"
    echo "3) Go to main menu"
    read -p "Enter your choice [1-3]: " sig_choice
    case "$sig_choice" in
        1)
            echo "Exiting..."
            exit 0
            ;;
        2)
            echo "Saving output to default_output.txt... (simulated)"
            # In a real scenario, capture and save the current output here.
            exit 0
            ;;
        3)
            echo "Returning to main menu..."
            main_menu
            ;;
        *)
            echo "Invalid choice. Returning to main menu..."
            main_menu
            ;;
    esac
}

trap handle_sigint SIGINT

check_ffuf_installation() {
    if ! command -v ffuf &> /dev/null; then
        echo "ffuf is not installed. Installing ffuf..."
        go install github.com/ffuf/ffuf@latest
        if [ $? -eq 0 ]; then
            echo "ffuf installed successfully."
            export PATH=$PATH:$(go env GOPATH)/bin
        else
            echo "Failed to install ffuf. Please install it manually."
            exit 1
        fi
    else
        echo "ffuf is already installed."
    fi
}

display_menu() {
    echo ""
    echo "FFUF Fuzzing Toolkit"
    echo "========================"
    echo "1) Directory/File Brute Force"
    echo "2) POST Request Fuzzing"
    echo "3) Case Insensitive Search"
    echo "4) File Extension Fuzzing"
    echo "5) Recursive Fuzzing"
    echo "6) Subdomain Fuzzing"
    echo "7) Virtual Host Fuzzing"
    echo "8) Fuzzing GET Parameters"
    echo "9) Fuzzing POST Parameters"
    echo "10) Login Bypass Fuzzing"
    echo "11) PUT Request Fuzzing"
    echo "12) Clusterbomb Attack"
    echo "13) Pitchfork Attack"
    echo "14) Setting Cookies"
    echo "15) Using Proxies"
    echo "16) Custom Header Fuzzing"
    echo "17) Fuzzing with Custom User-Agent"
    echo "18) Rate Limiting Bypass"
    echo "19) Output to HTML"
    echo "20) Output to JSON"
    echo "21) Output to CSV"
    echo "========================"
}

execute_ffuf_command() {
    local option=$1
    local domain=$2
    local wordlist=$3
    local userlist=$4
    local passlist=$5
    local wordlist2=$6
    local proxy=$7
    local cookie=$8
    local status_codes=$9

    base_flags="-t 50"

    if [[ -z $status_codes ]]; then
        echo "Error: Status codes are required for the -mc flag."
        exit 1
    elif [[ $status_codes == "all" ]]; then
        base_flags="$base_flags -mc all"
    else
        base_flags="$base_flags -mc $status_codes"
    fi

    case $option in
        1)
            echo "Running Directory/File Brute Force..."
            ffuf -u "$domain/FUZZ" -w "$wordlist" $base_flags
            ;;
        2)
            echo "Running POST Request Fuzzing..."
            ffuf -u "$domain/FUZZ" -w "$wordlist" -X POST $base_flags
            ;;
        3)
            echo "Running Case Insensitive Search..."
            ffuf -u "$domain/FUZZ" -w "$wordlist" -ic -c $base_flags
            ;;
        4)
            echo "Running File Extension Fuzzing..."
            ffuf -u "$domain/indexFUZZ" -w "$wordlist" -e .php,.bak,.db,.asp $base_flags
            ;;
        5)
            echo "Running Recursive Fuzzing..."
            ffuf -u "$domain/FUZZ" -w "$wordlist" -recursion -recursion-depth 3 $base_flags
            ;;
        6)
            echo "Running Subdomain Fuzzing..."
            ffuf -w "$wordlist" -u "https://FUZZ.$domain" $base_flags
            ;;
        7)
            echo "Running Virtual Host Fuzzing..."
            ffuf -w "$wordlist" -u "$domain/" -H "Host: FUZZ.$domain" $base_flags
            ;;
        8)
            echo "Running Fuzzing GET Parameters..."
            ffuf -w "$wordlist" -u "$domain/page?FUZZ=value" $base_flags
            ;;
        9)
            echo "Running Fuzzing POST Parameters..."
            ffuf -w "$wordlist" -u "$domain/api" -X POST -d 'FUZZ=value' $base_flags
            ;;
        10)
            echo "Running Login Bypass Fuzzing..."
            ffuf -w "$passlist" -u "$domain/login" -X POST -d "username=admin&password=FUZZ" $base_flags
            ;;
        11)
            echo "Running PUT Request Fuzzing..."
            ffuf -w "$wordlist" -X PUT -u "$domain/FUZZ" -b "$cookie" $base_flags
            ;;
        12)
            echo "Running Clusterbomb Attack..."
            ffuf -mode clusterbomb -w "$userlist:USER" -w "$passlist:PASS" -u "$domain/login?user=USER&pass=PASS" $base_flags
            ;;
        13)
            echo "Running Pitchfork Attack..."
            ffuf -mode pitchfork -w "$userlist:USER" -w "$passlist:PASS" -u "$domain/login?user=USER&pass=PASS" $base_flags
            ;;
        14)
            echo "Setting Cookies..."
            ffuf -b "$cookie" -w "$wordlist" -u "$domain/FUZZ" $base_flags
            ;;
        15)
            echo "Using Proxies..."
            ffuf -x "$proxy" -w "$wordlist" -u "$domain/FUZZ" $base_flags
            ;;
        16)
            echo "Running Custom Header Fuzzing..."
            ffuf -w "$wordlist" -u "$domain/" -H "X-Custom-Header: FUZZ" $base_flags
            ;;
        17)
            echo "Fuzzing with Custom User-Agent..."
            ffuf -u "$domain/FUZZ" -w "$wordlist" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $base_flags
            ;;
        18)
            echo "Running Rate Limiting Bypass..."
            ffuf -w "$wordlist" -u "$domain/FUZZ" -rate 50 -t 50 $base_flags
            ;;
        19)
            echo "Saving Output to HTML..."
            ffuf -w "$wordlist" -u "$domain/FUZZ" -o output.html -of html $base_flags
            ;;
        20)
            echo "Saving Output to JSON..."
            ffuf -w "$wordlist" -u "$domain/FUZZ" -o output.json -of json $base_flags
            ;;
        21)
            echo "Saving Output to CSV..."
            ffuf -w "$wordlist" -u "$domain/FUZZ" -o output.csv -of csv $base_flags
            ;;
        *)
            echo "Invalid option selected!"
            exit 1
            ;;
    esac
}

main_menu() {
    check_ffuf_installation
    display_menu

    read -p "Select option [1-21]: " option
    case $option in
        1) echo "You selected: Directory/File Brute Force" ;;
        2) echo "You selected: POST Request Fuzzing" ;;
        3) echo "You selected: Case Insensitive Search" ;;
        4) echo "You selected: File Extension Fuzzing" ;;
        5) echo "You selected: Recursive Fuzzing" ;;
        6) echo "You selected: Subdomain Fuzzing" ;;
        7) echo "You selected: Virtual Host Fuzzing" ;;
        8) echo "You selected: Fuzzing GET Parameters" ;;
        9) echo "You selected: Fuzzing POST Parameters" ;;
        10) echo "You selected: Login Bypass Fuzzing" ;;
        11) echo "You selected: PUT Request Fuzzing" ;;
        12) echo "You selected: Clusterbomb Attack" ;;
        13) echo "You selected: Pitchfork Attack" ;;
        14) echo "You selected: Setting Cookies" ;;
        15) echo "You selected: Using Proxies" ;;
        16) echo "You selected: Custom Header Fuzzing" ;;
        17) echo "You selected: Fuzzing with Custom User-Agent" ;;
        18) echo "You selected: Rate Limiting Bypass" ;;
        19) echo "You selected: Output to HTML" ;;
        20) echo "You selected: Output to JSON" ;;
        21) echo "You selected: Output to CSV" ;;
        *) echo "Invalid option selected!" ;;
    esac

    read -p "Enter target domain (e.g., example.com): " domain
    read -e -p "Enter main wordlist path: " wordlist
    wordlist=$(expand_path "$wordlist")

    userlist=""
    passlist=""
    wordlist2=""
    proxy=""
    cookie=""

    if [[ $option -eq 10 || $option -eq 12 || $option -eq 13 ]]; then
        read -e -p "Enter username wordlist path: " userlist
        userlist=$(expand_path "$userlist")
        read -e -p "Enter password wordlist path: " passlist
        passlist=$(expand_path "$passlist")
    fi

    if [[ $option -eq 12 || $option -eq 13 ]]; then
        read -e -p "Enter wordlist 2 path: " wordlist2
        wordlist2=$(expand_path "$wordlist2")
    fi

    if [[ $option -eq 14 ]]; then
        read -p "Enter cookies (e.g., 'session=abc123'): " cookie
    fi

    if [[ $option -eq 15 ]]; then
        read -p "Enter proxy address (e.g., http://127.0.0.1:8080): " proxy
    fi

    echo "Choose status codes to match:"
    echo "1) 200 (OK)"
    echo "2) 403 (Forbidden)"
    echo "3) 404 (Not Found)"
    echo "4) All status codes"
    read -p "Enter your choice [1-4]: " status_choice

    case $status_choice in
        1)
            status_codes="200"
            ;;
        2)
            status_codes="403"
            ;;
        3)
            status_codes="404"
            ;;
        4)
            status_codes="all"
            ;;
        *)
            echo "Invalid status code choice. Defaulting to 200,403,404."
            status_codes="200,403,404"
            ;;
    esac

    execute_ffuf_command "$option" "$domain" "$wordlist" "$userlist" "$passlist" "$wordlist2" "$proxy" "$cookie" "$status_codes"
}

main_menu
