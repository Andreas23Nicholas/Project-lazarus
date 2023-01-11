unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ColorBox, ComCtrls;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonRotasi: TButton;
    ButtonClose: TButton;
    ButtonClear: TButton;
    ButtonElips: TButton;
    ColorBox1: TColorBox;
    EditJariX: TEdit;
    EditPusatX: TEdit;
    EditJariY: TEdit;
    EditPusatY: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ScrollBox1: TScrollBox;
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonElipsClick(Sender: TObject);
    procedure ButtonRotasiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}

{ TFormUtama }

Uses Math;
type
  titik = Record
  x, y : integer;
end;

var
  lebar, tinggi, xVer, yHor : integer;
  jariX, jariY : Integer;
  sudut : double;
  c : double;
  xPusat, yPusat : integer;
  bangun : array [1..5] of titik;
  x, y : integer;
  miring : double;

procedure TFormUtama.FormShow(Sender: TObject);
begin
  lebar := image1.Width;
  tinggi := image1.Height;
  xVer := lebar div 2;
  yHor := tinggi div 2;
  ButtonClearClick(nil);
end;

procedure TFormUtama.Image1Click(Sender: TObject);
begin

end;

procedure TFormUtama.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormUtama.ButtonElipsClick(Sender: TObject);
var
  x, y : integer;
  temp : integer;
begin
  jariX := StrToInt(EditJariX.Text);
  jariY := StrToInt(EditJariY.Text);
  xPusat := StrToInt(EditPusatX.Text);
  yPusat := StrToInt(EditPusatY.Text);
  miring := 0;
  c:=1/max(jariX,jariY);
  sudut:=0;
  while (sudut<=2*pi) do
  begin
    x := Round(jariX * cos(sudut));
    y := Round(jariY * sin(sudut));
    if miring>0 then
    begin
      temp := x;
      x := Round(x*cos(miring) - y*sin(miring));
      y := Round(temp*sin(miring) + y*cos(miring));
    end;
    image1.Canvas.Pixels[xVer+(xPusat+x), yHor-(yPusat+y)]:=ColorBox1.Selected;
    image1.Repaint;
    sudut := sudut + c;
  end;
end;

procedure TFormUtama.ButtonRotasiClick(Sender: TObject);
var
    i, Tx, Ty : integer;
    SudutDeg, sudutRad : Double;
    temp : integer;
    pivX, pivY : integer;
begin
    pivX := 100;
    pivY := 100;
    Tx := -pivX;
    Ty := -pivY;
    ButtonClearClick(Nil);
    for i:=1 to 5 do
    begin
      bangun[i].x := round(bangun[i].x + Tx);
      bangun[i].y := round(bangun[i].y + Ty);
    end;
    SudutDeg := 45;
    sudutRad := (sudutDeg*pi)/180;
    for i:=1 to 5 do
    begin
      temp := bangun[i].x;
      bangun[i].x := round(bangun[i].x * cos(sudutRad) - bangun[i].y * sin(sudutRad));
      bangun[i].y := round(temp        * sin(sudutRad) + bangun[i].y * cos(sudutRad));
    end;
    Tx := pivX;
    Ty := pivY;
    ButtonClearClick(Nil);
    image1.Canvas.MoveTo(Xver+bangun[i].x+Tx, Yhor-bangun[i].y+Ty);
    for i:=1 to 5 do
    begin
    bangun[i].x := round(bangun[i].x + Tx);
    bangun[i].y := round(bangun[i].y + Ty);
    image1.Canvas.LineTo(Xver+bangun[i].x, Yhor-bangun[i].y);
    end;
end;


procedure TFormUtama.ButtonClearClick(Sender: TObject);
begin
  image1.Canvas.Pen.Color:=clWhite;
  image1.Canvas.Pen.Style:=psSolid;
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.Brush.Style:=bsSolid;
  image1.Canvas.Rectangle(0,0,lebar,tinggi);
  image1.Canvas.Pen.Color:=clRed;
  image1.Canvas.Pen.Style:=psDash;
  image1.Canvas.MoveTo(xVer, 0);
  image1.Canvas.LineTo(xVer, tinggi);
  image1.Canvas.MoveTo(0, yHor);
  image1.Canvas.LineTo(lebar, yHor);
  image1.Canvas.Pen.Color:=clBlack;
  image1.Canvas.Pen.Style:=psSolid;
end;

end.

