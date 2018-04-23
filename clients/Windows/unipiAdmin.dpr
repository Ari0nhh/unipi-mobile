program unipiAdmin;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MWnd};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMWnd, MWnd);
  Application.Run;
end.
