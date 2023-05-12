use v6;

use TUI::Chart::Basics;

class TUI::Chart::Responsive::Animation is TUI::Chart::Object {
  has Int $.duration is rw is built;
}

constant Animation = TUI::Chart::Responsive::Animation;

class TUI::Chart::Responsive::Rule::Options::Interval is TUI::Chart::Object {
  has Int $.interval is rw is built;
}

constant Interval = TUI::Chart::Responsive::Rule::Options::Interval;

class TUI::Chart::Responsive::Rule::Options::XAxis
  is TUI::Chart::Object
{
  has Interval $.tick  is rw is built;
  has Interval $.label is rw is built;
}


class TUI::Chart::Responsive::Rule::Options is TUI::Chart::Object {
  has XAxis  $.xAxis  is rw is built;
  has Legend $.legend is rw is built;
}

class Options = TUI::Chart::Responsive::Rule::Options;

class TUI::Chart::Responsive::Rule is TUI::Chart::Object {
  has         $.condition-string is rw is built;
  has Options $.options          is rw is built;
}

class TUI::Chart::Responsive is TUI::Chart::Object {
  has Animation $.animation is rw is built;
  has Rule      @.rules           is built;
}
