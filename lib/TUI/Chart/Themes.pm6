use v6;

use TUI::Chart::Basics;

our role TUI::Chart::Theme { }

class CX::InvalidMethodHere is CX::Warn {
  method message {
    my $called-from = Backtrace.new.grep( *.subname )[2];

    "Not allowed to call { $called-from.subname } from class {
     $called-from.code.?package.^name }";
  }
}

class TUI::Chart::Theme::Series::Hover
  does TUI::Basics::Style
  does TUI::Basics::Shadow
  is   TUI::Chart::Object
{ }

constant Hover = TUI::Chart::Theme::Series::Hover;

class TUI::Chart::Theme::Series::RestSeries is TUI::Chart::Object {
  has Num $.areaOpacity is rw is built;
}

constant RestSeries = TUI::Chart::Theme::Series::RestSeries;

class TUI::Chart::Theme::Series::Select
  does TUI::Basics::Style
  does TUI::Basics::Shadow
  is   TUI::Chart::Object
{
  has RestSeries $.restSeries  is rw is built;
  has Num        $.areaOpacity is rw is built;
}

constant Select = TUI::Chart::Theme::Series::Select;

class TUI::Chart::Theme::Series::DataLabel::Callout
  is TUI::Chart::Object
{
  has Bool $.useSeriesColor is rw is built;
  has Num  $.lineWidth      is rw is built;
  has Str  $.lineColor      is rw is built;
}

constant TUI-Callout is export =
  TUI::Chart::Theme::Series::DataLabel::Callout;

class TUI::Chart::Theme::Common::TextBubble
  does TUI::Basics::Style
  does TUI::Basics::Shadow
  is   TUI::Chart::Object
{
  has Bool $.visible         is rw is built;
  has Num  $.paddingX        is rw is built;
  has Num  $.paddingY        is rw is built;
  has Str  $.backgroundColor is rw is built;
  has Num  $.borderRadius    is rw is built;
  has Str  $.borderColor     is rw is built;
  has Num  $.borderWidth     is rw is built;
}

constant TB = TUI::Chart::Theme::Common::TextBubble;

class TUI::Chart::Theme::Common::DataLabelBox
  does TUI::Basics::Style
  does TUI::Basics::Fonts
  does TUI::Basics::Shadow
  is   TUI::Chart::Object
{
  has Bool $.useSeriesColor  is rw is built;
  has Str  $.textStrokeColor is rw is built;
  has TB   $.textBubble      is rw is built;

  # cw: To become CX::Warn descendants?
  method strokeStyle   { CX::InvalidMethodHere.new.throw }
  method shadowOffsetX { CX::InvalidMethodHere.new.throw }
  method shadowOffsetY { CX::InvalidMethodHere.new.throw }
}

constant TUI-BoxTheme is export  = TUI::Chart::Theme::Common::DataLabelBox;

class TUI::Chart::Theme::DataLabel
  is TUI-BoxTheme
  is TUI::Chart::Object
{
  has TUI-BoxTheme $.pieSeriesName is rw is built;
  has TUI-Callout  $.callout       is rw is built;
}

constant DL is export = TUI::Chart::Theme::DataLabel;

class TUI::Chart::Theme::Options::Series::RadiusRange
  is TUI::Chart::Object
{
  has Int $.inner is rw is built;
  has Int $.outer is rw is built;
}

constant RR is export = TUI::Chart::Theme::Options::Series::RadiusRange;

class TUI::Chart::Theme::Options::Series::AngleRange
  is TUI::Chart::Object
{
  has Int $.start is rw is built;
  has Int $.end   is rw is built;
}

constant AR is export = TUI::Chart::Theme::Options::Series::AngleRange;
