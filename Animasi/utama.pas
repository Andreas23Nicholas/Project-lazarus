unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ColorBox;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ColorBox1: TColorBox;
    ComboBox1: TComboBox;
    Image1: TImage;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
var
  x : integer;
  gerak : integer;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if x >= 500 then
    gerak :=-1;
  if x<=25 then
    gerak := 1;
  x := x+gerak;
  //hapus
  image1.Canvas.Brush.Color := clWhite;
  image1.Canvas.Pen.Color := clWhite;
  image1.Canvas.Pen.Style := psSolid;
  image1.Canvas.Rectangle(x-25+(gerak*(-1)),75,x+25+(gerak*(-1)),125);
  //gambar bolah
  image1.Canvas.Brush.Color := ColorBox1.Selected;
  image1.Canvas.Pen.Color := ColorBox1.Selected;
  image1.Canvas.Pen.Style := psSolid;
  if ComboBox1.ItemIndex = 0 then
    image1.Canvas.Rectangle(x-25,75,x+25,125)
  else
    image1.Canvas.Ellipse(x-25,75,x+25,125);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  x := 50;
  gerak := 1;
  image1.Canvas.Pen.Color:=clWhite;
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.Rectangle(0,0,image1.Width,image1.Height);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  for x:=50 to 500 do
  begin
    //hapus
    image1.Canvas.Brush.Color := clWhite;
    image1.Canvas.Pen.Color := clWhite;
    image1.Canvas.Pen.Style := psSolid;
    image1.Canvas.Rectangle(x-25-1,75,x+25-1,125);
    //gambar bolah
    image1.Canvas.Brush.Color := ColorBox1.Selected;
    image1.Canvas.Pen.Color := ColorBox1.Selected;
    image1.Canvas.Pen.Style := psSolid;
    image1.Canvas.Ellipse(x-25,75,x+25,125);
    //tahan dulu beberapa ms
    sleep(10);
    image1.Repaint;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  timer1.Enabled := not timer1.Enabled;
end;

end.

