use v6;

use Method::Also;
use JSON::Class;

class Toast::UI::Object does JSON::Class {
  has Str $.id is built;

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
    self;
  }

  method header {
    state $once = False;

    do if $once {
      $once = True;

      q:to/HEAD/;
        <link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
        <script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
        HEAD
    } else {
      ''
    }
  }

  multi method new ($id, *%a) {
    samewith($id, %a);
  }

  multi method new ($id, %a) {
    self.bless( :$id ).set(%a);
  }

  method Element is also<
    element
    HTML     html
    Chart    chart
  > {
    q:to/HTML/;
      <div id="{ $!id }"></div>
      HTML
  }

  proto method Init (|)
    is also<init>
  { * }

  multi method Init { '' }

}

our role NotInConstructor { }

multi sub trait_mod:<is>( Attribute \a, :$not-in-constructor is required )
  is export
{
  a does NotInConstructor
}
