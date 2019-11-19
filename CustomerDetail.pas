unit CustomerDetail;

interface

uses
  System.SysUtils;

type
  TCustomerDetail = class
  private
    FContactTypeID: Integer;
    FTextValue: string;
    FComment: string;
    FPhysical1: string;
    FPhysical2: string;
    FPhysical3: string;
    FPhysical4: string;
    FPhysicalCode: string;
    FPostalCode: string;
    FPostal2: string;
    FPostal3: string;
    FPostal1: string;
    FPostal4: string;
    FBank: string;
    FBranchCode: string;
    FAccountNo: string;
    FFirstName: string;
    FLastName: string;
    FInitials: string;
    FOtherName: string;
    FSalutationID: Integer;
    FIDNo: string;
    FPassportNo: string;
    FJobFunctionID: Integer;
    FPrimaryContact: Boolean;
    FEmailAddress: string;
    FTaxNo: string;
    FMobileNo: string;
    FDOB: TDateTime;
    FVehicleMakeID: Integer;
    FVehicleModel: string;
    FManufactureYear: Integer;
    FVehicleRegNo: string;
    FLicenceRenewalDate: TDateTime;
    FMaintenancePlan: Boolean;
    FHeaderTitle: string;
    FSubTitle: string;
  public
    constructor Create;
    procedure ClearValues;
    property ContactTypeID: Integer read FContactTypeID write FContactTypeID;
    property TextValue: string read FTextValue write FTextValue;
    property Comment: string read FComment write FComment;
    property Physical1: string read FPhysical2 write FPhysical2;
    property Physical2: string read FPhysical2 write FPhysical2;
    property Physical3: string read FPhysical3 write FPhysical3;
    property Physical4: string read FPhysical4 write FPhysical4;
    property PhysicalCode: string read FPhysicalCode write FPhysicalCode;
    property Postal1: string read FPostal1 write FPostal1;
    property Postal2: string read FPostal2 write FPostal2;
    property Postal3: string read FPostal3 write FPostal3;
    property Postal4: string read FPostal4 write FPostal4;
    property PostalCode: string read FPostalCode write FPostalCode;
    property Bank: string read FBank write FBank;
    property BranchCode: string read FBranchCode write FBranchCode;
    property AccountNo: string read FAccountNo write FAccountNo;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property Initials: string read FInitials write FInitials;
    property OtherName: string read FOtherName write FOtherName;
    property SalutationID: Integer read FSalutationID write FSalutationID;
    property IDNo: string read FIDNo write FIDNo;
    property PassportNo: string read FPassportNo write FPassportNo;
    property JobFunctionID: Integer read FJobFunctionID write FJobFunctionID;
    property PrimaryContact: Boolean read FPrimaryContact write FPrimaryContact;
    property EmailAddress: string read FEmailAddress write FEmailAddress;
    property TaxNo: string read FTaxNo write FTaxNo;
    property MobileNo: string read FMobileNo write FMobileNo;
    property DOB: TDateTime read FDOB write FDOB;
    property VehicleMakeID: Integer read FVehicleMakeID write FVehicleMakeID;
    property VehicleModel: string read FVehicleModel write FVehicleModel;
    property ManufactureYear: Integer read FManufactureYear write FManufactureYear;
    property VehicleRegNo: string read FVehicleRegNo write FVehicleRegNo;
    property LicenceRenewalDate: TDateTime read FLicenceRenewalDate write FLicenceRenewalDate;
    property MaintenancePlan: Boolean read FMaintenancePlan write FMaintenancePlan;
    property HeaderTitle: string read FHeaderTitle write FHeaderTitle;
    property SubTitle: string read FSubTitle write FSubTitle;
  end;

implementation

{ TCustomerDetail }

constructor TCustomerDetail.Create;
begin
  ClearValues;
end;

procedure TCustomerDetail.ClearValues;
begin
  FContactTypeID := 0;
  FTextValue := '';
  FComment := '';
  FPhysical1 := '';
  FPhysical2 := '';
  FPhysical3 := '';
  FPhysical4 := '';
  FPhysicalCode := '';
  FPostalCode := '';
  FPostal2 := '';
  FPostal3 := '';
  FPostal1 := '';
  FPostal4 := '';
  FBank := '';
  FBranchCode := '';
  FAccountNo := '';
  FFirstName := '';
  FLastName := '';
  FInitials := '';
  FOtherName := '';
  FSalutationID := 0;
  FIDNo := '';
  FPassportNo := '';
  FJobFunctionID := 0;
  FPrimaryContact := False;
  FEmailAddress := '';
  FTaxNo := '';
  FMobileNo := '';
  FDOB := 0.0;
  FVehicleMakeID := 0;
  FVehicleModel := '';
  FManufactureYear := 0;
  FVehicleRegNo := '';
  FLicenceRenewalDate := 0.0;
  FMaintenancePlan := False;
  FHeaderTitle := '';
  FSubTitle := '';
end;

end.

