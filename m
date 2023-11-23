Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7593C61D85
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=i4m3HLccokjF6RVdFup4ZnJZIJbSOT45FL8remQLTsI=;
  b=HGsOGQE+CqN2w1dz/CtDGUXFzbENVdWJ2y/ZUFvTgafyMxr4rPIE8CVo
   ZVQXfrJmC+ReBfvptHzXwzJPW2IEqMRf+2BvTOtTS+HNT9L6YQUGPPxVg
   RpZZJGGvNdU8scwkM7lyeXC9OcFbSnjbrVNWWzZefCudELaZnLmvaKG/B
   E=;
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
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138198176"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 19:36:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E714FE0CCE; Thu, 23 Nov 2023 19:35:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AE7C1E004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 19:35:58 +0100 (CET)
IronPort-SDR: 655f9b8d_9X6uiRgeyUJ3k0hSZLU66x4Cy8lozO0qZeY4msslYMgkukA
 UGvm9gwQmM5deDqjor+QYsxmw8JGky61Y8V6iZg==
X-IPAS-Result: =?us-ascii?q?A0FEBQB6ml9lh07ASNlagQmBT4I5elYwBAtIhFOPPYF1L?=
 =?us-ascii?q?YQ+jn6KRYFAPg8BAwENPQQBAgQBAQMDAYR/AocpAh4HAQQxCA4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4KAQUnhWgNglwBEIEMg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHQ?=
 =?us-ascii?q?gMDIx0BAREmAQ8LGgImAgJXGwEBgnwBgikBAzEHDbEsgTKBAYIJAQEGgVdBr?=
 =?us-ascii?q?T0fLCJWgV8DBoEaLogNAYkUeicPgVVEgTyCUjE+gmEBA4FeTYMOgmiGGYMOB?=
 =?us-ascii?q?4Ylg3qLA10iBUJwGwMHA38PKwcELRsHBgkUGBUjBlEEKCEJExI+BIFggVEKf?=
 =?us-ascii?q?z8PDhGCPys2NhlIglsVDDRKdhAqBBQXgRIEahsSHjcREhcNAwh0HQIRIzwDB?=
 =?us-ascii?q?QMEMwoSDQshBVYDQgZJCwMCGgUDAwSBNgUNHgIQGgYMJwMDEk0CEBQDOwMDB?=
 =?us-ascii?q?gMLMQMwVUQMTwNuHzYJPA8MHwIbHg0nJQIyQgMRBRICFgMkFgQ4EQkLKwMvB?=
 =?us-ascii?q?jgCEw4GBgkeBA4DGSsdQAIBC209NQkLGwY+AiefX4QXMC0sgVqTUrF6NAeCM?=
 =?us-ascii?q?YFfgWAMihaVDQYTL5ciDgaST5hAjWeabYFkATiBXDMaJIM2TwMZD445hBKBC?=
 =?us-ascii?q?448QDUCCTACBwsBAQMJhUYBAYNagUABAQ?=
IronPort-PHdr: A9a23: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
 JdcEtezu3QqG/lcBkk3RbQ/
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:eRDy+KmfhaK4ZeRiarZgFtqyp6PpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:s+E5lmEO4Zb0EVdzqmJizWoTPO55QEHZ7yzyDxOUIG1LVp68HAo=
X-Talos-MUID: 9a23:SlWFzQi0+hSOBcDAM1+Op8MpE8d53IOJDGs3yLpen8CbZBYvBgqZpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="72411673"
X-MGA-submission: =?us-ascii?q?MDF3bi7KqvDRvbHudV/uglCTx1FCba6Y9qrSdo?=
 =?us-ascii?q?sZuPGjAgF0nhiOh2HMmTh213PRdcBCvDR7FMEAzlBlMGqe7bucNpP2IC?=
 =?us-ascii?q?SCekCQ4W+eC1pGyFxQY1tpRJD8dQZ9JP2M0rjTAU1fohEOQSP7BMrQAj?=
 =?us-ascii?q?jTjzeaOfP2zimCll9gbaGJrg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 19:35:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700764556; x=1701369356; i=markus.elfring@web.de;
	bh=cq3cBIsdpL5WbQiY3ZVK/eATPnsBrgpjF2VQEkNW/7o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=eM+QDkg3fONWcoQx10GVi/u2yoH3ODgLl5kjc9rRvTw207fSP0a3/Fe8rYo0vZ2m
	 XiSwzv48wFoAL1jWn/KLMpKgQio2heqLI3XNHqeBhMl6QFhDzxmCBl8435AXwTIbc
	 gLjL4oN5vDYOGw0e7FMx8+ntYRrabs1De2RCIIgAwv2av/OR+TGZ8ru/kI7b01DVl
	 Jwd1IAi0W+97V10SSwXYVvDpgDCRrfmQwsczSkDLcdYQyoq5QymQh7asW5DiKdT11
	 XCvcY/2jqrhND0oWPPloOMrjz0na6NCbWN5kIaYL60ZYAyrSgcpB2Ov6/JDBl4bVq
	 4vVYiS00uqCfEt/Ilg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmqC-1r90Fm11DK-00Eu1l; Thu, 23
 Nov 2023 19:35:56 +0100
Message-ID: <2856c52e-f080-4cc3-a823-4bf4a35b7353@web.de>
Date: Thu, 23 Nov 2023 19:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: cocci@inria.fr
Cc: Julia Lawall <julia.lawall@inria.fr>
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
 <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
 <fabb554b-d109-4a77-96c1-a96f31d107d1@web.de>
 <alpine.DEB.2.22.394.2311231846240.3125@hadrien>
 <eb737656-e7fd-4331-a641-bd208b459f83@web.de>
 <alpine.DEB.2.22.394.2311231930330.3125@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311231930330.3125@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pEO3/h9+yNsw7Jl/5zEpEKbfRuj2v5OMmezajmV87Qo+4BQDa6L
 cPEG4Ykwvbf35Td4lqFwk33fL8sBkBp9w6+tMK7A2rjjRgRDZgVxHUCOU30yu0g6jRAZ4K+
 2lHhn2K/ZNkruRjw8ZEdyqclSxQGUorlsL+Fyw4s57tbyGulrS7ekafOChMK1cTY9hV99q5
 gIVdoE8ZvY2dz/bPOWY+w==
UI-OutboundReport: notjunk:1;M01:P0:rDrz3yXSVtA=;6XqXRF56COfjsSt3HUUnfPliNF6
 H0ioSAJO7aHm3hAKXHXnR14BIjeE+v06dme+yZ4KJfm9KCP7I1Adt+dQhRpAp/jMjHe4gylST
 FW6fzCksWGa5/ITJ7fIFH/MbEHE8pNKfFU2uJFTGRp/dLonY/jdrpmtAENMdQ55KjWILH+DWN
 HZ3BpeM4qsOTZAH4pqnGqq9YVZjyz9PkaB+nwd3bwnFYLyCH0NQ1rdzy6vYHtdF8NIJp3RSGd
 WNUgK+KGzl3QKIFyjJg9j33/pXJw6U+P8zZlA4lS/QIsPi+pZxqvaOmPljC5IIb3eYN9pfRGS
 KL1AWuiM5TdtLsYG4Ow6lm35kCjAOfye2G3ajaj2e99wedlxJoesGk5fLXXOjapEP3jDQZnCN
 dmg3XJphd84+00+DdSKUqc25HRQgE8fwAn95aIOp/bCEwNnr8mRWM2fShd9s7WMbDWUfNYFYp
 X+N+AgTZX2+28tboDpecUgcGU2GgJ1ado4eAkXTIitLQ/7xg0MTm0lkbyYkSQlAam6rgM2f4r
 E981sANJx9AaMkTT9n1/D0VpbOH0WStOibGzFFRKbq6n8HKDHJbT8m116nvl9LOCtDptLG51o
 /T25gM64I4yIJVYcnFZl/5TAYGJ3t4gPbh3J3MXUEoWjhPBk9rkwl3q0GV4nSELU7qcBPcKBh
 D4FEoktN1F+bQPVfknfQLCxRlxrbIQbfui7xE3CLqnoxWjQneskjvAxfM/PYV3pE4ChkYjSOe
 x109Y0UztvNgU7h2+I62uTxYVC+UKCMcjttng5LVv7JbHlfIb8YpvDGwoy0s1h3LeL4WCAcnt
 YAq8gnDVxZ/qYz0eWjsTtbjpff/EcDMk71nCsqrRYhe/kiq1H+y+UbZg//4PcQdQZalGLGBf1
 JHjbMvyT6pU2Osy5FN0LU34RL84rY1i5ohAH18vU2kj6oG2ToB+5bbRowvF6VrEVOa27yGIKl
 WKQ86g==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1324
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/2856c52e-f080-4cc3-a823-4bf4a35b7353%40web.de>

>>>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de4=
4e5c21b60d41938d32321b1a/docs/Coccilib.3cocci#L226
>>>>
>>>> How do you think about to provide a function variant which can copy r=
elevant data
>>>> from a previous position object directly?
>>>
>>> I don't see why it would be useful.
>>
>> Would you find any other code variant more reasonable than an approach
>> like the following?
>>
>> @script:python selection@
>> places << find.pos;
>> marker;
>> @@
>> place =3D places[-1]
>> coccinelle.marker =3D cocci.make_position(place.file,
>>                                         place.current_element,
>>                                         int(place.line),
>>                                         int(place.column),
>>                                         int(place.line_end),
>>                                         int(place.column_end))
>
> I don't know python.  It could be ok.

Would any other developers get into the mood to add more constructive comm=
ents
according to shown implementation details?

Regards,
Markus
