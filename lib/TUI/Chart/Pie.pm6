use v6.c;

use JSON::Class;

use TUI::Chart;
use TUI::Chart::Basics;
use TUI::Chart::ExportMenu;
use TUI::Chart::Legend;
use TUI::Chart::Themes;
use TUI::Chart::Tooltip;

use TUI::Chart::Pie::Theme;

class TUI::Chart::Pie::SeriesName
  is TUI::Chart::Object
{
  has Bool $.visible is rw is built;
  has Str  $.anchor  is rw is built; #= center | outer
}

constant PSN = TUI::Chart::Pie::SeriesName;

class TUI::Chart::Pie::Series::DataLabels
  is TUI::Chart::Object
{
  has Bool $.visible          is rw is built;
  has      $.anchor           is rw is built;
  has Num  $.offsetX          is rw is built;
  has Num  $.offsetY          is rw is built;
  has      $.formatter-string is rw is built; #= & (Str() $value)
  has PSN  $.pieSeriesName    is rw is built;
}

constant DataLabels = TUI::Chart::Pie::Series::DataLabels;

class TUI::Chart::Pie::Series is TUI::Chart::Object {
  has DataLabels $.dataLabels is rw is built;
}

constant Series = TUI::Chart::Pie::Series;

class TUI::Chart::Pie::Options is TUI::Chart::Object {
  has TUI-Chart        $.chart      is rw is built;
  has TUI-Legend       $.legend     is rw is built;
  has TUI-ExportMenu   $.exportMenu is rw is built;
  has TUI-ToolTip      $.tooltip    is rw is built;
  has                  $.responsive is rw is built;
  has Theme-Pie-Series $.theme      is rw is built;
  has Series           $.series     is rw is built;
}

multi sub Pie-MAIN is export {
  use Data::Dump::Tree;

  # cw: Options.series IS NOT the same type as Options.theme.series!

  ddt TUI::Chart::Pie::Options.from-json( q:to/JSON/ );
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
