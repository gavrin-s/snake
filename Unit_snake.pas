unit Unit_snake;

interface 
 uses GraphABC;
 const width=510;
 const height=405;
 const size_cell=15;
 const size_field_width=width div size_cell;
 const size_field_height=height div size_cell;
 dialog_form=100;

 type 
 fields = class
 private
  cl_field:color;
  cl_line:Color;
  massiv: array[0..size_field_width,0..size_field_height] of 0..1;
 public
  constructor Create;
   begin 
    cl_field:=rgb(15,96,37);
    cl_line:=Color.green;
   end;
  procedure print;
  procedure lose;
 end;
 
 snakes = class
 public 
  body: array[0..1000,0..1] of integer;
  vector:integer:=VK_Right; 
  leng:integer:=2;
  cl_snake:Color;
  bool_turn:boolean:=false;
  
  constructor create;
   begin
    body[1,0]:=5;
    body[1,1]:=10;
    body[0,0]:=6;
    body[0,1]:=10;
    cl_snake:=color.Black;
   end;
  procedure print;
  procedure eat;
  function accient:boolean;
  function cut:boolean;
  function move:boolean;
 end;
 
 foods = class
  public
   x,y:integer;
   cl_food:color:=color.red;
   bool_eaten:boolean:=false;
   coin:integer:=0;
   
   constructor create;
    begin
     x:=Random(size_field_width);
     y:=Random(size_field_height);
    end;
   
   procedure born;
   procedure print;
 end;
 
  var snake:snakes;
    field:fields;
    food:foods;
    sound,b:System.Media.SoundPlayer;
    
 
implementation



function snakes.cut:boolean;
begin
 Result:=false;
 for var i:=4 to leng-1 do
  if (body[0,0]=body[i,0]) and (body[0,1]=body[i,1]) then
   begin
    Result:=true;
    break;
   end;
end;

procedure fields.lose;
begin
 {SetBrushColor(Color.Green);
 FillRectangle(0,0,width,height);
 PABCSystem.Print('YOU LOSE!!!')}
 b:= new System.Media.SoundPlayer;
 b.SoundLocation:='b.wav';
 b.Play;
end;

function snakes.accient:boolean;
begin
 if (body[0,0]<0) or (body[0,0]>size_field_width-1) or (body[0,1]<0) or (body[0,1]>size_field_height-1)
  then
   Result:=true
  else
   Result:=false;
end;

procedure snakes.eat;
begin
 if (body[0,0] = food.x) and (body[0,1] = food.y) then
  begin
   leng+=1;
   food.born;
   food.coin+=1;
   sound:= new system.Media.SoundPlayer;
   sound.SoundLocation:='ab.wav';
   sound.Play;
  end;

end; 
 
procedure foods.print;
begin
 SetBrushColor(cl_food);
 FillEllipse(x*size_cell,y*size_cell,(x+1)*size_cell,(y+1)*size_cell)
end;
 
procedure foods.born;
begin
 x:=Random(size_field_width);
 y:=Random(size_field_height);
end; 
 
procedure snakes.print;
begin
 SetBrushColor(cl_snake);
 for var i:=0 to leng-1 do
  begin
   FillRectangle(body[i,0]*size_cell,body[i,1]*size_cell,(body[i,0]+1)*size_cell,(body[i,1]+1)*size_cell); 
  end;
end;  

function snakes.move:boolean;
begin 

 for var i:=leng-1 downto 1 do
   body[i]:=body[i-1];
 case vector of
  VK_Left: body[0,0]-=1;
  VK_Right: body[0,0]+=1;
  VK_Up: body[0,1]-=1;
  VK_Down: body[0,1]+=1;
 end; 
  result:=snake.accient or snake.cut;
end;

procedure fields.print;
 begin
  SetBrushColor(cl_field);
  FillRectangle(0,0,width,height);
  SetPenColor(cl_line);
  for var i:=0 to size_field_width do
   Line(i*size_cell,0,i*size_cell,height);
  for var i:=0 to size_field_height do
   Line(0,i*size_cell,width,i*size_cell);
 end;
 
 begin
 end.