Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F54C77B75
	for <cocci@archiver.kernel.org>; Tue, 16 May 2023 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4EPLS4GFXd7MgG97vXsOjbW8Zj2ZKpFrq1bcpAs+9wY=;
  b=bwreoU8MrlrGX2LExAR/kkEB3+JEXtv1j+AU2IcD7LhaIcspyU/JnTGq
   ezLwSxE+BVwI+AGrH95k1khKTISK7ohmqRsl3Y1JA2dZ7q2mn+U2Dmt1e
   0aNw6tWhhlc8T27BDyysN9yECKUTFTeFNTop6j81R+OGu3ygW2F5rwN+9
   o=;
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
X-IronPort-AV: E=Sophos;i="5.99,278,1677538800"; 
   d="scan'208";a="108335025"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 May 2023 17:56:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6223E7316; Tue, 16 May 2023 17:56:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 12095E00A8
	for <cocci@sympa.inria.fr>; Tue, 16 May 2023 17:56:38 +0200 (CEST)
IronPort-SDR: 6463a7b5_PApa8OUejPSbIXaD8dxgaWZ21wjDx0eRKbGl40/p60myLMO
 L/SDZu/7kHQFOIiuInJRV/bvf+xgOiVXUjdRCeg==
X-IPAS-Result: =?us-ascii?q?A0GNBADspmNkhwwR49RaHQEBAQEJARIBBQUBQIFPgi51A?=
 =?us-ascii?q?1MvBAtGhFKRCTGEM45ziGqDFj4PAQMBDTsGAQIEAQEDAwGCC4J0AoVZAh0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnh?=
 =?us-ascii?q?WgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQINOj8BAgIBIx0BAREmAQ8LDgwCJgICVwYBDAYCAQGCegGCJwEDD?=
 =?us-ascii?q?iMHDAauGIEygQGCCAEBBoFFAgwCQ5l1HywiVIFeAwaBFC2NKoM3eicPgVVEg?=
 =?us-ascii?q?TyDBD6CYgOFOoJnjyeLPoEwcoEjgSmBAgIJAhFngQ4IYoFzQAINZAsLbIE8W?=
 =?us-ascii?q?kOBaQICETQODBUFVQKBBBIBEwMHBAKBExAxBwQ3CxkJBgkdHRgtBl0HLyQJE?=
 =?us-ascii?q?xVTB4FNJQQOAxkrHUACAQs7Oj01BgMLHwZCAiuBWgQvWnYKBgEkJJp6A4M4K?=
 =?us-ascii?q?D0CIIF/xBo1B4IsgVmBXAyKD5UFBhMvg2sBkyQOBpIqLoczkCcgi0iBcZpVg?=
 =?us-ascii?q?XojgVwzGiSDNk8DGQ+OIBmEDYELg1aKZz80AjkCBwsBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 chXIle6fFkyC+9cFUlvWtAPcs8fYw==
IronPort-Data: A9a23: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
 R/yN5Ew0tWMLklVeNsu
IronPort-HdrOrdr: A9a23:Y0BIX6xT79VWKGvXncOoKrPwJ71zdoMgy1knxilNoNJuA6+lfr
 OV/cjztCWetN9/YhwdcLy7Scy9qDbnhPpICOoqUYtKPjONhILAFugL0WKh+UyDJ8SUzIBgPM
 lbE5SWROeeMWRH
X-Talos-CUID: =?us-ascii?q?9a23=3A76/nB2hqOkwif6PLk8VNZCf++DJuVHzH11zyegi?=
 =?us-ascii?q?BFUFjT6yYYEK7+bx/qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AO2NDwgzqcdavvowmVMl1hi9Vc0CaqPiIMVJdi7k?=
 =?us-ascii?q?AgvbeHyhqYhTDrj2oerZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,278,1677538800"; 
   d="scan'208";a="108335016"
X-MGA-submission: =?us-ascii?q?MDFVSFfkEA0K0xApXJ9h/T72MCyP+HI5nEl/D/?=
 =?us-ascii?q?TQxplhnZmki66ej9REBWMGpbovG4/S7EgwmqyLrLWCykEAbrvsCXM+0+?=
 =?us-ascii?q?3F7Fw+nxAmdytZc6I3McdR84dIYJS2V62felrSQ6bhfbbhh3uB8/MI+I?=
 =?us-ascii?q?QvkMYTBtbHdCXSLpW3ExHNQQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:56:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684252594; i=markus.elfring@web.de;
	bh=4EPLS4GFXd7MgG97vXsOjbW8Zj2ZKpFrq1bcpAs+9wY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L106HnnZ6G4GDLqK1ClXcicW4jD6ypEgYPUXsqCE5ES6oWviYwUjLtkkhfwg6PWDi
	 WmDlQBfeVkVNh7dvlqfCKPBo+YaIFCtqkJtL8rcuJR7DX4mzw2u56MSqqHrICVOnaH
	 D4e6GXWGEKspqa4cZZZL/ag93VH9VT5uSI2+WkSPjI5VTN2hI3rwy9pMkBDYxHe163
	 D2BVQJ+9k++g1KU3LuucYAYCPY+fxotMUL9w+UF9fkUe1Vti5D5p9Jy7V+A/+M3+08
	 ptJjERMRqyg/WpV0yuXKKZ9eLy6yBFNpQjNPY+bWTmruWjMeMqSLFUX5rzRNVJ19gP
	 RaFmPOX0dZ+fw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyvBA-1qKLVA3KEs-00vu33; Tue, 16
 May 2023 17:56:34 +0200
Message-ID: <43d14ca0-b69f-4f80-86e8-79165345429a@web.de>
Date: Tue, 16 May 2023 17:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
To: Nishanth Menon <nm@ti.com>, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <kristo@kernel.org>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <f1eaec48-cabb-5fc6-942b-f1ef7af9bb57@web.de>
 <20230516152043.bq2hnessstrhbc6s@distort>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230516152043.bq2hnessstrhbc6s@distort>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OCVcSJnL2DDFw5R0i6U1AnSpZ3hoyyVP3TsuizVD+4cq5uc+1Ig
 2uoE7OO8Hr5RlkerCRGqTTt8JoQbMzQqUkr9NG1jDU99hRJTew8H9777xgOu5hV6vo3Z24N
 Ksrql6pOxENR8VHXHyidLTcgLhzxdHnug5L/cpKC4m7dKa0sjf6vD4FwNgAe7C0QMJE4izV
 uLzHWE+Ey+SIwwCpNv6vA==
UI-OutboundReport: notjunk:1;M01:P0:04ImoULC7Io=;11jNmveM+F/dCi5FyfRozXc01+5
 Gmg0y4Gf06/fEhwyc/XPxQ3idGVFNgXIqDB1+h+tRt0abtH3kVh2CqFElrqeNpp46rev1bnVH
 5JtsabE/k9czlGoSwr/r7gfFrL76xiYnsmDY7oqzJUjdVYts4xNn+ZL5SUhEJFC332Bc/BymR
 bfvaoFLQ+dSnidPXcY+kVy6s4+9es174pfbQeEzcKDfG529QokD+gW7Wv0JwDc4gQ0JYV7ZDu
 25ujeoDDIek0dHxTtitEcufoN8kvqnZdXXZsetz3Of6X3US2T3UymyKLp3j8M8FdLgo6h7Y85
 /Cz2ecGOCiDrtQdxwRvohnCBHSHPHg7Sy6LAnVCPNd4MlNIsQDOhoZVM27OjXgsypKYkf798i
 i3dcn3rywIikg/72cJ3+MrKHtP/mxiNiyDQOEdY4tVMy4FnHP009tCojyT9JuwTQo0nzeECiT
 wkG283a7KuzCAFDibLU2Sm9KRxa5MJIyItRSPKl9Nf1ZnxDy8QQBMK+6LVlucCbNjY/Obxrg0
 YqPfRTJQv8epsYt3Fq9YSoA7R6IxFurTRqkXOfhOpLjzXTwcIeoBgbiIDroLNKcj1QluNwCXj
 ANHO1HUthCIhevC07WR5pvDfNsV1o78/c/6wPdqySuAaq/iOA/wMTSsWGGZz+yRlA+w1nJWfe
 k31IntCQXVCUlFvkl3iK0GUfuy1V8KXfuEr0CgJrCR+oZbYO0uTeHxd1mIsW/cFptjU7yBxlf
 Zh40WHR5jJKsnS675h7eD3gBowFaczCl6wrNEX0Nhv/TbwWOXJED0f9PdgHCQ8lZqWbN+Xn6c
 YyJ3XDke6DQ0PTbxkB53IY9ec/VbE2GsqsMRr+yMuG37UTl10X6YXrp61BgE8u8HQgiEesuCq
 19MmEYJAufDKnGO80IV2CNMzLJIfuTO1qpcwyEJ3Z30SeBLPEJy8zR6t5Mwdc5uA1vJ/6SaeG
 0RBHhQ==
Subject: Re: [cocci] firmware: ti_sci: Fix exception handling in
 ti_sci_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1145
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/43d14ca0-b69f-4f80-86e8-79165345429a%40web.de>

>> This issue was detected by using the Coccinelle software.
>
> Curious: what rule of coccicheck caught this?

None. (So far)

See also:
Reconsidering repeated checks for error pointers (with SmPL)
2023-04-04
https://lore.kernel.org/cocci/8f785de5-ebe2-edd9-2155-f440acacc643@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00008.html

Regards,
Markus
