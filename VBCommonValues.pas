unit VBCommonValues;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils;

//  WinApi.Windows, WinApi.Messages;

type
  // Record to store user data
  TUserData = record
    UserID: Integer;
    UserName: string; // Login name
    FirstName: string;
    lastName: string;
    EmailAddress: string; // Personal email address
    IDNO: string; // ID/Passport number
    ComputerName: string;
    IPAddress: string;
    AccountEnabled: Boolean;
  end;

  TShellResource = record
    ShellResourceFileFolder: string;
    RootFolder: string;
    SkinName: string;
    SOAPServerName: string;
    ConnectionDefinitionFileLocation: string;
    ConnectionDefinitionFileName: string;
    ApplicationFolder: string;
  end;

  TActionArray = array of Boolean;
  TUserRights = 1..255;
  TUserRightSet = set of TUserRights;
  TZCompressionLevel = (zcNone, zcFastest, zcDefault, zcMax);
  //  TApprovalActions = (apApprove, apUnApprove, apToggleApproval);
  //  TBillableActions = (abBillable, abNotBillable, abToggleBillable);
  TFileExtensions = (xls, xlsx, doc, docx, mdb, accdb, pdf, jpg, png, Bitmap, bmp);

  TCustomerLinkDataset = (
    ldsContactDetailCo,
    ldsAddress,
    ldsContactPerson,
    ldsContactDetailPerson,
    ldsBankingDetail,
    ldsDirector,
    ldsBeneficiary,
    ldsTrustee,
    ldsShareHolder,
    ldsHeir,
    ldsVehicle,
    ldsDirectorOfCompany,
    ldsCustomer);

  MasterReportDataSets = array of string;

  TMasterFormTypes = (
    ftActivityType,
    ftAgePeriod,
    ftBank,
    ftBankAccountType,
    ftContactType,
    ftCountry,
    ftCustomer,
    ftCustomerGroup,
    ftCustomerStatus,
    ftCustomerType,
    ftJobFunction,
    ftMonthOfYear,
    ftPricelist,
    ftRateUnit,
    ftSalutation,
    ftStdActivity,
    ftTaxoffice,
    ftVehicleMake,
    ftDirector);

var
  FileExtension: TFileExtensions;

  {
    $0080BFFF - Orange
    $00FFB3B3 - Light Mauve
    $009D9DFF - Light Pink
    $80       - Maroon
    $C6       - Red/Maroon
    $C6FFC6 - Light Green
    $B6EDFA - Light Yellow
  }
const
  Days: array[1..7] of string = ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
  LongMonths: array[1..12] of string = ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
  ShortMonths: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

  EKEY1 = 5376149;
  EKEY2 = 3261854;

  MASTER_DATASET_COUNT = 19;

  // XML Formatt specifiers
  EMPTY_STRING = '';
  ONE_SPACE = ' ';
  TWO_SPACE = '  ';
  FOUR_SPACE = '    ';
  SIX_SPACE = '      ';
  // Carriage return/Line feed character.
  CRLF = #13#10;
  COMMA = ',';
  SEMI_COLON = ';';
  PIPE = '|';
  DOUBLE_QUOTE = '"';
  SINGLE_QUOTE = '''';
  TELNET_PORT = 'telnet'; // Default telnet port standard = 23
  ESCAPE_CHAR = '\';
  DOUBLE_ESCAPE_CHAR = '\\';
  ALL_FILES_MASK = '*.*';
  // Drawing borders around grid cell.
  DRAW_CELL_BORDER = WM_APP + 300;

  // Genrate case insensitive queries in SQL Server.
  SQL_COLLATE = ' COLLATE SQL_Latin1_General_CP1_CI_AS ';

  // Default skin name
  DEFAULT_SKIN_NAME = 'Office2010Blue';
  SKIN_RESOURCE_FILE = 'AllSkins.skinres';

  // Default registry constants
  // Common keys
  KEY_COMMON_ROOT = '\Software\van Brakel';
  KEY_COMMON = KEY_COMMON_ROOT + '\Common';
  KEY_DATASNAP = KEY_COMMON + '\DataSnap';
  KEY_RESOURCE = KEY_COMMON + '\Resource';
  KEY_DATABASE = KEY_COMMON + '\Database';
  KEY_USER_DATA = KEY_COMMON + '\User Data\';
  KEY_USER_PREFERENCES = KEY_COMMON + '\User Preferences';
  KEY_EXCEL = KEY_COMMON + '\Excel';
  KEY_PDF = KEY_COMMON + '\PDF';
  KEY_TCP = KEY_COMMON + '\TCP';
  KEY_EXTERNAL_FILE_ACCESS = KEY_COMMON_ROOT + '\External File Access';
  KEY_VB_APPS = KEY_COMMON + '\VB Apps';
  KEY_MASTER_TABLE_MANAGER = KEY_COMMON_ROOT + '\Master Table Manager';
  KEY_TIMESHEET = KEY_COMMON_ROOT + '\Timesheet Manager';
  KEY_TIMESHEET_CARRY_FORWARD_MANAGER = KEY_TIMESHEET + '\Carry Forward Manager';
  KEY_TIMESHEET_DETAIL_REPORT = KEY_TIMESHEET + '\Timesheet Detail Report';
  KEY_TIMESHEET_BILLABLE_SUMMARY_REPORT = KEY_TIMESHEET + '\Timesheet Billable Summary Report';

  APPLICATION_FOLDER = 'C:\Apps\VB\';
  ROOT_FOLDER = 'C:\Data\VB\';

  CACHE_DATADATA = ROOT_FOLDER + 'Cache Data\';
  EXCEL_DOCS = ROOT_FOLDER + 'Excel\';
  INVOICES = ROOT_FOLDER + 'Invoices\';
  PAYMENTS = ROOT_FOLDER + 'Payments\';
  REPORTS = ROOT_FOLDER + 'Reports\';

  COMMON_FOLDER = ROOT_FOLDER + 'Common\';
  RESOURCE_FOLDER = ROOT_FOLDER + 'Resource\';
  VB_SHELL_FOLDER = ROOT_FOLDER + 'VB Shell\';
  PDF_DOCS = ROOT_FOLDER + 'PDF\';
  ATTACHMENT_ROOT_FOLDER = ROOT_FOLDER + 'Attachment\';
  DB_UPGRADE_SCRIPT_FOLDER = ROOT_FOLDER + 'DB Upgrade\';

  // FireDAC conection definition file.
  CONNECTION_DEFINITION_FILE = {ROOT_FOLDER + }RESOURCE_FOLDER + 'ConnectionDefinitions.ini';

  FILE_TYPE_APPLICATION = 1;
  FILE_TYPE_INSTALLER = 2;
  FILE_TYPE_RESOURCE = 3;
  FILE_TYPE_DOCUMENT = 4;

  // Constants to identify the client application.
  APP_VB_SHELL = 'VB Shell';
  APP_TIMESHEET_MANAGER = 'Timesheet Manager';
  LOCAL_USER_INFO =
    'LOGON_NAME=%s' + PIPE +
    'COMPUTER_NAME=%s' + PIPE +
    'IP_ADDRESS=%s';

  LOCAL_EXECUTABLE_ROOT_FOLDER = 'C:\Data\Delphi\Bin\';
  LOCAL_VB_SHELL_DS_SERVER = LOCAL_EXECUTABLE_ROOT_FOLDER + 'Servers\VBDSServerDebug.exe';

  // Default localhost port no's for connecting debug SOAP server to local machine.
  VB_SHELL_TCP_PORT = '2020';
  VB_SHELL_HTTP_PORT = '2025';

  VB_SHELLX_TCP_PORT = '20255';
  VB_SHELLX_HTTP_PORT = '20260';

  VB_SHELL_DEV_TCP_PORT = '2030';
  VB_SHELL_DEV_HTTP_PORT = '2035';

  VB_SHELL_DEV_TCP_KEY_NAME = 'VB Shell Dev TCP Port';
  VB_SHELL_DEV_HTTP_KEY_NAME = 'VB Shell Dev HTTP Port';

  VB_SHELL_TCP_KEY_NAME = 'VB Shell TCP Port';
  VB_SHELL_HTTP_KEY_NAME = 'VB Shell HTTP Port';

  VB_SHELLX_TCP_KEY_NAME = 'VB ShellX TCP Port';
  VB_SHELLX_HTTP_KEY_NAME = 'VB ShellX HTTP Port';

  // Messaging
  WM_USER_ID = WM_USER + 500;
  WM_DOWNLOAD_CAPTION = WM_USER + 501;
  WM_RECORD_ID = WM_USER + 502;
  WM_RESTORE_APP = WM_USER + 503;
  WM_APP_READY = WM_USER + 504;
  WM_APP_CLOSED = WM_USER + 505;
  WM_STATE_CHANGE = WM_USER + 506;
  WM_DOWNLOAD_PROGRESS = WM_USER + 507;
  WM_POST_DATA_ERROR = WM_USER + 508;
  WM_CONTACT_TYPE = WM_USER + 509;
  WM_SYNCH_DATA = WM_USER + 510;

  //-------------------    SQL Server Errror Messages     ------------------------
  { Error No  Severity Message
    2601      16       Cannot insert duplicate key row in object '%.*ls' with unique index '%.*ls'.
    208       16       Invalid object name '%.*ls'.
    515       16       Cannot insert the value NULL into column '%.*ls', table '%.*ls'; column does not allow nulls. %ls fails.
  }
  SQL_ERROR_2601 = 'Duplicate %s: %s not allowed. Transaction was rolled back';
  SQL_ERROR_208 = 'SQL server object name: %s does not exist.';
  SQL_ERROR_515 = 'Server error: %s';

  DUPLICATE_MESSAGE = 'Attempt to store duplicate value in table %s. Duplicate value: %s not allowed.';

  //----------------------------------------------------------------------------

  // Database actions.
  ACTION_INSERT = 1;
  ACTION_UPDATE = 2;
  ACTION_DELETE = -1;

  //----------------------------------------------------------------------------

  PRICE_HISTORY_CLAUSE =
    ' (SELECT' +
    '  H.RATE AS %s' +
    ' FROM' +
    '  PRICE_HISTORY H' +
    ' WHERE' +
    '  H.THE_YEAR = %s' +
    '  AND H.PRICE_LIST_ITEM_ID = P.ID' +
    ' ) AS %s';

  PRICE_HISTORY =
    'SELECT' +
    ' P.ID,' +
    ' P.RATE_UNIT_ID,' +
    ' P."NAME",' +
    ' P.DESCRIPTION,' +
    ' P.INVOICE_DESCRIPTION,' +
    ' R."NAME" AS "RATE_UNIT",' +
    ' %s' +
    'FROM' +
    ' PRICE_LIST P' +
    'LEFT JOIN RATE_UNIT R' +
    ' ON P.RATE_UNIT_ID = R.ID' +
    'ORDER BY' +
    ' P."NAME"';

  USE_COUNT =
    'SELECT' +
    ' SUM(USE_COUNT) AS USE_COUNT ' +
    'FROM (%s)';

  RELEASE_CARRY_FORWARD =
    ' UPDATE TIMESHEET SET ' +
    ' RELEASE_TO_PERIOD = %d, ' +
    ' DATE_RELEASED = %s, ' +
    ' CARRY_FORWARD = 0 ' +
    //    ' DATE_CARRIED_FORWARD = NULL ' +
  ' WHERE ID IN(%s)';

  REVERSE_RELEASED_ITEMS =
    ' UPDATE TIMESHEET SET ' +
    ' RELEASE_TO_PERIOD = 0, ' +
    ' DATE_RELEASED = %s,' +
    ' CARRY_FORWARD = 1 ' +
    ' WHERE ID IN(%s)';

  CHANGE_RELEASE_DATE =
    ' UPDATE TIMESHEET SET ' +
    ' RELEASE_TO_PERIOD = %d ' +
    ' WHERE ID IN(%s)';

  CARRY_FORWARD_STATUS_CHANGE =
    ' UPDATE TIMESHEET SET ' +
    ' CARRY_FORWARD = 1, ' +
    ' DATE_CARRIED_FORWARD = %s, ' +
    ' INVOICE_ID = -1, ' +
    ' DATE_RELEASED = NULL, ' +
    ' RELEASE_TO_PERIOD = 0 ' +
    ' WHERE ID IN(%s)';

  APPROVE_STATUS_CHANGE =
    ' UPDATE TIMESHEET SET ' +
    ' APPROVED = %d ' +
    ' WHERE ID IN(%s)';

  BILLABLE_STATUS_CHANGE =
    ' UPDATE TIMESHEET SET ' +
    ' BILLABLE = %d ' +
    ' WHERE ID IN(%s)';

  {
  SELECT SUM(C) AS ID_COUNT
  FROM (
    SELECT COUNT(ID) AS C FROM BENEFICIARY WHERE SALUTATION_ID = 1
    UNION ALL
    SELECT COUNT(ID) AS C FROM CONTACT_PERSON WHERE SALUTATION_ID = 1
    UNION ALL
    SELECT COUNT(ID) AS C FROM DIRECTOR WHERE SALUTATION_ID = 1
  )
  }

implementation

end.

