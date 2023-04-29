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
      constructor Create(AWidth, AHeight: Integer); overload;
      destructor Destroy; override;

      procedure Rotate;
      procedure Move(AX, AY: Integer);

      property BoundsRect: TRect read FBoundsRect write FBoundsRect;
      property Name: String read FName write FName;

      property Color: TColor read FColor write FColor;

      property Width: Integer read FWidth;
      property Height: Integer read FHeight;
  end;

  TOlgSlots = class(TObjectList<TOlgSlot>);

implementation

{=========================================================================================================================================}
{ TOlgSlot }
{=========================================================================================================================================}
constructor TOlgSlot.Create(AWidth, AHeight: Integer);
begin
  FWidth := AWidth;
  FHeight := AHeight;
  FBoundsRect := Rect(0, 0, AWidth, AHeight);
  FName := 'Unknown';
  FColor := $00FFFFFF;
end;

{=========================================================================================================================================}
constructor TOlgSlot.Create;
begin
  Create(100, 50);
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
procedure TOlgSlot.Rotate;
var Q: Integer;
begin

  Q := FWidth;
  FWidth := FHeight;
  FHeight := Q;

end;

{=========================================================================================================================================}
end.
