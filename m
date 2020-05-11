Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B336C54E8E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 09:00:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE4F2495A
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 09:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mhpjJQdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE4F2495A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04B90ar0016852;
	Mon, 11 May 2020 11:00:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9E3E07839;
	Mon, 11 May 2020 11:00:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7DB363DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 10:54:14 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60052.outbound.protection.outlook.com [40.107.6.52])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04B8sDjr013220
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 10:54:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f65WhUlQ6NmLJnf9ejXrWBP5Vtjk41cd09Ze//5B2NyomRtYwxiqQM0FvQg38BcT7Fls2MhRQ9B8MpjuvO2t7n1Ukw0XMkRBTilqYw871RBC25Cv0drffs6IQwafJ3H/GRzQPZTQXnJlbZQNVUZaa7zPQkvNCC5nRderX8YNxJdpLjLdfocqLouIOYQhzSKo6XapSxza1n5vZoCKogm8jrKEQ2JJxHAe+Yt2QnJ/ZQ/LgkmmSgh9l1w8km9mUNKh8D3f96H0k9a2L4th7R6jdMNt1f3g99ayuCLTg6AHeyBbYzFfF7JZsVCgizxbSX1eyUXWP3J9axp4kgkVLmy/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTiKjfHrjsqCdUiRsLmmznW/UJmVb/I46ifpSDudpXc=;
 b=gsgfDZmNtESvWTo+C2WOOv0PQpxqWTGNz12TOnFWCUxP2vyVyWfY4t63IheW/WpNszDtO9Gq9+lt9YThfyoq92S0VaTTnmb3Etpu1DdZrsVgzc5cXtSkE8GsTvtJS4myknejBkF1KS1rt3f+doGlAjMdo6zxt/qndJWbTBZBVXsZxKYozDoxwA0iamW+pGYxvH5T2XftrE95f0jPk/cA71HqqEiGmYDryWHQ27Z0rfCW7UVo6QWVNFZymOrUlqEExKsuEe/knC6zEPYBVWtNVxwzLjdo5LQjAuMmz0Nvg9HSd5CLDNu1r6hd16BrO+thOoaWo8L67k3TAUQe597rcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTiKjfHrjsqCdUiRsLmmznW/UJmVb/I46ifpSDudpXc=;
 b=mhpjJQdMZD7Gy1BxHYeKMcEkRSNl7Br/EIDqB/QJhOIvcnff+a8k3xw3Zd/FlAxtRcsW27Bm8V4qzTvzaInzfzXaZFZSkR4822GWd4tcdgh4nivSIZbnrutA1bbrThm8bZPfX4orm0b8+cv8Noy5WAhEXc4H8YqH353fVN5iFl0=
Received: from AM0PR05MB4738.eurprd05.prod.outlook.com (2603:10a6:208:b7::18)
 by AM0PR05MB4547.eurprd05.prod.outlook.com (2603:10a6:208:b8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 08:54:13 +0000
Received: from AM0PR05MB4738.eurprd05.prod.outlook.com
 ([fe80::d881:998d:b326:952c]) by AM0PR05MB4738.eurprd05.prod.outlook.com
 ([fe80::d881:998d:b326:952c%5]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 08:54:12 +0000
From: Shetu Ayalew <shetu@mellanox.com>
To: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Thread-Topic: make install possible bug
Thread-Index: AdYncZr7xbmQGhrXSFyHZyC+hhCJiw==
Date: Mon, 11 May 2020 08:54:12 +0000
Message-ID: <AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10@AM0PR05MB4738.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: systeme.lip6.fr; dkim=none (message not signed)
 header.d=none;systeme.lip6.fr; dmarc=none action=none
 header.from=mellanox.com;
x-originating-ip: [85.250.60.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25369f4e-2eb2-48fa-598b-08d7f588e0a6
x-ms-traffictypediagnostic: AM0PR05MB4547:
x-microsoft-antispam-prvs: <AM0PR05MB454765A19B3CC3AB7B8E7D1FDAA10@AM0PR05MB4547.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHs+DvLWiKE4t76T2JwO0LfW3hIrmICtLiPRb6EPRvQfSqEXxYB77vL7rXuU+En9GjToN6TCjNNMmhWqnS5LOLea66DdyZmTNWLBdvfQDoHVnegzC92g8g+4irRtTfTvSWdXu22lezs8+6M61Ewm4RkIhW7uJEF4jL8McMn02rQS5KVyiN+hWoFASb+tvxWrzph+zWVwDAfa8SoIfpA/l2pE1Y813jbLSjBRd4MKfu0Tidr4A9bWLdR0WJAqPPNZU3WtQbBXY2+k8ycFRy7NcLksfcF4tOlLJ3+pNHpRYL190lWUlhaqh6xtCKupb4ftsbzotwap46jziXNDOcL0Nj9oM6thh5iAo2O3NbY8lOLQelCpwJPQGDVWIn2Mi2y3T7ESv+ZvxgR8qyzQf7elPUut1BnGuueDgKN1nW4JL6Ai6jMmVJuKnaRrQkT3iCTmcS0A2111nlSKLxs+zTOch9EVP7dWal2lmFrZRRvvGGCcQ9Qt8wlsBbgrurifeH38v6VvSF6fsp0M6tvue0Cv3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB4738.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(33430700001)(55016002)(8936002)(9686003)(71200400001)(8676002)(6506007)(7696005)(5660300002)(33656002)(33440700001)(26005)(186003)(316002)(99936003)(4744005)(2906002)(3480700007)(86362001)(52536014)(478600001)(9326002)(66476007)(64756008)(66946007)(66446008)(66556008)(66616009)(76116006)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: G27U70Rd6lQwpYXJe25JfF0ipbVXnFBmzfjdR/kRzR4t6cpPKC1ah6+jhfma+lwLv6yc5zBkKgVZO73/4kPQG8tXvm/utKF98jZDJye9XG7HQBHZlxAiQbQThZJGSv8l93/91gvN3cUdxM56/Jf2oAgV+rZM6s4Y70cwxYBUQRbx5FJlvP/HYotU7EF3J7A6t22i2CiyZQQkN52ODa0ixS/TIprss9AANRUGdkpBQm8MJxpnT0Et4bAmIwck2aRA3myK/ZAP3b5hBTxq5deNQAUPMgJJc+XSdGslCen0jXkmw+aQn+Iuck2L0OF7EPAEGnh+PtlnwyYyJNBzFr8FgYYTs1yxIZHOrHbrash6vCEQ5shmGL9+A392XiD9scnuiGAiQ/q9YoYk/hdIFUfLooLSNaQla8bQFRGG7lU7+VeEGo30VBF5GucLa2zL5IpocplbLrCg1JSRkq8ZS2BvWZhB4ZH9WAr7roSc6SVHfm8=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
 boundary="_004_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25369f4e-2eb2-48fa-598b-08d7f588e0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 08:54:12.8670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uu7fFwrrAS1HALJ8+eXYPArdxhZiMYFSb6dqvKQk/OZ6CkQORZj9VFFoj+Oy3l+MBbJO5Z1NXF4X9bfO6zKSNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4547
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 11:00:36 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 10:54:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 11 May 2020 11:00:34 +0200
Subject: [Cocci] make install possible bug
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--_004_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_
Content-Type: multipart/alternative;
	boundary="_000_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_"

--_000_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

While trying to install the coccinelle lib I faced error that as far I unde=
rstand says the make install assumes the existence of folder I did not have=
 (and also should not according to previous phases in the install txt).
The attached patch that just create this folder seems to solve the problem.=
 If you think I missed any stage through the install process I would like t=
o know.

Shetu.


--_000_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">While trying to install the coccinelle lib I faced e=
rror that as far I understand says the make install assumes the existence o=
f folder I did not have (and also should not according to previous phases i=
n the install txt).
<br>
The attached patch that just create this folder seems to solve the problem.=
 If you think I missed any stage through the install process I would like t=
o know.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Shetu.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_--

--_004_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_
Content-Type: application/octet-stream;
	name="0001-Create-python-coccilib-at-install-time.patch"
Content-Description: 0001-Create-python-coccilib-at-install-time.patch
Content-Disposition: attachment;
	filename="0001-Create-python-coccilib-at-install-time.patch"; size=666;
	creation-date="Mon, 11 May 2020 08:52:23 GMT";
	modification-date="Mon, 11 May 2020 08:52:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0OWRjYzVjYjc0ODNjZDIyMzQxYzNhMmU0YWE1ZDVhNzY0NDlkN2U4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGV0dSBBeWFsZXcgPHNoZXR1QG1lbGxhbm94LmNvbT4KRGF0
ZTogTW9uLCAxMSBNYXkgMjAyMCAxMTo0NToxOSArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIENyZWF0
ZSBweXRob24gY29jY2lsaWIgYXQgaW5zdGFsbCB0aW1lCgpTaWduZWQtb2ZmLWJ5OiBTaGV0dSBB
eWFsZXcgPHNoZXR1QG1lbGxhbm94LmNvbT4KLS0tCiBNYWtlZmlsZSB8IDEgKwogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQpp
bmRleCA0NTdkMzExNi4uNGFhMGFhZDEgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2Vm
aWxlCkBAIC0zMjksNiArMzI5LDcgQEAgaW5zdGFsbC1zcGdlbiA6IHRvb2xzL3NwZ2VuL3NvdXJj
ZS9zcGdlbiQoVE9PTFNfU1VGRklYKQogCiAuUEhPTlkgOiBpbnN0YWxsLXB5dGhvbgogaW5zdGFs
bC1weXRob246CisJaW5zdGFsbCAtZCAkKERFU1RESVIpJChMSUJESVIpL3B5dGhvbi9jb2NjaWxp
YgogCSQoSU5TVEFMTF9EQVRBKSBweXRob24vY29jY2lsaWIvKi5weSBcCiAJCSQoREVTVERJUikk
KExJQkRJUikvcHl0aG9uL2NvY2NpbGliCiAKLS0gCjIuMTQuNQoK

--_004_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--_004_AM0PR05MB4738EB6AA328B4DB1A7D29A0DAA10AM0PR05MB4738eurp_--
