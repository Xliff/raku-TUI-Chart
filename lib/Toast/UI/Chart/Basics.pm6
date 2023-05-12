use v6;

use Method::Also;

our role Toast::UI::Basics::Fonts {
  has Str  $.fontFamily      is rw is built;
  has Num  $.fontSize        is rw is built;
  has Num  $.fontWeight      is rw is built;
}

our role Toast::UI::Basics::Shadow {
  has Str $.shadowColor   is rw is built;
  has Num $.shadowBlur    is rw is built;
  has Num $.shadowOffsetX is rw is built;
  has Num $.shadowOffsetY is rw is built;
}

our role Toast::UI::Basics::Style {
  has Str $.color         is rw is built;
  has Num $.lineWidth     is rw is built;
  has Str $.strokeStyle   is rw is built;
}

class Toast::UI::Chart::Basics::FontColor
  does Toast::UI::Basics::Fonts
  does JSON::Class
{
  has Str $.color is rw is built;
}

constant TUI-FontColor is export = Toast::UI::Chart::Basics::FontColor
