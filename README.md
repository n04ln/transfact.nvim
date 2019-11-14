# transfact.nvim
For translation(En-Ja) in NeoVim

## Demo
[![asciicast](https://asciinema.org/a/6I68Wftec0YslkvWMl9lkh4mk.svg)](https://asciinema.org/a/6I68Wftec0YslkvWMl9lkh4mk)

## Requred
- NeoVim >= v0.4.2
- GoogleAppsScript environment (under‐mentioned)
- go >= 1.11 (go modules supported)

## Installation
### 1. Setup GoogleAppsScript environment for your translation.
This plugin will be used it.  
It is easy, please copy&paste the code from `google_app_script/code.gs` to your project.  
And it should be run.
### 2. Set Environment Variable
For using GAS project of `1. Setup GoogleAppsScript environment for your translation.`.  
Please set `TRANSFACT_APPURL` such as below.
``` sh
export TRANSFACT_APPURL=https://script.google.com/...
```
### 3. Install go binary.
Some of this plugin is written in Go.  
Therefore, please execute `go get -u github.com/NoahOrberg/transfact.nvim` on your terminal for installation of go binary.

### 4. Install transfact.nvim to your NeoVim
Finally, Install this plugin to your NeoVim.  
E.g, if you use `vim-plug`, please write below code to your `init.vim`
``` vim
Plug 'NoahOrberg/transfact.nvim'
```
Finally, please execute `:PlugUpdate` on your NeoVim.
### 5. :tada: setup is completed!!!
Let's Enjoy!

## Usage
1. please select target using visual mode.
2. stroke `<C-t>r` to show floating window with the texts.
