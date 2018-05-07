unit Main;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics, Intfs, System.JSON,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxClasses, dxBar, cxGraphics,
	cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
	dxRibbonCustomizationForm, dxRibbon, dxBarExtItems, System.ImageList,
	Vcl.ImgList, Generics.Collections;

type
	TMWnd = class(TForm)
		dxBars: TdxBarManager;
		dxTabEvents: TdxRibbonTab;
		dxRibbon: TdxRibbon;
		dxManageEventsBar: TdxBar;
		dxFilterEventsBar: TdxBar;
		dxBarLogin: TdxBar;
		dxBarServer: TdxBarCombo;
		dxBtnSrvEdit: TdxBarButton;
		dxBarBtnLogin: TdxBarLargeButton;
		cxLarge: TcxImageList;
		dxBarAddEvent: TdxBarLargeButton;
		dxBarRemEvent: TdxBarLargeButton;
    	dxBarEventKind: TdxBarCombo;
		dxBarDate: TdxBarDateCombo;
		dxBarUpdate: TdxBarLargeButton;
    	dxBarLogOut: TdxBarLargeButton;
    	procedure dxBtnSrvEditClick(Sender: TObject);
    	procedure FormCreate(Sender: TObject);
    	procedure FormDestroy(Sender: TObject);
    	procedure dxBarBtnLoginClick(Sender: TObject);
	strict private
        FServerList : TList<TServerData>;
        FSession    : ISession;
    	procedure InitServerList();
        procedure InitStartUI();
        procedure InitLoginGUI();
        procedure DisplayEventData();
	end;

var
	MWnd: TMWnd;

implementation

{$R *.dfm}

uses ServerList, LoginFormImpl, Session;

{ TMWnd }

procedure TMWnd.DisplayEventData();
begin

end;

procedure TMWnd.dxBarBtnLoginClick(Sender: TObject);
var
	login : TLoginForm;
begin
	login := TLoginForm.Create(Self);

    try
    	if login.ShowModal() <> mrOK then
        	Exit;

        if dxBarServer.ItemIndex = -1 then
        	Exit;

		FSession := CreateSession(FServerList[dxBarServer.ItemIndex],
        	login.cxUserName.Text, login.cxPassword.Text);

        if not FSession.Valid  then begin
        	Application.MessageBox(PChar(FSession.LastError),
            	PChar('Login error'), MB_ICONSTOP);
            Exit;
        end;

        InitLoginGUI();
        DisplayEventData();

    finally
    	login.Free();
    end;
end;

procedure TMWnd.dxBtnSrvEditClick(Sender: TObject);
var
	lst : TSrvList;
begin
	lst := TSrvList.Create(Self, FServerList);

    try
    	if lst.ShowModal() = mrOk then
        	InitStartUI();
    finally
    	lst.Free();
    end;
end;

procedure TMWnd.FormCreate(Sender: TObject);
begin
    InitServerList();
    InitStartUI();
end;

procedure TMWnd.FormDestroy(Sender: TObject);
begin
	FreeAndNil(FServerList);
end;

procedure TMWnd.InitLoginGUI;
begin
	dxBarBtnLogin.Visible := ivNever;
    dxBarLogOut.Visible := ivAlways;

    dxBarAddEvent.Enabled := True;
    dxBarRemEvent.Enabled := True;
    dxBarEventKind.Enabled := True;
    dxBarDate.Enabled := True;
    dxBarUpdate.Enabled := True;
end;

procedure TMWnd.InitServerList;
var
	sl, str : TStringList;
    i : Integer;
    srv : TServerData;
begin
	FServerList := TList<TServerData>.Create();

    sl  := TStringList.Create();

    str := TStringList.Create();
    str.Delimiter := ':';
    str.StrictDelimiter := True;

    try

        try
        	sl.LoadFromFile('servers.ini');
            for i:=0 to sl.Count-1 do begin
            	str.DelimitedText := sl[i];
                if str.Count <> 2 then
                	Continue;

                srv := Default(TServerData);
                srv.FAddress := str[0];

                if TryStrToInt(str[1], srv.FPort) then begin
                	FServerList.Add(srv);
                end;
            end;
        except
        end;

    finally
    	sl.Free();
        str.Free();
    end;
end;

procedure TMWnd.InitStartUI;
var
	srv : TServerData;
begin
	for srv in FServerList do begin
    	dxBarServer.Items.Add(Format('%s:%d', [srv.FAddress, srv.FPort]));
    end;

    if FServerList.Count > 0 then
    	dxBarServer.ItemIndex := 0;

    dxBarBtnLogin.Enabled := (FServerList.Count > 0);
end;

end.
