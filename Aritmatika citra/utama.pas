unit Utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ExtDlgs, ComCtrls;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonBlending: TButton;
    ButtonLogika: TButton;
    ButtonBiner: TButton;
    ButtonLoad2: TButton;
    ButtonClose: TButton;
    ButtonProses: TButton;
    ButtonSave: TButton;
    ButtonLoad: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ImageAsli2: TImage;
    ImageHasil: TImage;
    ImageAsli: TImage;
    Label1: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    TrackBar1: TTrackBar;
    procedure ButtonBinerClick(Sender: TObject);
    procedure ButtonBlendingClick(Sender: TObject);
    procedure ButtonLoad2Click(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonLogikaClick(Sender: TObject);
    procedure ButtonProsesClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}

uses windows, math;
var
  bitmapR, bitmapG, bitmapB, BitmapGray, BitmapBiner : array[0..1000, 0..1000] of integer;
  bitmapR2, bitmapG2, bitmapB2, BitmapGray2, BitmapBiner2 : array[0..1000, 0..1000] of integer;
  hasilR, hasilG, hasilB, hasilGray, hasilBiner : array[0..1000, 0..1000] of integer;

procedure TFormUtama.ButtonCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFormUtama.ButtonLoad2Click(Sender: TObject);
var
  i, j, R, G, B, gray : integer;
begin
  if (OpenPictureDialog1.Execute) then
  begin
    ImageAsli2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
  for j:=0 to ImageAsli2.Height-1 do
  begin
    for i:=0 to ImageAsli2.Width-1 do
    begin
      //mengambil nilai RGB
      R := GetRValue(ImageAsli2.Canvas.Pixels[i,j]);
      G := GetGValue(ImageAsli2.Canvas.Pixels[i,j]);
      B := GetBValue(ImageAsli2.Canvas.Pixels[i,j]);
      gray := (R + G + B) div 3;
      bitmapR2[i,j] := R;
      bitmapG2[i,j] := G;
      bitmapB2[i,j] := B;
      bitmapGray2[i,j] := gray;
      if gray>127 then
        BitmapBiner2[i,j] := 1
      else
        BitmapBiner2[i,j] := 0;
    end;
  end;
end;

procedure TFormUtama.ButtonBinerClick(Sender: TObject);
var
  i, j : integer;
begin
  //lengkapi procedure ini agar bisa untuk operasi lain (-, *, /)
  for j:=0 to ImageAsli.Height-1 do
  begin
    for i:=0 to ImageAsli.Width-1 do
    begin
      case ComboBox2.ItemIndex of
        0: begin
          hasilBiner[i,j] := BitmapBiner[i,j] + BitmapBiner2[i,j];
          if hasilBiner[i,j]>1 then hasilBiner[i,j] := 1
          else hasilBiner[i,j] := 0;
        end;
        1: begin
          hasilBiner[i,j] := BitmapBiner[i,j] - BitmapBiner2[i,j];
          if hasilBiner[i,j]>1 then hasilBiner[i,j] := 1
          else hasilBiner[i,j] := 0;
        end;
        2: begin
          hasilBiner[i,j] := BitmapBiner[i,j] * BitmapBiner2[i,j];
          if hasilBiner[i,j]>1 then hasilBiner[i,j] := 1
          else hasilBiner[i,j] := 0;
        end;
        3: begin
          hasilBiner[i,j] := round(BitmapBiner[i,j] / BitmapBiner2[i,j]);
          if hasilBiner[i,j]>1 then hasilBiner[i,j] := 1
          else hasilBiner[i,j] := 0;
      end;

      end;
      //ImageHasil.Canvas.Pixels[i,j]:= RGB(hasilBiner[i,j], hasilBiner[i,j], hasilBiner[i,j]); //tidak bisa dengan begini saja
      //1 diintepretasikan sebagai 255
      //0 tetap diintepretasikan sebagai 0
      //bisa pakai cara ini
      ImageHasil.Canvas.Pixels[i,j]:= RGB(hasilBiner[i,j]*255, hasilBiner[i,j]*255, hasilBiner[i,j]*255);
      //atau cara ini
      {if hasilBiner[i,j] = 1 then
        ImageHasil.Canvas.Pixels[i,j]:= RGB(255, 255, 255)
      else
        ImageHasil.Canvas.Pixels[i,j]:= RGB(0,0,0);}
    end;
  end;
end;

procedure TFormUtama.ButtonBlendingClick(Sender: TObject);
var
  i, j : integer;
  P : Double;
begin
  //Penugasan P
  P := TrackBar1.Position/10;
  for j:=0 to ImageAsli.Height-1 do
  begin
    for i:=0 to ImageAsli.Width-1 do
    begin
      hasilR[i,j] := Round(P*bitmapR[i,j] + (1-P)*bitmapR2[i,j]);
      hasilG[i,j] := Round(P*bitmapG[i,j] + (1-P)*bitmapG2[i,j]);
      hasilB[i,j] := Round(P*bitmapB[i,j] + (1-P)*bitmapB2[i,j]);
      ImageHasil.Canvas.Pixels[i,j]:= RGB(hasilR[i,j], hasilG[i,j], hasilB[i,j]);
    end;
  end;
end;


procedure TFormUtama.ButtonLoadClick(Sender: TObject);
var
  i, j, R, G, B, gray : integer;
begin
  if (OpenPictureDialog1.Execute) then
  begin
    ImageAsli.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
  ImageAsli2.Width:=ImageAsli.Width;
  ImageAsli2.Height:=ImageAsli.Height;
  ImageAsli2.Top:=ImageAsli.Top;
  ImageAsli2.Left:=ImageAsli.Left + 10 + ImageAsli.Width;
  ImageHasil.Width:=ImageAsli.Width;
  ImageHasil.Height:=ImageAsli.Height;
  ImageHasil.Top:=ImageAsli.Top;
  ImageHasil.Left:=ImageAsli.Left + 2*(10 + ImageAsli.Width);
  for j:=0 to ImageAsli.Height-1 do
  begin
    for i:=0 to ImageAsli.Width-1 do
    begin
      //mengambil nilai RGB
      R := GetRValue(ImageAsli.Canvas.Pixels[i,j]);
      G := GetGValue(ImageAsli.Canvas.Pixels[i,j]);
      B := GetBValue(ImageAsli.Canvas.Pixels[i,j]);
      gray := (R + G + B) div 3;
      bitmapR[i,j] := R;
      bitmapG[i,j] := G;
      bitmapB[i,j] := B;
      bitmapGray[i,j] := gray;
      if gray>127 then
        BitmapBiner[i,j]  := 1
      else
        BitmapBiner[i,j]  := 0;
    end;
  end;
end;

procedure TFormUtama.ButtonLogikaClick(Sender: TObject);
//deklarasi variabel lokal
var
  bitR, bitG, bitB : integer;
  temp : Double;
  i, j, R, G, B, gray : integer;
begin
  //lengkapi procedure ini agar bisa untuk operasi lain (or, nor, nand, xor dsb)
  for j:=0 to ImageAsli.Height-1 do
  begin
    for i:=0 to ImageAsli.Width-1 do
    begin
      case ComboBox3.ItemIndex of
        0: begin
          if (BitmapBiner[i,j]=1) AND (BitmapBiner2[i,j]=1) then
            hasilBiner[i,j] := 1
          else
            hasilBiner[i,j] := 0;
        end;
        1: begin
          if (BitmapBiner[i,j]=1) OR (BitmapBiner2[i,j]=1) then
            hasilBiner[i,j] := 1
          else
            hasilBiner[i,j] := 0;
        end;
        2: begin
          if (BitmapBiner[i,j]=0) AND (BitmapBiner2[i,j]=0) then
            hasilBiner[i,j] := 1
          else
            hasilBiner[i,j] := 0;
        end;
        3: begin
          if (BitmapBiner[i,j]=0) OR (BitmapBiner2[i,j]=0) then
            hasilBiner[i,j] := 1
          else
            hasilBiner[i,j] := 0;
        end;
        4: begin
          if (BitmapBiner[i,j]=1) XOR (BitmapBiner2[i,j]=1) then
            hasilBiner[i,j] := 1
          else
            hasilBiner[i,j] := 0;
        end;
        //tambahkan sendiri untuk operasi lainnya
      end;
      //ImageHasil.Canvas.Pixels[i,j]:= RGB(hasilBiner[i,j], hasilBiner[i,j], hasilBiner[i,j]); //yang ini tidak boleh nanti hasilnya hitam semua

      //pakai ini
      ImageHasil.Canvas.Pixels[i,j]:= RGB(hasilBiner[i,j]*255, hasilBiner[i,j]*255, hasilBiner[i,j]*255);
      //atau ini
      //if hasilBiner[i,j] = 1 then
        //ImageHasil.Canvas.Pixels[i,j]:= RGB(255, 255, 255)
      //else
        //ImageHasil.Canvas.Pixels[i,j]:= RGB(0,0,0 );
    end;
  end;
end;

procedure TFormUtama.ButtonProsesClick(Sender: TObject);
var
  bitR, bitG, bitB : integer;
  temp : Double;
  i, j, R, G, B, gray : integer;
begin
  for j:=0 to ImageAsli.Height-1 do
  begin
    for i:=0 to ImageAsli.Width-1 do
    begin
      case ComboBox1.ItemIndex of
        0:hasilGray[i,j] := BitmapGray[i,j] + BitmapGray2[i,j];
        1:hasilGray[i,j] := BitmapGray[i,j] - BitmapGray2[i,j];
        2:hasilGray[i,j] := BitmapGray[i,j] * BitmapGray2[i,j];
        3:hasilGray[i,j] := round(BitmapGray[i,j] / BitmapGray2[i,j]);
      end;

      if hasilGray[i,j]>255 then hasilGray[i,j] := 255;
      if hasilGray[i,j]<0 then hasilGray[i,j] := 0;

      ImageHasil.Canvas.Pixels[i,j]:= RGB(hasilGray[i,j], hasilGray[i,j], hasilGray[i,j]);
    end;
  end;
end;

procedure TFormUtama.ButtonSaveClick(Sender: TObject);
begin
  if (SavePictureDialog1.Execute) then
  begin
    ImageHasil.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TFormUtama.TrackBar1Change(Sender: TObject);
begin
  label1.Caption:=IntToStr(TrackBar1.Position * 10)+'%';
end;


end.

