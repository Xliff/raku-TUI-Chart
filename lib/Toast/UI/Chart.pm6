use v6;

use Toast::UI::Chart::Basics;

use Toast::UI::Chart::Subs;

class Toast::UI::Chart::TitleOpts is Toast::UI::Object {
  has Str $.text    is rw is built;
  has Num $.offsetX is rw is built;
  has Num $.offsetY is rw is built;
  has Str $.align   is rw is built; #= left | right | center;

  method align is rw {
    getSetLimitedOptions(self, 3);
  }

  submethod BUILD (
    :$text,
    :$offsetX,
    :$offsetY,
    :$align
  ) {
    $!text    = $text    if $text;
    $!offsetX = $offsetX if $offsetX;
    $!offsetY = $offsetY if $offsetY;
    $!align   = $align   if $align;
  }

  multi method new (Str $text) {
    self.bless( :$text );
  }
  multi method new {
    self.bless;
  }
  multi method new (
    :$text,
    :$offsetX,
    :$offsetY,
    :$align
  ) {
    self.bless(
      :$text,
      :$offsetX,
      :$offsetY,
      :$align
    );
  }

}

constant TitleOpts = Toast::UI::Chart::TitleOpts;

class Toast::UI::Chart::Animation is Toast::UI::Object {
  has $.duration is rw is built;

  method new ($opt) {
    self.bless( duration => $opt.not ?? 0 !! $opt.Num );
  }
}

constant Animation = Toast::UI::Chart::Animation;

class Toast::UI::Chart is Toast::UI::Object {
  has TitleOpts $.title     is rw;
  has Animation $.animation is rw;
  has           $.width     is rw;    #= Num | 'auto'
  has           $.height    is rw;    #= Num | 'auto'

  submethod BUILD (
    :$title,
    :$animation,
    :$width,
    :$height
  ) {
    if $title ~~ Str {
      $!title = TitleOpts.new( text => $title );
    } else {
      my $t = $title;
      $t .= TitleOpts if $t.^can('TitleOpts');
      die "Cannot set \$!title to a { $t.^name } object!"
        unless $t ~~ TitleOpts;
      $!title = $t;
    }

    $!animation = $animation if $animation;
    $!width     = $width     if $width;
    $!height    = $height    if $height;
  }

  method new (
    :$title,
    :$animation,
    :$width,
    :$height
  ) {
    self.bless(
      :$title,
      :$animation,
      :$width,
      :$height
    );
  }
}

constant Toast::UI-Chart is export = Toast::UI::Chart;

sub MAIN is export {
  Toast::UI::Chart.from-json( q:to/JSON/ ).gist.say;
    {
      "title": {
        "text": "Chart Title",
        "offsetX": 0,
        "offsetY": 0,
        "align": "center"
      }
    }
    JSON

  Toast::UI::Chart.from-json( q:to/JSON/ ).gist.say;
    {
      "title": "My Title"
    }
    JSON

}
