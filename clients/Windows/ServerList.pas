unit ServerList;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
	cxLookAndFeels,
	cxLookAndFeelPainters, cxContainer, cxEdit, cxCustomData, cxStyles, cxTL,
	cxTextEdit, cxTLdxBarBuiltInMenu, cxInplaceContainer, cxGroupBox, Vcl.Menus,
	Vcl.StdCtrls, cxButtons, Generics.Collections, Intfs, cxSpinEdit,
  	System.ImageList, Vcl.ImgList;

type
	TSrvList = class(TForm)
		cxServerList: TcxGroupBox;
		cxServers: TcxTreeList;
		cxServerName: TcxTreeListColumn;
		cxPort: TcxTreeListColumn;
		cxOK: TcxButton;
		cxCancel: TcxButton;
        cxMenu: TcxImageList;
        SrvPopUp: TPopupMenu;
        nAddServer: TMenuItem;
        nRemoveServer: TMenuItem;
        procedure nAddServerClick(Sender: TObject);
    	procedure nRemoveServerClick(Sender: TObject);
    	procedure cxOKClick(Sender: TObject);
	public
		constructor Create(AOwner : TComponent; AServers : TList<TServerData>); reintroduce;
    strict private
    	FServers : TList<TServerData>;
        procedure PopulateServerList();
        procedure InvalidateServerList();
        procedure SaveServerList();
	end;

implementation

{$R *.dfm}

{ TSrvList }

constructor TSrvList.Create(AOwner: TComponent; AServers: TList<TServerData>);
begin
	inherited Create(AOwner);
    FServers := AServers;

    PopulateServerList();
end;

procedure TSrvList.cxOKClick(Sender: TObject);
begin
	InvalidateServerList();
    SaveServerList();
    ModalResult := mrOK;
end;

procedure TSrvList.InvalidateServerList;
var
	i 	: Integer;
    srv : TServerData;
begin
	FServers.Clear();
    for i:=0 to cxServers.Count-1 do begin
    	srv := Default(TServerData);
        if VarIsNull(cxServers.Items[i].Values[0]) then
        	continue;

        srv.FAddress := cxServers.Items[i].Values[0];

        if not VarIsNumeric(cxServers.Items[i].Values[1]) then
        	continue;

        srv.FPort := cxServers.Items[i].Values[1];
        if srv.FPort = 0 then
        	Continue;

        FServers.Add(srv);
    end;
end;

procedure TSrvList.nAddServerClick(Sender: TObject);
begin
	cxServers.Root.AddChild();
end;

procedure TSrvList.nRemoveServerClick(Sender: TObject);
begin
	if cxServers.SelectionCount = 0 then
    	Exit;

    cxServers.Selections[0].Delete();
end;

procedure TSrvList.PopulateServerList;
var
	srv  : TServerData;
    node : TcxTreeListNode;
begin
	for srv in FServers do begin
    	node := cxServers.Root.AddChild();
        node.Values[0] := srv.FAddress;
        node.Values[1] := srv.FPort;
    end;
end;

procedure TSrvList.SaveServerList;
var
	sl 	: TStringList;
    srv : TServerData;
begin
	sl := TStringList.Create();
    try
    	for srv in FServers do
        	sl.Add(Format('%s:%d', [srv.FAddress, srv.FPort]));

        try
        	sl.SaveToFile('servers.ini');
        except
        end;
    finally
    	sl.Free();
    end;
end;

end.
