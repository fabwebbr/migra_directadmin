#!/bin/sh
echo "action=restore&ip%5Fchoice=select&ip=50.114.62.104&local%5Fpath=%2Fhome%2Fadmin%2Fadmin%5Fbackups&owner=admin&select%30=user%2E${1}%2E${2}%2Etar%2Egz&type=admin&value=multiple&when=now&where=local" >> /usr/local/directadmin/data/task.queue
