unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ColorBox;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonPakaiArray: TButton;
    ButtonClose: TButton;
    ButtonHapus: TButton;
    ButtonGambar: TButton;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    EditX1: TEdit;
    EditX2: TEdit;
    EditX3: TEdit;
    EditY1: TEdit;
    EditY2: TEdit;
    EditY3: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonGambarClick(Sender: TObject);
    procedure ButtonHapusClick(Sender: TObject);
    procedure ButtonPakaiArrayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}
//dari sini ke atas, jangan diubah-ubah, nanti lazarus sendiri yang mengubahnya
{ TFormUtama }
//bagian di bawah ini boleh di ubah-ubah
//deklarasi pemakaian library / unit
Uses Math, windows;

//deklarasi variabel Global
Var
  tinggi : Integer;
  lebar : Integer;
  kolomP, barisP : integer;

//event yang dipanggil ketika suatu form ditampilkan
procedure TFormUtama.FormShow(Sender: TObject);
//Deklarasi variabel Lokal
Var
  a : Double;
begin
  tinggi := Image1.Height;
  lebar  := Image1.Width;
  kolomP := lebar div 2;
  barisP := tinggi div 2;
  ButtonHapusClick(nil);
end;

procedure TFormUtama.ButtonHapusClick(Sender: TObject);
begin
  //menghapus canvas
  Image1.Canvas.pen.color := clWhite;
  Image1.Canvas.pen.Style := psSolid;
  Image1.Canvas.Brush.color := clWhite;
  Image1.Canvas.Brush.Style := bsSolid;
  image1.Canvas.Rectangle(0,0, image1.Width, image1.Height);
  //gambar sumbu koordinat
  Image1.Canvas.pen.color := clRed;
  Image1.Canvas.pen.Style := psDot;
  //bikin sumbu vertikal
  //mengarahkan pena ke titik awal garis
  Image1.Canvas.MoveTo(kolomP, 0);
  //tarik garis ke titik akhir garis
  Image1.Canvas.LineTo(kolomP, Image1.Height);
  //bikin sumbu horisontal
  Image1.Canvas.MoveTo(0, barisP);
  Image1.Canvas.LineTo(Image1.Width, barisP);
  //karena belum menggambar grafiknya, sumbu koordinat belum termasuk grafik, baru media atau background atau lapaknya atau apalah
end;

procedure TFormUtama.ButtonPakaiArrayClick(Sender: TObject);
var
  x,y : array[1..3] of integer;
  i : integer;
begin
  x[1] := StrToInt(editx1.Text);
  y[1] := StrToInt(edity1.Text);
  x[2] := StrToInt(EditX2.Text);
  y[2] := StrToInt(EditY2.Text);
  x[3] := StrToInt(EditX3.Text);
  y[3] := StrToInt(EditY3.Text);
  //contoh adjacency list
  image1.Canvas.MoveTo(kolomP+x[3], barisP-y[3]);
  for i:=1 to 3 do
  begin
    image1.Canvas.LineTo(kolomP+x[i], barisP-y[i]);
  end;
end;

procedure TFormUtama.ButtonGambarClick(Sender: TObject);
Var
  x1, y1, x2, y2, x3, y3 : integer;
begin
  x1 := StrToInt(editx1.Text);
  y1 := StrToInt(edity1.Text);
  x2 := StrToInt(EditX2.Text);
  y2 := StrToInt(EditY2.Text);
  x3 := StrToInt(EditX3.Text);
  y3 := StrToInt(EditY3.Text);

  Image1.Canvas.pen.Style := psSolid;
  image1.Canvas.MoveTo(kolomP+x1, barisP-y1);
  Image1.Canvas.pen.color := ColorBox1.Selected;
  image1.Canvas.LineTo(kolomP+x2, barisP-y2);
  Image1.Canvas.pen.color := ColorBox2.Selected;
  image1.Canvas.LineTo(kolomP+x3, barisP-y3);
  Image1.Canvas.pen.color := ColorBox3.Selected;
  image1.Canvas.LineTo(kolomP+x1, barisP-y1);

  image1.Canvas.TextOut(kolomP+x1, barisP-y1, 'P1');
  image1.Canvas.TextOut(kolomP+x2, barisP-y2, 'P2');
  image1.Canvas.TextOut(kolomP+x3, barisP-y3, 'P3');
end;

procedure TFormUtama.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

//keyword end. jangan sampai hilang
end.

