use v6;

use JSON::Class;

class TUI::Chart::Object does JSON::Class {

  multi method set (*%a) {
    samewith(%a);
  }
  multi method set (%a) {
    for %a.pairs {
      if self.^can{ .key } {
        self."{ .key }"() = .value;
      } else {
        say "Cannot execute method .{ .key } on an instance of { self.^name }";
      }
    }
  }

}

our role TUI::Basics::Fonts {
  has Str  $.fontFamily      is rw is built;
  has Num  $.fontSize        is rw is built;
  has Num  $.fontWeight      is rw is built;
}

our role TUI::Basics::Shadow {
  has Str $.shadowColor   is rw is built;
  has Num $.shadowBlur    is rw is built;
  has Num $.shadowOffsetX is rw is built;
  has Num $.shadowOffsetY is rw is built;
}

our role TUI::Basics::Style {
  has Str $.color         is rw is built;
  has Num $.lineWidth     is rw is built;
  has Str $.strokeStyle   is rw is built;
}

class TUI::Chart::Basics::FontColor
  does TUI::Basics::Fonts
  does JSON::Class
{
  has Str $.color is rw is built;
}

constant TUI-FontColor is export = TUI::Chart::Basics::FontColor
