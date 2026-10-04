codeunit 50150 "Service Request Tests EL"
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";
        LibrarySales: Codeunit "Library - Sales";

    [Test]
    procedure NewRequestStartsAsOpen()
    var
        ServiceRequest: Record "Service Request El";
    begin
        // [GIVEN] A request for an existing customer, created with status Closed
        InitRequest(ServiceRequest, CreateCustomerNo());
        ServiceRequest.Status := ServiceRequest.Status::Closed;

        // [WHEN] The request is inserted
        ServiceRequest.Insert(true);

        // [THEN] The status is Open
        Assert.AreEqual(ServiceRequest.Status::Open, ServiceRequest.Status, 'A new service request must start as Open.');
    end;

    [Test]
    procedure UnknownCustomerIsRejectedOnValidate()
    var
        ServiceRequest: Record "Service Request El";
    begin
        // [WHEN] A customer number that does not exist is validated
        asserterror ServiceRequest.Validate("Customer No.", UnknownCustomerNo());

        // [THEN] The request is rejected with the specific error
        Assert.ExpectedError('Customer ' + UnknownCustomerNo() + ' does not exist.');
    end;

    [Test]
    procedure UnknownCustomerIsRejectedOnInsert()
    var
        ServiceRequest: Record "Service Request El";
    begin
        // [GIVEN] A request assigned an unknown customer without validation
        InitRequest(ServiceRequest, UnknownCustomerNo());

        // [WHEN] The request is inserted
        asserterror ServiceRequest.Insert(true);

        // [THEN] The request is rejected with the specific error
        Assert.ExpectedError('Customer ' + UnknownCustomerNo() + ' does not exist.');
    end;

    [Test]
    procedure RequestWithoutCustomerIsRejected()
    var
        ServiceRequest: Record "Service Request El";
    begin
        // [GIVEN] A request without a customer
        InitRequest(ServiceRequest, '');

        // [WHEN] The request is inserted
        asserterror ServiceRequest.Insert(true);

        // [THEN] The request is rejected with the specific error
        Assert.ExpectedError('A service request must reference a customer.');
    end;

    [Test]
    procedure EntryNoIsAssignedAutomatically()
    var
        FirstRequest: Record "Service Request El";
        SecondRequest: Record "Service Request El";
        CustomerNo: Code[20];
    begin
        // [GIVEN] An existing customer
        CustomerNo := CreateCustomerNo();

        // [WHEN] Two requests are inserted
        InitRequest(FirstRequest, CustomerNo);
        FirstRequest.Insert(true);
        InitRequest(SecondRequest, CustomerNo);
        SecondRequest.Insert(true);

        // [THEN] Each request gets its own entry number
        Assert.AreNotEqual(0, FirstRequest."Entry No.", 'The entry number must be assigned on insert.');
        Assert.AreNotEqual(FirstRequest."Entry No.", SecondRequest."Entry No.", 'Entry numbers must be unique.');
    end;

    [Test]
    procedure StatusCanBeUpdatedAfterInsert()
    var
        ServiceRequest: Record "Service Request El";
    begin
        // [GIVEN] An inserted request
        InitRequest(ServiceRequest, CreateCustomerNo());
        ServiceRequest.Insert(true);

        // [WHEN] The status is changed and the request is modified
        ServiceRequest.Validate(Status, ServiceRequest.Status::"In Progress");
        ServiceRequest.Modify(true);

        // [THEN] The new status is stored
        ServiceRequest.Get(ServiceRequest."Entry No.");
        Assert.AreEqual(ServiceRequest.Status::"In Progress", ServiceRequest.Status, 'The status must be updated.');
    end;

    local procedure InitRequest(var ServiceRequest: Record "Service Request El"; CustomerNo: Code[20])
    begin
        ServiceRequest.Init();
        ServiceRequest."Entry No." := 0;
        ServiceRequest."Customer No." := CustomerNo;
        ServiceRequest.Title := 'Printer not working';
        ServiceRequest.Priority := ServiceRequest.Priority::High;
    end;

    local procedure CreateCustomerNo(): Code[20]
    var
        Customer: Record Customer;
    begin
        LibrarySales.CreateCustomer(Customer);
        exit(Customer."No.");
    end;

    local procedure UnknownCustomerNo(): Code[20]
    begin
        exit('NO-SUCH-CUSTOMER');
    end;
}
