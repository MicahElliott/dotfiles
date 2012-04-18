#! /bin/bash
#
# To be run from shed1.

rsync -v --archive --rsh=ssh \
  ~/public_html/medrics/webfaction/public \
  web7.webfaction.com:/home2/mde/webapps/medrics/medrics/
