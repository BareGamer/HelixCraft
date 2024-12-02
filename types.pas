unit types;

type
  vert=record
    x,y,z:double;
    constructor Create(x,y,z:double);
    begin
      self.x:=x;
      self.y:=y;
      self.z:=z;
    end;
  end;
  
  normal=record
    x,y,z:double;
  end;
  
  tex=record
    u,v:double;
    constructor Create(u,v:double);
    begin
      self.u:=u;
      self.v:=v;
    end;
  end;

begin
  
end.