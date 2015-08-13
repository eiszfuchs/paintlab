using Gtk;
using Cairo;

using Gui.Components;
using Gui.Modules;

int main (string[] args) {
    Gtk.init (ref args);

    var window = new Window();
    window.border_width = 5;
    window.title = "paintlab v3";
    window.window_position = Gtk.WindowPosition.CENTER;
    window.set_default_size(266, 60);
    window.destroy.connect(Gtk.main_quit);

    var rgb = new RgbSliders();
    window.add(rgb);

    window.show_all();
    Gtk.main();

    return 0;
}
