#!/bin/bash

# Mostra l'IP locale della connessione attiva
ip addr show | awk '/inet / && !/127.0.0.1/ {print $2}' | cut -d'/' -f1 | head -n1

