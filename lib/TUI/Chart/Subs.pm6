use v6.c;

our class X::TUI::InvalidValue is Exception {
  has $.bad-value is built;
  has $.attribute is built;

  method message {
    "An in valid value '{ self.bad-value } to the { $.attribute } attribute,
     which will only accept values of: { $.attribute.WHY.trailing }"
  }
}

multi sub getSetLimitedOptions ($self, Int $idx)          is export is rw {
  samewith( $self, $self.^attributes[$idx] );
}
multi sub getSetLimitedOptions ($self, Attribute() $attr) is export is rw {
  Proxy.new:
    FETCH => -> $     { $attr.get_value($self) },

    STORE => -> $, \v {
      if v eq $attr.WHY.trailing.split(/ \s+ '|' \s+ /).any {
        $attr.set_value($self, v);
      } else {
        X::TUI::InvalidValue.new( bad-value => v, attribute => $attr ).throw;
      }
    }
}
