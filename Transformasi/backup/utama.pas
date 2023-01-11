unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ColorBox;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonKomposit1: TButton;
    ButtonKomposit2: TButton;
    ButtonKomposit3: TButton;
    ButtonRotasi: TButton;
    ButtonScaling: TButton;
    ButtonTranslasi: TButton;
    ButtonClose: TButton;
    ButtonGambar: TButton;
    ButtonClear: TButton;
    CheckBoxM11: TCheckBox;
    CheckBoxM12: TCheckBox;
    CheckBoxM13: TCheckBox;
    CheckBoxM14: TCheckBox;
    CheckBoxM15: TCheckBox;
    CheckBoxM21: TCheckBox;
    CheckBoxM22: TCheckBox;
    CheckBoxM23: TCheckBox;
    CheckBoxM24: TCheckBox;
    CheckBoxM25: TCheckBox;
    CheckBoxM31: TCheckBox;
    CheckBoxM32: TCheckBox;
    CheckBoxM33: TCheckBox;
    CheckBoxM34: TCheckBox;
    CheckBoxM35: TCheckBox;
    CheckBoxM41: TCheckBox;
    CheckBoxM42: TCheckBox;
    CheckBoxM43: TCheckBox;
    CheckBoxM44: TCheckBox;
    CheckBoxM45: TCheckBox;
    CheckBoxM51: TCheckBox;
    CheckBoxM52: TCheckBox;
    CheckBoxM53: TCheckBox;
    CheckBoxM54: TCheckBox;
    CheckBoxM55: TCheckBox;
    ColorBox1: TColorBox;
    ComboBox1: TComboBox;
    EditD12: TEdit;
    EditD13: TEdit;
    EditD14: TEdit;
    EditD22: TEdit;
    EditD23: TEdit;
    EditD24: TEdit;
    EditD32: TEdit;
    EditD33: TEdit;
    EditD34: TEdit;
    EditD42: TEdit;
    EditD43: TEdit;
    EditD44: TEdit;
    EditD52: TEdit;
    EditD53: TEdit;
    EditD54: TEdit;
    EditSy: TEdit;
    EditTx: TEdit;
    EditD21: TEdit;
    EditD31: TEdit;
    EditD41: TEdit;
    EditD51: TEdit;
    EditSx: TEdit;
    EditSudut: TEdit;
    EditTy: TEdit;
    EditX1: TEdit;
    EditX2: TEdit;
    EditX3: TEdit;
    EditX4: TEdit;
    EditX5: TEdit;
    EditPivX: TEdit;
    EditY1: TEdit;
    EditY2: TEdit;
    EditY3: TEdit;
    EditY4: TEdit;
    EditY5: TEdit;
    EditD11: TEdit;
    EditPivY: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RadioGroupAdjacency: TRadioGroup;
    ScrollBox1: TScrollBox;
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonGambarClick(Sender: TObject);
    procedure ButtonKomposit1Click(Sender: TObject);
    procedure ButtonKomposit2Click(Sender: TObject);
    procedure ButtonKomposit3Click(Sender: TObject);
    procedure ButtonRotasiClick(Sender: TObject);
    procedure ButtonScalingClick(Sender: TObject);
    procedure ButtonTranslasiClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure EditPivYChange(Sender: TObject);
    procedure EditX1Change(Sender: TObject);
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
Type
  titik = Record
  x, y : integer;
  arah : array[1..4] of integer;
end;
Var
  Yhor, Xver, lebar, tinggi : integer;
  bangun : array [1..5] of titik;
  arah : array[1..5,1..5] of Boolean;

procedure TFormUtama.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormUtama.ButtonGambarClick(Sender: TObject);
Var
  ObjCheckBox : TCheckBox;
  ObjEdit : TEdit;
  i, j : integer;

begin
  if Sender<>NIL Then
  begin
    for i:=1 to 5 do
    begin
      ObjEdit := TEdit(FormUtama.FindComponent('EditX'+IntToStr(i)));
      bangun[i].x := StrToInt(ObjEdit.Text);
      ObjEdit := TEdit(FormUtama.FindComponent('EditY'+IntToStr(i)));
      bangun[i].y := StrToInt(ObjEdit.Text);
      for j:=1 to 4 do
      begin
        ObjEdit := TEdit(FormUtama.FindComponent('EditD'+IntToStr(i)+IntToStr(j)));
        bangun[i].arah[j] := StrToInt(ObjEdit.Text);
      end;
    end;
    for i:=1 to 5 do
    begin
      for j:=1 to 5 do
      begin
        ObjCheckBox := TCheckBox(FormUtama.FindComponent('CheckBoxM'+IntToStr(i)+IntToStr(j)));
        arah[i,j] := ObjCheckBox.Checked;
      end;
    end;
  end;
  Image1.Canvas.Pen.Color:=ColorBox1.Selected;
  Image1.Canvas.Pen.Style:=psSolid;
  case RadioGroupAdjacency.ItemIndex of
    0:begin
        if ComboBox1.ItemIndex = 0 then
        begin
          for i:=2 to 5 do
          begin
            image1.Canvas.MoveTo(Xver+bangun[1].x, Yhor-bangun[1].y);
            image1.Canvas.LineTo(Xver+bangun[i].x, Yhor-bangun[i].y);
          end;
          image1.Canvas.MoveTo(Xver+bangun[5].x, Yhor-bangun[5].y);
          for i:=2 to 5 do
          begin
            image1.Canvas.LineTo(Xver+bangun[i].x, Yhor-bangun[i].y);
          end;
        end else
        begin
          image1.Canvas.MoveTo(Xver+bangun[5].x, Yhor-bangun[5].y);
          for i:=1 to 5 do
          begin
            image1.Canvas.LineTo(Xver+bangun[i].x, Yhor-bangun[i].y);
          end;
        end;
    end;
    1:begin
      for i:=1 to 5 do
      begin
        for j:=1 to 4 do
        begin
          if (bangun[i].arah[j] > 0) then
          begin
            image1.Canvas.MoveTo(Xver+bangun[i].x, Yhor-bangun[i].y);
            image1.Canvas.LineTo(Xver+bangun[bangun[i].arah[j]].x, Yhor-bangun[bangun[i].arah[j]].y);
          end;
        end;
      end;
    end;
    2:begin
      for j:=1 to 5 do
      begin
        for i:=1 to 5 do
        begin
          if arah[i,j] then
          begin
            image1.Canvas.MoveTo(Xver+bangun[i].x, Yhor-bangun[i].y);
            image1.Canvas.LineTo(Xver+bangun[j].x, Yhor-bangun[j].y);
          end;
        end;
      end;
    end;
  end;
  for i:=1 to 5 do
  begin
    image1.Canvas.TextOut(Xver+bangun[i].x-20, Yhor-bangun[i].y,'P'+IntToStr(i));
  end;
  if sender<>nil then
  begin
    EditPivX.Text:='100';
    EditPivY.Text:='100';
  end;
end;

procedure TFormUtama.ButtonKomposit1Click(Sender: TObject);
var
  i : integer;
  SudutDeg, sudutRad : Double;
  temp : integer;
  Sx, Sy : Double;
  pivX, pivY : integer;
  Tx, Ty : integer;
begin
  //ambil input pivot
  pivX := StrToInt(EditPivX.Text);
  pivY := StrToInt(EditPivY.Text);
  //ambil input sudut
  SudutDeg := StrToFloat(EditSudut.Text);
  sudutRad := sudutDeg / 180 * pi; //konversi degree ke radian
  //ambil input skala
  Sx := StrToFloat(EditSx.Text);
  Sy := StrToFloat(EditSy.Text);
  //hitung Rotasi masing-masing koordinat
  for i:=1 to 5 do
  begin
    //translasi pivot ke 0,0
    Tx := -pivX;
    Ty := -pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
    //scaling
    bangun[i].x := Round(bangun[i].x * Sx);
    bangun[i].y := Round(bangun[i].y * Sy);
    //rotasi
    temp := bangun[i].x;
    bangun[i].x := Round(bangun[i].x * cos(sudutRad) - bangun[i].y * sin(sudutRad));
    bangun[i].y := Round(temp * sin(sudutRad) + bangun[i].y * cos(sudutRad));
    //translasi pivot ke titik pivot
    Tx := pivX;
    Ty := pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
  end;
  //hapus gambar yang lama
  ButtonClearClick(NIL);
  //gambar ulang grafiknya dengan koordinat yang baru.
  ButtonGambarClick(Nil);
end;

procedure TFormUtama.ButtonKomposit2Click(Sender: TObject);
var
  i : integer;
  SudutDeg, sudutRad : Double;
  temp : integer;
  Sx, Sy : Double;
  pivX, pivY : integer;
  Tx, Ty : integer;
begin
  //ambil input pivot
  pivX := StrToInt(EditPivX.Text);
  pivY := StrToInt(EditPivY.Text);
  //ambil input sudut
  SudutDeg := StrToFloat(EditSudut.Text);
  sudutRad := sudutDeg / 180 * pi; //konversi degree ke radian
  //ambil input skala
  Sx := StrToFloat(EditSx.Text);
  Sy := StrToFloat(EditSy.Text);
  //hitung Rotasi masing-masing koordinat
  for i:=1 to 5 do
  begin
    //translasi pivot ke 0,0
    Tx := -pivX;
    Ty := -pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
    //rotasi
    temp := bangun[i].x;
    bangun[i].x := Round(bangun[i].x * cos(sudutRad) - bangun[i].y * sin(sudutRad));
    bangun[i].y := Round(temp * sin(sudutRad) + bangun[i].y * cos(sudutRad));
    //scaling
    bangun[i].x := Round(bangun[i].x * Sx);
    bangun[i].y := Round(bangun[i].y * Sy);
    //translasi pivot ke titik pivot
    Tx := pivX;
    Ty := pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
  end;
  //hapus gambar yang lama
  ButtonClearClick(NIL);
  //gambar ulang grafiknya dengan koordinat yang baru.
  ButtonGambarClick(Nil);
end;

procedure TFormUtama.ButtonKomposit3Click(Sender: TObject);
var
  i : integer;
  SudutDeg, sudutRad : Double;
  temp : integer;
  pivX, pivY : integer;
  Tx, Ty : integer;
begin
  //ambil input pivot
  pivX := StrToInt(EditPivX.Text);
  pivY := StrToInt(EditPivY.Text);
  //ambil input sudut
  SudutDeg := StrToFloat(EditSudut.Text);
  sudutRad := sudutDeg / 180 * pi; //konversi degree ke radian
  //hitung Rotasi masing-masing koordinat
  for i:=1 to 5 do
  begin
    //translasi pivot ke 0,0
    Tx := -pivX;
    Ty := -pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
    //pivot point Rotation
    temp := bangun[i].x;
    bangun[i].x := Round(bangun[i].x * cos(sudutRad) - bangun[i].y * sin(sudutRad));
    bangun[i].y := Round(temp * sin(sudutRad) + bangun[i].y * cos(sudutRad));
    //translasi pivot ke titik pivot
    Tx := pivX;
    Ty := pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
    //rotasi non pivot
    temp := bangun[i].x;
    bangun[i].x := Round(bangun[i].x * cos(sudutRad) - bangun[i].y * sin(sudutRad));
    bangun[i].y := Round(temp * sin(sudutRad) + bangun[i].y * cos(sudutRad));
  end;
  //for i:=1 to 5 do
  begin
  end;
  //rotasi titik pivotnya untuk rotasi non pivot
  temp := pivX;
  pivX := Round(pivX * cos(sudutRad) - pivY * sin(sudutRad));
  pivY := Round(temp * sin(sudutRad) + pivY * cos(sudutRad));
  EditPivX.Text:=IntToStr(pivX);
  EditPivY.Text:=IntToStr(pivY);
  //hapus gambar yang lama
  ButtonClearClick(NIL);
  //gambar ulang grafiknya dengan koordinat yang baru.
  ButtonGambarClick(Nil);
end;

procedure TFormUtama.ButtonRotasiClick(Sender: TObject);
var
  i : integer;
  SudutDeg, sudutRad : Double;
  temp : integer;
  pivX, pivY : integer;
  Tx, Ty : integer;
begin
  pivX := StrToInt(EditPivX.Text);
  pivY := StrToInt(EditPivY.Text);
  //ambil input rotasi
  SudutDeg := StrToFloat(EditSudut.Text);
  sudutRad := sudutDeg / 180 * pi; //konversi degree ke radian
  //hitung Rotasi masing-masing koordinat
  for i:=1 to 5 do
  begin
    //translasi pivot ke 0,0
    Tx := -pivX;
    Ty := -pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
    //rotasi
    temp := bangun[i].x;
    bangun[i].x := Round(bangun[i].x * cos(sudutRad) - bangun[i].y * sin(sudutRad));
    bangun[i].y := Round(temp        * sin(sudutRad) + bangun[i].y * cos(sudutRad));
    //translasi pivot ke titik pivot
    Tx := pivX;
    Ty := pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
  end;
  //hapus gambar yang lama
  ButtonClearClick(NIL);
  //gambar ulang grafiknya dengan koordinat yang baru.
  ButtonGambarClick(Nil);
end;

procedure TFormUtama.ButtonScalingClick(Sender: TObject);
var
  i : integer;
  Sx, Sy : Double;
  pivX, pivY : integer;
  Tx, Ty : integer;
begin
  pivX := StrToInt(EditPivX.Text);
  pivY := StrToInt(EditPivY.Text);
  //ambil input skala
  Sx := StrToFloat(EditSx.Text);
  Sy := StrToFloat(EditSy.Text);
  //hitung scaling masing-masing koordinat
  for i:=1 to 5 do
  begin
    //translasi pivot ke 0,0
    Tx := -pivX;
    Ty := -pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
    //scaling
    bangun[i].x := Round(bangun[i].x * Sx);
    bangun[i].y := Round(bangun[i].y * Sy);
    //translasi pivot ke titik pivot
    Tx := pivX;
    Ty := pivY;
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
  end;
  //hapus gambar yang lama
  ButtonClearClick(NIL);
  //gambar ulang grafiknya dengan koordinat yang baru.
  ButtonGambarClick(Nil);
end;

procedure TFormUtama.ButtonTranslasiClick(Sender: TObject);
var
  i, Tx, Ty : integer;
  pivX, pivY : integer;
begin
  //ambil input translasi
  Tx := StrToInt(EditTx.Text);
  Ty := StrToInt(EditTy.Text);
  //hitung translasi masing-masing koordinat
  for i:=1 to 5 do
  begin
    bangun[i].x := bangun[i].x + Tx;
    bangun[i].y := bangun[i].y + Ty;
  end;
  //translasi pula pivotnya
  pivX := StrToInt(EditPivX.Text);
  pivY := StrToInt(EditPivY.Text);
  pivX := pivX + Tx;
  pivY := pivY + Ty;
  EditPivX.Text:=IntToStr(pivX);
  EditPivY.Text:=IntToStr(pivY);
  //hapus gambar yang lama
  ButtonClearClick(NIL);
  //gambar ulang grafiknya dengan koordinat yang baru.
  ButtonGambarClick(Nil);
end;

procedure TFormUtama.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0:begin
      //Limas
      EditX1.Text := '125';
      Edity1.Text := '150';
      EditX2.Text := '100';
      Edity2.Text := '50';
      EditX3.Text := '150';
      Edity3.Text := '50';
      EditX4.Text := '125';
      Edity4.Text := '100';
      EditX5.Text := '75';
      Edity5.Text := '100';
    end;
    1:begin
      //Bintang
      EditX1.Text := '50';
      Edity1.Text := '50';
      EditX2.Text := '100';
      Edity2.Text := '150';
      EditX3.Text := '150';
      Edity3.Text := '50';
      EditX4.Text := '25';
      Edity4.Text := '115';
      EditX5.Text := '175';
      Edity5.Text := '115';
    end;
    2:begin
      //Pentagonal
      EditX1.Text := '50';
      Edity1.Text := '50';
      EditX2.Text := '25';
      Edity2.Text := '115';
      EditX3.Text := '100';
      Edity3.Text := '150';
      EditX4.Text := '175';
      Edity4.Text := '115';
      EditX5.Text := '150';
      Edity5.Text := '50';
    end;
  end;
end;

procedure TFormUtama.EditPivYChange(Sender: TObject);
begin

end;

procedure TFormUtama.EditX1Change(Sender: TObject);
begin

end;

procedure TFormUtama.FormShow(Sender: TObject);
begin
  lebar := image1.Width;
  Xver := lebar div 2;
  tinggi := image1.Height;
  Yhor := tinggi div 2;
  ButtonClearClick(Nil);
end;

procedure TFormUtama.ButtonClearClick(Sender: TObject);
begin
  image1.Canvas.Pen.Style:=psSolid;
  image1.Canvas.Pen.Color:=clWhite;
  image1.Canvas.Brush.Style:=bsSolid;
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.Rectangle(0,0,lebar,tinggi);
  image1.Canvas.Pen.Style:=psDash;
  image1.Canvas.Pen.Color:=clRed;
  image1.Canvas.MoveTo(Xver,0);
  image1.Canvas.LineTo(Xver,tinggi);
  image1.Canvas.MoveTo(0, Yhor);
  image1.Canvas.LineTo(lebar, Yhor);
  image1.Canvas.TextOut(xVer-12, Yhor-6, '(0,0)');
end;


end.

