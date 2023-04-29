unit OlgSlotManager;

interface

uses
  SysUtils, Classes, Generics.Collections, Generics.Defaults, Types, Graphics,

  OlgLogger, OlgSlot, OlgSlotNode;

type
  TOlgSlotManager = class
    private
      FSlots: TOlgSlots;

      FBoundsRect: TRect;

      FLeft: Integer;
      FTop: Integer;
      FWidth: Integer;
      FHeight: Integer;

      FFilledArea: Integer;
      function GetTotalArea: Integer;
    public
      constructor Create; overload;
      constructor Create(ALeft, ATop, AWidth, AHeight: Integer); overload;
      destructor Destroy; override;

      procedure AddSlot(AWidth, AHeight: Integer; AColor: TColor; AName: String);
      procedure Clear;

      property Slots: TOlgSlots read FSlots;

      procedure Place;

      procedure SortByWidthASC;
      procedure SortByHeightASC;

      procedure SortByWidthDESC;
      procedure SortByHeightDESC;

      procedure SortByAreaASC;
      procedure SortByAreaDESC;

      property FilledArea: Integer read FFilledArea;
      property TotalArea: Integer read GetTotalArea;

      property Left: Integer read FLeft;
      property Top: Integer read FTop;
      property Width: Integer read FWidth;
      property Height: Integer read FHeight;

      property BoundsRect: TRect read FBoundsRect;

  end;

implementation

{=========================================================================================================================================}
{ TOlgSlotManager }
{=========================================================================================================================================}
constructor TOlgSlotManager.Create;
begin
  Create(50, 50, 700, 500);
end;

{=========================================================================================================================================}
constructor TOlgSlotManager.Create(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FSlots := TOlgSlots.Create;
  FFilledArea := 0;

  FLeft := ALeft;
  FTop := ATop;
  FWidth := AWidth;
  FHeight := AHeight;

  FBoundsRect := Rect(FLeft, FTop, FLeft + FWidth, FTop + FHeight);

end;

{=========================================================================================================================================}
destructor TOlgSlotManager.Destroy;
begin
  FreeAndNil(FSlots);
  inherited;
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.Clear;
begin
  FSlots.Clear;
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.AddSlot(AWidth, AHeight: Integer; AColor: TColor; AName: String);
var Q: TOlgSlot;
begin
  Q := TOlgSlot.Create(FLeft, FTop, AWidth, AHeight);
  Q.Name := AName;
  Q.Color := AColor;

  FSlots.Add(Q);

end;

{=========================================================================================================================================}
procedure TOlgSlotManager.Place;
var S: TOlgSlot;

    StartNode: TOlgSlotNode;
    Q: TOlgSlotNode;
begin

  FFilledArea := 0;

  StartNode := TOlgSlotNode.Create;
  StartNode.SetRect(FLeft, FTop, FWidth - FLeft, FHeight - FTop);

  for S in FSlots do
    begin
      Q := StartNode.Insert(S);
      if Q <> nil then
        begin
          S.Move(Q.Slot.Left, Q.Slot.Top);
          FFilledArea := FFilledArea + Q.Slot.Width * Q.Slot.Height;
        end;
    end;

  FreeAndNil(StartNode);

end;

{=========================================================================================================================================}
function TOlgSlotManager.GetTotalArea: Integer;
begin
  Result := FWidth * FHeight;
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByHeightASC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := A.Height - B.Height;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByHeightDESC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := B.Height - A.Height;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByWidthASC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := A.Width - B.Width;
      end
    )
  );
end;


{=========================================================================================================================================}
procedure TOlgSlotManager.SortByWidthDESC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := B.Width - A.Width;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByAreaASC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := A.Width * A.Height - B.Width * B.Height;
      end
    )
  );
end;

{=========================================================================================================================================}
procedure TOlgSlotManager.SortByAreaDESC;
begin
  FSlots.Sort(
    TComparer<TOlgSlot>.Construct(
      function (const A, B: TOlgSlot): Integer
      begin
        Result := B.Width * B.Height - A.Width * A.Height;
      end
    )
  );
end;

{=========================================================================================================================================}
end.
