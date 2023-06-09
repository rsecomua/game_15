unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, sButton, sSkinManager, sSkinProvider, XPMan;

type
  TForm1 = class(TForm)
    sButton1: TsButton;
    MainMenu1: TMainMenu;
    E1: TMenuItem;
    sButton2: TsButton;
    sButton3: TsButton;
    sButton4: TsButton;
    sButton5: TsButton;
    sButton6: TsButton;
    sButton7: TsButton;
    sButton8: TsButton;
    sButton9: TsButton;
    sButton10: TsButton;
    sButton11: TsButton;
    sButton12: TsButton;
    sButton13: TsButton;
    sButton14: TsButton;
    sButton15: TsButton;
    sButton16: TsButton;
    N1: TMenuItem;
    N2: TMenuItem;
    S1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    sSkinProvider1: TsSkinProvider;
    sSkinManager1: TsSkinManager;
    XPManifest1: TXPManifest;
    procedure E1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure newGame;
    procedure drwButton;
    procedure FormCreate(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    function findNiltag: integer;
    function CheckWin: boolean;
    function isSosedi(nl, tg: integer): boolean;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  matrix: array [0 .. 15] of byte;
  score: integer;

implementation

{$R *.dfm}

function TForm1.CheckWin: boolean;
var
  i: integer;
begin
  result := false;
  if matrix[15] <> 0 then
    exit;
  result := true;
  for i := 0 to 14 do
    result := result and boolean(matrix[i] = i + 1);

end;

procedure TForm1.drwButton;
var
  tg, i: integer;
begin
  for i := 0 to Form1.ComponentCount - 1 do
  begin
    if Form1.Components[i] is TsButton then
    begin
      tg := (Form1.Components[i] as TsButton).Tag;
      (Form1.Components[i] as TsButton).Caption := inttostr(matrix[tg]);
      (Form1.Components[i] as TsButton).Visible := boolean(matrix[tg] <> 0);
    end;
  end;
  if N4.Caption = 'En' then
    S1.Caption := '����: ' + inttostr(score)
  Else
    S1.Caption := 'Score: ' + inttostr(score);
  if CheckWin then
  begin
    if N4.Caption = 'En' then
      MessageBox(handle, PChar(S1.Caption), PChar('�� ���������!'),
        MB_OK + MB_ICONINFORMATION)
    else
      MessageBox(handle, PChar(S1.Caption), PChar('You Win'),
        MB_OK + MB_ICONINFORMATION);
  end;

end;

procedure TForm1.E1Click(Sender: TObject);
begin
  application.Terminate;
end;

function TForm1.findNiltag: integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to 15 do
    if matrix[i] = 0 then
      result := i;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  newGame;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin

  if ssleft in Shift then
  begin
    ReleaseCapture;
    Form1.Perform(wm_syscommand, $F012, 0);
  end;
end;

function TForm1.isSosedi(nl, tg: integer): boolean;
begin
  result := false;
  case tg of
    0:
      if (nl in [1, 4]) then
        result := true;
    1:
      if (nl in [0, 2, 5]) then
        result := true;
    2:
      if (nl in [1, 3, 6]) then
        result := true;
    3:
      if (nl in [2, 7]) then
        result := true;
    4:
      if (nl in [0, 5, 8]) then
        result := true;
    5:
      if (nl in [1, 4, 6, 9]) then
        result := true;
    6:
      if (nl in [2, 5, 7, 10]) then
        result := true;
    7:
      if (nl in [3, 6, 11]) then
        result := true;
    8:
      if (nl in [4, 9, 12]) then
        result := true;
    9:
      if (nl in [5, 8, 10, 13]) then
        result := true;
    10:
      if (nl in [6, 9, 11, 14]) then
        result := true;
    11:
      if (nl in [7, 10, 15]) then
        result := true;
    12:
      if (nl in [8, 13]) then
        result := true;
    13:
      if (nl in [9, 12, 14]) then
        result := true;
    14:
      if (nl in [10, 13, 15]) then
        result := true;
    15:
      if (nl in [11, 14]) then
        result := true;
  end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  newGame;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  if N4.Caption = 'Enlish' then
  begin
    N4.Caption := '����������';
    N1.Caption := 'NewGame';
    E1.Caption := 'Exit';
  end
  else
  begin
    N4.Caption := 'En';
    N1.Caption := '���� ���';
    E1.Caption := '�����';
  end;
  drwButton;
end;

procedure TForm1.newGame;
var
  r, i: integer;
  t: byte;
begin
  score := 0;
  randomize;
  for i := 0 to 15 do
    matrix[i] := i;
  for i := 0 to 15 do
  begin
    r := random(16);
    t := matrix[i];
    matrix[i] := matrix[r];
    matrix[r] := t;
  end;
  drwButton;
end;

procedure TForm1.sButton1Click(Sender: TObject);
var
  nl, tg: integer;
begin
  tg := (Sender as TsButton).Tag;
  nl := findNiltag;
  if not isSosedi(nl, tg) then
    exit;
  matrix[nl] := matrix[tg];
  matrix[tg] := 0;
  inc(score);
  drwButton;
end;

end.
