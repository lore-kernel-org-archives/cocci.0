Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B81C5475B
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JKzKBB5P5uc7qpNgZUdJ6bWB6H7/yth6E7pavEBmtMw=;
  b=IMoj/Dmv+FuvPuOUM3yoSe3eCyHkpOXZRNaTJlsWkRcomLfD5c5LCGba
   vvptWiw9FYNsMUxtgK0HKvipHr4oZTdrG/VmKT6afNr7AuoeFH38StTyT
   QuopW/szOutDVsHj976KeRCJEdrcr3n1owyx9AcH67q6+FIHjeXOZ8gjs
   U=;
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
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152484568"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 09:55:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D9CCE0CD5; Sun, 18 Feb 2024 09:55:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AFC62E008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 09:55:53 +0100 (CET)
IronPort-SDR: 65d1c619_3nrb1WTygm2SYJ/06ODfsS7tz8492BYUk611e7choGfSMk9
 FP7OSCWuy1hyBB/f5gz1ljsnCf3cZs1mRCRdtHQ==
X-IPAS-Result: =?us-ascii?q?A0EhAgCfxNFlhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COWIaA1MyBAtIhFORaYQ7mws+DwEDAQ07BgECBAEBAwMBOIRHAodkAh4HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnh?=
 =?us-ascii?q?WwNglwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQINOkEBAgIBIx0BAREmAQQLCxoCJgICVgYTAgEBgnwBgioBAw4jB?=
 =?us-ascii?q?w0GsmiBMoEBggoBAQaBRgIMAkOtQh8sIlaBYQMGgRouiCYBhSSEDXonD4FVR?=
 =?us-ascii?q?IE8glIxPoJhA4Ffg1uCaIIWgzuaCFSBAh0DgQUEWg0bER43ERATDQMIbh0CM?=
 =?us-ascii?q?ToDBQMEMgoSDAsfBVQDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDO?=
 =?us-ascii?q?AMDBgMKMQcpVUEMUANkHzIJPAsEDBoCGxsNJCMCLEADERACFgMdFgQwEQkLJ?=
 =?us-ascii?q?gMqBjYCEgwGBgZdCRoHDwkEJQMIBAMrKQMhM0ERAwQKAxMHCwd4ggmBPQQTR?=
 =?us-ascii?q?AMQgTRChHaEbAyBUgMZKx1AAgELbT01CQsbBiIBHQKfEQGCUIE3AiCBFIEUL?=
 =?us-ascii?q?8RwNAeCNIFggWEMihuVHQYTL5cwDgaSX5hYi3iBd5sIgXsjgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIBmEFIELg1aKZkI1AjkCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 pYDGOczaQ==
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:Am1uV6qJUSjcWS6NDXrJiZkaV5ssLNV00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssRAb6J290cy7LU80mqQFhbX5UY3CYOCighrQEGgA1/qv/9SDIVyYygc178
 4JHMZD4Z/LfD5HZK3BkWqF+qMbsby6GdeT9IXjJhlWLT2CQpsQlDtRO0K+KAlbVQNGDZ02GN
 614ddGnSOpfTA6f9m2HX4MWsnEvpnumIj9aRALKhY74E3W5AnYpoLSIly95FMzQjlPybAt/S
 zslBH43Lyqt7WW2wLRzGja6rVRgZ/ExsFYDMKBp8AJInHHixquZq5mR7qe1QpF792H2RIPqp
 3hsh0gN8N85zf6ZWeuuybg3AHmzXIH92Li4UXwuwqineXJABYBT+ZRj4NQdRXUr2A6ustn7a
 5N12WF87JKEBL7mjjn7dSgbWAoqqP0mwthrQcgtQ0abWIsUs4XkWUrxjIRLH9bdBiKkrzPXt
 MeSv00r8wmCW9yJ0qpw1WHhubcH0jbVy32PnTr76SuokZrtWE8wE0CyMMFmHAcsJo7Vplf/u
 zBdr9ljbdUU6YtHOpA7co6ML2K41b2MFvxGXPXJU6iGLAMOnrLpZKy6LIp5PuycJhNyJcpgp
 zOXF5RqGZ3IivVeIez9YwO9gqITHS2XDzrxM0b759luqfkTL6uNSGYUlghn8apvv1aCMzGXP
 S4Po5QHpbYXCDTMJcM2xe7V4hZKHEYXsFQstEnW0iWqsaOMYHuvvyzSoelGFLEeQxUK18WKx
 M4LUfOzQV7nzSWs1PD8WrssinWCzzCFLpLYdvn1vlWzpQRPYtRtQVQgUil56iwWEh/jpA=
X-Talos-CUID: 9a23:x4c0HmH19yOyJ/apqmJq+XAWQuYDQ0bglibQAF7jLXxwcIGsHAo=
X-Talos-MUID: 9a23:skiHigQwaXMJvJOMRXTB3DhyBp13v53wBRExtpAEisbZGzxJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="79935601"
X-MGA-submission: =?us-ascii?q?MDEVvjeSNRSd+c71IXcsI7juOGZmN1WYTqFzhB?=
 =?us-ascii?q?4nEYuJkghl0JA5xsVxa9NNZrx4vO1Bf3li12KRCwoxRfoL45WkBk4EEL?=
 =?us-ascii?q?4fgz7hILZ75eptu97nbd7QdlYJNlevAkFSVkkcqvBy7HCPxdshoWmClK?=
 =?us-ascii?q?2tOdZ9KRDcJhuhx//yGbJ5IA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:55:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708246551; x=1708851351; i=markus.elfring@web.de;
	bh=R6FdlDuzG1k8EfUikDa/bqC0GVybH/rgKUgYfrA2upo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=sYmvT+K0yDZ+O0SYIvmOBwut5NCUZ0q8TFN4agNvVDspYQWiipGzzCATlXKWY0N2
	 PkA8j/XrgssEgVyr2TKlaQRxN9u3eXOfDSp5BuSuPdMo06lLNxfRalyC/D9HD/Me5
	 vWwoP2LTQHBQmb43fTqiL5aFN7NQrPyzxz80uSr/N4ldvvMU42cLoL3VBg+D6bfEh
	 qeSgFZtdYNPgJPFzeVeoEdnm6XM5rnN7rImqsBqZFD2aU42ZEMccxBOEuMmBOoHOU
	 sody73bSdWG34XiuL+6EhHYw8rJBhb3LVJiMt32R3eHer6CCP531Adp04XMqHTfgo
	 FhQK8K+f2hPBeVwHNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KJR-1rbLyo2iDx-000JIJ; Sun, 18
 Feb 2024 09:55:51 +0100
Message-ID: <30fef057-5f06-47bd-8b62-1bb6fc3fb946@web.de>
Date: Sun, 18 Feb 2024 09:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
 <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
 <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
 <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
 <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de>
 <alpine.DEB.2.22.394.2402180908440.3095@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402180908440.3095@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KYjHLLLRyYr0lHougG/fAEF6UHj7TWvEEh4pYwz5SwHXYTgnbrs
 ZAn89E1Inaj93muaFZTgdHn6vVpMvnZvJqql9AWSdlOInPYdnT0MJieBHGyk6Q/cOeETCTh
 udZQSRRyeU3kDbOTtMfbl0Ebzex/Xv0ppV6+g4mQALqx7+R2s/LRfy2BLB5mBomN2NW0nq1
 SSOM1Rw8gMFlkcDfDRlUw==
UI-OutboundReport: notjunk:1;M01:P0:XYWYQpQ+CM8=;rzab2lu9W3wgSSLs5amdD3tUPjc
 faUZxbWxT1wSjiMMAqdAnKiMxLBuQTQ6Ii9Tr+jXfEIgVCqMozkYlN5JSuXVXtvtJRN/E2zrT
 XD5jh/gvz78hbVJzdq9qUUl2BqEML9XVBx5f+Fw69nHEtW4VS/zcludePMgGtL7KIu6ZKGiB/
 FRpR4KiGfkrc/F4YkDzVzAxo1JsqS5j3CgCl0mEoDceHDyvk0qhzFNEi1AeRaCofEdtvuWrOd
 zMH1S/NOROe9Sw2m8NvESdpEZ/4XzSy6MHNEK61FRjzV67xyGm1bEG2T8mjQwoKQZN3550uSl
 XilmFgAGTspfC1xryTbp6K4KpFzNMNJrbiUSjebeARhPcSlq0karq5HdIwn7VFIAoz/1NZfz3
 quRHuKIJF6s+7VGyY9v5rk5leo590bFHGwe3u0SVs5ugjICK9yzutFvML0djAsDiM1dPD3cxC
 YHbESxz/TKvbBZ547mupgo8MjLDP/B1w5S3dCdaWhdjt9YjeKXLdfFvTu+5CI7AeEWFH3QDdt
 sqWXX0wvLYNrKlJ7Jlv4TVzRxPIUkbH6M1qUlAbr1OpGk4dWKBHE2L0tpHwyV3CWsZkne1r5q
 vZxDfL0MOWAdqD9dQ1/YyZFzqrG2olw/bgsOeRwdTgoKR87JGGx1qV6CvQPdO2ksP/l+RkAhg
 vk7sJB6350/6Y4OlTPjoE9an4lCQoT23bV4wpxn2gKovoK++Kd8eRpo2goV2fB5+v2HSb2R8n
 /rrmtVHwboegMNbKhK4rpvRQgOXppSIvkxLUyn68vgbEAdTaDuxoCvXjmaYzBtEKVLd59M7ys
 PrcIR83xIBlh42sOb376hmHcT1+St3sxr1mXX5soT8N4Y=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1578
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/30fef057-5f06-47bd-8b62-1bb6fc3fb946%40web.de>

>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checko=
ut next-20240209 && time spatch drivers/md/dm-vdo/slab-depot.c =E2=80=A6/P=
rojekte/Coccinelle/janitor/delete_redundant_if_statement2.cocci
>> =E2=80=A6
>> @@ -4100,9 +4100,6 @@ static int allocate_components(struct sl
>> =E2=80=A6
>> real    0m1,211s
>> user    0m0,981s
>> sys     0m0,095s
>
>
> I don't understand what is the issue.  If it takes more times than befor=
e,
> then post the old running time too.

Another test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20240209 && time spatch drivers/md/dm-vdo/slab-depot.c =E2=80=A6/Proj=
ekte/Coccinelle/janitor/delete_redundant_if_statement.cocci
=E2=80=A6
real    0m1,065s
user    0m0,957s
sys     0m0,079s



You can take another look at previous measurement examples.
(The numbers will probably be different in other test environments.)

Repetition for your convenience:
https://lore.kernel.org/cocci/4bd9de70-de02-4fea-9d41-095304edf4fe@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-02/msg00063.html
+ delete_redundant_if_statement3.cocci:
  real    0m17,970s
  user    0m17,754s
  sys     0m0,080s

+ delete_redundant_if_statement4.cocci:
  real    0m13,992s
  user    0m13,348s
  sys     0m0,071s


> If it takes a little more time than before,

The application of a higher level metavariable type =E2=80=9Cstatement=E2=
=80=9D for an SmPL conjunction
makes a significant difference here.


> then that's normal, because when the match succeeds, it does more work.

It seems to be unclear so far how much extra efforts would be reasonable.

Regards,
Markus
