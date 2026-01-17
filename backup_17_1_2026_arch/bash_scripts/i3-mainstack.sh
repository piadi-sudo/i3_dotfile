#!/bin/bash
# i3 main + stack layout script

# Crea layout "main a sinistra + stack a destra"
# 1. imposta split verticale (main a sinistra)
i3-msg "split vertical"

# 2. marca la finestra attuale come 'main'
i3-msg "mark main"

# 3. sposta il focus nel contenitore genitore
i3-msg "focus parent"

# 4. crea una divisione orizzontale a destra (per lo stack)
i3-msg "split horizontal"

# 5. imposta il layout delle nuove finestre a stacking (impilate)
i3-msg "layout stacking"

