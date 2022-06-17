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
    LabeledEdit1.Text := 'Поле сетевого адреса прибора';
    LabeledEdit2.Text := 'DEV';
    LabeledEdit3.Text := '1';
    Memo1.Text := 'Устанавливается при конфигурации прибора.';
  end;

  1: begin
    LabeledEdit1.Text := 'Поле адреса канала прибора';
    LabeledEdit2.Text := 'CHA';
    LabeledEdit3.Text := '1';
    Memo1.Text := 'Канал - локальный замкнутый контур управления одиночным параметром техпроцесса.' + #13#10 +
                  'Каналы нумеруются с 0 до 5.';
  end;

  2: begin
    LabeledEdit1.Text := 'Поле адреса регистра';
    LabeledEdit2.Text := 'REG';
    LabeledEdit3.Text := '1';
    Memo1.Text := 'Регистр - переменная или константа канала.';
  end;

  3: begin
    LabeledEdit1.Text := 'Поле команды';
    LabeledEdit2.Text := 'CMD';
    LabeledEdit3.Text := '1';
    Memo1.Text := 'Двоичный код команды:' + #13#10 +
                  '00h - чтение регистра, RD,' + #13#10 +
                  '01h - запись регистра, WR.';
  end;

  4: begin
    LabeledEdit1.Text := 'Поле типа данных';
    LabeledEdit2.Text := 'TYP';
    LabeledEdit3.Text := '1';
    Memo1.Text := 'Младшая тетрада содержит условный тип регистра, а старшие два бита определяют права доступа к регистру:' + #13#10 +
    'TYP.7 = 1 - регистр доступен по записи (W);' + #13#10 +
    'TYP.6 = 1 - регистр доступен по чтению (R).';
  end;

  5: begin
    LabeledEdit1.Text := 'Поле данных';
    LabeledEdit2.Text := 'DATA';
    LabeledEdit3.Text := '1..32';
    Memo1.Text := 'Может отсутствовать (в зависимости от назначения пакета).';
  end;

  6: begin
    LabeledEdit1.Text := 'Поле контрольной суммы';
    LabeledEdit2.Text := 'CRC';
    LabeledEdit3.Text := '1';
    Memo1.Text := 'Однобайтовый циклический код, выисляемый по всем предшествующим битам данного пакета.' + #13#10 +  #13#10 +
                  'Условные обозначения:' + #13#10 +
                  '- CRC -- текущее значение контрольной суммы;' + #13#10 +
                  '- BYTES_CTR -- счетчик байтов;' + #13#10 +
                  '- BITES_CTR -- счетчик битов;' + #13#10 +
                  '- BYTES -- указатель на текущий обрабатываемый байт;' + #13#10 +
                  '- A, B, C -- вспомогательные переменные;' + #13#10 +
                  '- P_LENGTH -- длина пакета без байта контрольной суммы;' +#13#10 +
                  '- (+) -- операция поразрядного сложения по модулю 2;' + #13#10 +
                  '- SHR -- операция поразрядного сдвига на 1 бит вправо;' + #13#10 +
                  '- A.0 -- самый младший бит переменной A.';
  end;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Form2.ClientWidth := 250;
  Form2.ClientHeight := 500
end;

end.
