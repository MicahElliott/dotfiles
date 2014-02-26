# Dotfiles (slightly specific to MicahElliott, but reusable/customizable)

Most interesting areas:

* zsh (`.zshrc` top level control, hierarchy, completions)
* back-compatible with bash (almost)
* vim (`.vimrc` and `.vim/`)
* config (misc)
* bin
* extensive `.gitignore`

Notable features:

* Designates some standards dirs

* Separates own dotfiles (`~/.config`) from tool-installed (`~/.*` and `~/.config`)

* `dotfiles` script as a proxy for git

* `.*` configs are symlinks to `config/*` to avoid mixing of system things

Breakdown of directory structure:

    *  README    -- this file
    *  bin       -- small (usually standalone) scripts that I have written
    *  config    -- VCS-manageable, user-written CONFIGuration (mostly dot-files)
    *  contrib   -- other people's scripts that need to be under my control
    *  doc       -- text DOCuments I write, books, presentations, personal logs
    *  etc       -- system-specific symlinks to important sytem ETC files
    ** proj      -- PROJects (or *any* code) I'm working on
    ^  archive   -- tarballs, extracts, checkouts
    ^  artwork   -- anything related to graphics; binary so not in VCS
    ^  client    -- work done for development/consulting CLIENTs
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
    &  .config   -- system tools dump things here
    &  .*        -- 100s more dot-files/dirs not worth tracking or listing here

    Key:  * = $HOME-VCS-managed;         ^ = symlink-mirrored, not suited for VCS;
         ** = individually VCS-managed;  ! = lose-able;
          & = used by system
