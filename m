Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183F1C6FD1D
	for <cocci@archiver.kernel.org>; Tue,  4 Apr 2023 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XMgLFCxH+9eHVR5T/NQyRpVF2N7XZ/luCn+cnyxgeSQ=;
  b=JMUTCPO4IUYrVSa0oxWCs/P0J9SES1xZP0agU9Vu6EpPafNMKKLZRDsr
   E6Dcno3QgaAKmiJBYD7RaOvicWkgSXnCn2URm+71OFkajexOrFhfaEFVj
   DdOrlvHVkFqaJvHRLb8nsEA1wfm8h7aeb+ILg10TfFhX12R2LMMx2oTHI
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
X-IronPort-AV: E=Sophos;i="5.98,317,1673910000"; 
   d="scan'208";a="100596969"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Apr 2023 10:34:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DD0A3E01D1; Tue,  4 Apr 2023 10:34:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 254CEE00CE
	for <cocci@sympa.inria.fr>; Tue,  4 Apr 2023 10:33:56 +0200 (CEST)
IronPort-SDR: 642be0f3_TEOy6v/GRTCIuIAQt7GVttntGOGfYN3b65/PrOIv/vJPkNN
 WJXYKP2gNiwzYuqJJ6hfyhawqKtVGyQOwGRzGuw==
X-IPAS-Result: =?us-ascii?q?A0EvAACQ4Ctkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItdVYvBAtGCIRLkQGEYI5sikCBQD4PAQMBDT0EAQIEAQEDAwE3A?=
 =?us-ascii?q?QaEQQKFPAIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQECR1M9AwMjHQEBESYBDwsaAiYCAlcGDQgBA?=
 =?us-ascii?q?YJ6AYInAQMxBwwGrC+BMoEBgggBAQaBQAEVQZlzHywiVIFeAwaBFC0BkTcnD?=
 =?us-ascii?q?4FVRIE8glMwPoJiAQOBXoNbgmeOOIJ6iDYKgTR1gSAOgT2BBAIJAhFrgRAIZ?=
 =?us-ascii?q?oF7QAINZAsOb4FKgn8lBA4DGSsdQAIBCzs6PzUJCyAGWGsCLBETBQMLFSpHB?=
 =?us-ascii?q?Ag4Bhw0EQIIDxIPBiZEDkI3NBMGXAEpCw4RA02BRwQvXHwKBgEmJJ5fWYFRb?=
 =?us-ascii?q?DrDAzQHgiqBVYFZDIoNlQAGEy6XCQ4GkiWXcI1TmkmBZQE3gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIBmEDIELjj0/NAIJMQIHAQoBAQMJhUYBAYV8AQE?=
IronPort-PHdr: A9a23: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
 chXIoI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:R3mGTK2K38XfJc+nJHgUjwqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,317,1673910000"; 
   d="scan'208";a="100596935"
X-MGA-submission: =?us-ascii?q?MDE+uKA0hExXk83KVM8o+pztHkuJDPpp2SRO8R?=
 =?us-ascii?q?NwH0itCLNtjs2CYN/szE706XppdkVyEnzZ8izUd5Bb+s3z+iGsCKhCtK?=
 =?us-ascii?q?VbnFf3irXnEkHd+GpZKmWl9D7hPOPhXQIL3UUCD5nxQNbKmvQwgX0QPC?=
 =?us-ascii?q?T6UdqvuMcTPEK4LbMiIy9xBw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:33:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680597235; i=markus.elfring@web.de;
	bh=XMgLFCxH+9eHVR5T/NQyRpVF2N7XZ/luCn+cnyxgeSQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=MvXCcAPjUpyMI89r9My4ttjVu7QdWG5dYt8T9kVAFTtVMGxLBLE5fR/vy8ZOose57
	 PZvrl/yrb8zMD7cfXpYdstU46X0gg1PalNdNW4wXRDJqQwUfkdFofyNYAINLH8XbNx
	 CT6QkqhSxxdJihaId+YCTsGOqy1flDjr6GlwRwKJQMiNoUFQI6Tx/T/00nv2Hnsthu
	 VzAawkz20X48GORWAUHKQmkEZ8UoodJB/o2b//W65LEJmx/DmFRHYJN92UBmJq8zrC
	 aeNbzlaGYs5mkXUVEdQ4WrjIeLKiW/iEZGaZybSKM38R60WbC6A2WWn4d5EM69zS9f
	 r3EyhYwK7T8Kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElVH-1pcBRo1JrX-00G8Lb; Tue, 04
 Apr 2023 10:33:55 +0200
Message-ID: <b5a22dcf-0bd2-c268-00d0-caf28347c704@web.de>
Date: Tue, 4 Apr 2023 10:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <4bd84094-5838-c630-d1ec-d2d6bd0380ea@web.de>
 <b59a8472-95df-b592-78d6-9543aef463ac@inria.fr>
 <58d22807-63f2-da0d-e1a6-84210cb81e66@web.de>
 <30f398f2-1394-b67a-4ca4-ab6118c549e4@inria.fr>
 <5a615033-fa79-67fb-c892-bdd8e6f47d80@web.de>
 <54b3a612-6f31-d3be-507c-d17ff1446574@inria.fr>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <54b3a612-6f31-d3be-507c-d17ff1446574@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KAO+0M/EVveenpC0isyde0sU2cP2cISG4miRAJxdQGtyCKQ4wFP
 SDYw7f5mSXV6w2JY4H2VkFslP3EjbS7ItNVTB4hEvZXgP+f1jvL6nmcw4UqtHLs+HsnET2P
 4NPejiB8jbUegt55KHURpXX6iO79ZSpXioRmt9WDlN26K5MgBwuzm+PdppSKGtr9tEHu295
 MLK4z+jwiAo7v2se5n0Tw==
UI-OutboundReport: notjunk:1;M01:P0:B7gbioTlasw=;C8jltHwKWJTvl582EmcIxXgn+av
 wkYYQOqhxhayso2VChUhcjIciZ+OGjiYyE2bzkcKbZfFFd5Mkz2dQPXDfGUEN0/FrR9WMu+/o
 H/5LhXzit3hbkbnTbKTl+FpFWrLpEwZUnic8l75U4wfbltYgvotYzQPQuy6KgalHmMaHySo8C
 OB6kBUVfLUFBxmzvcSrbLnyFUGhwuQtPykRCLiOn8Dq/ai+MgUy8dEoVNKaA0osJtbjVPlMnk
 pOadz9frKIsqtu0NABOTwpB0tDC8nuEeNbk8sg73/cA3Pqmez3ur49+yXBeKabnGd7Yu9Prvt
 eiMYlISsOPhNnoBQoxN49YRE2N8+/u7IrsEz3VQV3viMwDfqtHWhI3bIMJYaeG2T/Urk+//Ci
 fktFjVCPUK1kvQhnE9CtBP2+udtsBVn+QkRK/cS1xt6SGKCIvcRs0PwpgUK7sAAmnFbjpWTC9
 E/TSUGDtaifl8oTchYYxw952RIJVqLIMFfRrT4aj9rjctVCK7EWtMgJbQQrD7Yg1EyERjLdbe
 xVb+mByninRFjHoadJ+7P7vdpFFxf0iGwGKtkyB/Osa/WEdKgVi1kyA7BjyYH29MitJV/73UC
 GZ1Ds/J/v8F1+i4p6e6W2umr/lA8AV32ebUHAL3LBdIuHUonydxTcevnBVxLXNik6ozghuJMm
 0cBMM3s2EGsQBxjkAAAc/sSJLNUidK9UFH5kJq4xdXtSmCOgH+B/T1RmJOqfR/poL+FOpmJRR
 AIxBv20QQp4e4mkQtlcKGGd+E/HGlZjFyTcID6mNc4TIBYk9nzjkR8l0vxEg6HM1uolyHbTth
 EYwBuExcC9Ww6veWgvghTGp68FxO1Khkdk6cYDhEphbxdxLEELVyD8rLzNZ8jXIDei3Wk4JA3
 PyMqVMJr08Z/r0JL+T7NvrOdbI+kF9AakaQEddB+BhyPA+aj55teIQKTA
Subject: Re: [cocci] Completing support for fork-join work flows
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1003
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/b5a22dcf-0bd2-c268-00d0-caf28347c704%40web.de>

>>>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e910982fe0830c9d=
ccc9a8d3a4639484947a7559/docs/manual/cocci_syntax.tex#L658
>>>>
>>>> Would you ever like to distinguish the scope for such actions?
>>>
>>> Why are you referring to the section about metavariables?
>>
>> The description starts for the elements =E2=80=9Cinitialize=E2=80=9C an=
d =E2=80=9Cfinalize=E2=80=9C of the
>> semantic patch language here, doesn't it?
>
> And?

I suggest to care occasionally more for the distinction of items like the =
following.

1. SmPL main program

2. spatch child (or background) processes

3. processing threads

4. tasks

5. effect handlers

6. Multicore OCaml


Regards,
Markus
