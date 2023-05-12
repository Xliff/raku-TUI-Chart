use v6.c;

use JSON::Fast;
use JSON::Class;

use Toast::UI::Object;

my $instance-num = 1;

class Toast::UI::Rolling is Toast::UI::Object does JSON::Class {
  has Str  $.element     is rw is built;
  has Bool $.isVariable  is rw is built;
  has Bool $.isCircular  is rw is built;
  has Int  $.duration    is rw is built;
  has Str  $.motion      is rw is built;
  has Int  $.initNum     is rw is built;
  has Str  $.direction   is rw is built;
  has Int  $.unit        is rw is built;
  has Str  $.wrapperTag  is rw is built;
  has Str  $.panelTag    is rw is built;
  has Str  $.data        is rw is built;

  has Str $.next-control is rw is built is not-in-constructor;
  has Str $.prev-control is rw is built is not-in-constructor;

  method header {
    qq:to/HEAD/;
      { callsame }
      <script src="https://uicdn.toast.com/tui.rolling/latest/tui-rolling.js"></script>
      HEAD
  }

  method new-control-name {
    "rolling_{ ++$instance-num }"
  }

  method control-name {
    "rolling_{ $instance-num }";
  }

  multi method Init {
    my %a = self.^attributes.skip(1).grep( * !~~ NotInConstructor).map({
      my \v = .get_value(self);
      Pair.new( .name.substr(2), v ) if v
    });

    my $controls = [~](
      |( ( self.dirControl( $!prev-control ), "\n" ) if $!prev-control ),
      |( ( self.dirControl( $!next-control ), "\n" ) if $!next-control )
    );

    qq:to/ECMA/;
      { callsame }

      const { self.new-control-name } = toastui.Rolling(\{
        "element": document.getElementById('{ self.element // 'rolling' }'){
          %a.elems ?? ",\n" ~
                      to-json(%a, :pretty, :sorted-keys).lines[1 .. * - 2]
                                                        .join("\n")
                   !! '' }
      \});
      { $controls }
      ECMA
  }

  method dirControl ($id) {
    qq:to/CONTROL/

      var control = document.getElementById('{$id}');
      CONTROL

    ~

    q:to/CONTROL/
      control.onclick = function(e) {
        var e = e || window.event;
        var target = e.target || e.srcElement;
        var className;

        if (target.tagName.toLowerCase() !== 'button') {
          return;
        }

        className = target.className;
      CONTROL

     ~

    qq:to/CONTROL/;
        if (className.indexOf('prev') > -1) \{
          { self.control-name }.roll(null, 'prev');
        } else if (className.indexOf('next') > -1) \{
          { self.control-name }.roll(null, 'next');
        \}
      }
      CONTROL

  }

}
