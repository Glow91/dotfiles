# README Alex's Dotfiles

## Contents

- ZSH & P10K Konfigurationen [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- WezTerm Konfiguration inkl. self made Mini Status Bar (aktuell nur unter Linux getestet, macOS folgt)

## Prequisites

- Es muss ein Terminal verhanden sein und z-Shell sollte die default Shell sein. (Anleitung folgt)
  - Z Shell kann über System Packetmanager installiert werden (apt/pacman), als default Shell mit ```chsh <username>```
- Es muss stow und fzf auf dem System installiert sein. Achtung fzf muss >= v48.0 sein. 
  - Einfachster weg ist das aktuelle Release von GitHub zu laden und an die passende Stelle packen. 

## Install

### Stow, zsh und p10k

1) Repo nach ~/.dotfiles clonen
2) Im dotfiles Verzeichniss ```stow .``` eingeben, sollte ein Konflikt Fehler kommen entweder manuell die Konflikte lösen indem die Files im Home Verzeichnis umbenannt werden. Oder 
```stow --adopt .```
3) Einmal checken ob im Home Verzeichnis die erwateten Symlinks entstanden sind und dann Terminal neu starten oder ```exec zsh``` ausführen.
4) Wenn die Settings für P10k nicht passen entweder die Konfig durchwühlen oder ```p10k configure``` ausführen und leiten lassen ;)

### WezTerm

1) WezTerm installieren, [Downloads](https://wezfurlong.org/wezterm/installation.html)
2) Mit Stow die files an den korrekten Platz linken, details folgen noch ```stow --target=/home/alex/.config/wezterm .``` ...
3) Config wenn nötig anpassen und checken ob via Stow alle dort hinverlinkt wurde.
4) WezTerm nutzen und genießen ;)

## NeoVim

Comming soon :)
