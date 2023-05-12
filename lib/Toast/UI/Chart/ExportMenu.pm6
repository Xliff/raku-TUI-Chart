use v6;

use Toast::UI::Chart::Basics;

class Toast::UI::Chart::ExportMenu is Toast::UI::Object {
  has Bool $.visible  is rw is built;
  has Str  $.filename is rw is built;
}

constant TUI-ExportMenu is export = Toast::UI::Chart::ExportMenu;

sub ExportMenu-MAIN is export {
  Toast::UI::Chart::ExportMenu.from-json( q:to/JSON/ ).gist.say;
     {
       "visible": false
     }
     JSON

   Toast::UI::Chart::ExportMenu.from-json( q:to/JSON/ ).gist.say;
     {
       "filename": "custom_file_name"
     }
     JSON
}
