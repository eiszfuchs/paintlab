using Gtk;

using Gui.Components;

namespace Gui.Modules {

    public class RgbSliders : Box {

        private Slider red = new Slider(0, 1);
        private Slider green = new Slider(0, 1);
        private Slider blue = new Slider(0, 1);

        public RgbSliders () {
            Object(orientation: Orientation.VERTICAL);

            set_spacing(0);

            red.set_stop_generator((pattern) => {
                pattern.add_color_stop_rgb(0, 0, green.get_value(), blue.get_value());
                pattern.add_color_stop_rgb(1, 1, green.get_value(), blue.get_value());
            });

            green.set_stop_generator((pattern) => {
                pattern.add_color_stop_rgb(0, red.get_value(), 0, blue.get_value());
                pattern.add_color_stop_rgb(1, red.get_value(), 1, blue.get_value());
            });

            blue.set_stop_generator((pattern) => {
                pattern.add_color_stop_rgb(0, red.get_value(), green.get_value(), 0);
                pattern.add_color_stop_rgb(1, red.get_value(), green.get_value(), 1);
            });

            add(red);
            add(green);
            add(blue);
        }
    }
}
