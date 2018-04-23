unit LoginFormImpl;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxImage, dxGDIPlusClasses,
  cxGroupBox, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel, cxTextEdit;

type
	TLoginForm = class(TForm)
    cxLoginData: TcxGroupBox;
    cxUserName: TcxTextEdit;
    cxPassword: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxOK: TcxButton;
    cxCancel: TcxButton;
	end;

implementation

{$R *.dfm}

end.
