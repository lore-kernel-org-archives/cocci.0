Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9853EC433EF
	for <cocci@archiver.kernel.org>; Fri,  1 Apr 2022 21:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KPK6ijoCl0vGAu1pjdU+oYCy4MIKLOUus86COdoyKPA=;
  b=Fhz5jFImR8+GOfAH5ZuwhH5BrYZQ9Hoz43XYkpQ5rKaErlwzkqlDN8Bu
   h7uKr+jYgNtmqXt3iJ9jbgAtbb1q8FR8xt++XNeYzE4fopqybasHLM4Rg
   dnPaf88d7MVcri14TFb7ij+d3ZlkJfWTRTmyFDWyLbzFT60N//hfh55FV
   I=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,228,1643670000"; 
   d="scan'208";a="29633069"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2022 23:11:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 51006E0298; Fri,  1 Apr 2022 23:11:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E55ADE00A8
	for <cocci@sympa.inria.fr>; Fri,  1 Apr 2022 23:11:03 +0200 (CEST)
IronPort-SDR: DgIUzrRU+ttqYUb7aHbfevyi7Bv+Yk91rmZyEFgT0Qnd6QOxEWvnIv66k+cEH4DXtJYQMzYcW8
 4ePxNxc+OxtlqJc2Ee0UbTMK1dRHXzZxpYRIk64qlMFgYUl7iyCDNFnnhr6GnnEcs9Ag75+kEV
 4+lfxgKSR3ZQ4SXyKqHKMiGltXVfdeTmP9yr1oZPBUlEl/4XEEqtjVWMV7yOxsaVB8gKDHaSGB
 R/MEw23BmwtKQQQXbmdr/YJE/vqUUqUSL1UEerS4exe3U+1rhkcUcSAParVXQQ9kZZc3qWEsoD
 BVR1eqPa7njz9wpyg4niKqez
X-IPAS-Result: =?us-ascii?q?A0DKAQDZaUdihwQP49RaHQEBAQEJARIBBQUBQIFagiiBV?=
 =?us-ascii?q?SsEC0SEVI5zgiiLJYcajCMLAQMBDUABAgQBAYISgnUChFoCHQcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZ?=
 =?us-ascii?q?ASBSwSBdAs0DYI1IoNsAQICASMdAQERJgEECwkCDgwCJgICVwYNCAEBgwCCZ?=
 =?us-ascii?q?QEDDSWTf5wMgTGBAYIIAQEGhEgfLCJSgVwJgRAsjk4nEIFVRIE8DIJ3Podfg?=
 =?us-ascii?q?kMimmHDJzQHghKBOoFCDJ4YBhEDLpZFDgaRdZZepwuBeIF+MxokT4JpTgECA?=
 =?us-ascii?q?QINAQICAwECAQIJAQECjh0ZhAyKLT80OAIGAQoBAQMJhUcBAYwXAQE?=
IronPort-PHdr: A9a23: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
 VCUlmtSo7fW4S4K2p1C
IronPort-Data: A9a23:VJmv66L15U9/qS4FFE+RjZMlxSXFcZb7ZxGr2PjKsXjdYENS0TIGy
 GMaCG6DOKveNGD1f41/btiy8EhQvpPXnd9kTlMd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhX1vU4
 YiaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhk9JN9
 sxv5JuJeRZ5ILfFhrkvVT1YOnQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RCvLwtXicXq
 LpEQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojacmbGP6auIMItNs2rsdjA9TBV
 5o6VTRibC3QfSMeJ3opC7tryY9EgVGmLmEG8QvLzUYt2EDYywd60ZD2Id/Nc5qLQ99UlwCWv
 Ar7E3/RBxYHKJqAxDDD/n/EavLzcT3TVIAuKqSap/lTsEzD2HYaFkAkU3+7iKzs4qKhYO53J
 0sR8ysoiKE98k23U9XwNyGFTG64Ug00BoMKQrxhgO2Z4vuIsl/BboQRZmQZMLQbWNkKqSsC+
 nLhoj8ELTloraHTVn+XsLuZxd9TBcT3BT9fDcPnZVJbizUGnG3VpkyVJjqEOPDs5uAZ4Rmqn
 1i3QNEW3t3/d/Ij2aSh5kzgiDmxvJXPRQNdzlyJAjL6s1olPNb5PdTABb3nARBoc9fxor6p4
 ylspiRixLtSZX1wvHHREbtWRtlFGd7fa2KM3jaD4KXNBxz0piL9JNkOiN2PDB4na44FfyPke
 knepUtY6/du0IiCPcdKj3aKI51yl8DITIy7PtiNN4YmSsUvKGevoX8/DWbNjjiFuBV9yskXZ
 MbLGe7yVypyIfo8llKeGbxCuYLHMwhlmAs/s7igk0/4uVdfDVbJIYo43KymNbtmvPvd8FyKq
 76y9aKikn1ibQE3WQGPmaZ7ELzABSFT6Unep5MFe+idDBBhHW19Wfbdzal/KZNoleJZm76Qr
 H26X0ZZznv5hGHGcFnbNCo8Nem3BZsv/2gmOSEMPEqz3yZxa4iY7JAZK8k9c44h+bEx1vVzV
 fQEJ56ND60XGDTK8jgQd7fnq4lmeEj5jA6CJXT3fzU1OZJtHlSb9tjhdwrp1S8PEivu6Zpg+
 eL9jFuDTMNaFQp4DcvQZPa+9H+LvCAQyLBoQk/FAthPY0GyooJkHCzGiKNlKc87LxielCCR0
 BybAEtDqOTA/901/d3OifzWpoulCbInTE9dAnWd8ru8cyXXpzLxzYhFWeeOXDbcSGKtpPT8P
 7oIlamkPa1VhktOvqp9D61vk/A06ezvkLkGnA5qK3PGMgawAbR6L3jahsRC6v9XyrlCtVfkU
 06D4IADa7COJd+jD1MbYgYoN7zR2fYRkzjUzPI0PESjuH4ppuXaCx0KMknekjFZIZt0LJghn
 7UrtvkW3Arj2BAkBdCL03JP/GOWI31cCKgqu/n22mMwZtbHF72DXXDdNsMyyJSIdskKLUQgZ
 DOZ7EYHa3Kw2WKaG0ff11CUtQaeuXjKkA9HxhkOKjxlX/Lb0+Qv0kQ5HSsfF2xoI9Yu7w63E
 ndmPQt5KM1iOtuuaNdrBwiRJu2KOPFVFoEdBbfEeK01gnREjlDwEVA=
IronPort-HdrOrdr: A9a23:1mvXOKwC24OZUR2wEH9jKrPwCL1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,228,1643670000"; 
   d="scan'208";a="10338548"
X-MGA-submission: =?us-ascii?q?MDFpPNIziC5GkCjBzDy6mH7CKyi1uY+Nz3ynSN?=
 =?us-ascii?q?210DjcmPgWZ+0hmKwNrt/l7R3F4eVHCT3ViCRW4SmWzex8IDjwrPmvNI?=
 =?us-ascii?q?z/L1LFTwdFxyTUjs9OnOEycd2b1lymS8glRjw4iYztyie8Tprebbv5X9?=
 =?us-ascii?q?/i/QPGjw0BWZBFWtTZCbc1yw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 23:11:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648847462;
	bh=glcIELjPe9uQNqWCdd+MVieUogcopYr69xOCoj17H68=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=WmFFVgtAT5SaFBSbVjyCgs9hblp+jsHka2gIRIWWEad9VQAv5QkJCkFgbs226TvcR
	 OR8Q1lA354/3IB+piKR+aNUO8OpKUD6AZXVCCANAPkvVT+OhvU7o0835qA2IybbJzK
	 ZJodX60cxWZC9DT2VhGSsN4JIauaCw24ebJfJPkM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.185.246]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxpiU-1nx1VQ0bLq-00z8hA; Fri, 01
 Apr 2022 23:11:02 +0200
Message-ID: <16859542-0e1f-5a4c-2506-22d437d25ead@web.de>
Date: Fri, 1 Apr 2022 23:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net>
 <alpine.DEB.2.22.394.2203192038220.3204@hadrien>
 <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net>
 <alpine.DEB.2.22.394.2203200732590.3429@hadrien>
 <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:92Wuhrwxc71nHQpAy3Nh/3zUdCDhd0qazTfBijTLwG6Lr+Fs2//
 38n0OrzQGvHewpJqiLlYZMTKi3oCD52suJK/r14UTxMVzt6X07MQEGISfidfOis/LRUnxju
 sKGZGjEa0+Lvzqy7viy8HgtqQ0e4Eu0hGHgbHTov+B2ZrAhFisBhPmCJmbJUcjNo2Scgtoh
 7HJVgo3JadmwGKCvsOpog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qGM1h9yWo9k=:KGV0AIYIF25MVWWZ3E/mdM
 DTWKLVXUiXZBsmB/z83LedSYQQHdv+z4VCJsQaVT/SjKguuaU4esdxlmG9NwRgVCdNwBea4Ww
 C02ygOyxwS1oN0txpsnqY80e2RkV+UxLK29SW4J7+MnI55UtHSmggGWU9fb+4MGJSzIhu00Gt
 v7IV6VuYPvqp9wnLoEfp++XxQgP4beVcUUgNXW58ff8/rbBs0FN/wfNW5rvDEtiFg4X9mxL7e
 LGL4W5Xxlyw2EiQMWlbkSq5t2k1ryf+MsxlghkMBm7R4zTMSobF4TtgCSDqZHNOejklzUiNzd
 DVRhJAN/UuRYowAflUcraq8Otr31V5YYMBdpqBP5LGsesmjMGGLcVW00oIbKYjoeoIqA1nHZN
 osheGwkTbFZmxlQ5WDjUGS2x5b81oSr3QuY99z4PB1pTF3NCublLyBDRtvXcshH4up4yCtcL0
 O5/i9s/UmQ5DI/7/a4iHZh+0EuZZ0Eagmh13WySnBvEF3BRZSKIsHtPnqzxgCKdU3wYqUM6hP
 btwJp82cRrsFBGlL9jFhSoZKNSjA2ngVAT+7ECBaMLrhuCUCcwKTXkitG4hsZKxajWxmEd/Vs
 sJCSqHsRMX4unevZFLExUBFpoyFTN4yo70Sd04AXH9Uq2CtgtKdJ8DirFfsFhHboxpAwnTNoX
 XQ2VocctdbZTtnmd++fHGlQ/4wpkgSKVm2wwayuhw1L1RmF0xPDz3htPkgZUfzZE6qeB8xifb
 UvvKO1RqJLK3OXRXlzm2qEd/OroAi+Axss6H7DvYgoJxNMS/JfXlPwCwmNeBH7bsae5PV1B9N
 r4hAAdIYl0balOwUJPobPsqot9LgClaGrpLYzDeZcm1hv9Xi3ANvGYU1j+EIVu/+VDuZ+0rHY
 nLI7oWBGtZA3TVRXEW4HoQAkQCQEzE0oPUZM56lmyQ+m+OtacYZRGT+31mc+TfRgc62dCbpte
 XFeSt2TFBXnymS6/EDTuLFyNxcjz4nzNIT0BmALH0253tpdsdw19IejyE/smAwl2YAPZ+PRqJ
 ofBZ/U3PJ4aPptjLcL4UK9r6HNmXPCyb3Qcb+Dq3cgxD1Cr4bgWm3P7vmVw8/5ZdEpIDUUYpl
 Lu55JNKu1tKBbA=
Subject: Re: [cocci] Using `parallel` to run over lots of .c files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 330
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/16859542-0e1f-5a4c-2506-22d437d25ead%40web.de>

> Here is the SmPL:
> 	@ p4 @
> 	expression list EL;
> 	constant C =3D~ "BUG";
> 	@@
> 	-printf(C, EL);
> 	+BUG(C, EL);
>
> 	@ p3 @
> 	expression list EL;
> 	constant C =3D~ "warn";
> 	@@
> 	-printf(C, EL);
> 	+pr_warn(C, EL);
>
> 	@ p @
> 	expression list EL;
> 	constant C;
> 	@@
> 	-printf(C, EL);
> 	+pr_info(C, EL);
>
> 	@ p2 @
> 	expression list EL;
> 	constant C;
> 	@@
> 	-fprintf(stderr, C, EL);
> 	+pr_err(C, EL);


How do you think about to compare the software run time characteristics
with a script variant for the semantic patch language like the following?


@replacement@
constant C1 =3D~ "BUG",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C2 =3D~ "warn",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C3 =3D~ "info",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C4;
@@
(
-printf
+BUG
=C2=A0(C1, ...);
|
-printf
+pr_warn
=C2=A0(C2, ...);
|
-printf
+pr_info
=C2=A0(C3, ...);
|
-fprintf
+pr_err
=C2=A0(
-stderr,
=C2=A0C4, ...
=C2=A0);
)


Would you like to extend the application of SmPL disjunctions any further?


Regards,
Markus

