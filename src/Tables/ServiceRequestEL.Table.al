table 50100 "Service Request El"
{
    DataClassification = CustomerContent;
    Caption = 'Service Request';
    TableType = Normal;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }

        field(10; Title; Text[100])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
        }

        field(15; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(20; Priority; Enum "Service Request Priority EL")
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }

        field(25; Status; Enum "Service Request Status EL")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.", "Customer No.")
        {
            Clustered = true;
        }
    }
}