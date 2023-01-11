unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ColorBox, ComCtrls;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonTranslasi: TButton;
    ButtonClose: TButton;
    ButtonClear: TButton;
    ButtonLingkaran: TButton;
    ColorBox1: TColorBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ScrollBox1: TScrollBox;
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonLingkaranClick(Sender: TObject);
    procedure ButtonTranslasiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  titik = record
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

procedure TFormUtama.FormShow(Sender: TObject);
begin
  lebar := image1.Width;
  tinggi := image1.Height;
  xVer := lebar div 2;
  yHor := tinggi div 2;
  ButtonClearClick(nil);
end;

procedure TFormUtama.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormUtama.ButtonLingkaranClick(Sender: TObject);
var
  miring : double;
  temp : integer;
begin
  jariX := 27;
  jariY := 27;
  xPusat := 0;
  yPusat := 0;
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

procedure TFormUtama.ButtonTranslasiClick(Sender: TObject);
var
  i, Tx, Ty, a, b, miring, temp : integer;
begin
  jariX := 27;
  jariY := 27;
  Tx := 100;
  Ty := 100;
  sudut :=0;
  miring :=0;
  c:=1/max(jariX,jariY);
  image1.Canvas.MoveTo(Xver+bangun[1].x, Yhor-bangun[1].y);
  for i:=1 to 5 do
  begin
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
    image1.Canvas.LineTo(Xver+bangun[i].x, Yhor-bangun[i].y);
  end;
  while (sudut<=2*pi) do
  begin
    a := Round(jariX * cos(sudut));
    b := Round(jariY * sin(sudut));
    if miring>0 then
    begin
      temp := a;
      a := Round(a*cos(miring) - b*sin(miring));
      b := Round(temp*sin(miring) + b*cos(miring));
    end;
    image1.Canvas.Pixels[xVer+(bangun[5].x+a), yHor-(bangun[5].y+b)]:=ColorBox1.Selected;
    image1.Repaint;
    sudut := sudut + c;
  end;
end;


procedure TFormUtama.FormCreate(Sender: TObject);
begin

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

