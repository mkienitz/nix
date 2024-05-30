# Can enable check to enable keychain
# I've disabled this by default
# It only needs to run once
CHECK_KEYCHAIN_ENABLE=0
if [ $CHECK_KEYCHAIN_ENABLE -eq 1 ]
then
    USE_KEYCHAIN=$(defaults read org.gpgtools.common UseKeychain)
    if [ $USE_KEYCHAIN -eq 0 ]
    then
        defaults write org.gpgtools.common UseKeychain -bool yes
    fi
    DISABLE_KEYCHAIN=$(defaults read org.gpgtools.common DisableKeychain)
    if [ $DISABLE_KEYCHAIN -eq 1 ]
    then
        defaults write org.gpgtools.common DisableKeychain -bool no
    fi
fi

echo -e "[$(date)]\nARGS: $*\nSERVICE: ${BURK:-no}" >> /tmp/askpass.log

# We want to ignore confirmations for user presence
if [[ "$1" == "Confirm user presence"* ]]
then
    echo
else
    # See if we can get the hash of the key
    # that we want the password for
    # (this enables keychain option support)
    HASHTYPE=$(echo $1 | awk -F':' '{print $1}')
    if [[ "$HASHTYPE" == *"SHA256" ]]
    then
        # Grab the actual hash
        SHA256=$(echo $1 | awk -F':' '{print $2}')
        PROMPT="SETDESC $1\nOPTION allow-external-password-cache\nSETKEYINFO $SHA256\nGETPIN"
    else
        # Otherwise don't include the keyinfo
        PROMPT="SETDESC $1\nGETPIN"
    fi

    # Prompt the user for their pin
    PIN=$(echo -e $PROMPT | /opt/homebrew/bin/pinentry-mac | grep D | tr -d '\n')
    # Return the pin to ssh-agent starting after 'D '
    echo "${PIN:2}"
fi
