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

            trigger OnValidate()
            begin
                CheckCustomerExists();
            end;
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
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Customer; "Customer No.")
        {
        }
    }

    var
        CustomerMissingErr: Label 'A service request must reference a customer.';
        CustomerNotFoundErr: Label 'Customer %1 does not exist.', Comment = '%1 = Customer No.';

    trigger OnInsert()
    begin
        if "Customer No." = '' then
            Error(CustomerMissingErr);
        CheckCustomerExists();
        Status := Status::Open;
    end;

    local procedure CheckCustomerExists()
    var
        Customer: Record Customer;
    begin
        if "Customer No." = '' then
            exit;
        if not Customer.Get("Customer No.") then
            Error(CustomerNotFoundErr, "Customer No.");
    end;
}
