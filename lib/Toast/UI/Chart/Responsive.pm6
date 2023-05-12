use v6;

use Toast::UI::Chart::Basics;

class Toast::UI::Chart::Responsive::Animation is Toast::UI::Object {
  has Int $.duration is rw is built;
}

constant Animation = Toast::UI::Chart::Responsive::Animation;

class Toast::UI::Chart::Responsive::Rule::Options::Interval is Toast::UI::Object {
  has Int $.interval is rw is built;
}

constant Interval = Toast::UI::Chart::Responsive::Rule::Options::Interval;

class Toast::UI::Chart::Responsive::Rule::Options::XAxis
  is Toast::UI::Object
{
  has Interval $.tick  is rw is built;
  has Interval $.label is rw is built;
}


class Toast::UI::Chart::Responsive::Rule::Options is Toast::UI::Object {
  has XAxis  $.xAxis  is rw is built;
  has Legend $.legend is rw is built;
}

class Options = Toast::UI::Chart::Responsive::Rule::Options;

class Toast::UI::Chart::Responsive::Rule is Toast::UI::Object {
  has         $.condition-string is rw is built;
  has Options $.options          is rw is built;
}

class Toast::UI::Chart::Responsive is Toast::UI::Object {
  has Animation $.animation is rw is built;
  has Rule      @.rules           is built;
}
