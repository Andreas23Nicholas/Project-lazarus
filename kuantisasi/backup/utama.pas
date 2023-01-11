unit Utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ExtDlgs, ComCtrls, FileCtrl, Menus, ActnList;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonClose: TButton;
    ButtonProses: TButton;
    ButtonSave: TButton;
    ButtonLoad: TButton;
    ImageHasil: TImage;
    ImageAsli: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    RadioGroupKuantisasi: TRadioGroup;
    RadioGroupKonversiWarna: TRadioGroup;
    SavePictureDialog1: TSavePictureDialog;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonProsesClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure RadioGroupKonversiWarnaClick(Sender: TObject);
    procedure RadioGroupKuantisasiClick(Sender: TObject);
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}

{ TFormUtama }
uses windows, math;
//deklarasi variabel global
var
  bitmapR, bitmapG, bitmapB, BitmapGray, BitmapBiner : array[0..1000, 0..1000] of integer;
  hasilR, hasilG, hasilB, hasilGray, hasilBiner : array[0..1000, 0..1000] of integer;

procedure TFormUtama.ButtonCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFormUtama.ButtonLoadClick(Sender: TObject);
var
  i, j, R, G, B, gray : integer;
begin
  if (OpenPictureDialog1.Execute) then
  begin
    ImageAsli.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
  ImageHasil.Width:=ImageAsli.Width;
  ImageHasil.Height:=ImageAsli.Height;
  ImageHasil.Top:=ImageAsli.Top;
  ImageHasil.Left:=ImageAsli.Left + 10 + ImageAsli.Width;
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
    end;
  end;
end;

procedure TFormUtama.ButtonProsesClick(Sender: TObject);
//deklarasi variabel lokal
var
  bitR, bitG, bitB : integer;
  temp : Double;
  i, j, R, G, B : integer;
begin
  for j:=0 to ImageAsli.Height-1 do
  begin
    for i:=0 to ImageAsli.Width-1 do
    begin
      //kuantisasi
      case RadioGroupKuantisasi.ItemIndex of
        0 : begin
          bitR := 1;
          bitG := 1;
          bitB := 1;
        end;
        1 : begin
          bitR := 1;
          bitG := 2;
          bitB := 1;
        end;
        2 : begin
          bitR := 3;
          bitG := 3;
          bitB := 2;
        end;
        3 : begin
          bitR := 5;
          bitG := 6;
          bitB := 5;
        end;
      end;
      temp := bitmapR[i,j] / power(2,(8-bitR));
      hasilR[i,j] := floor(temp);
      temp := bitmapG[i,j] / power(2,(8-bitG));
      hasilG[i,j] := floor(temp);
      temp := bitmapB[i,j] / power(2,(8-bitB));
      hasilB[i,j] := floor(temp);
      //konversi warna kuantisasi
      case RadioGroupKonversiWarna.ItemIndex of
        0: begin
          //jika lebih dari tengah --> konversi warna ke batas atas jika tidak batas bawah
          if hasilR[i,j]<power(2,bitR)/2-1 then
            R := round(hasilR[i,j] * power(2,8-bitR))
          else
            R := round((hasilR[i,j]+1) * power(2,8-bitR) - 1);
          if hasilG[i,j]<power(2,bitG)/2-1 then
            G := round(hasilG[i,j] * power(2,8-bitG))
          else
            G := round((hasilG[i,j]+1) * power(2,8-bitG) - 1);
          if hasilB[i,j]<power(2,bitB)/2-1 then
            B := round(hasilB[i,j] * power(2,8-bitB))
          else
            B := round((hasilB[i,j]+1) * power(2,8-bitB) - 1);
        end;
        1: begin
          //konversi warna ke batas bawah
          R := round(hasilR[i,j] * power(2,8-bitR));
          G := round(hasilG[i,j] * power(2,8-bitG));
          B := round(hasilB[i,j] * power(2,8-bitB));
        end;
        2 : begin
          //konversi warna ke batas bawah
          R := round((hasilR[i,j]+1) * power(2,8-bitR) - 1);
          G := round((hasilG[i,j]+1) * power(2,8-bitG) - 1);
          B := round((hasilB[i,j]+1) * power(2,8-bitB) - 1);
        end;
      end;
      ImageHasil.Canvas.Pixels[i,j]:= RGB(R, G, B);
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

procedure TFormUtama.RadioGroupKonversiWarnaClick(Sender: TObject);
begin

end;

procedure TFormUtama.RadioGroupKuantisasiClick(Sender: TObject);
begin

end;


end.

