#!/bin/bash
buster generate --domain=http://ghost:2368

echo "Removing index.html from links"
find static -name *.html -type f -exec sed -i -e 's#/index.html#/#g' {} \;

echo "Replacing domainname"
find static -name index.html -type f -exec sed -i -e 's/localhost\:2368/www.goposky.com/g' {} \;
find static -name robots.txt -type f -exec sed -i -e 's/localhost\:2368/www.goposky.com/g' {} \;

echo "Adding links header to all pages"
headervar=$(<header.html)
find static -name index.html -type f -exec sed -i -e '1s/ˆ*/'"${headervar}"'\'$'\n/' {} \;

if [ "$1" == "--deploy" ]; then
  buster deploy
fi

