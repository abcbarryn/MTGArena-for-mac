#!/bin/sh

clear
curl 'https://raw.githubusercontent.com/abcbarryn/MTGArena-for-mac/master/MTGArena.aa' >MTGArena.uue
echo
curl 'https://raw.githubusercontent.com/abcbarryn/MTGArena-for-mac/master/MTGArena.ab' >>MTGArena.uue
echo
curl 'https://raw.githubusercontent.com/abcbarryn/MTGArena-for-mac/master/MTGArena.ac' >>MTGArena.uue
cat MTGArena.uue | uudecode && rm MTGArena.uue
tar xvjf MTGArena.tbz && rm MTGArena.tbz
