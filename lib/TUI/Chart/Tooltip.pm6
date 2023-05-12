use v6;

use JSON::Class;

use TUI::Chart::Basics;

class TUI::Chart::ToolTip::Template::Data::Value {
  has $.value;
}

constant Value = TUI::Chart::ToolTip::Template::Data::Value;

class TUI::Chart::ToolTip::Template::Data is TUI::Chart::Object {
  has Str   $.label          is rw is built;
  has Str   $.color          is rw is built;
  has Value $.value          is rw is built;
  has Str   $.formattedValue is rw is built;
  has Str   $.category       is rw is built;
  has Num   $.percentValue   is rw is built;
}

constant Data = TUI::Chart::ToolTip::Template::Data;

class TUI::Chart::ToolTip::Template::Model is TUI::Chart::Object {
  has Data @.data     is rw is built;
  has Str  $.category is rw is built;
}

constant Model = TUI::Chart::ToolTip::Template::Model;

class TUI::Chart::ToolTip::Template::Default is TUI::Chart::Object {
  has Str $.header is rw is built;
  has Str $.body   is rw is built;
}

constant Default = TUI::Chart::ToolTip::Template::Default;

class TUI::Chart::ToolTip::Theme::Tooltip is TUI::Chart::Object {
  has Str           $.background   is rw;
  has Str           $.borderColor  is rw;
  has Num           $.borderWidth  is rw;
  has Str           $.borderStyle  is rw;
  has Num           $.borderRadius is rw;
  has TUI-FontColor $.header       is rw;
  has TUI-FontColor $.body         is rw
}

constant Tooltip = TUI::Chart::ToolTip::Theme::Tooltip;

class TUI::Chart::ToolTip::Theme {
  has Tooltip $.tooltip is rw is built;
}

constant TooltipTheme = TUI::Chart::ToolTip::Theme;

class TUI::Chart::ToolTip::Template is TUI::Chart::Object {
  has Model        $.model           is rw is built;
  has Default      $.defaultTemplate is rw is built;
  has TooltipTheme $.theme           is rw is built is required;
}

constant Template = TUI::Chart::ToolTip::Template;

class TUI::Chart::ToolTip is TUI::Chart::Object {
  has Num          $.offsetX           is rw is built;
  has Num          $.offsetY           is rw is built;
  has              $.formattter-string is rw is built;
  has Template     $.template          is rw is built;

  #| When 'false' or 'False', $!transition becomes an empty string!
  has Str          $.transition is rw is built; #= Bool | Str

  has TooltipTheme $.theme      is rw is built;
}

constant TUI-ToolTip is export = TUI::Chart::ToolTip;

sub Tooltip-MAIN is export {
  TUI::Chart::ToolTip.from-json( q:to/JSON/ ).gist.say;
    {
      "theme": {
        "tooltip": {
          "background": "#80CEE1",
          "borderColor": "#3065AC",
          "borderWidth": 10,
          "borderRadius": 20,
          "borderStyle": "double"
        }
      }
    }
    JSON

  TUI::Chart::ToolTip.from-json( q:to/JSON/ ).gist.say;
    {
      "offsetX": 30,
      "transition": "transform 1s ease-in",
      "offsetY": -100
    }
    JSON

}
