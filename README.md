# dmenu - my personal patched dmenu build

## Included patches
- border
- center
- fuzzymatch
- fuzzyhighlight
- line height
- wmtype (from Baitinq's repo [here](https://github.com/Baitinq/dmenu/blob/master/patches/dmenu-wm_type.diff))

### Maybe-list
- incremental
- non-blocking stdin
- xresources

## Repository structure

### Repository branches

**build**

The latest version of the patched dmenu.
It contains all of my chosen patches already merged into the base code of the latest tagged dmenu version.
There are other branches merged into this one, like **misc** and **distribution**.

**\*-patch**

There is a branch for each patch that will be applied to my dmenu.
These branches use the name of the patch suffixed with `-patch`.

For example, the _border_ patch has its own branch called __border-patch__.

These branches contain the base original code plus the patch already applied.
The idea is to merge all of them into the **build** branch to cook the customized dmenu.

**distribution**

This branch contains an Archlinux build system PKGBUILD and a shell script to help building a _dmenu_ package.

**misc**

Basically, it contains a modified README file.

### Base code updates

People who use suckless tools are used to apply a bunch of patches and build their own customized versions of the tools.

I have a tag `gpascual-4.9` that was created from the **build** branch some time ago. This tag includes all patch branches from that time.

         ,-- center-patch-------,
        /                        \
    4.9 ---- border-patch--------- gpascual-4.9
        \                        /
         '-- lineheight-patch --'

Let's say a new _dmenu_ version `4.10` is released. To update the *build* to a new version, start by rebasing each branch to the new tag.

We'll be going from this:

          ,--- 4.10
         /
        /  ,-- center-patch-------,
       /  /                        \
    4.9 ------ border-patch--------- gpascual-4.9
        \                          /
         '---- lineheight-patch --'

to this:

          ,--- qpascual-4.9
         /
        /        ,-- center-patch
       /        /
    4.9 --- 4.10 ---- border-patch
                \
                 '-- lineheight-patch

Now make a merge commit merging all the patch branches and tag the result
`gpascual-4.10`:

          ,--- qpascual-4.9
         /
        /        ,-- center-patch-------,
       /        /                        \
    4.9 --- 4.10 ---- border-patch--------- gpascual-4.10
                \                        /
                 '-- lineheight-patch --'

#### Example: updating to a new tagged version

Here is the above example (updating from 4.9 to 4.10) in long form.

Assume the **build** branch is currently pointing to the same commit as the 4.10 tag.

```shell script
git fetch --tags suckless # 'suckless' is a git remote pointing to https://git.suckless.org/dmenu
 
git checkout center-patch
git rebase 4.10
# fix conflicts if any

git checkout border-patch
git rebase 4.10

git checkout lineheight-patch
git rebase 4.10

git checkout build
git merge --ff-only center-patch
git merge border-patch
git merge lineheight-patch
# fix merge conflicts if any

git tag -m "4.10 with gpascual's patch selection" gpascual-4.10
```

## Installation

### Archlinux

1. Make sure to checkout the **build** branch or the latest `gpascual-*` tag.
2. Move to the `dist/archlinux` directory inside the project
3. Execute the `./build.sh` script
4. Install the generated package with `sudo pacman -U #PACKAGE_FILE_NAME#`


## External links

* dmenu - https://tools.suckless.org/dmenu/
* The Suckless philosophy - https://suckless.org/philosophy/
* qguv's dwm README (from where I took most of the _Repository structure_ section) - https://github.com/qguv/dwm
* wmtype patch from Baitinq - https://github.com/Baitinq/dmenu/blob/master/patches/dmenu-wm_type.diff
