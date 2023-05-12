use v6;

use Toast::UI::Chart::Basics;

our role Toast::UI::Chart::Theme { }

class CX::InvalidMethodHere is CX::Warn {
  method message {
    my $called-from = Backtrace.new.grep( *.subname )[2];

    "Not allowed to call { $called-from.subname } from class {
     $called-from.code.?package.^name }";
  }
}

class Toast::UI::Chart::Theme::Series::Hover
  does Toast::UI::Basics::Style
  does Toast::UI::Basics::Shadow
  is   Toast::UI::Object
{ }

constant Hover = Toast::UI::Chart::Theme::Series::Hover;

class Toast::UI::Chart::Theme::Series::RestSeries is Toast::UI::Object {
  has Num $.areaOpacity is rw is built;
}

constant RestSeries = Toast::UI::Chart::Theme::Series::RestSeries;

class Toast::UI::Chart::Theme::Series::Select
  does Toast::UI::Basics::Style
  does Toast::UI::Basics::Shadow
  is   Toast::UI::Object
{
  has RestSeries $.restSeries  is rw is built;
  has Num        $.areaOpacity is rw is built;
}

constant Select = Toast::UI::Chart::Theme::Series::Select;

class Toast::UI::Chart::Theme::Series::DataLabel::Callout
  is Toast::UI::Object
{
  has Bool $.useSeriesColor is rw is built;
  has Num  $.lineWidth      is rw is built;
  has Str  $.lineColor      is rw is built;
}

constant TUI-Callout is export =
  Toast::UI::Chart::Theme::Series::DataLabel::Callout;

class Toast::UI::Chart::Theme::Common::TextBubble
  does Toast::UI::Basics::Style
  does Toast::UI::Basics::Shadow
  is   Toast::UI::Object
{
  has Bool $.visible         is rw is built;
  has Num  $.paddingX        is rw is built;
  has Num  $.paddingY        is rw is built;
  has Str  $.backgroundColor is rw is built;
  has Num  $.borderRadius    is rw is built;
  has Str  $.borderColor     is rw is built;
  has Num  $.borderWidth     is rw is built;
}

constant TB = Toast::UI::Chart::Theme::Common::TextBubble;

class Toast::UI::Chart::Theme::Common::DataLabelBox
  does Toast::UI::Basics::Style
  does Toast::UI::Basics::Fonts
  does Toast::UI::Basics::Shadow
  is   Toast::UI::Object
{
  has Bool $.useSeriesColor  is rw is built;
  has Str  $.textStrokeColor is rw is built;
  has TB   $.textBubble      is rw is built;

  # cw: To become CX::Warn descendants?
  method strokeStyle   { CX::InvalidMethodHere.new.throw }
  method shadowOffsetX { CX::InvalidMethodHere.new.throw }
  method shadowOffsetY { CX::InvalidMethodHere.new.throw }
}

constant TUI-BoxTheme is export  = Toast::UI::Chart::Theme::Common::DataLabelBox;

class Toast::UI::Chart::Theme::DataLabel
  is Toast::UI-BoxTheme
  is Toast::UI::Object
{
  has Toast::UI-BoxTheme $.pieSeriesName is rw is built;
  has Toast::UI-Callout  $.callout       is rw is built;
}

constant DL is export = Toast::UI::Chart::Theme::DataLabel;

class Toast::UI::Chart::Theme::Options::Series::RadiusRange
  is Toast::UI::Object
{
  has Int $.inner is rw is built;
  has Int $.outer is rw is built;
}

constant RR is export = Toast::UI::Chart::Theme::Options::Series::RadiusRange;

class Toast::UI::Chart::Theme::Options::Series::AngleRange
  is Toast::UI::Object
{
  has Int $.start is rw is built;
  has Int $.end   is rw is built;
}

constant AR is export = Toast::UI::Chart::Theme::Options::Series::AngleRange;
