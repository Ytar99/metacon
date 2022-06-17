unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, CPort, CPortCtl, Menus, inifiles, ShellAPI, Buttons;

type
  TForm1 = class(TForm)
    Lch1: TLabel;
    Lch2: TLabel;
    Lch3: TLabel;
    Lch4: TLabel;
    Lch5: TLabel;
    Lch6: TLabel;
    Lrd1: TLabel;
    Lrd2: TLabel;
    Lrd3: TLabel;
    Lrd4: TLabel;
    Lrd5: TLabel;
    Lrd6: TLabel;
    Button_Settings: TButton;
    Button_Read: TButton;
    ComPort: TComPort;
    Button_Open: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Panel1: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    procedure Button_OpenClick(Sender: TObject);
    procedure Button_SettingsClick(Sender: TObject);
    procedure ComPortAfterClose(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button_ReadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
//    procedure Button1Click(Sender: TObject);
  //  procedure Button2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  MyThread=class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure clChange(numb:integer);
  end;

var
  Form1: TForm1;
  flag: Integer;
  flag_ctr: integer;
  Temp: integer;
  Cond: integer;
  MyThr: MyThread;
  ThrEnable: boolean;

  Frame10: array [0..8] of Byte;

  pathINI: string;
  sIniFile: TIniFile;

implementation

uses info;

{$R *.dfm}

procedure ini_load();
begin
  if  FileExists(pathINI) then
  begin
    try
      Form1.ComPort.Port := sIniFile.ReadString('ComPort','Port', 'Ошибка чтения');
      Form1.ComPort.CustomBaudRate := StrToInt(sIniFile.ReadString('ComPort','BaudRate', 'Ошибка чтения'));
      Form1.Edit1.Text := sIniFile.ReadString('Other','Temperature','Ошибка чтения');
    except
    end;
  end;
end;


procedure res();
const
  cl: TColor = clAppWorkSpace;

var
  Lctr: integer;
begin
  for Lctr := 1 to 6 do
  begin
  (Form1.FindComponent('Lch' + IntToStr(Lctr)) As TLabel).Color := cl;
  (Form1.FindComponent('Lrd' + IntToStr(Lctr)) As TLabel).Caption := '...';
  end;
end;

procedure Open_Com();
begin
  if Form1.ComPort.Connected then
  begin
    Form1.ComPort.Close;
    If MyThr <> nil then MyThr.Terminate;
    Form1.Button_Read.Caption := 'Старт'; //'Начать' + #13#10 + 'считывание';
    Form1.Button_Settings.Enabled := True;
    ThrEnable := False;
    res();
  end
  else
  begin
    Form1.ComPort.Open;
    Form1.Button_Settings.Enabled := False;
  end;
end;

procedure TForm1.Button_OpenClick(Sender: TObject);
begin
 if ComPort.Connected then
  begin
    ComPort.Close;
    If MyThr <> nil then MyThr.Terminate;
    //Button_Read.Caption := 'Установить' + #13#10 + 'Подключение';
    Button_Settings.Enabled := True;
    ThrEnable := False;
    res();
    Button_Open.Enabled := False;
  end;

end;

procedure TForm1.Button_SettingsClick(Sender: TObject);
begin
    ComPort.ShowSetupDialog;
end;

procedure TForm1.ComPortAfterClose(Sender: TObject);
begin
    If MyThr <> nil then
      MyThr.Terminate;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ComPort.Connected then
    ComPort.Close;
  If MyThr<>nil then
    MyThr.Terminate;
end;

procedure TForm1.Button_ReadClick(Sender: TObject);
begin

  //Open_Com();

  if not ComPort.Connected then
    Open_Com();
  begin
      if (TryStrToInt(Edit1.Text,Cond)) then
      begin
        if (Cond<0) or (Cond > 800) then
          ShowMessage('Неверный диапазон')
        else
        begin
           If ThrEnable then
           begin
              MyThr.Terminate;
              ThrEnable := False;
              res();
              Edit1.Enabled := True;
              Button_Open.Enabled := True;
              Button_Read.Caption := 'Старт';
              Button_Settings.Enabled := False;
           end
           else
           begin
              ThrEnable := True;
              Edit1.Enabled := False;
              Button_Open.Enabled := False;
              MyThr:=MyThread.Create(False); //Создаем поток чтения;
              MyThr.FreeOnTerminate:=true; //Запускаем поток чтения;
              Button_Read.Caption := 'Стоп';
              Button_Settings.Enabled := False;
              flag_ctr := 1;
              Memo1.Lines.add('Start');
           end;
        end;
      end
      else
        ShowMessage('Некорректное число');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  pathINI:=extractfilepath(application.ExeName)+'\settings.ini';
  sIniFile:=TIniFile.Create(pathINI);
  ini_load();
  ThrEnable := False;
  Form1.Width := 570;
  Form1.Height := 400;
  with form1.ComPort do
       begin
        timeouts.ReadInterval:=50;
        timeouts.ReadTotalMultiplier:=70;
        timeouts.ReadTotalConstant:=100;
        timeouts.WriteTotalMultiplier:=60;
        timeouts.WriteTotalConstant:=100;
       end;
end;

procedure MyThread.clChange(numb:integer);
begin
  if Frame10[6] = 128 then
    (Form1.FindComponent('Lch' + IntToStr(numb)) As TLabel).Color:=clYellow
  else
  begin
    (Form1.FindComponent('Lrd' + IntToStr(numb)) As TLabel).Caption:= IntToStr(Frame10[5]);
    if Frame10[5]<=Cond then
    (Form1.FindComponent('Lch' + IntToStr(numb)) As TLabel).Color:=clLime
    else
    (Form1.FindComponent('Lch' + IntToStr(numb)) As TLabel).Color:=clRed;
  end;
end;

procedure MyThread.execute;
const
  Ch1: array [0..4] of Byte = ($03, $00, $01, $00, $A7);
  Ch2: array [0..4] of Byte = ($03, $01, $01, $00, $0C);
  Ch3: array [0..4] of Byte = ($03, $02, $01, $00, $E8);
  Ch4: array [0..4] of Byte = ($03, $03, $01, $00, $43);
  Ch5: array [0..4] of Byte = ($03, $04, $01, $00, $39);
  Ch6: array [0..4] of Byte = ($03, $05, $01, $00, $92);

var
  i: integer;
  S: string;
  S_Message: string;
begin
  inherited;
//..some code here
  While not MyThr.Terminated do
  begin
    case flag_ctr of
      1: begin Form1.ComPort.Write(Ch1,5); sleep(100); end;
      2: begin Form1.ComPort.Write(Ch2,5); sleep(100); end;
      3: begin Form1.ComPort.Write(Ch3,5); sleep(100); end;
      4: begin Form1.ComPort.Write(Ch4,5); sleep(100); end;
      5: begin Form1.ComPort.Write(Ch5,5); sleep(100); end;
      6: begin Form1.ComPort.Write(Ch6,5); flag_ctr := 0; sleep(100); end;
    end;

    flag_ctr := flag_ctr + 1;
    Form1.ComPort.Read(Frame10,17);

    for i:=0 to 7 do
    If Frame10[0] = 3 then
    begin
      Str(Frame10[i]:7,S);
      S_Message := S_Message + S
    end;

    Form1.Memo1.Lines.Add(S_Message);
    If flag_ctr = 1 then Form1.Memo1.Lines.Add('     -------------------------------------------------------');
    S_Message := '';
    Form1.Memo1.Lines.BeginUpdate;
    Form1.Memo1.Perform(EM_LINESCROLL,Form1.Memo1.Lines.Count-1,Form1.Memo1.Lines.Count);
    Form1.Memo1.Lines.EndUpdate;

    if ThrEnable = False then break
    Else
    If Frame10[0] = 3 then clChange(Frame10[1]+1);
  end;
  Form1.Memo1.Lines.add('Close');
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  MessageDlg('© Я. О. Тарасов, 2020' + #13#10 +
             'студент 3 курса,' + #13#10 + #13#10 +
             'Уральский технический институт связи и информатики (филиал) федерального' + #13#10 +
             'государственного бюджетного образовательного учреждения высшего образования'+ #13#10 +
             '«Сибирский государственный университет телекоммуникаций и информатики» в' + #13#10 +
             'г. Екатеринбурге.                             ',
             mtInformation,[mbOk], 0);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  MessageDlg('Программа считывает измерения температур с регулятора Метакон-562-ТП' + #13#10 +
             'с настроенным адресом, имеющим значение "3".' + #13#10 + #13#10 +
             '"Настройки" - открывает окно с настройками COM-порта.'+ #13#10 + #13#10 +
             '"Открыть порт" - устанавливает соединение между устройством и компьютером.'+ #13#10 + #13#10 +
             '"Закрыть порт" - разрывает установленное соединение.'+ #13#10 + #13#10 +
             '"Начать считывание" - программа начинает опрос каналов устройства и '+ #13#10 +
             'выводит измеренные значения на экран.' + #13#10 + #13#10 +
             '"Закончить считывание" - программа заканчивает опрос каналов устройства и '+ #13#10 +
             'очищает информацию об измерениях.' + #13#10 + #13#10 +
             '"Температура" - сюда вводится значение, с которым будет сравниваться '+ #13#10 +
             'измеренная температура.'+ #13#10 + #13#10+ #13#10 +
             'Состояния каналов:' + #13#10 +
             '*Зеленый - температура оптимальна (ниже введённого значения);' + #13#10 +
             '*Красный - температура не оптимальна (выше введённого значения);'+ #13#10 +
             '*Желтый - к каналу не подключен термопреобразователь.' + #13#10 + #13#10 + #13#10 +
             'При разрыве соединения с устройством рекомендуется перезапустить программу.',
             mtInformation,[mbOk], 0);
end;

procedure TForm1.N4Click(Sender: TObject);
begin
    // Open
    if FileExists(pathINI)
    then
      ShellExecute(0, 'open', pansichar(pathINI), nil, nil, SW_SHOW)
    else
      ShowMessage('Файл с настройками не найден.' + #13#10 +
                  'Настройте программу и затем выберите пункт' + #13#10 +
                  '"Конфигурация" -> "Сохранить настройки".');
end;

procedure TForm1.N5Click(Sender: TObject);
begin
   // Load
   if FileExists(pathINI)
    then
    begin
      ini_load();
    end
    else
      ShowMessage('Файл с настройками не найден.' + #13#10 +
                  'Настройте программу и затем выберите пункт' + #13#10 +
                  '"Конфигурация" -> "Сохранить настройки".');
end;

procedure TForm1.N6Click(Sender: TObject);
begin
   // Save
  sIniFile.WriteString('ComPort','Port',ComPort.Port);
  sIniFile.WriteInteger('ComPort','BaudRate',ComPort.CustomBaudRate);
  sIniFile.WriteInteger('Other','Temperature',StrToInt(Edit1.Text));
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Form2.Visible := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  If Form1.Width < 600 then
  begin
    Form1.Width := 1080;
    Button2.Caption := '<-';
  end
  else
  begin
    Form1.Width := 570;
    Button2.Caption := '->';
  end;
end;

end.
