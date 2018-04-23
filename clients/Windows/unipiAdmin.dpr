program unipiAdmin;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MWnd},
  ServerList in 'ServerList.pas' {SrvList},
  Intfs in 'Intfs.pas',
  LoginFormImpl in 'LoginFormImpl.pas' {LoginForm},
  Session in 'Session.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMWnd, MWnd);
  Application.Run;
end.
