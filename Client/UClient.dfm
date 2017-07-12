object FrmClient: TFrmClient
  Left = 165
  Top = 160
  Caption = 'Indy Chat Client'
  ClientHeight = 383
  ClientWidth = 730
  Color = clBtnFace
  Constraints.MinHeight = 270
  Constraints.MinWidth = 683
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 65
    Width = 730
    Height = 299
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 0
    Visible = False
    DesignSize = (
      730
      299)
    object Label1: TLabel
      Left = 16
      Top = 208
      Width = 36
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = '&Usu'#225'rio'
      FocusControl = checkListUsuario
    end
    object checkListUsuario: TCheckListBox
      Left = 16
      Top = 224
      Width = 145
      Height = 66
      Anchors = [akLeft, akBottom]
      ItemHeight = 13
      TabOrder = 1
      OnClick = checkListUsuarioClick
    end
    object lbEdtMsg: TLabeledEdit
      Left = 264
      Top = 272
      Width = 376
      Height = 21
      Anchors = [akLeft, akRight, akBottom]
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = '&Mensagem'
      TabOrder = 3
      OnChange = checkListUsuarioClick
      OnKeyPress = lbEdtMsgKeyPress
    end
    object btnEnviar: TBitBtn
      Left = 647
      Top = 269
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Enviar'
      Default = True
      DoubleBuffered = True
      Enabled = False
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = btnEnviarClick
    end
    object Memo1: TMemo
      Left = 16
      Top = 40
      Width = 707
      Height = 161
      TabStop = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object cboxReservado: TCheckBox
      Left = 172
      Top = 273
      Width = 81
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = '&Reservado'
      TabOrder = 2
    end
    object btnExecutarAppServ: TBitBtn
      Left = 16
      Top = 8
      Width = 185
      Height = 25
      Caption = 'Executar Aplica'#231#227'o no Servidor...'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 5
      Visible = False
      OnClick = btnExecutarAppServClick
    end
    object btnLimpar: TBitBtn
      Left = 623
      Top = 208
      Width = 75
      Height = 25
      Caption = '&Limpar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 6
      TabStop = False
      OnClick = btnLimparClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 364
    Width = 730
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 50
      end>
  end
  object ScrollBox2: TScrollBox
    Left = 0
    Top = 0
    Width = 730
    Height = 65
    Align = alTop
    BorderStyle = bsNone
    TabOrder = 2
    DesignSize = (
      730
      65)
    object Image1: TImage
      Left = 480
      Top = 3
      Width = 242
      Height = 61
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      AutoSize = True
      Center = True
      Picture.Data = {
        0A544A504547496D616765AB160000FFD8FFE100E645786966000049492A0008
        0000000500120103000100000001000000310102001C0000004A000000320102
        00140000006600000013020300010000000100000069870400010000007A0000
        00000000004143442053797374656D73204469676974616C20496D6167696E67
        00323030343A30343A30382032313A32383A3037000500009007000400000030
        32313090920200030000003931000002A0040001000000F200000003A0040001
        0000003D00000005A0040001000000BC00000000000000020001000200040000
        00523938000200070004000000303130300000000000000000FFC0001108003D
        00F203012200021101031101FFDB00840007040506050407060506070707080A
        110B0A09090A150F100C1119161A1A181618181C1F28221C1D261E1818232F23
        26292A2D2D2D1B213134312B34282C2D2B010B0B0B0F0D0F1E11111E402B242B
        4040404040404040404040404040404040404040404040404040404040404040
        404040404040404040404040404040404040FFC400A600000105010101000000
        0000000000000007000405060803020110000103020403010B060A0803090000
        00010203040511000612211331411407151722515461718193D2081632365291
        23333435427492B2D1F02437446382A1B1C12572942643455356629596E10101
        0003010100000000000000000000000001030405021101000202010303030500
        0000000000000001020311042131411271810513A191C1D1F0F1FFDA000C0301
        0002110311003F002FD5AA331AA9BE86E4BC942566C013B0C36EFACEBFE54F7A
        B5E18E71AD52A8F5677BEF5385078AB5F0FB4BE86B5DB9DB51DED717B794621C
        E75CAA0FD65A1D872FE9ED7C582566EFACFEB2DEB7AF0855678E72DEF4F8D8AC
        0CE99546DF3968876F3F6BE2C219D72ADC7FDA5A27FD7B5FC70166EFACFF003C
        7B97DAC7D3559F6244B7BF6BFDF15839D72B11F59A896F276F6BE2F4E3E9CEB9
        5AF7F9CB44F64F6BE2C059BBEB3AFF0095BDCFED6177D67DFF002A7BF6B158F9
        E995B90CCB4417DAFDBDAF8B139D45F7DF00EC55679FED6F7ED1C2EFACFB0FE9
        6EFEDE2BCFE63A6319818A1BEEBE89F2750650B8CE843BA51AD5A57A742AC373
        626D7B73C4B75F59C03BEFA4FF003B7B97DAC2EFB4E27694F7AB56F8663903E4
        1ECC32935982C76A4F1CBEE43D1DA23C54A9F75AD7F46EDA015EFCF972B9E580
        99EFACF1FDADE3FE2C2EFACE1FDADEFDAC57E0665A4D432FB75B872B894F7364
        3A1B582B21651608B6A24A8690902E4D80BDC6253D9D39601E1AACF17BCB746D
        7FA585DF69C2FF00D2DE3FE3C333B5EFCFF938F325F6A330E4892EA1A65A495B
        8E38AD294A40B9249D80F4E01F77D67F9D3C7FC56C23559E6F696EFB158895D4
        E1A63C578496DC6E5AD088EB6BC7E3156E34E9BDC586A246C120AAE00247115E
        A7AABCBA307962A0840738259701D0412160E9B1478A4150360A2126CA20109C
        EFB4EE5DADDE7F6B0D6AB99D748A7BB3AA5535468CD005C75C5D826E6C3EF240
        F6E3E6E36E5FCF4C709F0A3D4213B126B0D3F1DD4E85B6E26E950F48C0403BDD
        AF2E3319994ED7E5A23C82A0CBAA872421C29D95A4F0EC6D717B72BE2C397339
        2331D31150A354DE93116A5252E94AD1A88363B28038077769A251729C5A2D31
        C8F264529C7242A3A10F14BB045DA2B0DA8DC2926E4D9609BF250C16A975E66A
        597E4CAA0C50E3F0D4B8EA82EAB84A69D473694521412472DAE395B6C059FBEB
        3FA4B7BEFE785DF59C39CB7FF6B024CBDDDA1AADEA31F2FCC57093F856D9529E
        74ACA494A5B4A50755D49B5D45206C77E587F943BAA26B79CDDCB552A24AA44D
        1AC341C735951482A214348D3E28B8E60FDD702677D27F9DBC4FFCD86957CCEF
        52212E64D992C30D91A8B4DADD237FB2804FB6D882CE99B29D94A9E8913F8CEA
        DF5F0A3B0CA0AD6F2EDB245BD9CFCB8E48AE579A82264CCB4B283A4A63C59A97
        640493FA49525290771B059E477C048E53EE8D0336768EF0569E97D97471BC47
        11A755EDF4922FF455CBC989CEFACFB7E56F136E5AB005F92B9586F3296D2952
        F4C6D214AB027F0B6B9E9F762C47BAA55D19B5796DFCA8DC7A9595C243B52B25
        F201524255C1B78DD09B0BF3230058EFB4EE7DADEB7A158E33AB5518F0643C99
        4E1536DA940151B5C0277C53E666CAB5372F3F56AB6559718466CADF6C4C6565
        2916B9490771F71D8EDCB0F28F5B398B25AAABD89D868931D6B69B7140929D26
        CADB95FC9CF019DB317745CEBF382A3A7376606D3DA9DB21BA8BA84A7C63B048
        5580F40D8618F845CEDFFAC7327FF28F7C5889CC5F582A1FAD39FBC70C712357
        F75CFEB0A9BFAB4DFDF8F884B0F20C4DF75BFEB069BCFF00269BFBF1F0268DDD
        1E82FA14E4F9B9A233C56BB350A3C42D253A8E8B6B0557D36BEFCEF6DAD8E971
        3362C387778DEE7F68537ACDADD16DCC73DEA6D3F8B1223B25E5AF42036CA9C0
        82413A9413BD85BA73361717B8A34EAFC8A7B8CB3327546117F569912E2BBA35
        DC7D21E2909F1AE4A02B481608370313ECE67796DBFD86EF40328331AB7500A6
        E304281095BAA4B693F8C0526C8094EC0ABF48BAEE8F90E155D843EE7742A24A
        723363831A345B052DC4EB6C78AEAD44AC2458004902E949EB4F36FC7CF116AD
        BB78F1F2D7C5E465E356D5AD6373E67BFC78FC2A545CC354974D6E54BE38438A
        284A9978A893A8247897D5B920002F7DF90C4ED31BAAD51FE121DA845686EEBC
        F216D903C890B03528FB40E66FB031F4DCA757632842ECEDB4996A4A7885CBEB
        61B52D4AD49074F8E92ABEE7620D8DC8B5869799A8D51E0F7EF312681C7E1A5A
        619405BA54A69B7352DC52549437F85D3BA45CA09D560463070E9C7BCDAF9267
        A4F68F2EBF33EA19B161A63A446ED5EB3311B89F3AFF003695A9476D1966ACCE
        92B422932EDC4256768EBB124DC93B5EE77BE0A07AF5F2E0315FAB46873E6D2E
        915B895D83268B38ADEED0D29E65CECCF91F8B4A52504367902413E3100A4134
        75EBCF1B399971E5BC5A91A8D3818E2623AA83DD0D8765774DC90CB32DF86B57
        7C2CF309415A6CCA796B4A93BDADB83CFDB86B5ACC755A554F32D01AACAE63D0
        E8ABAAB134B6C87A32D1CD971211A1415B2AE52080BEB70A170CD3952879AA3B
        2C57E9E89688EA2B6FC7521482458D94920D8ED717B1B0F20B73CBD9372FE5D8
        12A152696C331A66D210BD4EF185ADA4959248B5F6E5B9F29BE57B55ABF5DAD7
        CD2C8F363555F8B22AF2A14698B69A68F103CD82A559482028106D6B0DCEC76B
        3EC9CF4E73BA8E718F26A9364468BD938319D524B6DF11B2A3A4691A6D6B6D6B
        83756A558E2558C879799E05E1BEEF656B851FB44C7DDECA36DDAD6B3C350D29
        B291A48B0B1C766F28521BA85426B299CD4AA901DA9D6AA1210A73490536B2F6
        B5AC2D6B02523624600574A6D4EF720EE7ADB6F2D852F31B494BADD8A904BCFF
        008C35022E3D208F5E0C3408B3A152188F55A88A9CC4EAE24AE0259D7751B788
        9D858103D988B819132F408688B1623FD9DAB96595CC7D686144DF88D852C86D
        609242D3650B9B1DCE2C67DB6E430026ABE64AF65DCC35DA4D6B314D5A634615
        2A6ADA8B1C392594A5C0A6B642ACAD6524AB41B2595AAC94EF8749AE4AADE52A
        E54E89996AEF41628AB792EBAD30871123C725174349D0A406AC45CDC3C9524A
        6C951BECAA0D2E657A1569F88855460A14862426E1484A81041B11A8589D8DED
        736B5CE1AC3C9D4287969DA0428023D35FBF15965E7125CD5CF52C1D46FCB73B
        81A796D801FCA66A35197DCC4375894DD424D3A5B899EE210EAD2B54642B7045
        9437B6E2E475D5E36255C81515F7668B13BECB6E4A72BA13226B51D01C74891B
        A92920A1054AB1DD2A005C0B1B285BE1E55A3C44424B51564C04251154B90E38
        B6120DEC852944A41BE9201F192024DD2001EFE6DD33E72F7FF82FF7CB85C12E
        F6A734E8FB3A3568D3D6D6E7E373DF010F92EA9507337E66A14E98A9CD52D515
        4C3EEA10970875AD4A0AD094A48046DE2DF737BF4B66D6F50E7E4C45D372DD32
        9D5A9B5688D3E99B3EDDA56A92EAC2EC76BA54A29161B0B0D86C2C36C4A03D46
        FD70010F955BA853D979A0AF1D0990A29F2025BB7FA1FBB06680F427A1899056
        C18D2071C3CCDB4AEE3E9DFAED6DF15FADF734CA75CA93B3EAD4B5C994E1BAD6
        A96F0FB80580073D862469D9528D4DCBABA1C18AB669EB24A9A43EE5C5F73656
        AD437F21C00ABE4A646BCC29B8B9ECC40EBFF7B7FF005C252929F9576A528007
        A936E70B6C13A8391B2E65E9C99946A7086F06F87743CE5949DFE902A21477E6
        4138F8BC8796D727B52E969328BA5D328B8BE3155EF7E25F55BD04DADB72C00C
        FE506EC9A57741CB55990D29DA746D0B0909BDD687752C7B53A76BF43CB04AF9
        FF00953B0F6AF9C34BD3A75F0FB5A35FAB4DEF7C4BD629502B30170EAB11A951
        D7625A75208BDF63BF5F4E2ABE07722F4A11E7E76FFC780A3FC951690BCC28D4
        35111884DF720717F88FBF165EEED92155BA40ADD211C3AAD3471029B0788EB6
        37D208DEE0EE3EEDB13F42EE6D95283516EA147A5AA3C96EFA56253CAFBC1590
        7A7307A627EB0F4D8F01C5D2E1B532427E8B0E3FC14ABCBE36956F6BF4C00FB2
        C6691DD432EC7A4250EA5650915B7109D09423EC279DCB8536D8EC9D5B8205C8
        152421BA3496DA4A5084C7580840B048D3CB02FF0093765EABD0857CD669D2A0
        F116CA1BE3B651ACA439AAD7E63C61BF2DF9E0A757FCD52B9FE257B7B0E031E6
        62FAC150FD69CFDE386387D98BEB0543F5A73F78E18E24696F94B541CA5D4C4A
        675F10419A84942B4949539192140F42355FD9D315AAD53B3E535C4C3AB549A6
        32D3288AD38F1115A6164F092B6C90D9521A2A2A4825B50B690B494951174EED
        E982BCF34B6EA52988ADA9A9652E3B2846B2D2E465A6CE6A4D8829B8DC72C505
        9CB1416AB02AAACE71DF9E168589326B309E5852149524DD773705091EADB912
        313F672E4889A5E22237D27E3FBE7D88B56BDE253946A3C38F9466405D6E9A89
        EFCA69526245084283C1280630643208539C158E1964A86A524A1C293ADA4D5C
        DCAB45A1D31AE054E657A495B48852DA8CC70C3480A4B2E842128E22C850D290
        6CE280257670BB76A4E3D4D4539DCD59493112561296A700A6DB504A54CA0AA5
        2806484A7F02525AF153741B5B0CEA35BAAD11C665653CCF449806AED30EA598
        1B7C3DD13A4B8E9D36BA89B2937B0BDED6C63B70334566FEA89EBBD4CC75FD36
        BE33D3711F1B8DA19DCD112A54CACBF966154D85531E6911E7B95F7B8642DDD2
        85143D74D8909252A1A74EABA9240BC4E614C79140CD73EAACC065F96634AA38
        71865990E32EB9ACA8000295E29014A1AB70ADCD8E22A8597AA4CB32A9F26A94
        48F0669471922B30D69510484A95A5F0AB202D4B005C15252083CC10EAF46C9F
        57E076F9B9717D9D1C36B455D86F4A7A27C5706C3A0E9BDB9E35E2E1465DCFAA
        2BAD77F3DBF8FCAB9CF358D6A643FC8B67E93A10A057163D61C5A06EAD0B81A7
        56DC802902EAB025634EAB2B4EA33FE7EBFE7C980B229B94B2FD12B6ED2A7509
        B75FA5CA6BF075569E5AC965612948E213B92361CCDBC9834F4B0B1DB90DF1EF
        2E28C53111313ECAE2DEAEAF2F3ED3051C571B6C296108D4AB6A57403D3CF6C2
        6D685A494292B02E9B8208B83623EF16B621F37FFE15CBF3933D7FE6C45D2DBA
        9B526A73294E0774D4DD4BD0D6A094BA9BF3493F455B9F5D8792C6B4ACCF5421
        475283F2E3B45B500A0B740292795EFD4804FAB1C8D6A9647E73856F271D3FC7
        D3884CBAB8B59ADD65D7E26A6CA99FC14A6C5D2A4A549371BEFB1C74A4D3202F
        3356595C28AA6DBE06841652426E8DEC3A5CE025CD6A977BF7CA17B1F47F1C7B
        EF9C0E07184E8BC2D5A389C54E9D56BDAF7E7D7147A17E6A67EAC7E97E5A7F0B
        F48FD2FF006F45B0F6AC1C550622596A90F386A68D0D41DD959D26C15BF33C8F
        A30168EFD52CF3A9C2B1FEFD3FC70F12B4AD4B014925074A8037B1B0363F78FB
        F03A96A7A5A9DA6CD8544A4BCAB596B64B44D89374AC5C5B6B5F91BED7C4DAD8
        9EBCCD5A91487F43ECF00869762878145F49F21DB63B7323ADC0595F9B163ACA
        244861A294EB21C700B26F6BDBC97B0BF94E3877EA956DEA50BFEA127FDF14BC
        CB3CCF97502B8CEC675980869D69646CA0FA09B11CC6FB1EB879FF00D2B016A7
        2AF4D42ACE5421A55606CA793B83B8EBCAC71EE2D4614B734469919F581A8843
        A0903CB607D388BAA53E13996E448722405BFD889E2B2D820108D8A0F3B6DB7A
        2D8739621C562910A4331996DD5C646A710D80A578A09B91CEE45F00F3B6C5ED
        5D94C964C9FF00C9E20D7CAFCB9F2DF1D9C5A1B429C75484211BA94A360903A9
        FF003C5425C2A44CCCF594D65D69A20321A52DEE1904B7B9173BF21CC1C7C8D3
        54C45ABD1912513623305C723480E05108B5B41B1E97B743B72B1160B3B95380
        C047167456CAD2169D4EA46A49E446FB8E78F8DD5A9AE2B4B75088A2015592FA
        49B017279F4DCFB314D9699465D38C2811E7AD3466D45A7D1AC04826E40B8B9E
        9D79E3834AEDFC57968A4C1723479095C565B534E925B58B1046F6B743B602EE
        2B54BDBFE27087AA4276C7A555A9A9082AA8434858BA497D22E371B6FE51FE58
        A7D3BF208FF543F149FCA3F19C87D2FF00DDE5F4E1D45EC06BF1FBE8691C1EF7
        1D3C2D3C0D5C63F4756D7B5FDB7C0599157A6B8AF16A1096402A203E9E405CF5
        E96C79EFD52F977CE09E9BBE9FE386F111979D7C370D34953AB05212D06CA940
        8371B6FCAFECC30AB53203799A8CD220C64A1CE3F110969365D9008B8B6F6F4E
        02C31DF6A4329763BA871B56E95214140F4D8FAF6C71ABFE6A963FB95EC3D471
        D9865A8CD06A3B4869B4DEC86D3603AF21EBC71AB7E6A97CBF10BF6EC796031E
        E62FAC150FD69CFDE386387D98BEB0543F5A73F78E18E246E5ADFE7693E4D66F
        F7E19FFAEFD3006AB7CA16AF3AA4FC96696D476DD59525A0F05681D05CA37F5F
        FA61AF87AAD798B7EF07C3881A0FDB61E9E78406FB0EBE4E58CF9E1EAB5E64DE
        DFDE0F870BC3D56BCC5BF783E1C0683E7C803EDBEF85B5F7F5EFFCFA319F3C3D
        56BCC9BF783E1C21DDEAB439426FDE0F870D0D0608EBF77F3FCED8FBD45FA7FF
        00B8CF7E1EAB5E64DFBC1F0E1787BAD79937EF07C380D00EB2D3DA38EDA1CE1A
        C2D0549D5A5439117EBFE784CB2D31AF84DA1BD6A2B5940B6A51E67D2719FF00
        C3DD6BCC9BF783E1C2F0F75AF326FDE0F8701A010CB4DBCB752D3695B96E22D2
        9DD76B8173D6D84865A6DD71D4B684B8E5B88B4A7755B95CF5B633FF0087BAD7
        9937EF07C385E1EEB5E64DFBC1F0E00EDDE5A5F5A6C2F6309F4FA31D5AA7C269
        096D1123210873881296C0017F680B73C013C3DD6BCC9BF783E1C2F0F75AF326
        FDE0F8701A01F65A90D16A4B6875B36D495A75036F41E7CB090CB4DBCE3A96D0
        971CB711C48F1956BDAE7ADB19FF00C3DD6BCC9BF783E1C2F0F75AF326FDE0F8
        70D03EBF0A2C8595498CC3A4A7428AD01448BDEDB8E5717B6380A2D2C73A6C2F
        709FE1E8C027C3DD6BCC9BF783E1C2F0F75AF326FDE0F8701A0382D767ECE5B4
        7074E8E181E2DAC45ADCAD6E98F4DA10D212DA1094A103484A45801E403FDB19
        F7C3DD6BCC9BF783E1C2F0F75AF326FDE0F8700797E990243C5D930A2BAE1B6A
        5ADA4A89B7A48DF961334C80C6BE1428ADEB4942F43406A07983B6E3D1803787
        BAD79937EF07C385E1EEB5E64DFBC1F0E1A07F6E2C769C4AD0C3495211C20A4A
        00213F646DCBD184FC662429264B2D3A520A415A42880459405C751CF000F0F7
        5AF326FDE0F870BC3DD6BCC9BF783E1C01DBBCB4BEB4D85EC613E9F463D2A934
        D5042574F86A081A520B29361726C36F2926DE9C01FC3DD6BCC9BF783E1C2F0F
        75AF326FDE0F8700798F4B8119D0E33062B4E2760B6DA4823A1B6D8EEB65A71D
        438EB68538D5F42CA6E517D8DBD78CFF00E1EEB5E64DFBC1F0E1787BAD79937E
        F07C380D09D77B790FF3ECC35AB0BD2A5DF9F0177FB8E00BE1EEB5E64DFBC1F0
        E3CBDDDDAB0F32B69C82DA90B494A87146E0F3FD1C00E7317D60A87EB4E7EF1C
        31C77A8C9ED950912B4E8E33AA734DEF6B926D7F6E386247FFD9}
      OnClick = Image1Click
    end
    object btnConecta: TBitBtn
      Left = 304
      Top = 22
      Width = 84
      Height = 25
      Caption = '&Conectar'
      DoubleBuffered = True
      Enabled = False
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = btnConectaClick
    end
    object lbEdtServidor: TLabeledEdit
      Left = 16
      Top = 24
      Width = 105
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = '&Servidor'
      MaxLength = 15
      TabOrder = 0
      Text = '127.0.0.1'
      OnChange = lbEdtNickChange
      OnKeyPress = lbEdtPortaKeyPress
    end
    object lbEdtPorta: TLabeledEdit
      Left = 256
      Top = 24
      Width = 42
      Height = 21
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = '&Porta'
      MaxLength = 4
      TabOrder = 2
      Text = '1024'
      Visible = False
      OnChange = lbEdtNickChange
      OnKeyPress = lbEdtPortaKeyPress
    end
    object lbEdtNick: TLabeledEdit
      Left = 128
      Top = 24
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = '&Nick'
      MaxLength = 20
      TabOrder = 1
      OnChange = lbEdtNickChange
      OnKeyPress = lbEdtPortaKeyPress
    end
    object btnSobre: TBitBtn
      Left = 394
      Top = 22
      Width = 61
      Height = 25
      Caption = 'S&obre...'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      TabStop = False
      OnClick = btnSobreClick
    end
  end
  object IdTCPClient1: TIdTCPClient
    OnConnected = IdTCPClient1Connected
    ConnectTimeout = 4000
    Host = '127.0.0.1'
    IPVersion = Id_IPv4
    Port = 1024
    ReadTimeout = 0
    Left = 96
    Top = 144
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 184
    Top = 144
  end
end
