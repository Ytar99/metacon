unit info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, jpeg, ExtCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    RadioGroup1: TRadioGroup;
    Memo1: TMemo;
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Image2: TImage;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;


implementation

{$R *.dfm}

procedure TForm2.RadioGroup1Click(Sender: TObject);
var
  i:integer;
begin

  i := RadioGroup1.ItemIndex;

  if i = 4 then
  begin
    Form2.ClientWidth := 700;
    ScrollBox1.Visible := True;
    Image1.Visible := True;
    ScrollBox1.Width := 433;
    ScrollBox1.Height := 260;
    Memo1.ScrollBars := ssNone;
  end
  else
  begin
    if i = 6 then
      begin
        Form2.ClientWidth := 720;
        ScrollBox1.Visible := True;
        Image2.Visible := True;
        ScrollBox1.Width := 438;
        ScrollBox1.Height := 441;
        Memo1.ScrollBars := ssVertical;
      end
      else
      begin
        Form2.ClientWidth := 250;
        ScrollBox1.Visible := False;
        Image1.Visible := False;
        Image2.Visible := False;
        Memo1.ScrollBars := ssNone;
      end;
  end;

  case i of
  0: begin
    LabeledEdit1.Text := '���� �������� ������ �������';
    LabeledEdit2.Text := 'DEV';
    LabeledEdit3.Text := '1';
    Memo1.Text := '��������������� ��� ������������ �������.';
  end;

  1: begin
    LabeledEdit1.Text := '���� ������ ������ �������';
    LabeledEdit2.Text := 'CHA';
    LabeledEdit3.Text := '1';
    Memo1.Text := '����� - ��������� ��������� ������ ���������� ��������� ���������� �����������.' + #13#10 +
                  '������ ���������� � 0 �� 5.';
  end;

  2: begin
    LabeledEdit1.Text := '���� ������ ��������';
    LabeledEdit2.Text := 'REG';
    LabeledEdit3.Text := '1';
    Memo1.Text := '������� - ���������� ��� ��������� ������.';
  end;

  3: begin
    LabeledEdit1.Text := '���� �������';
    LabeledEdit2.Text := 'CMD';
    LabeledEdit3.Text := '1';
    Memo1.Text := '�������� ��� �������:' + #13#10 +
                  '00h - ������ ��������, RD,' + #13#10 +
                  '01h - ������ ��������, WR.';
  end;

  4: begin
    LabeledEdit1.Text := '���� ���� ������';
    LabeledEdit2.Text := 'TYP';
    LabeledEdit3.Text := '1';
    Memo1.Text := '������� ������� �������� �������� ��� ��������, � ������� ��� ���� ���������� ����� ������� � ��������:' + #13#10 +
    'TYP.7 = 1 - ������� �������� �� ������ (W);' + #13#10 +
    'TYP.6 = 1 - ������� �������� �� ������ (R).';
  end;

  5: begin
    LabeledEdit1.Text := '���� ������';
    LabeledEdit2.Text := 'DATA';
    LabeledEdit3.Text := '1..32';
    Memo1.Text := '����� ������������� (� ����������� �� ���������� ������).';
  end;

  6: begin
    LabeledEdit1.Text := '���� ����������� �����';
    LabeledEdit2.Text := 'CRC';
    LabeledEdit3.Text := '1';
    Memo1.Text := '������������ ����������� ���, ���������� �� ���� �������������� ����� ������� ������.' + #13#10 +  #13#10 +
                  '�������� �����������:' + #13#10 +
                  '- CRC -- ������� �������� ����������� �����;' + #13#10 +
                  '- BYTES_CTR -- ������� ������;' + #13#10 +
                  '- BITES_CTR -- ������� �����;' + #13#10 +
                  '- BYTES -- ��������� �� ������� �������������� ����;' + #13#10 +
                  '- A, B, C -- ��������������� ����������;' + #13#10 +
                  '- P_LENGTH -- ����� ������ ��� ����� ����������� �����;' +#13#10 +
                  '- (+) -- �������� ������������ �������� �� ������ 2;' + #13#10 +
                  '- SHR -- �������� ������������ ������ �� 1 ��� ������;' + #13#10 +
                  '- A.0 -- ����� ������� ��� ���������� A.';
  end;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Form2.ClientWidth := 250;
  Form2.ClientHeight := 500
end;

end.
