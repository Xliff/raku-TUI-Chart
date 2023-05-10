use v6;

use JSON::Class;

class TUI::Chart::ExportMenu is JSON::Class {
  has Bool $.visible  is rw is built;
  has Str  $.filename is rw is built;
}

constant TUI-ExportMenu is export = TUI::Chart::ExportMenu;


sub MAIN is export {
  TUI::Chart::ExportMenu.from-json( q:to/JSON/ ).gist.say;
     {
       "visible": false
     }
     JSON

   TUI::Chart::ExportMenu.from-json( q:to/JSON/ ).gist.say;
     {
       "filename": "custom_file_name"
     }
     JSON
}
