use v6.c;

use JSON::Class;

use Toast::UI::Chart;
use Toast::UI::Chart::Basics;
use Toast::UI::Chart::ExportMenu;
use Toast::UI::Chart::Legend;
use Toast::UI::Chart::Themes;
use Toast::UI::Chart::Tooltip;

use Toast::UI::Chart::Pie::Theme;

my $instance-num = 1;

class Toast::UI::Chart::Pie::SeriesName
  is Toast::UI::Object
{
  has Bool $.visible is rw is built;
  has Str  $.anchor  is rw is built; #= center | outer
}

constant PSN = Toast::UI::Chart::Pie::SeriesName;

class Toast::UI::Chart::Pie::Series::DataLabels
  is Toast::UI::Object
{
  has Bool $.visible          is rw is built;
  has      $.anchor           is rw is built;
  has Num  $.offsetX          is rw is built;
  has Num  $.offsetY          is rw is built;
  has      $.formatter-string is rw is built; #= & (Str() $value)
  has PSN  $.pieSeriesName    is rw is built;
}

constant DataLabels = Toast::UI::Chart::Pie::Series::DataLabels;

class Toast::UI::Chart::Pie::Series is Toast::UI::Object {
  has DataLabels $.dataLabels is rw is built;
}

constant Series = Toast::UI::Chart::Pie::Series;

class Toast::UI::Chart::Pie::Options is Toast::UI::Object {
  has TUI-Chart        $.chart      is rw is built;
  has TUI-Legend       $.legend     is rw is built;
  has TUI-ExportMenu   $.exportMenu is rw is built;
  has TUI-ToolTip      $.tooltip    is rw is built;
  has                  $.responsive is rw is built;
  has Theme-Pie-Series $.theme      is rw is built;
  has Series           $.series     is rw is built;
}

constant Options = Toast::UI::Chart::Pie::Options;

class Toast::UI::Chart::Pie::Data::Value is Toast::UI::Object {
  has Str $.name is rw is built;
  has Num $.data is rw is built;
}

constant Value = Toast::UI::Chart::Pie::Data::Series

class Toast::UI::Chart::Pie::Data is Toast::UI::Object {
  has Str   @.categories       is built;
  has Value @.series     is rw is built;

  has Int   $.value-count = 1;

  method add-data (@values) {
    self.add-value(for @values);
  }

  method add-value ($value) {
    @!series.push: Value.new(
      data => $value.data;
      name => $value.name // 'Value' ~ $!value-count++;
    );
  }
}

constant Data = Toast::UI::Chart::Pie::Data;

class Toast::UI::Chart::Pie is Toast::UI::Object {
  has Options $.options is built;
  has Data    $!data;

  method data is rw {
    Proxy.new:
      FETCH => $, { $!data },

      STORE => $, $_ is copy {
        # cw: .data should be able to accept
        when Array {
          when .all ~~ Hash {
            $_ = .map({ Value.new( |$_ ) });
            proceed;
          }

          #   2) An array of Value objects
          when .all ~~ Value {
            self.add-value($_) for $_;
          }

          #   1) An array of single values
          default {
            self.add-value( Value.new( data => $_ ) )
          }
        }

        #   3) A single Data object
        when Data {
          $!data = $_;
        }

        default {
          # Throw typed exception.

        }
      }
  }

  method add-data (@values) {
    $!data.add-values(@values);
  }

  method add-value ($value) {
    $!data.add-value($value);
  }

  submethod BUILD {
    $!data = Data.new;
  }

  multi method Init {
    qq:to/ECMA/;
      { callsame }

      const pieChart_{ $instance-num }++ = Chart.PieChart(\{
        el: document.getElementById('{ self.element // 'pie' }'){
          $.data || $.options ?? ',' !! '' }
        { $.data    ?? 'data: '   ~  to-json($.data) ~ ',' !! '' }
        { $.options ?? 'options: ' ~ to-json($.options)    !! '' }
      \});
      ECMA
  }

}


multi sub Pie-MAIN is export {
  use Data::Dump::Tree;

  # cw: Options.series IS NOT the same type as Options.theme.series!

  ddt Toast::UI::Chart::Pie::Options.from-json( q:to/JSON/ );
    {
      "series": {
        "dataLabels": {
          "visible": true,
          "pieSeriesName": { "visible": true, "anchor": "outer" }
        }
      },
      "theme": {
        "series": {
          "dataLabels": {
            "fontFamily": "monaco",
            "useSeriesColor": true,
            "lineWidth": 2,
            "textStrokeColor": "#ffffff",
            "shadowColor": "#ffffff",
            "shadowBlur": 4,
            "callout": {
              "lineWidth": 3,
              "lineColor": "#f44336",
              "useSeriesColor": false
            },
            "pieSeriesName": {
              "useSeriesColor": false,
              "color": "#f44336",
              "fontFamily": "fantasy",
              "fontSize": 13,
              "textBubble": {
                "visible": true,
                "paddingX": 1,
                "paddingY": 1,
                "backgroundColor": "rgba(158, 158, 158, 0.3)",
                "shadowOffsetX": 0,
                "shadowOffsetY": 0,
                "shadowBlur": 0,
                "shadowColor": "rgba(0, 0, 0, 0)"
              }
            }
          }
        }
      }
    }
    JSON

}
