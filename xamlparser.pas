unit xamlparser;
uses types;

{$zerobasedstrings on}

function strtovert(s:string):vert;
begin
  if s.Contains('"') then 
  begin
    //var t:=s.Split('"');
    s:=s.Split('"')[1-integer(not(s[0]='"'))];
  end;
  var nums:=s.Split(',');
  var vert:=new vert;
  vert.x:=StrToInt(nums[0]);
  vert.y:=StrToInt(nums[1]);
  vert.z:=StrToInt(nums[2]);
  result:=vert;
end;

function strtotex(s:string):tex;
begin
  if s.Contains('"') then 
  begin
    s:=s.Split('"')[1-integer(not(s[0]='"'))];
  end;
  var nums:=s.Split(',');
  var text:=new tex;
  text.u:=StrToFloat(nums[0]);
  text.v:=StrToFloat(nums[1]);
  result:=text;
end;

function verttostr(t:vert):string;
begin
  result:=FloatToStr(t.x)+','+FloatToStr(t.y)+','+FloatToStr(t.z);
end;

function textostr(t:tex):string;
begin
  result:=FloatToStr(t.u)+','+FloatToStr(t.v);
end;

var Positions:array of vert:=new vert[0];
var TextureCoordinates:array of tex:=new tex[0];

var path:string;

function readfile(filepath:string):array of string;
begin
  path:=filepath;
  var f:text;
  assign(f,filepath);
  f.Reset;
  var s:=f.ReadToEnd.Split(' ');
  f.Close;
  result:=s;
end;

procedure savefile(filename,text:string);
begin
  var f:pabcsystem.text;
  assign(f,filename);
  f.Rewrite;
  f.Write(text);
  f.Flush;
  f.Close;
end;

function xamlpositions(s:array of string):array of vert;
begin
  for var i:integer:=0 to s.Length-1 do
  begin
    if not (s[i].Chars[0]='P') then 
    begin 
      continue;
    end else
      begin
        var check:=s[i].Split('=');
        if check[0]='Positions' then
        begin
          Setlength(Positions,Positions.Length+1);
          Positions[Positions.Length-1]:=strtovert(check[1]);
          var j:integer:=1;
          while not (s[i+j].Chars[s[i+j].Length-1]='"') do
          begin
            Setlength(Positions,Positions.Length+1);
            Positions[Positions.Length-1]:=strtovert(s[i+j]);
            j+=1;
          end;
          Setlength(Positions,Positions.Length+1);
          Positions[Positions.Length-1]:=strtovert(s[i+j]);
          result:=Positions;
          break;
        end;
      end;
  end;
end;

var texcoords:integer;  //shows where TextureCoordinates is located

function xamltexcoords(s:array of string):array of tex;
begin
  for var i:integer:=0 to s.Length-1 do
  begin
    if not (s[i].Chars[0]='T') then 
    begin 
      continue;
    end else
      begin
        var check:=s[i].Split('=');
        if check[0]='TextureCoordinates' then
        begin
          texcoords:=i;
          Setlength(TextureCoordinates,TextureCoordinates.Length+1);
          TextureCoordinates[TextureCoordinates.Length-1]:=strtotex(check[1]);
          var j:integer:=1;
          while not (s[i+j].Chars[s[i+j].Length-1]='"') do
          begin
            Setlength(TextureCoordinates,TextureCoordinates.Length+1);
            TextureCoordinates[TextureCoordinates.Length-1]:=strtotex(s[i+j]);
            j+=1;
          end;
          Setlength(TextureCoordinates,TextureCoordinates.Length+1);
          TextureCoordinates[TextureCoordinates.Length-1]:=strtotex(s[i+j]);
          result:=TextureCoordinates;
          break;
        end;
      end;
  end;
end;

function makexml(s:array of string;texcoords:array of tex;texcoordpos:integer):string;
begin
  s[texcoordpos]:='TextureCoordinates="'+textostr(texcoords[0]);
  for var i:integer:=1 to texcoords.length-2 do
  begin
    s[texcoordpos+i]:=textostr(texcoords[i]);
  end;
  s[texcoordpos+texcoords.length-1]:=textostr(texcoords[texcoords.length-1])+'"';
  result:=string.Join(' ', s);
end;

begin
  
end.