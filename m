Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB08C47073
	for <cocci@archiver.kernel.org>; Tue,  2 Jan 2024 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=u80Ta8d3SlYGIHK9p8uo81i2yAQCWLED2fjbfzy6ibc=;
  b=rhrvzIV7UTqH7/+GT/ftd8lcFNqnygFuSZcEKPmEXGp4TnB3PmEU5Lyd
   V6j/jGAV5MAsrUk3M1gwVl10VpZndvSyjHYdhCbpXim0KuRz7Duz8XQbh
   B7aH8QPsXGysVjxL6aoRiQrHShjM4evnUqGWJVT6MvuCY6e4VQrF+5fm1
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,325,1695679200"; 
   d="scan'208";a="144607330"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Jan 2024 19:00:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47458E0CCE; Tue,  2 Jan 2024 19:00:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BC31DE0AF1
	for <cocci@sympa.inria.fr>; Tue,  2 Jan 2024 19:00:15 +0100 (CET)
IronPort-SDR: 65944f2f_zf+SuO8JJcZGJVr0W2qdbTiHrZWU/asYivk4GhAALZB2MMt
 9wbWWrr+m7OEJbJS/OyOjo7IxXZOOGNBLHZQ4DA==
X-IPAS-Result: =?us-ascii?q?A0FEBgA7TpRlhw4P49RagQmBT4I5YhpWMgQLSCqBJYMEj?=
 =?us-ascii?q?0GBdYRrgVWNLIhvgVaBQD4PAQMBDTQNAQIEAQEDAQMNK4ERQoNhhksCHgcBB?=
 =?us-ascii?q?DIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDgULJ?=
 =?us-ascii?q?4VsDYJVGHYWbDACAQEBAQEBAQEBAQEBAQEBAQEBFwINOmsdAQERJzQCJgJzA?=
 =?us-ascii?q?QGCfAGCKgEDMQcNBq9FgTKBAYIKAQEGgmasch8sIlaBYAMGgRouiAEaAQVji?=
 =?us-ascii?q?TonD4FVRIE8glIBAYM3FwEDGIEedYMOgmiDaIU2BzKCHINPgSiIUodafQVBc?=
 =?us-ascii?q?BsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCDMQp+Pw8OEYI+YTYZSIJYFQw0S?=
 =?us-ascii?q?nUQKgQUF4EObhsSHjcREBcNAwh0HQIRIzwDBQMEMwodCyEFVgNCBkkLAwIaB?=
 =?us-ascii?q?QMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMHKVVEDFADZR8yCTwPDBoCG?=
 =?us-ascii?q?x4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY4AhIMBgYJXQkdBw8JBCUDCAQDK?=
 =?us-ascii?q?ykDIzNBEQMECgMUBwsHUAMZKx1AAgELbT01CQsbBj4ColaBNgGBRYFuEyyVW?=
 =?us-ascii?q?7FwNAeCNIFgBYFcDIh1gSOVEwYTL5cmDgaSVJhNjWqVNIVIgWoGLYFcMxokg?=
 =?us-ascii?q?zZPAxkPjjmDXzOEYYpmQDUCAQgwAgcBCgEBAwmFRgEBgyczgUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LvbHwK/G3AlCNRT2e4luk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-Talos-CUID: 9a23:BYkarWMuon1nku5DWRg28E0QKtgZNVLUw1TJOH+ELzkzYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AW+oYag/NKm3lmfUBoMRLqyWQf94xvKmrCkcmq4s?=
 =?us-ascii?q?tgOm4BXFUNTqxiA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,325,1695679200"; 
   d="scan'208";a="75666278"
X-MGA-submission: =?us-ascii?q?MDE/w0AtPGk5EUbXMtc/AGdIjI27//oOJiDZW6?=
 =?us-ascii?q?BMprDA/rD9ywyYUNPmRMJU9WiY3m30Z/aMM1WUlDeuQQLd7zVtzIHfQo?=
 =?us-ascii?q?GRJZ8V+XwMixKqnd1OBjeL43x/b5T2tXKZxfzosLuHYXRwJyxx4m9FNY?=
 =?us-ascii?q?JXAIJgPg5TPI9PgDAkd4WSZw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 19:00:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704218414; x=1704823214; i=markus.elfring@web.de;
	bh=EBM+Rcg3FmROtiip5fgLqLCeL1mvNcWJLTq0NQNbryE=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=MLVtlMRMZ6tC+2dXirzNVr1t/nc51cbDQpld4NZ5jByHQKEPLH0r6f7KCsux2xix
	 sW4rdGQYMeds7ct3bkDvW7qjo1cbsAk4Z4Ml7BftAxpw3BQa3dptuL9myAekQVTM/
	 CxPjr1KqMsro5ezIphbOrfc6QInIjzGcznxzByHWF4ONdBbtjXqXmrJKRkK8qwf5N
	 loa/Z6KIrkJfonu2NT4r6NU/yDStB7LAX0aoTEXB7vYI33rPA6O1haxIipK7yK5VH
	 0yhzoBP9lww8Izl+NApeXkGb3GCPdS8cB7kNSGkafRPinyYI3tSsfUOOzNTXanaUh
	 yHlHGUac3li4tnWnyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1rYxcn3suC-00Pk3E for
 <cocci@inria.fr>; Tue, 02 Jan 2024 19:00:13 +0100
Message-ID: <913bb6fa-c168-46f7-ba39-5fdaae586b6e@web.de>
Date: Tue, 2 Jan 2024 19:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMoIP2zuF009kCqQsPA5TcnmmTpFZ0o62WVyEUdcNZRvUE6s6Cl
 IjmXVhGnRbn+zsKAGEXVAfd3BWinJyojpwiDErlcrebks+bjo30BXad9eHkukDW2LEHhNEu
 /mrC2pRBGqOwNLaBaM0irBB8WRBqukBcZ1PJtnrsD8cMYDOwkdYEMAES/DL5hNYkmJBpIw/
 DdakHdLEPTDl5llBkDlaQ==
UI-OutboundReport: notjunk:1;M01:P0:Xz3DNlOix2Q=;YmhPmhyorz8wKoj5tT5eoI3EUxk
 SKfpK4D/eXWyrG2tOGyhfnCQ0EMhAy5GiYo3oj1DNv2bqcZo0M9BwNFAleWoV5rQrQex3JaDQ
 9dmMtdQAXoWcgozz/8GKAFF3HNsq5y4TlaT9meTYL061qs+Jl3dZu8u9nb04xwTRKG7CimACH
 VsICU5yijmmzQ1dfY/HLkSdnpzRg7votGncZ+ixi7vGoNxgWKiG5QLqFiwXd0hSbi/QH2ODI1
 gfuOEsWUBhyBeBkvQOk87pUir7ha81RleFTpjO2GJH7OofikaIWQLjv6MTbjI/XOnIDUW0F8c
 5hCwYEPzwhDwS5+Gr/AucADvZtT95Wjp1eq4CBR2fkjKr2didEV5a8aQThNCD5xDxmnHAFPdp
 OjfCBhP33PEcfxodrZ86tX5n31GQu5lhgLSULG7+l9P4FMloUi2M3rfJgaxKF2UejEBeHi1D9
 vjrYszO0ipeU+zuRSvPUC/yNfIOplU3lFR/LCHQFsqEzHnjxC3QqHAHxihQYkTLI/hKyy2yMl
 Sdqrybpwp27ar1hbj2XG+G2eeA+DoX+BfFfKC87vPBNXx29+i3k+VpLzEcuaDPMJg3iynHrZl
 WKvAX3ys4nS1Fd7V2wP8E9+kq8WncxayiVPPEyRJ6Iw1mAm/mWa3Afc0Yv04ki78lkxiLNsSO
 sa2hny3ImI5EjiBnZYU6rJoM0uEVZYaEOZG26atpSBq/qplvChL2b410/dzR6hg7rXvDSTGBg
 oEbbzGTPW+3zX2vpkMFVRsW5GAqOhFMWee9kxorQaTyegncOHULSDCREZz3ILAvF7vCGJQqJM
 dECQrl+nZ0tr/CIEBqAAtGmj/7UI3M6KYpbJK7ghPrEciqZJs3XX1ppvIDLhK/lhAIaK5J5Ki
 YYvUOjSniT2eZRtuFulh0a/2eR4f1JWerjDrAaBrF41gJhonntVO21QbGJ+KDlBrr/aazADqL
 4/lpgOkePtVHGkvgwmjsEntCSqQ=
Subject: [cocci] Checking addition of local error code checks
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1427
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/913bb6fa-c168-46f7-ba39-5fdaae586b6e%40web.de>

Hello,

I applied the following SmPL script also together with the software
combination =E2=80=9CCoccinelle 1.1.1-00628-gd7ca09d1=E2=80=9D on a known =
source file.


@addition@
@@
+{
+int rc =3D
 fb_alloc_cmap(...);
+if (rc)
+   return rc;
+}


See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/drivers/video/fbdev/atafb=
.c#L2988
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/video/fbdev/atafb.c?id=3D425562be861b46ba8dac78e3927c1cbff5fbb514#n2=
988


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch =E2=80=
=A6/Projekte/Coccinelle/janitor/return_error_code_for_fb_alloc_cmap_call_f=
ailure.cocci drivers/video/fbdev/atafb.c
=E2=80=A6
@@ -3126,7 +3126,11 @@ static int __init atafb_probe(struct pla

        atafb_set_disp(&fb_info);

-       fb_alloc_cmap(&(fb_info.cmap), 1 << fb_info.var.bits_per_pixel, 0)=
;
+       {
+               int rc =3Dfb_alloc_cmap(&(fb_info.cmap), 1 << fb_info.var.=
bits_per_pixel, 0);
+               if (rc)
+                       return rc;
+       }
=E2=80=A6


Such diff output indicates opportunities for pretty-printing improvements.

* Additional space character for variable initialisation

* Line length limit


Regards,
Markus
