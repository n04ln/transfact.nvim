# transfact.nvim
For translation(En-Ja) in NeoVim

## Demo
[![asciicast](https://asciinema.org/a/6I68Wftec0YslkvWMl9lkh4mk.svg)](https://asciinema.org/a/6I68Wftec0YslkvWMl9lkh4mk)

## Requred
- NeoVim > v0.4.0
    - with floating window support
- GoogleAppsScript environment (under‐mentioned)
- go >= 1.11

## Installation
### 1. Setup GoogleAppsScript environment for your translation.
This plugin will be used it.
It is easy, please copy&paste the code from `google_app_script/code.gs` to your project.
And it should be run.
### 2. Install go binary.
Some of this plugin is written in Go.
So, please execute `go get -u github.com/NoahOrberg/transfact.nvim` on your terminal for installation of go binary.
### 3. Install transfact.nvim to your NeoVim
Finally, Install this plugin to your NeoVim.
E.g, if you use `vim-plug`, please write below code to your `init.vim`
```
Plug 'NoahOrberg/transfact.nvim'
```
Finally, please execute `:PlugUpdate` on your NeoVim.
### 4. :tada: setup is completed!!!

## Usage
1. please select target using visual mode.
2. stroke `<C-t>r`, show floating window with the texts.
