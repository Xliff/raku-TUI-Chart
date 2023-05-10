use v6;

use JSON::Class;

role TUI::Chart::Legend::Circle {
  has Bool $.visible;
}

class TUI::Chart::Legend::Item does JSON::Class {
  has Num $.width    is rw is built;
  has Str $.overflow is rw is built; #= ellipsis;
}

constant Item = TUI::Chart::Legend::Item;

class TUI::Chart::Legend::Theme::Label does JSON::Class {
  has Num $.fontSize   is rw is built;
  has Str $.fontFamily is rw is built;
  has Int $.fontWeight is rw is built;  #= Num | Str
  has Str $.color      is rw is built;
}

constant Label = TUI::Chart::Legend::Theme::Label;

role TUI::Chart::Legend::Role::Theme {
  has Label $.label is rw is built;
}

class TUI::Chart::Legend::Theme::Legend
  does TUI::Chart::Legend::Role::Theme
{ }

constant LTL = TUI::Chart::Legend::Theme::Legend;

class TUI::Chart::Legend::Theme
  does JSON::Class
{
  has LTL $.legend is rw is built;
}

constant Theme = TUI::Chart::Legend::Theme;

class TUI::Chart::Legend does JSON::Class {
  has Str   $.align        is rw is built; #= top | bottom | right | left
  has Bool  $.showCheckbox is rw is built;
  has Bool  $.visible      is rw is built;
  has Num   $.maxWidth     is rw is built;
  has Item  $.item         is rw is built;
  has Theme $.theme        is rw is built;
}

sub MAIN is export {
  TUI::Chart::Legend.from-json( q:to/JSON/ ).gist.say;
    {
      "item": {
        "width": 70,
        "overflow": "ellipsis"
      }
    }
    JSON

  TUI::Chart::Legend.from-json( q:to/JSON/ ).gist.say;
    {
      "theme": {
        "legend": {
          "label": {
            "fontFamily": "cursive",
            "fontSize": 15,
            "fontWeight": 700,
            "color": "#ff416d"
          }
        }
      }
    }
    JSON
}
