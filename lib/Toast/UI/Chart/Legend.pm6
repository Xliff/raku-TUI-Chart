use v6;

use Toast::UI::Chart::Basics;

role Toast::UI::Chart::Legend::Circle {
  has Bool $.visible;
}

class Toast::UI::Chart::Legend::Item is Toast::UI::Object {
  has Num $.width    is rw is built;
  has Str $.overflow is rw is built; #= ellipsis;
}

constant Item = Toast::UI::Chart::Legend::Item;

class Toast::UI::Chart::Legend::Theme::Label is Toast::UI::Object {
  has Num $.fontSize   is rw is built;
  has Str $.fontFamily is rw is built;
  has Int $.fontWeight is rw is built;  #= Num | Str
  has Str $.color      is rw is built;
}

constant Label = Toast::UI::Chart::Legend::Theme::Label;

role Toast::UI::Chart::Legend::Role::Theme {
  has Label $.label is rw is built;
}

class Toast::UI::Chart::Legend::Theme::Legend
  does Toast::UI::Chart::Legend::Role::Theme
{ }

constant LTL = Toast::UI::Chart::Legend::Theme::Legend;

class Toast::UI::Chart::Legend::Theme
  is Toast::UI::Object
{
  has LTL $.legend is rw is built;
}

constant Theme = Toast::UI::Chart::Legend::Theme;

class Toast::UI::Chart::Legend is Toast::UI::Object {
  has Str   $.align        is rw is built; #= top | bottom | right | left
  has Bool  $.showCheckbox is rw is built;
  has Bool  $.visible      is rw is built;
  has Num   $.maxWidth     is rw is built;
  has Item  $.item         is rw is built;
  has Theme $.theme        is rw is built;
}

constant TUI-Legend is export = Toast::UI::Chart::Legend;

sub Legend-MAIN is export {
  Toast::UI::Chart::Legend.from-json( q:to/JSON/ ).gist.say;
    {
      "item": {
        "width": 70,
        "overflow": "ellipsis"
      }
    }
    JSON

  Toast::UI::Chart::Legend.from-json( q:to/JSON/ ).gist.say;
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
