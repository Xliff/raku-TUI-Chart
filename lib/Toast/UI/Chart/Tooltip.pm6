use v6;

use JSON::Class;

use Toast::UI::Chart::Basics;

class Toast::UI::Chart::ToolTip::Template::Data::Value {
  has $.value;
}

constant Value = Toast::UI::Chart::ToolTip::Template::Data::Value;

class Toast::UI::Chart::ToolTip::Template::Data is Toast::UI::Object {
  has Str   $.label          is rw is built;
  has Str   $.color          is rw is built;
  has Value $.value          is rw is built;
  has Str   $.formattedValue is rw is built;
  has Str   $.category       is rw is built;
  has Num   $.percentValue   is rw is built;
}

constant Data = Toast::UI::Chart::ToolTip::Template::Data;

class Toast::UI::Chart::ToolTip::Template::Model is Toast::UI::Object {
  has Data @.data     is rw is built;
  has Str  $.category is rw is built;
}

constant Model = Toast::UI::Chart::ToolTip::Template::Model;

class Toast::UI::Chart::ToolTip::Template::Default is Toast::UI::Object {
  has Str $.header is rw is built;
  has Str $.body   is rw is built;
}

constant Default = Toast::UI::Chart::ToolTip::Template::Default;

class Toast::UI::Chart::ToolTip::Theme::Tooltip is Toast::UI::Object {
  has Str           $.background   is rw;
  has Str           $.borderColor  is rw;
  has Num           $.borderWidth  is rw;
  has Str           $.borderStyle  is rw;
  has Num           $.borderRadius is rw;
  has Toast::UI-FontColor $.header       is rw;
  has Toast::UI-FontColor $.body         is rw
}

constant Tooltip = Toast::UI::Chart::ToolTip::Theme::Tooltip;

class Toast::UI::Chart::ToolTip::Theme {
  has Tooltip $.tooltip is rw is built;
}

constant TooltipTheme = Toast::UI::Chart::ToolTip::Theme;

class Toast::UI::Chart::ToolTip::Template is Toast::UI::Object {
  has Model        $.model           is rw is built;
  has Default      $.defaultTemplate is rw is built;
  has TooltipTheme $.theme           is rw is built is required;
}

constant Template = Toast::UI::Chart::ToolTip::Template;

class Toast::UI::Chart::ToolTip is Toast::UI::Object {
  has Num          $.offsetX           is rw is built;
  has Num          $.offsetY           is rw is built;
  has              $.formattter-string is rw is built;
  has Template     $.template          is rw is built;

  #| When 'false' or 'False', $!transition becomes an empty string!
  has Str          $.transition is rw is built; #= Bool | Str

  has TooltipTheme $.theme      is rw is built;
}

constant Toast::UI-ToolTip is export = Toast::UI::Chart::ToolTip;

sub Tooltip-MAIN is export {
  Toast::UI::Chart::ToolTip.from-json( q:to/JSON/ ).gist.say;
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

  Toast::UI::Chart::ToolTip.from-json( q:to/JSON/ ).gist.say;
    {
      "offsetX": 30,
      "transition": "transform 1s ease-in",
      "offsetY": -100
    }
    JSON

}
