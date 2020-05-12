unit BaseCustomerEdit_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, Vcl.ImgList, cxImageList, Vcl.ActnList,
  Vcl.Controls, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, System.Actions,

  BaseLayout_Frm,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, System.ImageList, dxLayoutLookAndFeels, cxClasses,
  cxStyles, dxLayoutContainer, dxLayoutControl, dxScreenTip, cxContainer, cxEdit,
  dxLayoutControlAdapters, cxButtons, cxLabel, dxCustomHint, cxHint, cxMemo,
  dxLayoutcxEditAdapters, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxDBLabel;

type
  TBaseCustomerEditFrm = class(TBaseLayoutFrm)
    styHintController: TcxHintStyleController;
    repScreenTip: TdxScreenTipRepository;
    stySubTitle: TcxEditStyleController;
    styHeaderFont: TcxEditStyleController;
    lblHeaderTitle: TcxLabel;
    grpHeader: TdxLayoutGroup;
    grpData: TdxLayoutGroup;
    grpButtons: TdxLayoutGroup;
    sep01: TdxLayoutSeparatorItem;
    litSave: TdxLayoutItem;
    litCancel: TdxLayoutItem;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    litHeaderTitle: TdxLayoutItem;
    litSubTitle: TdxLayoutItem;
    litLegend: TdxLayoutItem;
    lblSubTitle: TcxDBLabel;
    sep2: TdxLayoutSeparatorItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FValidationError: Boolean;
  public
    { Public declarations }
    property ValidationError: Boolean read FValidationError write FValidationError;
  end;

var
  BaseCustomerEditFrm: TBaseCustomerEditFrm;

const
  EDIT_FORM_HEIGHT_OFFSET = 50;

implementation

{$R *.dfm}

uses
  MT_DM,
  VBBase_DM;

procedure TBaseCustomerEditFrm.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := MTDM.FormCaption;
  lblHeaderTitle.Caption := MTDM.HeaderCaptionArray[MTDM.DetailIndex];

  if MTDM.DetailIndex = 5 then
  begin
    lblSubTitle.DataBinding.DataSource := MTDM.dtsDirector;
    lblSubTitle.DataBinding.DataField := 'FULL_NAME';
  end
  else
  begin
    lblSubTitle.DataBinding.DataSource := MTDM.dtsCustomer;
    lblSubTitle.DataBinding.DataField := 'NAME';
  end;

  styHeaderFont.Style.Font.Color := cxLookAndFeels.RootLookAndFeel.SkinPainter.DefaultContentTextColor;
  styHeaderFont.Style.TextColor := cxLookAndFeels.RootLookAndFeel.SkinPainter.DefaultContentTextColor;
  stySubTitle.Style.Font.Color := cxLookAndFeels.RootLookAndFeel.SkinPainter.DefaultContentTextColor;
  stySubTitle.Style.TextColor := cxLookAndFeels.RootLookAndFeel.SkinPainter.DefaultContentTextColor;
  MTDM.ClearFieldValues;
  VBBaseDM.MadeChanges := False;
  btnOK.Enabled :=  VBBaseDM.MadeChanges;
end;

procedure TBaseCustomerEditFrm.FormShow(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crDefault;
end;

end.

