unit Session;

interface

uses Classes, SysUtils, Intfs;

function CreateSession(const AServer : TServerData; const ALogin : string;
	const APassword : string) : ISession;

implementation

uses REST.Client, REST.Authenticator.Simple;

type
    TSession = class(TInterfacedObject, ISession)
    public
    	constructor Create(const AServer : TServerData; const ALogin : string;
							const APassword : string); reintroduce;
    protected //ISession
    	function IsValid() : Boolean;
        function GetLastError() : string;

        property Valid : Boolean read IsValid;
        property LastError : string read GetLastError;
    strict private
    	FValid     : Boolean;
        FLastError : string;
        FClient    : TRestClient;
        FAuth      : TSimpleAuthenticator;
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
    FClient := TRESTClient.Create(Format('%s:%d',
    				[AServer.FAddress, AServer.FPort]));
    FClient.AllowCookies := True;
    FClient.AcceptEncoding := 'utf-8';

    FAuth := TSimpleAuthenticator.Create('email', 'password', ALogin, APassword);
    FClient.Authenticator := FAuth;
end;

function TSession.GetLastError: string;
begin
	Result := FLastError;
end;

function TSession.IsValid: Boolean;
begin
	Result := FValid;
end;

end.
