using Gtk;
using Cairo;

namespace Gui {

    public class Component : EventBox {

        protected void draw_rounded_path (Cairo.Context cr, double x, double y, double width, double height, double radius) {
            double degrees = Math.PI / 180.0;

            cr.new_sub_path();
            cr.arc(x + width - radius, y + radius, radius, -90 * degrees, 0 * degrees);
            cr.arc(x + width - radius, y + height - radius, radius, 0 * degrees, 90 * degrees);
            cr.arc(x + radius, y + height - radius, radius, 90 * degrees, 180 * degrees);
            cr.arc(x + radius, y + radius, radius, 180 * degrees, 270 * degrees);
            cr.close_path();
        }
    }
}
