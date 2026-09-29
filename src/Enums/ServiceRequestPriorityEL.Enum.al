enum 50100 "Service Request Priority EL"
{
    Caption = 'Service Request Priority';

    value(0; Low)
    {
        Caption = 'Low', Locked = true;
    }

    value(1; Normal)
    {
        Caption = 'Normal';
    }

    value(2; High)
    {
        Caption = 'High';
    }
}