
uses GraphABC,Timers,Unit_snake,ABCButtons;

var t:Timer;
    speed:integer:=100;
    btn_start,btn_speed1,btn_speed2,btn_speed3,btn_menu:ButtonABC;


procedure btn_start_onclick;forward;
procedure menu;forward;
procedure btn_menu_onclick; forward;

procedure onTimer;
 begin 
  LockDrawing;
  snake.bool_turn:=true;
  snake.eat;
  if snake.move then 
   begin 
    UnlockDrawing;
    b:= new System.Media.SoundPlayer;
    b.SoundLocation:='b.wav'; 
    b.Play;
    t.stop;
    SetFontColor(Color.Yellow);
    SetFontStyle(fsItalicUnderline);
    SetBrushStyle(bsClear);
    TextOut(width div 2 -50,10,'LOSE!!!');
    SetBrushStyle(bsSolid);
    
    btn_start.Visible:=true;
    btn_start.RedrawNow;
    btn_menu.Visible:=true;
    btn_menu.ToFront;
   end
  else
   begin
    SetWindowTitle('Ваш счёт: '+InttoStr(food.coin));
    field.print;
    food.print;
    snake.print; 
    Redraw;
   end; 
 end;
 
procedure btn_menu_onclick;
 begin
  btn_menu.Visible:=false;
  btn_start.Visible:=false;
  Window.Clear;
  menu;
 end;
 
procedure KeyDown(Key:integer);
begin
  case Key of
   VK_Left: if (snake.vector<>VK_Right)and snake.bool_turn then
             begin
              snake.vector:=VK_Left;
              snake.bool_turn:=false;
             end; 
   VK_Right: if (snake.vector<>VK_Left)and snake.bool_turn then 
              begin
               snake.vector:=VK_Right;
               snake.bool_turn:=false;
              end;    
   VK_Up: If (snake.vector<>VK_Down) and snake.bool_turn then
           begin         
            snake.vector:=VK_Up;
            snake.bool_turn:=false;
           end; 
   VK_Down: if (snake.vector<>VK_Up) and snake.bool_turn then
             begin 
              snake.vector:=VK_Down;
              snake.bool_turn:=false;
             end; 
  end;           
end;

procedure btn_start_onclick;
begin
 btn_speed1.Visible:=false;
 btn_speed2.Visible:=false;
 btn_speed3.Visible:=false;
 btn_start.Visible:=false;
 btn_menu.Visible:=false;;
 field := new fields;
 snake := new snakes;
 food := new foods;
 t:=new timer(speed,onTimer);
 t.start();
end;

procedure btn_speed1_onclick;
begin
 speed:=150;
 btn_speed1.Color:=Color.MediumPurple;
 btn_speed2.Color:=Color.MediumSpringGreen;
 btn_speed3.Color:=Color.MediumSpringGreen;
end;

procedure btn_speed2_onclick;
begin
 speed:=100;
 btn_speed2.Color:=Color.MediumPurple;
 btn_speed1.Color:=Color.MediumSpringGreen;
 btn_speed3.Color:=Color.MediumSpringGreen;
end;

procedure btn_speed3_onclick;
begin
 speed:=50;
 btn_speed3.Color:=Color.MediumPurple;
 btn_speed2.Color:=Color.MediumSpringGreen;
 btn_speed1.Color:=Color.MediumSpringGreen;
end;

procedure menu;
begin
 Window.Clear;
 Window.Clear(Color.Green);
 SetFontSize(20);
 SetFontColor(Color.Yellow);
 SetFontStyle(fsItalicUnderline);
 SetBrushStyle(bsClear);
 TextOut(width div 2 -50,10,'SNAKE!!!');
 SetBrushStyle(bsSolid);
 
 btn_start.Visible:=true;
 btn_speed1.Visible:=true;
 btn_speed2.Visible:=true;
 btn_speed3.Visible:=true; 
 
end;

begin
 Randomize;
 SetWindowTitle('Snake');
 SetWindowWidth(width);
 SetWindowHeight(height);
 Window.CenteronScreen();
 Window.IsFixedSize:=true;
 OnKeyDown:=KeyDown;
 btn_start:= new ButtonABC(30, height div 2 +20, 100,40, 'Старт',color.MediumSpringGreen);
 btn_start.OnClick+=btn_start_onclick;
 btn_start.Visible:=false;
 btn_speed1:=new ButtonABC (width div 2 +50,height div 2 -50, 100,30,'Лопух', Color.MediumSpringGreen);
 btn_speed1.OnClick+=btn_speed1_onclick;
 btn_speed1.Visible:=false;
 btn_speed2:=new ButtonABC (width div 2 +50,height div 2 +20, 100,30,'Нормуль', Color.MediumPurple);
 btn_speed2.OnClick+=btn_speed2_onclick;
 btn_speed2.Visible:=false;
 btn_speed3:=new ButtonABC (width div 2 +50,height div 2 +90, 100,30,'Красаучег', Color.MediumSpringGreen);
 btn_speed3.OnClick+=btn_speed3_onclick;
 btn_speed3.Visible:=false;
 btn_menu:= new ButtonABC(width-130, height div 2 +20, 100,40, 'Меню', Color.MediumSpringGreen);
 btn_menu.Visible:=false;
 btn_menu.OnClick+=btn_menu_onclick;
 menu;
end.



