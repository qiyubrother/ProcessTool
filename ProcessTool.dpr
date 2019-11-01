program ProcessTool;

uses
  Vcl.Forms,
  UnitMainForm in 'UnitMainForm.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
