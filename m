Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3981DC54791
	for <cocci@archiver.kernel.org>; Thu, 22 Feb 2024 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6tfXsDsPx3hPLy6exy3YvmrZKYPrm5GOZGX7HZ3YeSU=;
  b=YgwilU0lAwz+SYMQh43Fn80MKHKafPc7Z5YvQyCquGGmZaipH455pLdt
   kWx+8jkQgqagpQz7rK9gdIv9xj6fgYVzNvti39FjFJQYQRXi0O5yaiqeF
   eTDEkD/I/7bIeOm+Vy3Td1Vnm3St83yfitp30jHUB2DfCMkt5hdRWPmq4
   s=;
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
   d="scan'208";a="153327712"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Feb 2024 18:36:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DB43E0CDA; Thu, 22 Feb 2024 18:36:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A79FFE008A
	for <cocci@sympa.inria.fr>; Thu, 22 Feb 2024 18:36:10 +0100 (CET)
IronPort-SDR: 65d785fa_0Uta6xWLMInxmk3yw/Dh3MP8N8/X0mc2caW4fcQY3+UayBX
 uw9x8pyD9G1f0Re5pLCuXLiC5Llv1ucQchWclQw==
X-IPAS-Result: =?us-ascii?q?A0GzBACghddlhwwR49RaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FOPRIF1MIQ7hzeHTohwgVaBQD4PAQMBDUEBAgQBAQMEhH8Ch20CHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDgULJ4VsD?=
 =?us-ascii?q?YJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQQECAgEjBBkBAREnBAsLG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfIIrAQMOIwewW38zgQGCCgEBBoJnrHUfLCJWgWEJgRoui?=
 =?us-ascii?q?CYBhW+EPCcPgVVEgRUngwM+hEODW4JoghaDO5pRVH8cA4EFBFoNGxAeNxEQE?=
 =?us-ascii?q?w0DCG4dAjE6AwUDBDIKEgwLHwVUA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDA?=
 =?us-ascii?q?xJJAhAUAzgDAwYDCjEwVUEMUANnHzIJPA8MGgIbGw0kIwIsQAMJChACFgMdF?=
 =?us-ascii?q?gQwEQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEAyspAyF0EQMECgMTBwsHeIIJg?=
 =?us-ascii?q?T0EE0QDEIE0iiYMgicDGSsdQAIBC209NQkLGwYiAR0CuRWTLJ5+NAeCNIFgg?=
 =?us-ascii?q?WEMnzgGEy+XMQ4GkmCYWSCoWIFkOoFcMxokgzZPAxkPjiAZhBSPR0I1OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 j3ni6/5bjtPoYq8FSo0As/JNISYPXBnPRe7QFbp
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:lTueraDCCk8pyiblHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBHhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOktK1vp
 0BT0ERMqyUMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AczG5LWmR3Y9JHskWH7BES7EEmlPXOVT2k0z/AHW?=
 =?us-ascii?q?lMGRoE4OeFgeq24JvlMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AUqCf1wwndfbyunzYgosY4QDH1PCaqP61CU8UgdJ?=
 =?us-ascii?q?bgcWvFCpWOQa0vi2IWKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153327660"
X-MGA-submission: =?us-ascii?q?MDGUkUFAgRuCYZba7FBNyfsKjAOuitWGttSCWr?=
 =?us-ascii?q?s5L4kGvztU4XWsRk1YN29ahJKPL48zmYSMFEgwMqc5eONVQtYV8j6PTf?=
 =?us-ascii?q?8xOlAiuzI0Ny2ZqisFxXDtD4dMDwrwFkIXP66+z32eqqHClJIuB2nled?=
 =?us-ascii?q?OlUeXfSPORvSSxGlRaG3AglA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 18:35:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708623354; x=1709228154; i=markus.elfring@web.de;
	bh=GQbiCjjLB+f2Y9xFB1miCvJU/CH+kqHRUQr1/aO3/jk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=Z3duHmI0PzUfneXkY/k9bNP3GL3iOJH23N24kVh/cAh+/gqX9vKAGS6uzdXMtwQM
	 QIHr+sGHb8A5UY4O1f2dpe9O/kPlUzYMrnCZbTpd5e5JJx1RmOAJFO6+iD0M3rfyH
	 1mD75QcXVsYgl3zFl3bcDn3vJI4EeHSPPtcOAZsXwJ7AZUwcrrpN+KB0DJas86yQg
	 GxCsMi0Rscx4JDhlqtDH1lEy5uVqxOKUwY1JWhUH15ZiOhAZ5v+c7lL1HnbPJloU3
	 MCUTrvZhp0gGeWxDwJ7r7fbz9VASsgjNsFy5Xuba3Su0+3+D2rrB/Zmjc8eNKPhUc
	 054hZ+AnweKJ+GhQXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnG2Q-1rBbOY0AEO-00jUq8; Thu, 22
 Feb 2024 18:35:54 +0100
Message-ID: <28db1dca-d689-4b17-888f-459184c843a8@web.de>
Date: Thu, 22 Feb 2024 18:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a@web.de>
 <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr>
 <edf1d5e4-ddec-40f7-9c19-53ce851727d5@web.de>
In-Reply-To: <edf1d5e4-ddec-40f7-9c19-53ce851727d5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qLn9hTG6cXBn1pR6wYWLpC2GwOC5yjgrQbZDVw8LURlQZjrmYxJ
 sT59FnNztxiWRld/wLmQddWA0Yk6ahHvAW2N5HG1UX6tHVMmj+W2W4tzZQYGEH9+b1MOWdr
 N++GuB9NLirwM6T4UXrg9oOEm7pKxPn+m+H5RYoSI80L3xrHZNMYHbpy/0XVtxx+2xznVbe
 sON4iAYVPAU/BoOrv3R5A==
UI-OutboundReport: notjunk:1;M01:P0:gPqkLvVanmM=;rqBZTdulmisF9+xP+NWqtvXP26b
 fC+oFQCdo/pKqTCHVmmqyeZrF0K+Fd2RSVKkhRtkzZF9XN3JJr8UfHCboNG8Dx6WemAQqtUdZ
 qQDjWYmfe1YagfKo8OzB3chuNyaqEL1XRfEohvZ4p/2pvGQJZlozgjtmIqM72V/tHSjLgbSzB
 hBc8kpgu/dTq7YE8Aro3pJAPloXIlXIFZAew8gNMAwtttWeM5LffJsxJCVrj3PnZbuMPS/40U
 lEGRw+QVn/a6pFQNERk3iVLqnSzoWUY1TEgRXj1Vnpj+MbfQ3y/7b9qRkBjXSKS24HNp2VYYh
 G1tKfVjSWWKAmvAUC/fJ/UCr/XPhfpH9dcOj9Zk64qbqQ5I7S5j73trMBByIIqHukmqyZv4wn
 SBaQoujm0X4NRrz8d5I4VnxCi5EblA03lfuvxmlRGaoWKi5xac+CjoxlRWayta9vAW8XpIRtW
 IHTv9ss37R7nt7tRPshILCEV8G7J+yexWKgaCg4IAIqTl2YVB6TSfc9TtW4zqu11nEVmrxyeC
 heUahPRrDAz5BUnI8n0x1euXL8cb8zf7UNDa8zD1z46dLzJLDqC2F8RCeCOgtVGh3/YKWeN5u
 yIW7EywmQ4BNnt051eozhT4XswtMB9um+WmaDEcdyrrOfcIV3I2Wpcf1AOCFLJwvuGLrAupGu
 gJRaiunCpAFbHUxup4EHoNOHX7e9XpWRNotI4Q59+7UqwEpH4f0SdZDJDnhD6KEkjblbDT5gJ
 dIMJfQkwOvAO9lzXu6A4A6N0KopaqgLvtWng/YMkVMLVmBQspXiPCnCay/mshBceJc0J6+It8
 izpxf80P02xJUPMTNSqV4qnuCm/wc8j5t92el9hYQ0EAA=
Subject: Re: [cocci] Detecting misused expressions with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1597
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/28db1dca-d689-4b17-888f-459184c843a8%40web.de>

> Would you get further development ideas from the comparison with the fol=
lowing
> SmPL script variant?
=E2=80=A6
> @display@
> expression find.e !=3D find.x;
=E2=80=A6

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20240221 && spatch drivers/remoteproc/qcom_q6v5.c =E2=80=A6/Projekte/=
Coccinelle/janitor/show_questionable_PTR_ERR_usage2.cocci
=E2=80=A6
@@ -333,8 +333,6 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v
        q6v5->qmp =3D qmp_get(&pdev->dev);
        if (IS_ERR(q6v5->qmp)) {
                if (PTR_ERR(q6v5->qmp) !=3D -ENODEV)
-                       return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->qmp=
),
-                                            "failed to acquire load state=
\n");
                q6v5->qmp =3D NULL;
        } else if (!q6v5->load_state) {
                if (!load_state)


How does such a diff output fit to the specified SmPL constraint?

Regards,
Markus
