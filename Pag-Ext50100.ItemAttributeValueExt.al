/// <summary>
/// PageExtension ItemAttributeValue-Ext (ID 50100) extends Record Item Attribute Values.
/// </summary>
pageextension 50100 "ItemAttributeValue-Ext" extends "Item Attribute Values"
{
    layout
    {
        AddAfter(Blocked)
        {
            field("Multiple Selection"; Rec."Multiple Selection")
            {
                ApplicationArea = All;
                Editable = True;
                //Enabled = gEnable;
                Trigger Onvalidate();
                Begin
                    IF gEnable = FALSE THEN
                        Rec."Multiple Selection" := False;
                End;
            }
        }
    }
    actions
    {
        addlast(Creation)
        {
            Action("Clear Selection")
            {
                ApplicationArea = All;
                Caption = 'Clear Selection';
                Trigger OnAction();
                Var
                    ItemAttValue: Record "Item Attribute Value";
                Begin
                    IF ItemAttValue.FINDSET THEN
                        ItemAttValue.MODIFYALL("Multiple Selection", FALSE);
                End;
            }
        }
    }
    Procedure CheckCharacter(): Boolean
    Begin
        gText := rec.Value;
        For i := 1 to STRLEN(gText) DO BEGIN
            gText2 := CopyStr(gtext, i, 1);
            IF gText2 = ',' THEN
                Exit(False);
        END;
        Exit(TRUE);
    End;

    Trigger OnAfterGetCurrRecord()
    BEGIN
        genable := CheckCharacter;
    End;

    Trigger OnOpenPage()
    Begin
        gEnable := True;
        Editable := True;
    End;

    var
        gEnable: boolean;
        gText: Text[100];
        gText2: Text[30];
        i: Integer;
}

PageExtension 50101 "ItemAttributeValueList-Ext" extends "Item Attribute Value List"
{
    Layout
    {
        modify("Value")
        {
            ApplicationArea = all;
            trigger OnBeforeValidate()
            Begin
                If xRec.Value <> Rec.Value THEN
                    GetValues;
            End;
        }

    }
    /// <summary>
    /// GetValues.
    /// </summary>
    procedure GetValues()
    var
        lItemAttributeValue: record "Item Attribute Value";
        lValue: Text;
    Begin
        lValue := '';
        lItemAttributeValue.RESET;
        lItemAttributeValue.SETRANGE("Attribute ID", rec."Attribute ID");
        lItemAttributeValue.SETRANGE("Multiple Selection", TRUE);
        IF lItemAttributeValue.FINDSET THEN
            REPEAT
                IF lValue <> '' THEN
                    lValue += ',';
                lValue += lItemAttributeValue.Value;
                rec.Value := lValue;
            UNTIL lItemAttributeValue.NEXT = 0;
    End;
}
PageExtension 50103 "ItemAttValEditor-Ext" Extends "Item Attribute Value Editor"
{
    Layout
    {

    }
    Trigger OnOpenPage()
    Var
        ItemAttriVal: Record "Item Attribute Value";
    Begin
        IF iTemAttriVal.FINDSET THEN
            iTemAttriVal.MODIFYALL("Multiple Selection", FALSE);
        CurrPage.Update;
    End;
}
PageExtension 50104 "PostSalesInvSub-Ext" Extends "Posted Sales Invoice Subform"
{
    Layout
    {
        AddAfter(Description)
        {
            Field(Attributes; rec.Attributes)
            {
                ApplicationArea = All;
                Editable = False;
                Caption = 'Item Attributes';
            }
        }
    }
}