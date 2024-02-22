Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB1C48BF8
	for <cocci@archiver.kernel.org>; Thu, 22 Feb 2024 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3mS7f1frAcxkhGI+xrzFtt+Koenez4SoPPedjauGTGE=;
  b=fHvEwDDE5Sjrl8y4E5LctIScoH0+ZrJB0V28MNQUo3fPC52X5c1JKuVe
   ZncuEgnUZh9al0j6eJJ6XAjP+X784YlsjnUJgEaKHJgCcrlMzI7eZJ/DD
   p3TviMoxYj74y4an8aoZ0Qtty+UO7EdxHihBNDPiTvu1/2YH9/vgKLoSZ
   o=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153298394"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Feb 2024 16:43:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 764E8E008A; Thu, 22 Feb 2024 16:43:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E04D4E008A
	for <cocci@sympa.inria.fr>; Thu, 22 Feb 2024 16:43:26 +0100 (CET)
IronPort-SDR: 65d76b9e_i6EiVJEWCL78RDd/oYCTSB+ObvKnhq8Xko7gIqTqA5jcfBZ
 RcbFMbGYLVIpjk7oCJlp2mVBwlLuVMhYvp+lYXg==
X-IPAS-Result: =?us-ascii?q?A0EeBgBGatdlhwwR49RaHQEBAQEJARIBBQUBQIFPgjl/U?=
 =?us-ascii?q?zIEC0iEU49EgXUwhDuHN4dOiHCDFj4PAQMBDUEBAgQBAQMEhH8Ch20CHgcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOBQsnh?=
 =?us-ascii?q?WwNglwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdBAQICASMdAQERJwQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgnyCKwEDDiMHsD+BMoEBggoBAQavXB8sIlaBYQmBGi6IJ?=
 =?us-ascii?q?gGFb4Q8Jw+BVUSBPIMDPoRDg1uCaIIWgzuaS1R/HAOBBQRaDRsQHjcREBMNA?=
 =?us-ascii?q?whuHQIxOgMFAwQyChIMCx8FVANABkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSS?=
 =?us-ascii?q?QIQFAM4AwMGAwoxMFVBDFADZx8yCTwPDBoCGxsNJCMCLEADCQoQAhYDHRYEM?=
 =?us-ascii?q?BEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDEwcLB3iCCYE9B?=
 =?us-ascii?q?BNEAxCBNIomDIIfAxkrHUACAQttPTUJCxsGIgEdAqYZxSI0B4I0gWCBYQyfO?=
 =?us-ascii?q?AYTL5cxDgaSYJhZIKhYgXsjgVwzGiSDNk8DGQ+OIBmEFI9HQjU7AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 ICnfEfbNzpItd7Zr5N07yf8N8+NdnYsY0OBJQ==
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:0AJ4laESADK3xhxOpLqENseALOsnbusQ8zAXPjNKOH9om6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4tgPM
 xbE5SWZueAb2RSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:0eCYJG5rI8HFEh/C2NssqF81RdkvaTrmwn7CHU2TBHZuE7+zYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AXZVYdA1fNCRm+6A/vJ30mL5aqzUjw/W/EllTlrY?=
 =?us-ascii?q?65syHHiVNICmTng3rXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153298382"
X-MGA-submission: =?us-ascii?q?MDHYqRRp6U/MFdkgzeRXpOTO4dAei0Pm2+a0yV?=
 =?us-ascii?q?BtosQkwv9QEE8yRwzJXC6Co+5byBTHOjXJh1k8hoLfalc8NZW0dhPQ4M?=
 =?us-ascii?q?PNEBTlxIeQEuv4ZduRYxfNvwZ1KhEeTK+daQu/Dbt7yIpdEjXZL694FQ?=
 =?us-ascii?q?E3ONPn+3CDbgzuquZOwZCykA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 16:43:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708616605; x=1709221405; i=markus.elfring@web.de;
	bh=FrtfJveZjQtVGpJ+yrAQTvYfW6gPIYoHs+0Qx4Q0INk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=DdO1jBCcROK/ISjWfZvjiiH1CynLYP1ecsQinS6Df/I23O0m9FG9B5KxxvXQnK6x
	 hGn/zj+tS6ezYNa2Y9iA//ycoQ9YzlV3FeCGYC8Jt0vPIKmeS/BF3/ZqfqRkDTBRY
	 DpN3BJUl6++2DBxitErIgwvj5AedRCd5/A6Okrdo1eeffz63YUlxPY0ndVTO2wovv
	 TmKkp0zhprGd6WxuQSAeCbHBN5AuNp6Xu11ifBjI6Li4ZRtfRtpVpa3dejhmb/cuV
	 96QWck7I9Ch+Yf6Cnpv13NV57V+dEIcI9N+gNifyRoT0idTqik/weqqchh7n1mOkq
	 0/OPwPTdEwypnunIyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xjd-1quOBK1UMV-010COL; Thu, 22
 Feb 2024 16:43:25 +0100
Message-ID: <edf1d5e4-ddec-40f7-9c19-53ce851727d5@web.de>
Date: Thu, 22 Feb 2024 16:43:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a@web.de>
 <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dpCdsuRzsiSz3Bm8MUJErSn1ZM3uJT9F4y4VDf7lUxgbsipo/HE
 Zk5jnHE6XQ7n7kQlP2Wx+mNUIl79wKS7AINkRzyNXQUpnnFpFJSIu+GwLodvdaU9Fxqe3Xf
 ByoYIJn/He1hrkw+WPH7u9J7Vlgq8D6DkQgBzD4cv9DUfe4fAg7L/iJYG0/dRMnZtWduMrn
 jMJK1MYC0LdfKNBWWICtA==
UI-OutboundReport: notjunk:1;M01:P0:MHlS/NcJgD8=;aU3zG5sMpJJMzB7geRciRoV8G1R
 vLbRO0U+gmfNErGsUhsmvIu5x4E5Qid/m4nfto0C6lrXgJ4QXMd6xWMTRl118H0AnlvUD4GVd
 /yPiGPQ1ojszyTdw5+25ctSs3BEasGNLp72zCGFgLJKoAC5A1bdHDMQmzMgZgm9FzTNertA4i
 SiMAhwSiJ7JdhcJEb2Oe/rDacOqTlAfb84SYUsVsXEV7AnrqWduAyMJcU2S/SqcxwzDPT5mSu
 SWZmnqygugkkdMfVoarMuttnbe6HTDn7qUdbTS8eDRoPP5g71VQ8lB4AY3N8K0cW+QyDQXsPv
 Rp3PdfKnYKdJ3fsk6qP0CtI+wiINWYQccFviO7eIbj8oXFlKVb63hbEO4Tcxi2iUwjBrPq31y
 zd741eTxMWMEZNqHcqMR1QG4WPA9eAtX91bn31cz8BLZrUAq3DZjURrVp+hg3CCnD/3zaxZWv
 iiS/Zsn9krv4BObLOyFeu54R6EZVIjG7zexsstl/s7OlITB8lUaAOGKXTBr1opx67aXuRtkx/
 kuPtY+ytOW55M6pldNsk/+waPx3NBHGv4vMbeBd3XxhEyz5bO3IXSAxVS9zELkgn0r1BdT1+F
 8RSZnMpr7GBLQEtMK11KJJND+WEGwtEfIVd4qkWCkEQkYcJv78wsi6FN4HHDWuvEgTNIRUdla
 hfpazVW5MuTtEVkJIXIq5QeBZ5oKa2Fv81cjDxyiCvbReU6eb9d29MuaspvhSq34B09z+q09w
 RTzCoQHd53MQrF7Ub44O6AzzAuaoecR/Kcpe9TyA6kcjfTSMdu7Dm4SU7BlFT2KVnkKjVfxIs
 4OvvZLBGHe+EPEKTugx3RW1NAdCk95qEuGg/5EwpdF60E=
Subject: Re: [cocci] Detecting misused expressions with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1596
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/edf1d5e4-ddec-40f7-9c19-53ce851727d5%40web.de>

> What do you expect the ... with the * in front of it to match?

Would you get further development ideas from the comparison with the follo=
wing
SmPL script variant?


@find@
expression e, x;
position p;
statement s;
@@
 if@p (PTR_ERR(e) !=3D -ENODEV)
(     return ... (..., PTR_ERR(x), ...);
&     s
)

@display@
expression find.e !=3D find.x;
position find.p;
statement find.s;
@@
 if@p (PTR_ERR(e) !=3D -ENODEV)
*     s


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20240221 && time spatch drivers/iio/adc/ti-ads1298.c =E2=80=A6/Projek=
te/Coccinelle/janitor/show_questionable_PTR_ERR_usage2.cocci
=E2=80=A6
real    0m0,208s
user    0m0,184s
sys     0m0,017s


Regards,
Markus
