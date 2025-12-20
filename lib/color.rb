# frozen_string_literal: true

module Color # rubocop:disable Style/Documentation
  COLORS = { brown: '102;51;0',
             light_color: '255;178;102',
             white: '255;255;255',
             black: '0;0;0',
             yellow: '204;204;0',
             red: '255;0;0' }.freeze

  refine String do
    def bg_color(color)
      rgb_val = COLORS[color]
      "\e[48;2;#{rgb_val}m #{self}\e[0m"
    end

    def fg_color(color_name)
      rgb_val = COLORS[color_name]
      "\e[38;2;#{rgb_val}m#{self}\e[0m"
    end
  end
end
