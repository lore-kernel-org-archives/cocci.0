Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2DFC25B75
	for <cocci@archiver.kernel.org>; Wed, 29 May 2024 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SwT1Hi3zkUc4mbxavJdwDIU28AlHdArcSEl5zkC4c2w=;
  b=F5OFKIoO30UDBFffV7NyaMY6yo2yAZkKoDdguODmI6uW2lItsc8H6MNa
   vMEkDSG4dlbOAnaFFkNBeX/2n9KvCXnOtpRSa/3N8i7EMZHEsIBYfgmTk
   KzY3iJQ0S1erXyrw+w8rVRZsbKbd/PGmS32jMdNzVwkFvnBPDNgyDwPHc
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,198,1712613600"; 
   d="scan'208";a="168023137"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 May 2024 15:24:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2DB08E0CCC; Wed, 29 May 2024 15:24:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5EC16E004E
	for <cocci@sympa.inria.fr>; Wed, 29 May 2024 15:24:09 +0200 (CEST)
IronPort-SDR: 66572c79_WkTyTblN70t1qdYHYMjRx0heytbRvjHQ7TurdtgdQi/ghtw
 Kanu4HZ6C1JxPyi9yN2dgGgz1k7wnD7f46AyGpg==
X-IPAS-Result: =?us-ascii?q?A0F3BgBkK1dmhwwR49RaHgEBCxIMQIFEC4JEfAZUMwQLS?=
 =?us-ascii?q?IRWj0iBdS0DhDuPCYhxgVaBQD4PAQMBDTkIAQIEAQEDBIILgmoKAohOAh4HA?=
 =?us-ascii?q?QQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ?=
 =?us-ascii?q?4V0DYJnARCBDl5IAQEBAQEBAQEBAQEBAQEBAQEBAQEBFAINOiIBHwEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICVgYBFAEBgnwBgi8BAw4jBw0GsHmBMoEBggwBAQbaW?=
 =?us-ascii?q?R8sIleBYwMGgRouiC4BhXyDRnonD4FVRIEVJwuCeD6CYQOFOoJpjyuHJYMTg?=
 =?us-ascii?q?iaKAYc7VH0cA1kyAVUTFws+HQIWAxsUBDAPCQsmKgY2AhIMBgYGWTQJBCMDC?=
 =?us-ascii?q?AQDQgMgcREDBBoECwd1gXGBNAQTRAOBNwaJagyDBwIFISmBTCmBIoJ4CDATb?=
 =?us-ascii?q?BWBCQKCZYFrDmGIGmOBEIFEgWkBUWMdQAIBC209NQYDCxsGPaYPg2JlPQJUJ?=
 =?us-ascii?q?4FCpCKhITQHgjaBYIFiDIohlScGEy+DcgGTRg4GkmiYYyCNVpsUgWwDMIFcM?=
 =?us-ascii?q?xokgzZPAxkPjiEZhBSEYccDQTUCOQIHCwEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
 JdcEteztXQwEe4GTFtoFpoOLcUvNg4=
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:H0kqOakK+kNt0y/02ENkvxlRbRHpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A2oJWsWlUHZ0U4oFhVOXdXAjJ6gjXOXDwyyj7DUy?=
 =?us-ascii?q?/MElCapipcl3P8fpqzdU7zg=3D=3D?=
X-Talos-MUID: 9a23:fBA7aQTWDJVlk3I5RXTnth1fDuQv5pj2M24BzLwBhce8bBNJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,198,1712613600"; 
   d="scan'208";a="168023136"
X-MGA-submission: =?us-ascii?q?MDFh4cv56IdHJ2Ezwua/1Uh3PiW3mXQH9nhHSX?=
 =?us-ascii?q?FLBW2NCqnsdGZYQjGgZBnyByHNLmrDRkukyET2GFWp53uFUmoOZT4+mF?=
 =?us-ascii?q?gCCWalqifZnldnrnQcXwACz/AgfGZI0PU0JcWO/PTA0IsBwqefU7KHDU?=
 =?us-ascii?q?29k/nxsM1P7LMRkpBCSh7Wpw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 15:24:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716989047; x=1717593847; i=markus.elfring@web.de;
	bh=SwT1Hi3zkUc4mbxavJdwDIU28AlHdArcSEl5zkC4c2w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JQmuP/eCQnt8HdI6X2HdvRLQB0OQmplUUuuIe5TJfRSCf2Ib/RZNTnL0fY/3fr7p
	 xETDGgju6ESKWSonJSBE9PCSwSGXTB1TI7ES9VhOrhUFU6sl8fiDH7Ichjd8fmBnP
	 Phd6pLBeRctJvkyQ9+zakG8Pc/E+ihBXJp1onjatt+HpCd301ox2yOF8nhW8IvSh5
	 nMh90pY2q2/QvBh0XleUW2ASIOCV7SGSniPpkFiCzF9aYbIiQ3OGax63jz+wbX2n0
	 GfTa3uotJBFLJpNEkbIe8rSdmhcbKh2xcH5H1RlLpE+fj7EnpMTzChEFbovx6PngJ
	 g19jdAUHxIa/CW2NlQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwA1O-1sT0kt3MAO-00s7Xa; Wed, 29
 May 2024 15:24:07 +0200
Message-ID: <e6de2b59-c9c5-4714-8a4d-5c5970b9fad4@web.de>
Date: Wed, 29 May 2024 15:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Dr. David Alan Gilbert" <linux@treblig.org>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
 <2dc6a1c7-79bf-42e3-95cc-599a1e154f57@web.de> <Zlckg1LH-2TBew85@gallifrey>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Zlckg1LH-2TBew85@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5c1FsYEM2NyRYaw/Nu20egXTNsqmT3g83WjusYE5ysIbm+Wz1ki
 5Cu547w8aJIMTPjT/BJkwMu7wu01571xrD5zaqqVvs/zbtP4/MXIT7B2CO0e829ysHtKJ+E
 AYvWB9TWjKLhnmrgcS9FQ3iJsxdbH8iNXudN+ZSmJNTjIVuSQxDbm1LIFRCvb/UUa/qhdob
 SQG2lLZdM7xLvfsrhl9Bg==
UI-OutboundReport: notjunk:1;M01:P0:X7T1phtB/XE=;2Qo+xjwzbwKG+ReQhZB6LgfLuUh
 uvJy4ytbb81gRiYRToViLfScMBHGsp+d8a7xjrEXaX3hO/f8Oo49ymM6WK1Rn7QkazQTeCmxa
 2Qf3c8MG5iZvdqvxZSTo+UfZQmti6DKGUFKcGniI561vx4e1sai/e67RdwQ0VviiOdiJzMQy6
 xLvwvgf07YxJexjG+ThFwh/RLGzjp9xXNaXJmZoW4Odd7z3D6jhDOFfOuqbRx6vToctZ3mvZT
 ctXNvsHIHz+l0Be/Y3AYgD8u5snA6jxvuM9dz3wGzCARIyr/oMlzIZ+RCO+1ppvOWDsFJ94Ok
 TbcFXbSsgm2G9hoCsUWEQK5sAAV6BYVzZtThyQoTqqVlyfeNx20F1msJBoKZBZNka2yWv1rd2
 D73pkpwqlkMK7i6Yj7ii0PlXqAqQAAKhaaIqBQzabT+Xkx+Fb3d9RSRerFX26fYbBTuFNNkdA
 +rgMaORF5fc5Ubr3/MMKi51dL3bEwfDCrfWB62cvrIFGO6lsgJgr1vCCCwW2lEjk6yqP0Gsmn
 gd/ak6OpNm/gSpVJDDzefaG4UibTATQf+7vMtdBK+ivKos7lZiNF1nb0KRPNmQYU8nhqrBhBe
 w4Gc+0hTSC5eHazF74JQ6whXQsP88YOxWT5ia0gO8vOZUfeehp9Ri9wY35RO01X2Ran75EQVJ
 VqkSYAuFgoLOtJTNlC9Im78b1aK1bIB8seR+o5wy24gO/V9OMNwRzi+bX46Q3qJSdOMojMnOR
 8nhUwyJmWO39L0CiAp+Dy9iw4bNTXrP66ISRuTTmORh4reWu0I1XLf5XncbaOKMtggr+Wz3/N
 Kai0WW14KEeyYDrPCbXPYDA8SJb42gIO7eJ8m0hkvPCPU=
Subject: Re: [cocci] Looking at guard usage (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1767
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/e6de2b59-c9c5-4714-8a4d-5c5970b9fad4%40web.de>

> Is there a way to look for functions that have a lock, followed by unlocks on
> multiple error paths?

Probably, yes.
https://cwe.mitre.org/data/definitions/667.html


> IMHO the nicest thing with guard is simplifying lots of error paths, and
> innevitably someone forgets to unlock in one of them.

Would you like to improve the support anyhow for more complete and succinct
resource management in affected software areas?

Regards,
Markus
