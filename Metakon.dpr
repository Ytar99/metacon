program Metakon;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  info in 'info.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
