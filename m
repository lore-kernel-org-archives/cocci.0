Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C68D58D72
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Mw4IHOf7vuSM3IgbSeZEcpM211mmeelhIoAZ1bfoszw=;
  b=gHHTMGO9XZcgQogvnasWBaXcp+U2qXdwsckhfbGta55LFyt9fy9GdGoo
   NC4geP//iGWMkamhr+u4yc7CD4rohn5eo8gjLxTu+gfFPgzfsDCh4c/u8
   sWyIcS2R5TVQVNV+8xb9bdP64qSB08OsHkwIzdKC7e4tsVNPnj3R228pj
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195732856"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 18:48:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1EE45E00B6; Mon, 25 Nov 2024 18:48:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7890BE0133
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 18:48:40 +0100 (CET)
IronPort-SDR: 6744b877_5ow6hmyjhbthoz6N8KPOFa8Y/5VJSR+6nIcomNxkeIaIMVP
 rByK9CAfbkLfeLC7fWehoskPSzc6MhWljFS0xww==
X-IPAS-Result: =?us-ascii?q?A0HRAABKuERneAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDYiFUMwQLSIRWkUGBDoNdhzuQS4NUDwEDAQ1BAQIEAQEDBIUAA?=
 =?us-ascii?q?opbAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAFDD?=
 =?us-ascii?q?goxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBESYBDwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ9gjABAzEHsDWBMoEBggwBAQbaWx8sIleBZAmBGi4BhWmCYgGFa?=
 =?us-ascii?q?TuCWYFjJw+BVUSBPAuBCYE3OD6EQ4NbgmmCRIUPJYgYaJs4UnscA1kyAVUTF?=
 =?us-ascii?q?wsHBYEpERAsAyJuaU5/gTYogSkBQoEVgTkvGyELXIEpfR0UBhUEgQ4FNwo9g?=
 =?us-ascii?q?kppTTcCDQI2giQkWYJNgSUEBYNrgQuDXmUvAwMDA4ITgSuCSV2CZx1AAgELb?=
 =?us-ascii?q?T03BgMLGwY9oV6EcxSVYLJlNAeCOIFlgWMMn1kGEy+XQw4GknqIL5BMIqNph?=
 =?us-ascii?q?R2BfSSBXDMaJIM2TwMZD44hhC3HDUI1OwIHAQoBAQMJhUYBAYtygUsBAQ?=
IronPort-PHdr: A9a23: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
 nbeZSNhbO5r+Dq+uj8K
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:AjIZz6jDuLiJca0UE74otyQLCXBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:pyep725Thf05oHolB9ss8GcOIOoPLXLm0FiLZGaESmwyUeXMVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AXuutmg1HaU46ZXsi6I0rBv28QjUj3I3xFWFTk5A?=
 =?us-ascii?q?848SeEQdJEWi3lQqGe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="102597126"
X-MGA-submission: =?us-ascii?q?MDEv1M+IBmB7B9MD6RWa90O/gUDw6m36P6Jq/I?=
 =?us-ascii?q?a2M58R65NlVkDTXUW3Oh0jni8WixPt3gcJVC5gdUOZtzkuxAFMy5I4eU?=
 =?us-ascii?q?bdSCX3RWpapEoLhVsqdMavacQiKexfP+Du6qx1OH7GNFKhcXmh+hi4BR?=
 =?us-ascii?q?zGcvYEsV1Hvr4YoP0jQX9mYQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 18:48:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732556901; x=1733161701; i=markus.elfring@web.de;
	bh=Mw4IHOf7vuSM3IgbSeZEcpM211mmeelhIoAZ1bfoszw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TJgNoJI2MYd5w1uysLg9IeyY7WEVw14PC7DqSzFVM5ma3TQOFvgpqyYK1WC8THT3
	 +muG8P3Pjhx+iSgWtwkuUbrr0N3UT0u7Df1d5Su9sSg9JtxhfvGmir41BH/f4YHz6
	 7zKOb/vsCru1fcioIkrd68KRekdgMCKbPsHTM+2TBLkzHYfv1hMjSugyZw4+Mdbgd
	 yosrduCBEStPRRIQy/dhBS4QUBoenDjZvhNRkirz5/mvuME7gmYbVRXLqApjtXHhr
	 fgQFHrKnlYu+OTi7oH7ugVDa0KW9p3GM54pJDYc4s6bnkZp8N2L6TihPyQ6KxPKgk
	 VjSTUOC+o7dBXB03+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWi5s-1tDRJl1N8q-00VWJG; Mon, 25
 Nov 2024 18:48:21 +0100
Message-ID: <8b3f42a3-7053-42de-a66c-92426749e246@web.de>
Date: Mon, 25 Nov 2024 18:48:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Language: en-GB
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9YwCxDC03gCGBHpBkoeUKi5KqlFDtnkJJ4WSt5E0FX2uGRLnXiV
 F7W3Zyc6nb7acaCArfg6jSskMAi9znnmE0VhKyraqEXLwbRKHtJM1z8BetCa2U7JksN0EcH
 jWRSPYJ0xMZPN9ex0Y8Yo+LX+LmIMw7hT2occdk8R9GEUSBV0vky1XA69hpZnzoKw1LCuvf
 uJY/cHIvrs66THymFmLYg==
UI-OutboundReport: notjunk:1;M01:P0:ehWcrQ3/VbY=;FtAuX92aUZrmdkgXRSxEzHYFW1F
 0bH1o4r9y56HlLyRzjmljqQw7O09t4hXNL7T8YVOi5lyJaLk0yi/efoa7EZ2RSTB0rqsRXiyn
 p8+/77QDxh39ZGkyTc1gV7OI1fAPo4UITDDWrUoOhlPKKDo6uEXJ6gwHCiQ3Gf4FrLMAO44Bl
 oZ1xcZEFBmN9lnHpsTBjW9CKdEm/UQIMvnI4h49/v9CbgzmNmENfHXWE1TbJe27I8+rFoCWJb
 o8xCItiZHLvAEBalLsuHtBd89NbARhQ51HSN3v3MiKwPr8PRXmUnGHVnY4ABJKSoJg3bhOMlM
 tVRvWyXNlwVMOQ1r+gixZBVIXNGhaVXf0kDfHFkv/9XGlqMjki73hAk6q97z0sDZurpNnM91X
 6SfBdtatkIWcIoTGFR1AqjVVMIyco5m2YJu3htu7s6gT6a0i42vxIwOMXY6rR4qvxHQrGd04g
 G+UYFisO75EyBKTFQk1/LlAOqM5LROEfmYadCkZtVxDzFKtSjGfErBGf+urX6hCqriEJgbRCI
 6nBG5fDjCkSbn2f7U9pIjwRgR2wP1QtG6NfbBMxL20mT5cOgpynSGkmyyyR+35KLknhyFG94w
 3TcMb4jpYy/lDY4dUukRMuatMMBLOBevpAKXCynHets5Ob9K6gPayJFPRKNrKhte+DTmpX1HW
 r4FnPK+HQd4lnn16Y9rWrSU1XZVWCxUBcRmkPne6kXP7cxM6/WgqBdYTUAyewf4j4kvEe+Y2Q
 vz8Jls/rKkUhcbmQdE6nVBtkU58/p4/PYs7oFnbMqn+YvhNtgOnVuzSFej0WbyZ3zlSjgrzQT
 XufWNsNl6dayayZl40kmoR4PjLtbV0zL6tt4yckH71AEB9l8F8Ze7U7P102K76g3QiTATmZNH
 YRXehYzCzXw/7pw6hYdXn/N/uJ2WmX+wfVmTVJNbj0pgltWMV6+ldi4/9/JyUUJ9L7pJee6Iv
 wsj3RkkjOneFWwpq9h8+3XLiKROaMxSC6lGQHVUoCtEiQgWzUZwMH9q35T6rjxl3NCOBk4PPX
 Sc5ImFxzYgwcmTz6fndWjEslGMVUaGKob4ZhbApkaG7PsjwMBRmeZgZi649HEQZiGjNYHyhLZ
 2BbK5ni70=
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2125
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/8b3f42a3-7053-42de-a66c-92426749e246%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/api/capable_order.cocci
> @@ -0,0 +1,98 @@
=E2=80=A6
> +@ignore@
> +identifier F1 =3D { capable, ns_capable, sockopt_ns_capable };
> +identifier F2 =3D { capable, ns_capable, sockopt_ns_capable };

May a key word repetition avoided here?

+identifier F1 =3D { capable, ns_capable, sockopt_ns_capable },
+           F2 =3D { capable, ns_capable, sockopt_ns_capable };


=E2=80=A6
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------

I suggest to omit such a comment.


> +@ depends on patch@
=E2=80=A6
> +(
> +-  F@p(EL) op E
> ++  E op F(EL)
> +|
> +-  E1 op1 F@p(EL) op2 E2
> ++  E1 op1 E2 op2 F(EL)
> +)

How do you think about to omit extra space characters at the beginning
of any SmPL lines?


> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@r1 depends on !patch exists@

How good do the provided data fit to the operation modes =E2=80=9Corg=E2=
=80=9D and =E2=80=9Creport=E2=80=9D?


> +//----------------------------------------------------------
> +//  For org mode
> +//----------------------------------------------------------

I suggest to omit such a comment.

> +
> +@script:python depends on org@
> +p << r1.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for capable reordering",p)

How do you think about to use a statement like the following?

coccilib.org.print_todo(p[0], "WARNING: opportunity for reordering of capa=
ble() calls")


> +//----------------------------------------------------------
> +//  For report mode
> +//----------------------------------------------------------

I suggest to omit such a comment.


> +@script:python depends on report@
> +p << r1.p;
> +@@
> +
> +msg =3D "WARNING opportunity for capable reordering"
> +coccilib.report.print_report(p[0], msg)

Can the following code variant be a bit nicer?

coccilib.report.print_report(p[0], "WARNING: opportunity for reordering of=
 capable() calls")


Regards,
Markus
