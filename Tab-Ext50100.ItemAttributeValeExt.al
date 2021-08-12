/// <summary>
/// TableExtension ItemAttributeVale-Ext (ID 50100) extends Record Item Attribute Value.
/// </summary>
tableextension 50100 "ItemAttributeVale-Ext" extends "Item Attribute Value"
{
    fields
    {
        field(50100; "Multiple Selection"; Boolean)
        {
            Caption = 'Multiple Selection';
            DataClassification = ToBeClassified;
        }
    }
}
TableExtension 50101 "SalesInvLine-Ext" extends "sales Invoice Line"
{
    fields
    {
        field(50101; "Attributes"; Text[250])
        {
            Caption = 'Attributes';
            DataClassification = ToBeClassified;
        }
        field(50102; "Item Attributes"; Boolean)
        {
            Caption = 'Item Attributes';
            DataClassification = ToBeClassified;
        }
    }
}