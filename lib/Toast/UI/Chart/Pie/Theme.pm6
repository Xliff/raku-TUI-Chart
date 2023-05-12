use v6;

use Toast::UI::Chart::Basics;
use Toast::UI::Chart::Themes;

#
# class Toast::UI::Chart::Pie::Series is Toast::UI::Object {
#   has Bool $.selectable   is rw is built;
#   has Bool $.clockwise    is rw is built;
#   has RR   $.raduisRange  is rw is built;
#   has AR   $.angleRange   is rw is built;
#   has SDL  $.dataLabels   is rw is built;
# }
# constant Series is export = Toast::UI::Chart::Pie::Theme::Series;

class Theme-Series-Datalabels
  is   Toast::UI-BoxTheme
  does Toast::UI::Basics::Fonts
  does Toast::UI::Basics::Shadow
{
  has Toast::UI-BoxTheme $.pieSeriesName is rw is built;
  has Toast::UI-Callout  $.callout       is rw is built;
}

constant TSDL = Theme-Series-Datalabels;

class Theme-Series
  does Toast::UI::Chart::Theme
  is   Toast::UI::Object
{
  has Str    @.colors            is built;
  has Num    $.areaOpacity is rw is built;
  has Num    $.lineWidth   is rw is built;
  has Str    $.strokeStyle is rw is built;
  has Hover  $.hover       is rw is built;
  has Select $.select      is rw is built;
  has TSDL   $.dataLabels  is rw is built;
}

class Toast::UI::Chart::Theme::Pie::Series {
  has Theme-Series $.series      is rw is built;
}

constant Theme-Pie-Series is export = Toast::UI::Chart::Theme::Pie::Series;
