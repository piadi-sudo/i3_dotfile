#!/usr/bin/env python3

import gi, os, subprocess
gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
from gi.repository import Gtk, GdkPixbuf, Gdk  # <-- aggiunto Gdk

# === CONFIGURAZIONE ===
WALL_DIR = os.path.expanduser("~/wallpaper/wallpaper_switch")
LAST_WALL_FILE = os.path.expanduser("~/.cache/wal/last_wallpaper")
PREVIEW_WIDTH = 600
PREVIEW_HEIGHT = 400

# Ottieni lista immagini
IMAGES = [os.path.join(WALL_DIR, f) for f in os.listdir(WALL_DIR)
          if f.lower().endswith((".jpg", ".jpeg", ".png"))]
IMAGES.sort()
if not IMAGES:
    print("Nessun wallpaper trovato!")
    exit(1)

# Index iniziale
current_index = 0

# Funzione per applicare wallpaper
def apply_wallpaper(path):
    subprocess.run(["feh", "--no-fehbg", "--bg-fill", path])
    subprocess.run(["wal", "-i", path, "-n", "--backend", "wal", "--saturate", "0.9"])
    with open(LAST_WALL_FILE, "w") as f:
        f.write(path)
    print(f"Wallpaper cambiato: {os.path.basename(path)}")

# Creazione finestra GTK
class WallpaperSelector(Gtk.Window):
    def __init__(self):
        super().__init__(title="wallpaper")
        self.set_default_size(PREVIEW_WIDTH, PREVIEW_HEIGHT)
        self.set_resizable(False)

        self.image = Gtk.Image()
        self.add(self.image)
        self.connect("key-press-event", self.on_key_press)

        self.update_image()

    def update_image(self):
        global current_index
        path = IMAGES[current_index]
        pixbuf = GdkPixbuf.Pixbuf.new_from_file(path)
        pixbuf = pixbuf.scale_simple(PREVIEW_WIDTH, PREVIEW_HEIGHT, GdkPixbuf.InterpType.BILINEAR)
        self.image.set_from_pixbuf(pixbuf)

    def on_key_press(self, widget, event):
        global current_index
        key = Gdk.keyval_name(event.keyval)
        if key in ["Right", "Down"]:
            current_index = (current_index + 1) % len(IMAGES)
            self.update_image()
        elif key in ["Left", "Up"]:
            current_index = (current_index - 1) % len(IMAGES)
            self.update_image()
        elif key in ["Return", "KP_Enter"]:
            apply_wallpaper(IMAGES[current_index])
            Gtk.main_quit()
        elif key == "Escape":
            Gtk.main_quit()

win = WallpaperSelector()
win.show_all()
Gtk.main()

