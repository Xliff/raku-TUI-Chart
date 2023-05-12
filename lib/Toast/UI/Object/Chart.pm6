use v6;

use Method::Also;
use JSON::Class;

class Toast::UI::Object does JSON::Class {
  has Str $.id is built;

  method header {
    state $once = False;

    do if $once {
      $once = True;

      qq:to/HEAD/;
        { callsame }
        <link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
        <script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
        HEAD
    } else {
      ''
    }
  }

  multi method Init {
    state $once = False;
    # cw: If not last line in block it needs a trailing ';'

    do if $once.not {
      $once = True;

      qq:to/INIT/;
        { callsame // ''}
        const Chart = toastui.Chart;
        INIT
    } else {
      ''
    }
  }

}
