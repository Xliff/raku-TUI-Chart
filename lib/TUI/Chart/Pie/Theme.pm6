use v6;

use TUI::Chart::Basics;
use TUI::Chart::Themes;

#
# class TUI::Chart::Pie::Series is TUI::Chart::Object {
#   has Bool $.selectable   is rw is built;
#   has Bool $.clockwise    is rw is built;
#   has RR   $.raduisRange  is rw is built;
#   has AR   $.angleRange   is rw is built;
#   has SDL  $.dataLabels   is rw is built;
# }
# constant Series is export = TUI::Chart::Pie::Theme::Series;

class Theme-Series-Datalabels
  is   TUI-BoxTheme
  does TUI::Basics::Fonts
  does TUI::Basics::Shadow
{
  has TUI-BoxTheme $.pieSeriesName is rw is built;
  has TUI-Callout  $.callout       is rw is built;
}

constant TSDL = Theme-Series-Datalabels;

class Theme-Series
  does TUI::Chart::Theme
  is   TUI::Chart::Object
{
  has Str    @.colors            is built;
  has Num    $.areaOpacity is rw is built;
  has Num    $.lineWidth   is rw is built;
  has Str    $.strokeStyle is rw is built;
  has Hover  $.hover       is rw is built;
  has Select $.select      is rw is built;
  has TSDL   $.dataLabels  is rw is built;
}

class TUI::Chart::Theme::Pie::Series {
  has Theme-Series $.series      is rw is built;
}

constant Theme-Pie-Series is export = TUI::Chart::Theme::Pie::Series;
