unit filehelpers;
uses xamlparser;
uses System.runtime.interopservices;

[Dllimport ('User32.dll', charset = charset.auto)]
function MessageBox(h:integer;m,c:string;t:integer):integer;external;

var matsfolder:string;
var wine:boolean;

procedure directorychecks();
begin
  var t:text;
  var directory:=GetCurrentDir();
  writeln(directory);
  if directory.contains('Z:')then
  begin
    {if not fileexists(directory+'gamepath.txt') then
    begin
      writeln('Warning! Possible use of wine detected. Please refer to the text document or repo for more info.');
      MessageBox(0,'Warning!','Possible use of wine detected. Please refer to the text document or repo for more info.',0);
      halt
    end else
    begin}
      wine:=true;
      var l:text;
      l:=OpenRead('gamepath.txt',system.text.encoding.utf8);
      var dir:=l.ReadlnString();
      chdir(dir);
      l.Close;
      matsfolder:=dir+'\tex\';
    {end;}
  end;
  if not wine then
  begin
  if not(fileexists('directory.txt')) then
  begin
    t:=OpenWrite('directory.txt',system.text.encoding.utf8);
    t.Write(directory);
    t.Flush;
    t.Close;
  end else begin
    t:=OpenRead('directory.txt',system.text.encoding.utf8);
    var path:string:=t.ReadlnString;
    t.Close;
    if not(path=directory) then
    begin
      t.Rewrite(system.text.encoding.utf8);
      t.Write(directory);
      t.Flush;
      t.Close;
    end;
  end;
  end;
end;

procedure setmatsfolder();
begin
  if not wine then
  begin
  var t:text;
  t:=OpenRead('directory.txt',system.text.encoding.utf8);
  matsfolder:=t.ReadlnString+'\tex\';
  t.Close;
  end;
end;

begin
  directorychecks;
  setmatsfolder;
end.