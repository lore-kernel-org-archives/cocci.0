Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61720E8FDC8
	for <cocci@archiver.kernel.org>; Thu,  5 Oct 2023 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aO86BFEdjLRKJWjBrRb2XyM4TXdCNwliOyiutaI+trY=;
  b=elBsBKwxRgM7iHCQXdbbLAQdfkBCaigk1whT5TIXKgmhXfM0qDiYu5TI
   iZZcfhvzlAoWmo5z2v9A8L6jqPa+HpFrmPvbu5Y4nENFoH8IpM5OuHBGn
   QomoisZgTh4Hvp1Y5jKxuTf2PAxFxVmSuDL+Z6lP0Ut4/X0NAt0m8fo0E
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129632751"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2023 12:18:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6B0E6E0CD8; Thu,  5 Oct 2023 12:18:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E05B6E00B7
	for <cocci@sympa.inria.fr>; Thu,  5 Oct 2023 12:18:15 +0200 (CEST)
IronPort-SDR: 651e8d66_A73POZI7rnTxj0lnY4nIJmTwKbduQVBsmYPIrtAtBr4SrJa
 Hptz3/Iq4AZA1zoFJo/v8Z+NmwQNqZvqHKdup3A==
X-IPAS-Result: =?us-ascii?q?A0HLBwBkjB5l/wwR49RagQmBT4I3B3MDUzAEC0iEU488g?=
 =?us-ascii?q?XaBBYNmjnyIboFWgUA+DwEDAQ05CAECBAEBAwSCDIJ0AocMAh4HAQQyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNgjcrARGBDIEeA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFwINOkIGIx0BAREnDwsaAiYCAlcGARQBAYJ6A?=
 =?us-ascii?q?YIpAQMxBw2xDIEygQGCCQEBBq9UHywiVYFfAwaBGi6ICgGENIEdhDUnD4FVR?=
 =?us-ascii?q?IE8DIJ4PoJKFwQBgV2DW4JGIoQFliphERMFQnAbAwcDgQMQKwcELxsHBgkWG?=
 =?us-ascii?q?BUlBlEELSQJExI+BIFngVEKgQY/Dw4RgkMrNjYZS4JbCRUMNTkUdhArBBQXg?=
 =?us-ascii?q?RQEah8VHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRwZLCwMCHAUDAwSBO?=
 =?us-ascii?q?AUPHgIQGgYOKQMDGU0CEBQDOwMDBgMLMQMwV0sMWQRoBA4DGSsdQAIBC209N?=
 =?us-ascii?q?QkLGwY+AiebfW2DJFIrxw80B4IxgV6BXwyKFpUMBhMvg24BkysOBpI3mDcgj?=
 =?us-ascii?q?UKaaYFqATWBWTMaJIM2TwMZD5IYM49IPzU7AgcLAQEDCYVGAQGDWoIoAQE?=
IronPort-PHdr: A9a23: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
 klQqY4=
IronPort-Data: A9a23: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
 28aS95O/qF8S5eZd68hYfSo4laFXOQ=
IronPort-HdrOrdr: A9a23:Mw2tWKhyH0OpmOjzgloS361pvXBQX1l13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwXpVoMkmsjKKdgLNhdItKOTOLhILGFvAH0WKP+Vzd8k7Fh6ZgPM
 VbAs9D4bTLZDAU4/oSizPIcOrIteP3lZxA8t2urUuFIzsLV4hQqyNCTiqLGEx/QwdLQbAjEo
 CH28ZBrz28PVwKc8WSHBA+LqL+juyOsKijTQ8NBhYh5gXLpyiv8qTGHx+R2Qpbey9TwI0l7X
 POn2XCl+ieWrCAu1PhPl3ontprcejau5p+7Qu3+4gowwDX+0mVjUJaKv6/VX4O0aOSAR0R4a
 HxSl8bTr9OAjXqDyqISFLWqnTdODpC0Q6Z9XaCgGfnl8H4Xjg+A8pEiZkxSGqp12Mw+N57y6
 5FxGSfqt5eCg7Bhj3045zSWwhtjVfcmwtXrQc/tQ0sbWIlUs4lkaUPuEdOVJsQFiPz744qVO
 FoEcHH/f5TNVeXdWrQsGVjyMGlGi1bJGbxfmES/siOlzRGlnFwyEUVgMQZg3cb7Zo4D51J/f
 7NPKhknKxHCsUWcaV+DuEcRtbfMB27fTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPIcFyZMj8a
 6xI2+wdVRCC34GJff+oqGjqCq9PFlVdQ6dtf1j2w==
X-Talos-CUID: =?us-ascii?q?9a23=3A1ei3LGhTTgkbXX6MCNQr9yqYsjJuXGHm8CnIBne?=
 =?us-ascii?q?DIEE1ara+YFWByIZqnJ87?=
X-Talos-MUID: 9a23:H0OwiQaCMZnjMeBTjw3h3Cs5OPlSvKmNBUAuus0hvszDOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129632742"
X-MGA-submission: =?us-ascii?q?MDFiYXLVBibngbnNqZ/ttVHNiAsKrYAszyywhC?=
 =?us-ascii?q?lwRTvS5b/PuDubEjHEA715l3Upgw0rvTAmgsNuwlITyaq+ThOapdy0U5?=
 =?us-ascii?q?ShoQbJ0+104TqxW3hzvsS5BRl1HUKK83PPXB0bQ3SrfDjwLdz85YlC+n?=
 =?us-ascii?q?hxZKw+J46L5jfH9yGqwu1e6A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:18:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696501087; x=1697105887; i=markus.elfring@web.de;
 bh=aO86BFEdjLRKJWjBrRb2XyM4TXdCNwliOyiutaI+trY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=YHXxPmMcz6df9GRzAmWPZHcOB5yr1u442a0AWHOBPC+OnqcupG5qGEtAiBPpxB9tb+sUYGF/C0g
 mf4aKIbcQDytkc0fc7/h/xcouUPiMZPyC7FEVkqDYPxymh/Cspk+Ufy8+vbSYmQ/vD3ASM2ZGj5JT
 W1lI1bEmpyMgclOKvfcuPwkGC9GNqAtsDBnm36kGGUoMyzZavIp0dx63i+MGMr8aBkMUoTPryR9Z0
 TE4iuIq9X2DuvSitwnfU15TCOsps8nG0jLHDb78dC73OO+HD9/lZUpj0Ap4OZab0jjIdPN1r79TiD
 hgpAkQoG9rqI2XgMvGFv8EdTgiH42Co2FbIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoNV4-1rPeFy3q8G-00oqNb; Thu, 05
 Oct 2023 12:18:06 +0200
Message-ID: <29542ba7-5d13-4089-abc3-5ab314af4fc6@web.de>
Date: Thu, 5 Oct 2023 12:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d71be555-d569-4ccd-9f06-4b33d8095e6f@web.de>
 <alpine.DEB.2.22.394.2310051159410.3375@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2310051159410.3375@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dm4CAAhcpbK1dYINkaD0qIlEMXdg0girbEcEurFsTwOJlYqskwv
 uPZC7EC3nn3NK8sK+Qd5mTyjZ3jdXSkWwAq3tagzwVLdEWB2Ha2uqI47LmtJHqjrH6kRtOw
 NnPgJSVHioQVvSQrGAYq6KGI6hHRIQXuXfNjLY1lQV4UBfVFXci03b7TOoiyvnNTYqzQPUp
 Tt4/MhMf4eC8GZ53jIW1g==
UI-OutboundReport: notjunk:1;M01:P0:UsU8XqcbYdw=;rh8tSHGl0dbnLnjTUfcsCOoNHei
 LfIruMmis5ugNILqisZCFosdqcRhN87WQcQDnQQgn1eGMLfxVbtr5jiGA0MSoH/MEv/ybtlcC
 uu1G1wAZ0HzFDWVthvvaX5JTgjZ3eBT+rp8xoK4FcsyAu0/cyL3JtS5Ny+knflshD5AZoa5E6
 2vDXJ6exZJv2xKmtMSV/VDuoolUoltJRbRtqhXgkXMNXqExfeDGOjpIa87AijPZIcNnDOQTQH
 ABYAQPmlENGRm2E0eSvP4T3GU5EKj/dXe7xze7Dzq6D3GkWc/pa8Jctqvb2zLs5RXyP/s815K
 DoPtn57w1ALJPlDOrdumKYSkbfqlQbG1YbF9XmT9O4g363TD1w3rT9vLnQ106zch55qzTtk5z
 JdafWeeMo+dK+AR7xO+zms42mh71ppwKymhYop8pyB5balI1nv1lTgONpyEnySSm+gDqq8n8Q
 f+EgLSVlLdEbKgcaahUP4yEjIl8yBluuaItRLTxn6L1EG+DrKe9nkRkgjOVvF/tRJh3/7O7/m
 8SSLKNqZSpCOLQerwYjnnfekAIeyNjRHC4Ihmk8szu9Tmg529wVj8y6Wm/CTom1i61lduGdNX
 3NlXPY49BdWxw/INuwDTxDPM491eumnjA+c4+9I7GFwdCX2lLsRIsR3MnZNvEUG6Tlpm/9jiA
 gO+5ic7KYmWbqTpawi7dqIfcJYbrs/gnkhdAukHuYw/lhMM9CKhkBuctHs/IzrZBGYNSMuPvs
 49i8qHW2vrMg3O3kY3yVF4KSY7FQxmx+7QHOdfLz4yhi0J7WHZCn5oFwG2cns9bmTShijobh9
 tE6AZVuNjIwrNkQtMo/lqgbPjWwJZm2LzxLBxR0f8LYjUm7qW6nollGHMEnWwx0FKiijrQ8o6
 pIgvLinFVCFHK2viaxlZpy5t1WBiNtBFH+Tg6UlKzB6bM/bG0CywIFWya/KeYQidMX2Eubxvy
 5HMeWA==
Subject: Re: [cocci] Searching for variable definitions in C++ source files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1246
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/29542ba7-5d13-4089-abc3-5ab314af4fc6%40web.de>

>> @display@
>> identifier x;
>> @@
>> *RPC x(...);
>
> Some dy we will be able to parse more of C++.

Is the current Coccinelle software status so far that the search for varia=
bles
(where a constructor initialisation is applied) is not supported?
https://en.cppreference.com/w/cpp/language/definition
https://en.cppreference.com/w/cpp/language/constructor#Example

Regards,
Markus
