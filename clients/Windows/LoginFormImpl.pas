unit LoginFormImpl;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
	cxLookAndFeels,
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    strict private
    	procedure LoadSettings();
        procedure SaveSettings();
	end;

implementation

uses Registry;

{$R *.dfm}

{ TLoginForm }

procedure TLoginForm.FormCreate(Sender: TObject);
begin
	LoadSettings();
end;

procedure TLoginForm.FormDestroy(Sender: TObject);
begin
	SaveSettings();
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
	if cxUserName.Text <> '' then
    	cxPassword.SetFocus();
end;

procedure TLoginForm.LoadSettings;
var
	reg : TRegistry;
begin
	reg := TRegistry.Create();
    try
        reg.RootKey := HKEY_CURRENT_USER;

        if not reg.OpenKey('Software\H&H Inc\unipiAdmin', False) then
        	Exit;

        if reg.ValueExists('LastLogin') then begin
        	cxUserName.Text := reg.ReadString('LastLogin');
        end;
    finally
    	reg.Free();
    end;
end;

procedure TLoginForm.SaveSettings;
var
	reg : TRegistry;
begin
	reg := TRegistry.Create();
    try
    	reg.RootKey := HKEY_CURRENT_USER;
        if not reg.OpenKey('Software\H&H Inc\unipiAdmin', True) then
        	Exit;

        reg.WriteString('LastLogin', cxUserName.Text);
    finally
    	reg.Free();
    end;
end;

end.
