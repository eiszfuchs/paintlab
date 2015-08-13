using Gtk;
using Cairo;
using Gui;

namespace Gui.Components {

    public delegate void StopGenerator (Cairo.Pattern cr);

    public class Slider : Component {

        private double value;

        private double min_value;

        private double max_value;

        private bool is_changing = false;

        private StopGenerator pattern_stop_generator;

        public Slider (double min_value, double max_value) {
            add_events(Gdk.EventMask.BUTTON_PRESS_MASK
                     | Gdk.EventMask.BUTTON_RELEASE_MASK
                     | Gdk.EventMask.POINTER_MOTION_MASK);

            set_has_window(false);

            this.value = min_value;

            this.min_value = min_value;
            this.max_value = max_value;
        }

        public void set_stop_generator (StopGenerator stop_generator) {
            pattern_stop_generator = stop_generator;
        }

        public double get_value () {
            return value;
        }

        public override bool draw (Cairo.Context cr) {
            int width = get_allocated_width();

            if (pattern_stop_generator != null) {
                var pattern = new Cairo.Pattern.linear(0, 0, width, 0);
                pattern_stop_generator(pattern);

                cr.rectangle(0, 0, width, 10);
                cr.set_source(pattern);
                cr.fill();
            }

            cr.move_to(value * width, 12);
            cr.line_to(value * width - 5, 17);
            cr.line_to(value * width + 5, 17);
            cr.set_source_rgb(0, 0, 0);
            cr.fill();

            return false;
        }

        private void update_value (double x, double y) {
            int width = get_allocated_width();
            value = double.min(max_value, double.max(min_value, x / width));

            get_parent().queue_draw();
        }

        public override bool button_press_event (Gdk.EventButton event) {
            is_changing = true;
            update_value(event.x, event.y);

            return false;
        }

        public override bool button_release_event (Gdk.EventButton event) {
            is_changing = false;
            update_value(event.x, event.y);

            return false;
        }

        public override bool motion_notify_event (Gdk.EventMotion event) {
            if (is_changing) {
                update_value(event.x, event.y);
            }

            return false;
        }

        public override void get_preferred_height (out int minimum_height, out int natural_height) {
            minimum_height = 20;
            natural_height = 20;
        }
    }
}
