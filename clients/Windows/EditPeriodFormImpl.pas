unit EditPeriodFormImpl;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit, cxLabel, cxGroupBox;

type
	TFrmEditPeriod = class(TForm)
        cxGPData: TcxGroupBox;
        cxLabel1: TcxLabel;
        cxPeriodName: TcxTextEdit;
        cxLabel2: TcxLabel;
    	cxDateStart: TcxDateEdit;
        cxLabel3: TcxLabel;
    	cxDateEnd: TcxDateEdit;
    	cxOK: TcxButton;
        cxCancel: TcxButton;
    	procedure cxCancelClick(Sender: TObject);
    procedure cxOKClick(Sender: TObject);
    public
    	constructor Create(AOwner : TComponent); reintroduce; overload;
        constructor Create(AOwner : TComponent; const AName : string; const
        	ADS, ADE : TDateTime); reintroduce; overload;
    strict private
    	function ValidateInput() : Boolean;
	end;

implementation

{$R *.dfm}

constructor TFrmEditPeriod.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
    cxPeriodName.Text := 'New period';
    cxDateStart.Date := Now() + 10;
    cxDateEnd.Date := Now() + 10;
end;

constructor TFrmEditPeriod.Create(AOwner: TComponent; const AName: string;
  const ADS, ADE: TDateTime);
begin
	inherited Create(AOwner);
    cxPeriodName.Text := AName;
    cxDateStart.Date := ADS;
    cxDateEnd.Date := ADE;
end;

procedure TFrmEditPeriod.cxCancelClick(Sender: TObject);
begin
	ModalResult := mrCancel;
end;

procedure TFrmEditPeriod.cxOKClick(Sender: TObject);
begin
	if ValidateInput() then
    	ModalResult := mrOK;
end;

function TFrmEditPeriod.ValidateInput: Boolean;
begin
	if Trim(cxPeriodName.Text) = '' then begin
    	Application.MessageBox('Period name could not be empty!', 'Error', MB_ICONSTOP);
        Exit(False);
    end;

    if cxDateStart.Date > cxDateEnd.Date then begin
    	Application.MessageBox('Start date is greater than the end date', 'Error', MB_ICONSTOP);
        Exit(False);
    end;

    Result := True;
end;

end.
