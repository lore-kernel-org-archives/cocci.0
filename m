Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF60D13577
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kJ7GauC342yF2Ra/YK7JFp0p1fbcGSK8C8yuAPwkaNE=;
  b=Z5BKXc3VS0wPbFwidC3RT+DmSvGWu1cVC6hiw8+WVaLBZDCL+v87wx49
   JZhHQezdTe6TxyH8TKktBFTL08AcaOeIH5/rjECFRR/SgI+OYMWf2OvWi
   JGDt89tL/Z6sFZrems/NQuF1skquhwqoAQgmXwaElIKLIO08TEYbXJ94n
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190932558"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 19:00:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8A6C2E0D1F; Sun, 27 Oct 2024 19:00:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DADDE00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 19:00:12 +0100 (CET)
IronPort-SDR: 671e7fac_yjZZ6jR/DX7BSfs3PBo9jIPcJpYmi4YfbkZcdFBiOWQMpKw
 6AvBOLWnmPx0XkAvjr+2sLC9TIabHJt4Ud1QKNg==
X-IPAS-Result: =?us-ascii?q?A0H0BwBdfh5n/xOg6VVagQmBVYJCB3ZaMwcISIRWg0+OI?=
 =?us-ascii?q?qATDwEDAQ01DwQBAQMBA4IMgmoBCQKKJwIfBgEENQUNAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAoEKCAuFNUYNgls7ghYsDX4BAQECASMVRgsLG?=
 =?us-ascii?q?gImAgJWGwEBgn0BgkEjAwSvQoEygQGDHNsXgWYGgRovhWmCYgGKYBcQFQaCD?=
 =?us-ascii?q?YE8DoJEMT6FEIMOgmkEglGIAokhkUNSexwDWSERAVUTFwsHBYErJi4DhUl/g?=
 =?us-ascii?q?TuBUwGDLEqDRxyBRThJgk1pSzoCDQI2giR9glCBJQQFgzqCNh1AAgELbT01C?=
 =?us-ascii?q?QsbQ5tQR4JGgVqBX6UjoWqEJIwWlS4GDwQvg3EBk00UkniYd6khgX8lgVlNN?=
 =?us-ascii?q?ASDIlILDg+SG8xJQzU7AgcLAQEDCZB5gUsBAQ?=
IronPort-PHdr: A9a23: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
 23ZqZhzoAP/+tQ=
IronPort-Data: A9a23:ULJGa69BAf1tWTJ2bMpODrUDtX+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 zRMDTqPP/7YZjb2ft1/Ooy19EJTvcfdyNEwQQFt/HxEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWctWo4ow/jb8k825K6t4GpwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE3/9vJkEtJY8j3edrPmZqy
 dE+KjouV0XW7w626OrTpuhEncE/NI/rO5gDoTdrynfEDp7KQ7iTHuOQvoQehWlowJkfdRrdT
 5JxhT5HYBnabh5nOVEQE5Uw2uyvwGT8G9FdgAvE/ftsuTWPk2Sd1pCqO+PKJd2wSf5LpUqG/
 3770UvVWwMzYYn3JT2ttyjEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutGij1KmHdJYM
 FAPvCEp67UxnKC2cuTAs9SDiCbslnYhtxB4SoXWRSnUokYIy251x1ToTwKtrPQ9sdMuAzwtz
 UOS2djuQyFs2FFQYWzI7a+a9FteJgBMRVLupwddJefG3zUniII1iQnIQJBoF+iojbUZ3Bnul
 iuSonFWa6o71KY2OmbSwbwDqzGqoYPOQEg+4UPKXQpJK++/iJGNP+SV1LQQ0RqMwEt1gLVMU
 LjoVvVyNNwzMKw=
IronPort-HdrOrdr: A9a23:kPFeZqv6ip6RegcLrihI+cyO7skDTNV00zEX/kB9WHVpm6uj5q
 WTdZUgpH3JYVkqM03I9errBEDiewK+yXcd2+B4AV7FZmbbUQCTQb2Kg7GP/xTQXwnAzNdS0c
 5bEpRWOZnVMmJBgcH22gmkH78bruVviJrJudvj
X-Talos-CUID: 9a23:uT1mwmyW1Oy1/FMeLW4HBgUIEMEPcmbFzkz3IlOHDkJVZZuXQ3yprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AX38Lqw7xDMTg7ZgoCy8L4lHnxowv6J2xV0E3na4?=
 =?us-ascii?q?YgMWabDBNFRix1SaeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190932547"
X-MGA-submission: =?us-ascii?q?MDFM1AxD9VMJPt7AXMbATkRiaCDHVQk/rr35rQ?=
 =?us-ascii?q?tKOkXxxHHNiAG8De1zwt58Tx1dWEd4b+rgiLz+jwkKxXC+qJ3PhDJ+Nq?=
 =?us-ascii?q?kHTGEANiiUTCuoJV3HMVDX76FDScqW5DRYbuYKVeo1KlVwGYk/TdkMdf?=
 =?us-ascii?q?2y66DJiLn2Kq0dBIkq6fyEaw=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:00:10 +0100
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t57YX-000000006tQ-2vIR
	for cocci@inria.fr;
	Sun, 27 Oct 2024 18:00:01 +0000
Message-ID: <b776e513-b4f4-464a-a4fb-81a441e70e10@knosof.co.uk>
Date: Sun, 27 Oct 2024 18:00:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
 <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de>
 <alpine.DEB.2.22.394.2410271833310.3498@hadrien>
 <f63293b2-94a8-4c2e-933c-5b2f94f64bb2@web.de>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <f63293b2-94a8-4c2e-933c-5b2f94f64bb2@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1952
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/b776e513-b4f4-464a-a4fb-81a441e70e10%40knosof.co.uk>

Markus,

> How helpful do you find the following information then?

All these questions.  Have you finished reading my book already?

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

