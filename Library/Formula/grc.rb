require 'formula'

class Grc < Formula
  homepage 'http://korpus.juls.savba.sk/~garabik/software/grc.html'
  url 'http://korpus.juls.savba.sk/~garabik/software/grc/grc_1.7.orig.tar.gz'
  sha1 'df9a6a303823500e315d83e1982e4ca1b42d9e77'

  conflicts_with 'cc65', :because => 'both install `grc` binaries'

  def install
    inreplace ['grc', 'grc.1'], '/etc', etc
    inreplace ['grcat', 'grcat.1'], '/usr/local', prefix

    etc.install 'grc.conf'
    bin.install %w[grc grcat]
    (share+'grc').install Dir['conf.*']
    man1.install %w[grc.1 grcat.1]

    (prefix+'etc/grc.bashrc').write rc_script
  end

  def rc_script; <<-EOS.undent
    GRC=`which grc`
    if [ "$TERM" != dumb ] && [ -n "$GRC" ]
    then
        alias colourify="$GRC -es --colour=auto"
        alias configure='colourify ./configure'
        alias diff='colourify diff'
        alias make='colourify make'
        alias gcc='colourify gcc'
        alias g++='colourify g++'
        alias as='colourify as'
        alias gas='colourify gas'
        alias ld='colourify ld'
        alias netstat='colourify netstat'
        alias ping='colourify ping'
        alias traceroute='colourify /usr/sbin/traceroute'
        alias head='colourify head'
        alias tail='colourify tail'
    fi
    EOS
  end

  def caveats; <<-EOS.undent
    New shell sessions will start using GRC after you add this to your profile:
      source "`brew --prefix`/etc/grc.bashrc"
    EOS
  end
end
