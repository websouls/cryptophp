check_filesystem.py

Run this script on your server to find all "social*.png" files and determine if they are CryptoPHP backdoors.

An optional argument can be passed to start scanning from the directory specified by the argument, else it will default to the root 
directory.

To scan your whole system (it can take a while), run: ./check_filesystem.py

To scan only a specific directory, for example /var/www, run: ./check_filesystem.py /var/www
