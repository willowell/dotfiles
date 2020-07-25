# --------------------------------------- USER CONFIGURATION ---------------------------------------
# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
#
#  Description:  This file holds all my ZSH configurations and aliases
#
#  Sections:
#  0.   ZSH Configuration
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Web Development
#  9.   Reminders & Notes
#  10.  PATH Settings
#
# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   0.  ZSH CONFIGURATION
#   -------------------------------------

#   Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
#   Initialization code that may require console input (password prompts, [y/n]
#   confirmations, etc.) must go above this block, everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

#   Path to my oh-my-zsh installation.
#   ------------------------------------------------------------
    export ZSH=$HOME/.oh-my-zsh

#   ZSH Theme Settings
#   ------------------------------------------------------------
    ZSH_THEME="powerlevel10k/powerlevel10k"
    POWERLEVEL9K_MODE="awesome-patched"

#   History Timestamps Format
#   ------------------------------------------------------------
    HIST_STAMPS="dd/mm/yyyy"

#   ZSH Plugins
#   ------------------------------------------------------------
    plugins=(
        git
        iterm2
        osx
        tmux
        vscode    
    )

#   Load Oh My Zsh!
#   ------------------------------------------------------------
    source $ZSH/oh-my-zsh.sh

#   Powerlevel10K script
#   ------------------------------------------------------------
#   To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------------

#   Set Default User
#   ------------------------------------------------------------
    DEFAULT_USER=$(whoami)

#   Set Default Language
#   ------------------------------------------------------------
    export LANG=en_US.UTF-8

#   Set Default Editor
#   ------------------------------------------------------------
    export EDITOR='kak'

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
    export BLOCKSIZE=1k

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   2.  MAKE TERMINAL BETTER
#   -------------------------------------

    alias cp='cp -iv'                           # Preferred 'cp' implementation
    alias mv='mv -iv'                           # Preferred 'mv' implementation
    alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
    alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
    alias less='less -FSRXc'                    # Preferred 'less' implementation
    cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
    alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
    alias ..='cd ../'                           # Go back 1 directory level
    alias ...='cd ../../'                       # Go back 2 directory levels
    alias .3='cd ../../../'                     # Go back 3 directory levels
    alias .4='cd ../../../../'                  # Go back 4 directory levels
    alias .5='cd ../../../../../'               # Go back 5 directory levels
    alias .6='cd ../../../../../../'            # Go back 6 directory levels
    alias edit=$EDITOR                          # edit:         Opens any file in the default editor
    alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
    alias ~="cd ~"                              # ~:            Go Home
    alias c='clear'                             # c:            Clear terminal display
    alias which='type -all'                     # which:        Find executables
    alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
    alias show_options='shopt'                  # Show_options: display bash options settings
    alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
    alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
    mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
    trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
    ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
    alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
    alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }


# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------------

    zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
    alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
    alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
    alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
    alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   4.  SEARCHING
#   -------------------------------------

    alias qfind="find . -name "                 # qfind:    Quickly search for file
    ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
    ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
    ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   5.  PROCESS MANAGEMENT
#   -------------------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   6.  NETWORKING
#   -------------------------------------

    alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
    alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
    alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
    alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
    alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
    alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
    alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
    alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
    alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
    alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   -------------------------------------

    alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias finderHideHidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#   screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   8.  WEB DEVELOPMENT
#   -------------------------------------
    alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
    alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
    alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
    alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
    alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
    httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   9.  REMINDERS AND NOTES
#   -------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   10.  PATH SETTINGS
#   -------------------------------------

#   DEFAULT BINARY PATHS:
#   /usr/local/bin
#   /usr/bin
#   /usr/sbin
#   /bin
#   /sbin

#   Sections:
#   0.   Homebrew and Other General Paths
#   1.   Language Specific, in Alphabetical Order
#   2.   Tools

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   0.  Homebrew and Other General Paths
#   -------------------------------------

#   /usr/local/sbin path for Homebrew
    export PATH=$PATH:/usr/local/sbin:$PATH

    export PATH=$HOME/.local/bin:$PATH

    export PATH=$PATH:/usr/local/opt/openssl@1.1/bin:$PATH

    export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib
# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   1.  Language Specific, in Alphabetical Order
#   -------------------------------------

#   C++
#       vcpkg
        alias vcpkg="./vcpkg/vcpkg"
        alias vcpkg_update="cd ~/vcpkg && git pull && ./bootstrap-vcpkg.sh"
# ---------------------------------------

#   Carp Lisp
        export CARP_DIR=$HOME/Carp/
# ---------------------------------------

#   Haskell
#       ghcup
        [ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

#       Haskell
        export PATH=$PATH:/Library/Haskell/bin:$PATH

#       Cabal
        export PATH=$PATH:/.cabal/bin:$PATH
# ---------------------------------------

#   Java
#       JAVA_HOME -- points to AdoptOpenJDK
        export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home

#       JavaFX PATH variables
        export PATH_TO_JAVAFX=/usr/local/JavaFX/javafx-sdk-11/lib

#       JavaFX Alias
        alias javafx="java --module-path $PATH_TO_JAVAFX --add-modules=javafx.controls"
# ---------------------------------------

#   JavaScript and NodeJS
#       Node Version Manager
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# ---------------------------------------

#   LÖVE
        alias love="/Applications/love.app/Contents/MacOS/love"
# ---------------------------------------

#   Python
#       Anaconda
        export PATH=$PATH:$HOME/opt/anaconda3/bin:$PATH

#       IBM Qiskit virtual environment
        alias Qiskit=". /usr/local/anaconda3/bin/activate && conda activate $HOME/opt/anaconda3/envs/Qiskitenv"

#       Poetry -- Finally, cargo for Python!!        
        export PATH=$PATH:$HOME/.poetry/bin:$PATH

#       Anaconda init
        # >>> conda init >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
        if [ $? -eq 0 ]; then
            \eval "$__conda_setup"
        else
            if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
                . "/anaconda3/etc/profile.d/conda.sh"
                CONDA_CHANGEPS1=false conda activate base
            else
                \export PATH="/anaconda3/bin:$PATH"
            fi
        fi
        unset __conda_setup
        # <<< conda init <<<
# ---------------------------------------
   
#   Rust
#       Cargo
        export PATH=$PATH:$HOME/.cargo/bin:$PATH
# ---------------------------------------

# --------------------------------------------------------------------------------------------------

#   -------------------------------------
#   2.  Tools
#   -------------------------------------

#   Bison Syntax Analyzer
        export PATH="/usr/local/opt/bison/bin:$PATH"
# ---------------------------------------

#   Homebrew LLVM
        # WARNING: This will add LLVM/Clang to the PATH. If a toolchain depends on an Apple Clang-specific feature,
        #   this will break that toolchain.
        # export PATH="/usr/local/opt/llvm/bin:$PATH"

#       # Include and Linker Paths
        export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
        export CPPFLAGS="-I/usr/local/opt/llvm/include"
# ---------------------------------------

#   OPAM
    test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# ---------------------------------------

#   vterm
#   This is mostly for Emacs.
        vterm_printf(){
            if [ -n "$TMUX" ]; then
                # Tell tmux to pass the escape sequences through
                # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
                printf "\ePtmux;\e\e]%s\007\e\\" "$1"
            elif [ "${TERM%%-*}" = "screen" ]; then
                # GNU screen (screen, screen-256color, screen-256color-bce)
                printf "\eP\e]%s\007\e\\" "$1"
            else
                printf "\e]%s\e\\" "$1"
            fi
        }

        if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
            alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
        fi
# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
