# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

set -x PATH (pwd)/flutter/bin $PATH
set -x PATH (pwd)/flutter/.pub-cache/bin $PATH

set --export ANDROID $HOME/Library/Android;

set --export ANDROID_HOME $ANDROID/sdk;
set -gx PATH $ANDROID_HOME/tools $PATH;
#set -gx PATH $ANDROID_HOME/usr/local/opt/android-sdk $PATH;
set -gx PATH $ANDROID_HOME/platform-tools $PATH;



function subl
    sublime .
end

function mvim
    open -a 'macvim' .
end

function mine
    open -a 'rubymine' .
end

function r
    rails
end
function m
    rake db:migrate
end
function rgc
    rails g controller
end
function rgs
    rails g scaffold
end
function s
    rails s
end
function b
    bundle install
end
function db
    rails db
end
function c
    rails c
end
function cl
    clear
end

function server
    mix phoenix.server
end
function migrate
    mix ecto.migrate
end
function setup
    mix ecto.setup
end
function create
    mix ecto.create
end
function genhaml
    mix phoenix_haml.gen.html
end
function genhtml
    mix phoenix.gen.html
end
function deps
    mix deps.get
end

function dk
    cd ~/Desktop
end
