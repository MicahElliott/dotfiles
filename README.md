# Dotfiles (slightly specific to MicahElliott, but reusable/customizable)

Most interesting areas:

* zsh (`.zshrc` top level control and file hierarchy)
* vim (`.vimrc` and `.vim/`)
* config (misc)
* bin scripts (add your own if not gists)

Notable features:

* Many handy settings, aliases, functions, completions, prompts, colors, etc

* Designates some standards dirs (via `.gitignore`s)

* Separates own dotfiles (`~/config`) from tool-installed (`~/.*` and
  `~/.config`) via symlinks; e.g., `~/.vimrc -> ~/config/vimrc`

* Provides `dotfiles` script (and several `d*` aliases) as a proxy for git

* Time-able and fast

* Multi-shell capable; back-compatible with bash (somewhat, should be made so)

## Setup

1. Move your own config files temporarily into a scratch area

        cd ~
        mkdir ~/tmp
        mv .bash* .zsh* tmp

1. Install Zsh and make sure it's your default shell

        chsh -s /usr/bin/zsh

1. Sign in to github and fork this repo to make your own which you can modify

1. Clone and set up for repo.

        git clone git@github.com:YOU/dotfiles.git ~/.dotfiles.git
        mv .dotfiles.git/.* .dotfiles.git/*
        mv .git .dotfiles.git/

1. Try it out! (lots of `dotfiles` aliases, like `dst`, `dci`, etc)

        exec zsh
        alias dotfiles
        dotfiles «tab»

There are still vim (via [vundle](https://github.com/gmarik/Vundle.vim)) and
gist files to grab. I'll clean this up if someone requests.

You can also use the included `binstubs.zsh` to create a single `bin/` for
your gists.

## Layout

    *  README.md -- this file
    *  bin       -- small (usually standalone) scripts that I have written
    *  config    -- VCS-manageable, user-written CONFIGuration (mostly dot-files)
    *  contrib   -- other people's scripts that need to be under my control
    *  doc       -- text DOCuments I write, books, presentations, personal logs
    *  etc       -- system-specific symlinks to important sytem ETC files
    *  test      --
    +  proj      -- PROJects (or *any* code) I'm working on
    +  client    -- work done for development/consulting CLIENTs
    ^  archive   -- tarballs, extracts, checkouts
    ^  art       -- anything related to graphics; binary so not in VCS
    ^  exp       -- small-scale code/tests I'm working on only EXPerimentally
    ^  data      -- generated, machine-specific config DATA files
    ^  log       -- holds LOGs: installs, runs, reports
    ^  Documents -- binary DOCUMENTS, books, presentations
    ^  Books     -- EPUBs to be shared with other devices
    ^  Mail      -- all the mutt-managed MAIL
    ^  Music     -- songs, podcasts, etc
    ^  Photos    -- still shots (most mirrored to Flickr)
    ^  Videos    -- VIDEOS, screencasts (mirror to vimeo/viddler?)
    !  local     -- my LOCAL install tree (... --prefix=~/local)
    !  outgoing  -- temp queue for things (forSOMEONE.tgz) sent to others
    !  tmp       -- a manual trash can
    !  Downloads -- temp holding area
    &  .config   -- system tools dump settings here
    &  .local    -- system tools dump things here
    &  .*        -- 100s more dot-files/dirs not worth tracking or listing here

    Key:  * = $HOME-VCS-managed;         ^ = symlink-mirrored, not suited for VCS;
          + = individually VCS-managed;  ! = lose-able;
          & = used by system
