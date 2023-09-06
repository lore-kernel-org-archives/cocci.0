Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAF9EB8FAD
	for <cocci@archiver.kernel.org>; Wed,  6 Sep 2023 07:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vE0S1PaydEEzvx4BY3sYXb/enkpYzd0YeRjpdpkSu9Y=;
  b=ead7mDc74dAEmnYOGR3tmufZq9uHfbCHBDMXPOJyjrIUGKuTiBFamYcL
   1q2YUyZUoRReGBVGFwdzeHJOdQnDxEocgQ/Czp6f1k6gQX2fK4uBtGwc7
   kI4a2PN0ChKPzpshT7bCShPSFtr+p21xPKiuZRzbrLcrfy2W3rq7k77dk
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.02,231,1688421600"; 
   d="scan'208";a="124540171"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2023 09:11:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 17BB9E0CCC; Wed,  6 Sep 2023 09:11:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 11131E004E
	for <cocci@sympa.inria.fr>; Wed,  6 Sep 2023 09:11:08 +0200 (CEST)
IronPort-SDR: 64f8260b_lj9jXCshb6Jo5B2xfGT+t98dpMHWfwkKEEh1jXVB17cIJUR
 IW3k88gQEbeGfN8tc5IPv+NtyzvJW7hPI4Hjs/g==
X-IPAS-Result: =?us-ascii?q?A0G0BQAmJfhkhw4P49RagQmBT4I3eVMwBAtHhFKPPYF2M?=
 =?us-ascii?q?IQ8hzOHSYpDgUA+DwEDAQ1BAQIEAQEDBIILgmoBCQKGbwIdBwEEMgcOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOECeFaA2CNykBE?=
 =?us-ascii?q?WSBCAEBAQEBAQEBAQEBAQEBAQEBARcCRz8BAgIBIx0BAREmAQQLCxoCJgICV?=
 =?us-ascii?q?xsBAYJ6gioBAw4jB6lsgTKBAYIJAQEGr1QfLCJVgV8JgRctiAgBiX8nD4FVR?=
 =?us-ascii?q?IE8glMxPoRETYMOgmeJUZUrKoEICF+Baj0CDVQLC12BFYJHAgIRJxITBUJxG?=
 =?us-ascii?q?wMHA4ECECsHBDIbBwYJFxgVJQZRBC0kCRMSPgSBaYFTCoEGPxEOEYJHKzY2G?=
 =?us-ascii?q?UuCYwkVDDVOdhArBBQYgRMEah8VHjYREhkNAwh2HQIyPAMFAwQ2ChUNCyEFV?=
 =?us-ascii?q?wNIBkwLAwIcBQMDBIE2BQ8fAhAaBg4tAwMaFgQOAxkrHUACAQttPTUJCxsGQ?=
 =?us-ascii?q?AInoVCCTw2CL8V9NAeCMYFdgV8Mnx8GEy+DbgGTKA4GkjSYLKhFgWoBMoFcM?=
 =?us-ascii?q?xokgzZPAxkPjjmEEY9IPzU7AgcBCgEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 D3eFrDN0sCN/6xU
IronPort-HdrOrdr: A9a23:u/L2m6ysfb+EynJYcxHWKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:QcrcgW6kIYQXaAWWN9ssy38PE9kMfGDn/kyAOG2jVmBHTKW1cArF
X-Talos-MUID: 9a23:md9PbQrgVyfHOFczHGUezxYzGIAwyoCpNFFXi65W5OC4Kj03YQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,231,1688421600"; 
   d="scan'208";a="65196922"
X-MGA-submission: =?us-ascii?q?MDFY2v/roCGd3XYvHSkTkXUb1xoUS9/bTRRHt2?=
 =?us-ascii?q?xFuy0p4gouKA1y8ksrTkAP+J4fZ44NJ2JpIMo6p6aSPLt08vOtcEXjHz?=
 =?us-ascii?q?sLeQJYIQKLqv51YKa3Att/dz4RJYoOowRIS5Bj5IyC1tYO06BV6x5qbw?=
 =?us-ascii?q?kbWZzKWwyXYUs2cYRDux2BjA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 09:11:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693984251; x=1694589051; i=markus.elfring@web.de;
 bh=vE0S1PaydEEzvx4BY3sYXb/enkpYzd0YeRjpdpkSu9Y=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=V7joO+Knc75GUI84lEg8Nw7mbZJd0aHmlyTGrmJfMzCDRynf7YCHl249OTTyJaKO5by2Aa7
 7VrvtOhELeKmuFSeyljzK44R9JwlZSIZFBzGV+eJQkzt13T7O3wmi+a8ytb/leyxAw3xRA74W
 qx/co6Kqc2um34GE7YcSwmQg+Lbyg6HC3MDsUy2rJlHY5m6wYV6PqmzP01NELbeU/g5aKxfhM
 3m9+e5X1gx/XS/iKfwhHSfG8Jlk/LlYlgNWxdgi88oSfz6bI24tXYGthZ0jwA34m9ciDiBFMt
 0HbjDlSOdsacY/UP4zsNbJh7Qo92xcmCcHX0aOha5j8xExM1JFKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ux4-1qZxCD3QBO-005IFK; Wed, 06
 Sep 2023 09:10:51 +0200
Message-ID: <0bd30d22-162c-487e-a4a2-4592cb6f2a24@web.de>
Date: Wed, 6 Sep 2023 09:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
 <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
 <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
 <alpine.DEB.2.22.394.2309022032260.3175@hadrien>
 <1326a929-8a48-4113-981c-df6dc3220474@web.de>
 <alpine.DEB.2.22.394.2309022101230.3175@hadrien>
 <852c86a4-403b-49f5-b307-c47fcf6da68a@web.de>
 <a9c2e240-eb0d-449c-ace2-d723a891500b@web.de>
Content-Language: en-GB
Cc: Thomas Adam <thomas@fvwm.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a9c2e240-eb0d-449c-ace2-d723a891500b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gtGb8Z3OSf/iXRIx9tL/TacxBvBRdVt8YGmsd6U5pVbhx5+2YMs
 1zZjlYrXqOKerT2WnzD2dsB4dk4ubHde2BCLTK11yzaW25jmc4Z7zNjoiEXBOSV1VM8zAWO
 yqjopc1uiMl94Ei3gYzD4kq+ZKYwHxM+5yaeDa39zPen+gpTbaDRspe24ouZHMNdRozr8nW
 4f4w4FLThuXlZ0bn5qE8A==
UI-OutboundReport: notjunk:1;M01:P0:r88CD3SCvM8=;up039f99og+7Ir4g9v6effIYZwW
 zgVncUCpV7ssAaXuc0+02iZk93tT6NhFZdbXb6XGnuHDLzc2qUN39S5IBpHdsMQMcs0aAsxUe
 Iesxvzfd97G98JQF7vVy+yr8Qsn36kQY3uAbk2Ug1sFdfcMWNVGADbHw1Ner3Tg+higytbiGQ
 d5Ss7UkecnHi0j8Jh1U54GTq93rxs8T1A+PnyNBA7+B67az3/03OU1+tTlrCVZnIwKQGSXUg7
 memXvMHY8L//tyiTvv9fMWa7QtikJkWEMZDKre4LAlkR5ecKxRq5/3PuCqa6hPpeTd4QgKA3h
 MUo5wM6gYqyLzlnkt9XBTHHOcuLHy+2mruBuHMBSJsEs2aXGvQjVI0UopzgRBzEzDx4kRYexa
 G9HdMrHFpsH+yiGqjF/EmjVkw9fR/Ztwr84IR6Lygw8JLIiA5LuXvVgcX3SgQKl7XRwrOxY4m
 pmMlP9+t8AnWfPdZBWCeBzGkQfs33CtR7q49X1l44BThgMaQ7MTUbUjdMOmzQZwJ0zKxF09hx
 T4/tfkIOJfk+imY5+Lob/HhuLpyd3Ps0a4q67iZzUOGBgc7GoesJsqlmoRVcbLO/QFt2ZWOoQ
 /47o0XhTzELjaqIQy+8+QKq2H4rI3+uFr+y0tCH5oNKSjaL6R0I9oBjlk1mUeSutcBHHxW5+G
 8ziSWUI9qkYQtJ8jACAzjHRHkzZOnVeOrL6SyQ26W0L5d6VJlKRYaJUYoVIyy3b+NZTjfuSBe
 NP6ku6Dm/qrkXl1FQYP3UGt/yktEhRyTCD5eaNQm9ua77rcp24b8qnZXH4/XhMj1gzQ7VBDWX
 eJmsndn3UUe2SBCv0Edt4t01aoZSnDnkQn1bIeP9Wpvp5Ss37k5NCxVyS+cKwH1l0lWlXP4MJ
 oUj2eguFhA0PpAJZYmgF+BK9ue2wQgUF3ZR/8CAozE5NEfV/LVxBl8ne6ERb4Vnx/kq1Rkh1H
 Q+gahfn9xEoC30G+O+Sdiv4SBMM=
Subject: Re: [cocci] Checking an analysis approach for the avoidance of
 duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1238
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/0bd30d22-162c-487e-a4a2-4592cb6f2a24%40web.de>

> Will any case distinctions be adjusted in the implementation of the Cocc=
inelle software?

Would you like to discuss data processing consequences any more for the us=
e case
if multiple metavariables are specified with the same type?

Are there any special constraints to consider for the safe application
of the semantic patch language if a type like =E2=80=9Cstatement=E2=80=9D =
was chosen for some
variable names?

Regards,
Markus
