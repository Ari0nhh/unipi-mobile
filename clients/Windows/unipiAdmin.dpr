program unipiAdmin;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MWnd},
  ServerList in 'ServerList.pas' {SrvList},
  Intfs in 'Intfs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMWnd, MWnd);
  Application.Run;
end.
