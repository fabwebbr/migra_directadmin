#!/bin/sh
IP="50.114.62.104"
echo "action=restore&ip%5Fchoice=select&ip=${IP}&local%5Fpath=%2Fhome%2Fadmin%2Fadmin%5Fbackups&owner=admin&select%30=${1}%2E${2}%2E${3}%2Etar%2Egz&type=admin&value=multiple&when=now&where=local" >> /usr/local/directadmin/data/task.queue