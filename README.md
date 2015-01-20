Kyle Tolle's dotfiles
======================

Installation
------------

Clone the repo and then move the files into your root path.
Warning: This will clobber any existing files already in your root path.

```
cd ~
git clone https://github.com/kyletolle/dotfiles.git
mv dotfiles/* . && mv dotfiles/.* .
rmdir dotfiles
```

VIM
---

To install the vim bundles
```
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +PluginInstall! +qall
```

If you haven't [installed the patched fonts for powerline/airline](https://powerline.readthedocs.org/en/latest/installation/osx.html#installation-osx), you'll need to.
The gist of it is that you'll have to download fonts from [powerline-fonts](https://github.com/Lokaltog/powerline-fonts), install them and then use them.
