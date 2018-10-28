unit Session;

interface

uses Classes, SysUtils, Intfs, System.JSON;

function CreateSession(const AServer : TServerData; const ALogin : string;
	const APassword : string) : ISession;

implementation

uses REST.Client, REST.Authenticator.Simple, REST.Types, IpPeerClient,
	 IdHTTP, HTTPApp, IdURI;

type
    TSession = class(TInterfacedObject, ISession)
    public
    	constructor Create(const AServer : TServerData; const ALogin : string;
							const APassword : string); reintroduce;
        destructor Destroy(); override;
    protected //ISession
    	function IsValid() : Boolean;
        function GetLastError() : string;

        function Execute(const AReqUrl : string) : TJSONValue; overload;
        function Execute(const AReqUrl : string; const APayload : string) : TJSONValue; overload;
        function Delete(const AReqUrl : string) : Boolean;

        property Valid : Boolean read IsValid;
        property LastError : string read GetLastError;
    strict private
    	FValid     : Boolean;
        FLastError : string;
        FSession   : TIdHTTP;
        FToken     : string;
        procedure TryAuthorize(const ALogin : string; const APassword : string);
        function  IsAdmin(const AResp : string) : Boolean;
    end;

function CreateSession(const AServer : TServerData; const ALogin : string;
	const APassword : string) : ISession;
begin
	Result := TSession.Create(AServer, ALogin, APassword);
end;

{ TSession }

constructor TSession.Create(const AServer: TServerData; const ALogin,
  APassword: string);
begin
	inherited Create();

    FValid := False;
    FSession := TIdHTTP.Create();
    FSession.AllowCookies := True;
    FSession.HandleRedirects := True;
    FSession.ReadTimeout := 30000;
    FSession.URL.Host := AServer.FAddress;
    FSession.URL.Port := IntToStr(AServer.FPort);

    TryAuthorize(ALogin, APassword);
end;

function TSession.Delete(const AReqUrl: string): Boolean;
begin
	Result := False;
    try
        FSession.URL.Path := '/';
        FSession.URL.Document := AReqUrl;
        FSession.URL.Params := 'access_token=' + FToken;
        FSession.Delete(FSession.URL.URI);
        Result := (FSession.ResponseCode = 200);
    except
    end;
end;

destructor TSession.Destroy;
begin
	FreeAndNil(FSession);
	inherited;
end;

function TSession.Execute(const AReqUrl, APayload: string): TJSONValue;
var
	resp : string;
    sl   : TStringStream;
begin
	Result := nil;
    try
        FSession.URL.Path := '/';
        FSession.URL.Document := AReqUrl;
        FSession.URL.Params := 'access_token=' + FToken;

        sl := TStringStream.Create(APayload, TEncoding.UTF8);
        try
            FSession.Request.ContentType := 'application/json';
        	resp := FSession.Post(FSession.URL.URI, sl);
        finally
        	sl.Free();
        end;
        Result := TJSONObject.ParseJSONValue(resp);
    except
    end;
end;

function TSession.Execute(const AReqUrl: string): TJSONValue;
var
	resp : string;
begin
	Result := nil;
    try
        FSession.URL.Path := '/';
        FSession.URL.Document := AReqUrl;
        FSession.URL.Params := 'access_token=' + FToken;

        resp := FSession.Get(FSession.URL.URI);
        Result := TJSONObject.ParseJSONValue(resp);
    except
    end;
end;

function TSession.GetLastError: string;
begin
	Result := FLastError;
end;

function TSession.IsAdmin(const AResp: string): Boolean;
var
	obj : TJSONObject;
    val : TJSONValue;
    adm : Integer;
begin
    Result := False;
    try
		obj := TJSONObject.ParseJSONValue(AResp) as TJSONObject;
        try
            val := obj.GetValue('admin');

            if not Assigned(val) then begin
                FLastError := 'Invalid auth REST format';
                Exit;
            end;

            adm := val.GetValue<Integer>();
            if adm = 0 then begin
            	FLastError := 'Your accound does not have sufficient rights';
                Exit;
            end;

            val := obj.GetValue('token');
            if not Assigned(val) then begin
            	FLastError := 'Invalid auth REST format';
                Exit;
            end;

            FToken := val.GetValue<string>();
            Result := True;
        finally
        	obj.Free();
        end;
    except
    	on E : Exception do
        	FLastError := E.Message;
    end;
end;

function TSession.IsValid: Boolean;
begin
	Result := FValid;
end;

procedure TSession.TryAuthorize(const ALogin, APassword: string);
var
    params : TStringList;
    resp   : string;
begin
    params := TStringList.Create();

    try
    	params.Add('email=' + ALogin);
        params.Add('password=' + APassword);

        try
        	resp := FSession.Post('/auth', params);
            FValid := IsAdmin(resp);
        except
        	on E : Exception do begin
            	FLastError := E.Message;
            end;
        end;
    finally
    	FreeAndNil(params);
    end;
end;

end.
