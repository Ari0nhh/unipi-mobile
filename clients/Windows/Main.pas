unit Main;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics, Intfs, System.JSON,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxClasses, dxBar, cxGraphics,
	cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
	dxRibbonCustomizationForm, dxRibbon, dxBarExtItems, System.ImageList,
	Vcl.ImgList, Generics.Collections, cxDropDownEdit, cxBarEditItem, Vcl.ExtCtrls,
    cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
    Data.DB, cxDBData, cxGridCustomTableView, cxGridCardView, cxGridDBCardView,
    Datasnap.DBClient, cxGridCustomView, cxGridCustomLayoutView, cxGridLevel,
    cxGrid, EventDataFrame;

type
	TMWnd = class(TForm)
		dxBars: TdxBarManager;
    	dxTabAdmin: TdxRibbonTab;
		dxRibbon: TdxRibbon;
		dxManageEventsBar: TdxBar;
		dxFilterEventsBar: TdxBar;
		dxBarLogin: TdxBar;
		dxBtnSrvEdit: TdxBarButton;
		dxBarBtnLogin: TdxBarLargeButton;
		cxLarge: TcxImageList;
		dxBarAddEvent: TdxBarLargeButton;
		dxBarRemEvent: TdxBarLargeButton;
    	dxBarEventKind: TdxBarCombo;
		dxBarDate: TdxBarDateCombo;
		dxBarUpdate: TdxBarLargeButton;
    	dxBarLogOut: TdxBarLargeButton;
   	 	cxBarServer: TcxBarEditItem;
        dxTabEvents: TdxRibbonTab;
        dxBarSelection: TdxBar;
        dxBarSelEvents: TdxBarLargeButton;
        dxBarSelUsers: TdxBarLargeButton;
        dxBarFiles: TdxBarLargeButton;
        dxBarVideo: TdxBarLargeButton;
        pnlEvents: TPanel;
        cxEvtLevel: TcxGridLevel;
        cxEvtGrid: TcxGrid;
        cxEvtView: TcxGridDBCardView;
        dsEvents: TDataSource;
        clEvents: TClientDataSet;
        cxEvtViewclEvtID: TcxGridDBCardViewRow;
        cxEvtViewclEvtName: TcxGridDBCardViewRow;
        cxEvtViewclEvtStart: TcxGridDBCardViewRow;
        cxEvtViewclEvtEnd: TcxGridDBCardViewRow;
        cxEvtViewclEvtInt: TcxGridDBCardViewRow;
        cxStyleRep: TcxStyleRepository;
        cxStyleInternal: TcxStyle;
    	pnlEvtData: TPanel;
    	EvtFrame: TEventData;
        dxTabEvent: TdxRibbonTab;
        dxBarsEditEvent: TdxBar;
        dxBarApplyEvent: TdxBarLargeButton;
        dxBarDiscardEvent: TdxBarLargeButton;
        dxBarEditProgram: TdxBar;
        dxBarAddPeriod: TdxBarLargeButton;
        dxBarsActions: TdxBar;
        dxBarEditPeriod: TdxBarButton;
        dxBarDelPeriod: TdxBarButton;
        dxBarAddAction: TdxBarLargeButton;
        dxBarEditAction: TdxBarButton;
        dxBarDelAction: TdxBarButton;
    	procedure dxBtnSrvEditClick(Sender: TObject);
    	procedure FormCreate(Sender: TObject);
    	procedure FormDestroy(Sender: TObject);
    	procedure dxBarBtnLoginClick(Sender: TObject);
        procedure cxEvtViewStylesGetCaptionRowStyle(Sender: TcxCustomGridTableView;
          ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
          var AStyle: TcxStyle);
    	procedure dxBarSelEventsClick(Sender: TObject);
    	procedure dxBarLogOutClick(Sender: TObject);
        procedure cxEvtViewCellDblClick(Sender: TcxCustomGridTableView;
          ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
          AShift: TShiftState; var AHandled: Boolean);
    	procedure dxBarDiscardEventClick(Sender: TObject);
    	procedure dxBarAddEventClick(Sender: TObject);
    	procedure dxBarApplyEventClick(Sender: TObject);
    	procedure dxBarRemEventClick(Sender: TObject);
    	procedure dxBarEditPeriodClick(Sender: TObject);
    	procedure dxBarAddPeriodClick(Sender: TObject);
    procedure dxBarDelPeriodClick(Sender: TObject);
	strict private
        FServerList : TList<TServerData>;
        FSession    : ISession;
        FDefServer  : Integer;
    	procedure InitServerList();
        procedure InitStartUI();
        procedure InitLoginGUI();
        procedure DisplayEventData();
        procedure DoLogOut();
    strict private
    	procedure SaveSettings();
        procedure LoadSettings();
        procedure KillContexts();
        procedure HideAllFrames();
	end;

var
	MWnd: TMWnd;

implementation

{$R *.dfm}

uses ServerList, LoginFormImpl, Session, Registry;

{ TMWnd }

procedure TMWnd.cxEvtViewCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
	if clEvents.Eof then
    	Exit;

	KillContexts();
    HideAllFrames();

    EvtFrame.PopulateEventData(FSession, clEvents.Fields[0].AsInteger);

    pnlEvtData.Align := alClient;
    pnlEvtData.Visible := True;
    dxRibbon.Contexts[1].Activate();
end;

procedure TMWnd.cxEvtViewStylesGetCaptionRowStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
	if ARecord.Values[4] <> 0 then
    	AStyle := cxStyleInternal;
end;

procedure TMWnd.DisplayEventData();
var
	events : TJSONValue;
    arr : TJSONArray;
    i   : Integer;
    obj : TJSONObject;
begin
    HideAllFrames();
    KillContexts();

	events := FSession.Execute('REST/events');
    if not Assigned(events) then
    	Exit;

    try
        if not (events is TJSONArray) then
            Exit;

        arr := events as TJSONArray;

        try
            cxEvtView.BeginUpdate();
            clEvents.DisableControls();

            clEvents.EmptyDataSet();

            for i:=0 to arr.Count-1 do begin
                obj := arr.Items[i] as TJSONObject;

                clEvents.Append();
                clEvents.Fields[0].Value := obj.GetValue('evt_id').GetValue<Integer>();
                clEvents.Fields[1].Value := obj.GetValue('evt_name').GetValue<string>();
                clEvents.Fields[2].Value := _ToDate(obj.GetValue('evt_date_start').GetValue<string>());
                clEvents.Fields[3].Value := _ToDate(obj.GetValue('evt_date_end').GetValue<string>());
                clEvents.Fields[4].Value := obj.GetValue('evt_internal').GetValue<Boolean>();
                clEvents.Post();
            end;
        finally
            clEvents.EnableControls();
            cxEvtView.EndUpdate();
        end;

    finally
    	events.Free();
    end;

    pnlEvents.Align := alClient;
    pnlEvents.Visible := True;
    dxRibbon.Contexts[0].Activate();
    dxBarSelEvents.Down := True;
end;

procedure TMWnd.DoLogOut;
begin
	dxBarBtnLogin.Visible := ivAlways;
    dxBarLogOut.Visible := ivNever;

    dxBarAddEvent.Enabled := False;
    dxBarRemEvent.Enabled := False;
    dxBarEventKind.Enabled := False;
    dxBarDate.Enabled := False;
    dxBarUpdate.Enabled := False;

    dxBarSelEvents.Enabled := False;
    dxBarSelEvents.Down := False;
    dxBarSelUsers.Enabled := False;

    KillContexts();

    pnlEvents.Visible := False;
    pnlEvtData.Visible := False;

    FSession := nil;
end;

procedure TMWnd.dxBarAddEventClick(Sender: TObject);
begin
	KillContexts();
    HideAllFrames();

    EvtFrame.PrepareForNewEvent(FSession);

    pnlEvtData.Align := alClient;
    pnlEvtData.Visible := True;
    dxRibbon.Contexts[1].Activate();
end;

procedure TMWnd.dxBarAddPeriodClick(Sender: TObject);
begin
	EvtFrame.AddNewPeriod();
end;

procedure TMWnd.dxBarApplyEventClick(Sender: TObject);
begin
	if not EvtFrame.ApplyEventData() then begin
    	Application.MessageBox('Invalid data', 'Error', MB_ICONSTOP);
        Exit;
    end;

    DisplayEventData();
end;

procedure TMWnd.dxBarBtnLoginClick(Sender: TObject);
var
	login : TLoginForm;
    idx   : Integer;
begin
	login := TLoginForm.Create(Self);

    try
    	if login.ShowModal() <> mrOK then
        	Exit;

        idx := TcxComboBoxProperties(cxBarServer.Properties).Items.IndexOf(cxBarServer.EditValue);

        if idx = -1 then
        	Exit;

		FSession := CreateSession(FServerList[idx],
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

procedure TMWnd.dxBarDelPeriodClick(Sender: TObject);
begin
	EvtFrame.DeletePeriod();
end;

procedure TMWnd.dxBarDiscardEventClick(Sender: TObject);
begin
	DisplayEventData();
end;

procedure TMWnd.dxBarEditPeriodClick(Sender: TObject);
begin
	EvtFrame.EditSelectedPeriod();
end;

procedure TMWnd.dxBarLogOutClick(Sender: TObject);
begin
	DoLogOut();
end;

procedure TMWnd.dxBarRemEventClick(Sender: TObject);
var
	id : Int64;
begin
    if clEvents.Eof then
    	Exit;

	if Application.MessageBox(PChar('Are you sure want to delete this event?' + #13#10 +
    	'This action is irreversible!'), PChar('Warning!'), MB_ICONEXCLAMATION or MB_YESNO) = mrNo then
    	Exit;

    id := clEvents.Fields[0].Value;

	if FSession.Delete(Format('REST/delete_event/%d', [id])) then begin
    	DisplayEventData();
    end else begin
    	Application.MessageBox('Unable to delete event', 'Error', MB_ICONSTOP);
    end;
end;

procedure TMWnd.dxBarSelEventsClick(Sender: TObject);
begin
	DisplayEventData();
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
    LoadSettings();
    InitStartUI();
end;

procedure TMWnd.FormDestroy(Sender: TObject);
begin
    SaveSettings();
	FreeAndNil(FServerList);
end;

procedure TMWnd.HideAllFrames;
begin
	pnlEvents.Visible := False;
    pnlEvtData.Visible := False;

	EvtFrame.CleanUp();
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

    dxBarSelEvents.Enabled := True;
    dxBarSelUsers.Enabled := True;
end;

procedure TMWnd.InitServerList;
var
	sl, str : TStringList;
    i : Integer;
    srv : TServerData;
begin
	FServerList := TList<TServerData>.Create();
    FDefServer := -1;

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
    	TcxComboBoxProperties(cxBarServer.Properties).Items.Add(Format('%s:%d', [srv.FAddress, srv.FPort]));
    end;

    if FServerList.Count > 0 then begin
        if (FDefServer < 0) or (FDefServer >= FServerList.Count) then
        	FDefServer := 0;
    	cxBarServer.EditValue := TcxComboBoxProperties(cxBarServer.Properties).Items[FDefServer];
    end;

    dxBarBtnLogin.Enabled := (FServerList.Count > 0);
end;

procedure TMWnd.KillContexts;
var
	i : Integer;
begin
	for i:=0 to dxRibbon.Contexts.Count-1 do
    	dxRibbon.Contexts[i].Visible := False;
end;

procedure TMWnd.LoadSettings;
var
	reg : TRegistry;
begin
	reg := TRegistry.Create();
    try
        reg.RootKey := HKEY_CURRENT_USER;

        if not reg.OpenKey('Software\H&H Inc\unipiAdmin', False) then
        	Exit;

        if reg.ValueExists('DefServer') then
        	FDefServer := reg.ReadInteger('DefServer');
    finally
    	reg.Free();
    end;
end;

procedure TMWnd.SaveSettings;
var
	reg : TRegistry;
begin
	reg := TRegistry.Create();
    try
    	reg.RootKey := HKEY_CURRENT_USER;
        if not reg.OpenKey('Software\H&H Inc\unipiAdmin', True) then
        	Exit;

        FDefServer := TcxComboBoxProperties(cxBarServer.Properties).Items.IndexOf(cxBarServer.EditValue);
        reg.WriteInteger('DefServer', FDefServer);
    finally
    	reg.Free();
    end;
end;



end.
