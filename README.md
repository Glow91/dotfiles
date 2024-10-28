# README Alex's Dotfiles

## Contents

- ZSH & P10K Konfigurationen [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

## Prequisites

- Es muss ein Terminal verhanden sein und z-Shell sollte die default Shell sein. (Anleitung folgt)
- Es muss stow und fzf auf dem System installiert sein. Achtung fzf muss >= v48.0 sein

## Install

1) Repo nach ~/.dotfiles clonen
2) Im dotfiles Verzeichniss ```stow .``` eingeben, sollte ein Konflikt Fehler kommen entweder manuell die Konflikte lösen indem die Files im Home Verzeichnis umbenannt werden. Oder 
```stow --adopt .```
3) Einmal checken ob im Home Verzeichnis die erwateten Symlinks entstanden sind und dann Terminal neu starten oder ```exec zsh``` ausführen.
4) Wenn die Settings für P10k nicht passen entweder die Konfig durchwühlen oder ```p10k configure``` ausführen und leiten lassen ;)
5) NeoVim folgt...
