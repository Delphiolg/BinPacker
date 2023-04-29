unit OlgSlot;

interface

uses
  SysUtils, Classes, Types, Generics.Collections, Graphics;

type

  TOlgSlot = class
    private
      FBoundsRect: TRect;

      FLeft: Integer;
      FTop: Integer;
      FWidth: Integer;
      FHeight: Integer;

      FName: String;
      FColor: TColor;
    public
      constructor Create; overload;
      constructor Create(ALeft, ATop, AWidth, AHeight: Integer); overload;
      destructor Destroy; override;

      function FitsIn(ARect: TOlgSlot): Boolean;
      function SameSizeAs(ARect: TOlgSlot): Boolean;

      procedure SetRect(ALeft, ATop, AWidth, AHeight: Integer);

      procedure Move(AX, AY: Integer);

      property BoundsRect: TRect read FBoundsRect write FBoundsRect;
      property Name: String read FName write FName;

      property Color: TColor read FColor write FColor;

      property Left: Integer read FLeft;
      property Top: Integer read FTop;
      property Width: Integer read FWidth;
      property Height: Integer read FHeight;
  end;

  TOlgSlots = class(TObjectList<TOlgSlot>);

implementation

{=========================================================================================================================================}
{ TOlgSlot }
{=========================================================================================================================================}
constructor TOlgSlot.Create(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FLeft := ALeft;
  FTop := ATop;
  FWidth := AWidth;
  FHeight := AHeight;
  FBoundsRect := Rect(ALeft, ATop, AWidth, AHeight);
  FName := 'Unknown';
  FColor := $00FFFFFF;
end;

{=========================================================================================================================================}
constructor TOlgSlot.Create;
begin
  Create(0, 0, 100, 50);
end;

{=========================================================================================================================================}
destructor TOlgSlot.Destroy;
begin

  inherited;
end;

{=========================================================================================================================================}
procedure TOlgSlot.Move(AX, AY: Integer);
begin
  FBoundsRect := Rect(AX, AY, AX + FWidth, AY + FHeight);
end;

{=========================================================================================================================================}
function TOlgSlot.SameSizeAs(ARect: TOlgSlot): Boolean;
begin
  Result := (FWidth = ARect.Width) and (FHeight = ARect.Height);
end;

{=========================================================================================================================================}
function TOlgSlot.FitsIn(ARect: TOlgSlot): Boolean;
begin
  Result := (FWidth <= ARect.Width) and (FHeight <= ARect.Height);
end;

{=========================================================================================================================================}
procedure TOlgSlot.SetRect(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FLeft := ALeft;
  FTop := ATop;
  FWidth := AWidth;
  FHeight := AHeight;
  FBoundsRect := Rect(FLeft, FTop, FLeft + AWidth, FTop + AHeight);
end;

{=========================================================================================================================================}
end.
