# Installed on both Windows and WSL independently

## Windows
https://ianchanning.wordpress.com/2016/03/25/jupyter-on-windows-with-chocolatey/

choco install python

pip install jupyter











## Mac Mojave Install Issue
` sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /`

```
taf_integration (RICS-574-add-handling-for-mailchimp-api-errors)$ pyenv install 3.7.3
python-build: use openssl@1.1 from homebrew
python-build: use readline from homebrew
Downloading Python-3.7.3.tar.xz...
-> https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
Installing Python-3.7.3...
python-build: use readline from homebrew

BUILD FAILED (OS X 10.14.1 using python-build 20180424)

Inspect or clean up the working tree at /var/folders/v2/0fqv7qcd2nsd7jxq_bcxk39xc81tzc/T/python-build.20190603103048.7361
Results logged to /var/folders/v2/0fqv7qcd2nsd7jxq_bcxk39xc81tzc/T/python-build.20190603103048.7361.log

Last 10 log lines:
  File "/private/var/folders/v2/0fqv7qcd2nsd7jxq_bcxk39xc81tzc/T/python-build.20190603103048.7361/Python-3.7.3/Lib/ensurepip/__main__.py", line 5, in <module>
    sys.exit(ensurepip._main())
  File "/private/var/folders/v2/0fqv7qcd2nsd7jxq_bcxk39xc81tzc/T/python-build.20190603103048.7361/Python-3.7.3/Lib/ensurepip/__init__.py", line 204, in _main
    default_pip=args.default_pip,
  File "/private/var/folders/v2/0fqv7qcd2nsd7jxq_bcxk39xc81tzc/T/python-build.20190603103048.7361/Python-3.7.3/Lib/ensurepip/__init__.py", line 117, in _bootstrap
    return _run_pip(args + [p[0] for p in _PROJECTS], additional_paths)
  File "/private/var/folders/v2/0fqv7qcd2nsd7jxq_bcxk39xc81tzc/T/python-build.20190603103048.7361/Python-3.7.3/Lib/ensurepip/__init__.py", line 27, in _run_pip
    import pip._internal
zipimport.ZipImportError: can't decompress data; zlib not available
make: *** [install] Error 1
taf_integration (RICS-574-add-handling-for-mailchimp-api-errors)$ brew install zlib
Updating Homebrew...
==> Auto-updated Homebrew!
Updated 1 tap (homebrew/cask).
No changes to formulae.

Warning: zlib 1.2.11 is already installed and up-to-date
To reinstall 1.2.11, run `brew reinstall zlib`
taf_integration (RICS-574-add-handling-for-mailchimp-api-errors)$ xcode select -s /Library/Developer/CommandLineTools
-bash: xcode: command not found
taf_integration (RICS-574-add-handling-for-mailchimp-api-errors)$ xcode-select -s /Library/Developer/CommandLineTools
xcode-select: error: --switch must be run as root (e.g. `sudo xcode-select --switch <xcode_folder_path>`).
taf_integration (RICS-574-add-handling-for-mailchimp-api-errors)$ sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
Password:
installer: Package name is macOS_SDK_headers_for_macOS_10.14
installer: Installing at base path /
installer: The install was successful.
taf_integration (RICS-574-add-handling-for-mailchimp-api-errors)$ pyenv install 3.7.3
python-build: use openssl@1.1 from homebrew
python-build: use readline from homebrew
Downloading Python-3.7.3.tar.xz...
-> https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
Installing Python-3.7.3...
python-build: use readline from homebrew
Installed Python-3.7.3 to /Users/winston.kotzan/.pyenv/versions/3.7.3

```