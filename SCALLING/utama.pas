unit Utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs, ComCtrls;

type
  TFormUtama = class(TForm)
    ButtonSave: TButton;
    ButtonLoad: TButton;
    ButtonScaling: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
    RadioGroupPerbaikan: TRadioGroup;
    RadioGroupInisialisasi: TRadioGroup;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    Splitter1: TSplitter;
    TrackBarSkala: TTrackBar;
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonScalingClick(Sender: TObject);
    procedure TrackBarSkalaChange(Sender: TObject);
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}

uses
  windows, math;

var
  bitmapR, bitmapG, bitmapB : array [0..1000, 0..1000] of integer;
  hasilR, hasilG, hasilB : array [0..2000, 0..2000] of integer;
  bitmapBiner : array [0..1000, 0..1000] of boolean;
  modewarna : byte;


procedure TFormUtama.ButtonLoadClick(Sender: TObject);
var
  x, y : integer;
  maxscalex, maxscaley : integer;

begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);

    TrackBarSkala.Position:=1;
    for y:=0 to image1.Height-1 do
    begin
      for x:=0 to image1.Width-1 do
      begin
        bitmapR[x,y] := GetRValue(image1.Canvas.Pixels[x,y]);
        bitmapG[x,y] := GetGValue(image1.Canvas.Pixels[x,y]);
        bitmapB[x,y] := GetBValue(image1.Canvas.Pixels[x,y]);
      end;
    end;
  end;
end;


procedure TFormUtama.ButtonSaveClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    image2.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TFormUtama.ButtonScalingClick(Sender: TObject);
var
  i, j, x, y : integer;
  skala : double;
  inisial : integer;
  intervalR, intervalG, intervalB : double;
begin
  skala := TrackBarSkala.Position / 10;
  inisial := RadioGroupInisialisasi.ItemIndex * 255;
  for y:=0 to round((image1.Height-1)*skala) do
  begin
    for x:=0 to round((image1.Width-1)*skala) do
    begin
      hasilR[x,y] := inisial;
      hasilG[x,y] := inisial;
      hasilB[x,y] := inisial;
    end;
  end;
  for y:=0 to image1.Height-1 do
  begin
    for x:=0 to image1.Width-1 do
    begin
      hasilR[round(x*skala),round(y*skala)] := bitmapR[x,y];
      hasilG[round(x*skala),round(y*skala)] := bitmapG[x,y];
      hasilB[round(x*skala),round(y*skala)] := bitmapB[x,y];
    end;
  end;
  if RadioGroupPerbaikan.ItemIndex = 1 then
  begin
    for y :=0 to Image1.Width-1 do
    begin
      for x :=0 to Image1.Width-1 do
      begin
        for j:=1 to round(skala) do
        begin
          for i:=1 to round(skala) do
          begin
            hasilR[round(x*skala)+i, round(y*skala)+j] := bitmapR[x,y];
            hasilG[round(x*skala)+i, round(y*skala)+j] := bitmapG[x,y];
            hasilB[round(x*skala)+i, round(y*skala)+j] := bitmapB[x,y];
          end;
        end;
      end;
    end;
  end else
  begin
    if RadioGroupPerbaikan.ItemIndex = 2 then
    begin
      for i:=0 to image1.Width-1 do
      begin
        bitmapR[i,image1.Height] := bitmapR[i,image1.Height-1];
        bitmapG[i,image1.Height] := bitmapG[i,image1.Height-1];
        bitmapB[i,image1.Height] := bitmapB[i,image1.Height-1];
      end;
      for i:=0 to image1.Height do
      begin
        bitmapR[image1.Width,i] := bitmapR[image1.Width-1,i];
        bitmapG[image1.Width,i] := bitmapG[image1.Width-1,i];
        bitmapB[image1.Width,i] := bitmapB[image1.Width-1,i];
      end;
      for y :=0 to Image1.Height-1 do
      begin
        for x :=0 to Image1.Width-1 do
        begin
          intervalR := (bitmapR[x+1,y]-bitmapR[x,y])/skala;
          intervalG := (bitmapG[x+1,y]-bitmapG[x,y])/skala;
          intervalB := (bitmapB[x+1,y]-bitmapB[x,y])/skala;
          for i:=0 to round(skala) do
          begin
            hasilR[round(x*skala)+i, round(y*skala)] := bitmapR[x,y] + round(intervalR * i);
            hasilG[round(x*skala)+i, round(y*skala)] := bitmapG[x,y] + round(intervalG * i);
            hasilB[round(x*skala)+i, round(y*skala)] := bitmapB[x,y] + round(intervalB * i);
          end;
        end;
      end;
      for y :=0 to Image1.Height-1 do
      begin
        for x :=0 to round((Image1.Width)*skala) do
        begin
          intervalR := (hasilR[x,round((y+1)*skala)]-hasilR[x,round(y*skala)])/skala;
          intervalG := (hasilG[x,round((y+1)*skala)]-hasilG[x,round(y*skala)])/skala;
          intervalB := (hasilB[x,round((y+1)*skala)]-hasilB[x,round(y*skala)])/skala;
          for j:=1 to round(skala-1) do
          begin
            hasilR[x, round(y*skala)+j] := round(hasilR[x,round(y*skala)] + intervalR * j);
            hasilG[x, round(y*skala)+j] := round(hasilG[x,round(y*skala)] + intervalG * j);
            hasilB[x, round(y*skala)+j] := round(hasilB[x,round(y*skala)] + intervalB * j);
          end;
        end;
      end;
    end;
  end;
  for y:=0 to round((image1.Height-1)*skala) do
  begin
    for x:=0 to round((image1.Width-1)*skala) do
    begin
      image2.Canvas.Pixels[x,y] := RGB(hasilR[x,y], hasilG[x,y], hasilB[x,y]);
    end;
  end;
end;

procedure TFormUtama.TrackBarSkalaChange(Sender: TObject);
begin
  label1.Caption:=FloatToStr((TrackBarSkala.Position/10));
end;


end.

