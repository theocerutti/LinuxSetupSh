if status is-interactive
    # Commands to run in interactive sessions can go here


  function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
  end
  set -x NVM_DIR ~/.nvm
  nvm use default --silent
end
