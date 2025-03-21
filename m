Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFBEC36000
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0kp3MoJXCrNSZa2csjkbqOlZMS0sEAoJZVc6Cq0RQlQ=;
  b=l8LkidZvg0KCaaebQfl0xU5SJplN5CWhWxsHkXpf7ZXnw85qmgQtBGfG
   mOvv7oykxC0nn3C0Hw1aKh5QF+VburpR1CeaHowgMFtHhV6OfcleIYusp
   /66iSi8rYt+NFy6+w4TOqsmKnoh3fyJNE936yCSIxsUDquFL1JW6i4gY0
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214158033"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 15:53:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 578C7E0D1F; Fri, 21 Mar 2025 15:53:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 27512E007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 15:52:57 +0100 (CET)
IronPort-SDR: 67dd7d48_YO1Xi7gWpg0kF3ACmG29WDzm5f7gw/PeNBVJNyexHUkJ1/k
 qlGb1kHS7kJ0gE2ATAV8MhmyFr+ZqtyNajfTjow==
X-IPAS-Result: =?us-ascii?q?A0FnAADYe91ng07ASNlaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPUYF0MIQ7hzuHU4h1gVaBfg8BAwENQQECBAEBAwSFAAKLI?=
 =?us-ascii?q?gIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQE6B?=
 =?us-ascii?q?w47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJw8LGgImA?=
 =?us-ascii?q?gJWBgEUAQGCfoIwAQMOIweuTYEygQGCDAEBBtpcHywiV4FlCYEaLgGFbIJjA?=
 =?us-ascii?q?YYnhDwnD4FVRIE8C4J4PoRDg1uCaYIzhENniU6IVIdUkGNSexwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSlDAyo0MSOBIgU0NA44KYFjaUk6Ag0CNYIbJFiCKGoEBYEkgjaEPoRAh?=
 =?us-ascii?q?VCCEYFcAwMWDwGDH3Ucg0t1PYRjLVCCRR1AAgELbT03CQsbBj2kCoQ8g0k1o?=
 =?us-ascii?q?zCicjQHgjiBZoFjDJ9eBhMvg3CTVg4GkViBJS6YUCKpEYFuAzCBXDMaJIM2T?=
 =?us-ascii?q?wMZD44hGYQUuyhCNTwCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 uU=
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:NVMZi63vqBw9s0StcJzUGgqjBIskLtp133Aq2lEZdPU1SL36qy
 nKpp8mPHDP4gr5J0tQ/+xoVJPtfZqkz+8Q3WBJB8bEYOCEgguVxeNZgLcKqgeIcxEXnIVmpM
 Jdms5FZ+EYZmIasS+V2meF+7tK+qjkzJyV
X-Talos-CUID: 9a23:CfRm8mC+InO6axb6EzlZ3lU7FN8dTkGHymrsCGKmIGdjVZTAHA==
X-Talos-MUID: 9a23:krgvSQaieDl4HeBT7BLFuSo4Lp5U0YenF2EErIoGvJW7DHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="112268543"
X-MGA-submission: =?us-ascii?q?MDGNVD7TytOJVhNp0tCf1Ipvo7hFui/KzebXEq?=
 =?us-ascii?q?HFGpurEFzrdiJpJVLeTySHeHec/dj9CzGR+ArUKOjymXYTSDdcKjFhM8?=
 =?us-ascii?q?Lu3jCWtxvOWqn6dOKME6z1aB6bC3bW4VSQ9vqrwbC5/tGNBgVFzpOfio?=
 =?us-ascii?q?RZu68D82O21Z9bK3oLfqTg5A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:52:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742568775; x=1743173575; i=markus.elfring@web.de;
	bh=0kp3MoJXCrNSZa2csjkbqOlZMS0sEAoJZVc6Cq0RQlQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UxR00S6GHR4hc/P2FbZKkWy8C3FvzJnnyu5IjbS4wT3ICnmVbkPs0QynVjby7rfc
	 hEfGgiTvDk1ng/vXscMM/Ia80PBz/tPnEH2eGLK32RNd4FkiniGZVaRm0j1c05JDu
	 ilIMw9a2lnqCbqz6+74AvW2AYP5nvfgrSjbiFks0LVnw5WZ+F44E3Yb55ErBv0uBo
	 UE7W1xb3A/PxxtQmf2hEgNn8sNlqdSkSaI3LTa1T1H4B3x4gfDA7sGkN0/SfH+jc6
	 cUyh6N28iO/jMCe3Uu+NHxu7n4+OgpmIefUTbcpeG+vtTqROOd9SruCe/fJiu6JsE
	 AAI1MIfNV5prd3E9ZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.36]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2Phc-1tssaP2u58-004Bfb; Fri, 21
 Mar 2025 15:52:55 +0100
Message-ID: <8e8dcbc4-6614-48d6-98bf-1cc0f5e64bd6@web.de>
Date: Fri, 21 Mar 2025 15:52:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
 <a5c6c5e1-d04f-4a93-b37a-cfc797a021a2@web.de>
 <af3f266-cea-3d1e-6ad9-96fc522db1cf@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <af3f266-cea-3d1e-6ad9-96fc522db1cf@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sMf3FzzIIqixrKj8bCmszL5KWDmwMrZGUJfa+acW6YfccPoiUqb
 6pWOlX8Tm4cdPaTGIKgj6ZHh6w+kEobCxpJs0N8yCKcb5FuYRdzN4WKLpE7NtwsRzDCvLfi
 ceVlMXZRBDZU04MsVxq+CG0dWFVfkYm13hHUZA1a0iUsxhaWhO6p5dAhlkKI4ojmv1AJqFL
 xp+DjlL+1XJj9M8IF/lhg==
UI-OutboundReport: notjunk:1;M01:P0:DRuQDF4bhqQ=;IZecy0/JyYgG9IbISlFA7ivT7mj
 ixYusE+Go4Cf0COAsP+LzXhzUM5vQlwnkRq//8rYx0v7Kqy/4x18/gpic7X059gPv+3v+O5Nd
 Xi8j1uuHn+LOAgw8WaVz50iQnN1WEi5PX/1oyz0s4P803dzA4EuiLGQTPSXdU4RF7vuIjCoPP
 +YqvmMgsWt6U97RdolBdvp2zGbNYexNOF/ZmcU/Z0hBZ0kMeeHKTvy+uhLiHTgEwu1ZKz0juv
 X94UiPyu4eGE2rD11sufctmawDVc7TKB4Kmn2GBI0OxcSgTnzTlYQGdt+6M65Q2JrhChEQpRK
 SksCc4kVajUqJaK2a6ztTSV/b0rbsOcFO6+JY0z96stOzJJIC4ivXIXFPjCx+5YYBPC3HB+2f
 EUOp7WDWc/eNLA8O5GfbnYaEphsUT4NjCqbgyigFg6yW8jAKT2FMeC74iLKB1Q71AoLYNJpvJ
 Y4vwC2NYhX+jFzBc1Wi8DjyjHo/OnSl9G+YgKscJ0+wVhMPMtbfu+t+DOcaRrN5foIee8KNdz
 rq8TiwTPBAnJF6yt3/VXUik5ZdIBhtxnJ231fMpC7zuWrcHOVjJrxhsXcv1hEuyNTzc73Yl4h
 mw0ODswPisko2tGKxg8Mga/lq7G5rjLD5RwpkAuWWXRP2ecMP/797orzUeoDIoDOwKuCcdTDW
 /GCzAGf0kmEUoXNSQ7xrHfnXr7oS/Lb36rRUDfdaSm4dGN9AZr2x00JltPR213o2r+znrozFY
 zCMZxkWFN1Cm3M8i1iPlOMDEmR85Q2C0bmmWko2j7vKX75HEjCeugkSW/iS7e2NSyP5gomiWx
 TcHGNy03MJ9HiYOFuRe8X/UGrNzvhG6o1OkqNF8GJHEohGl/nxFnrfTRb4jUBnY2tb8lbhMys
 uITLlRtCSPY186HimN/HMxGzd/K1jidMWLoAC/1ohvLR7B7vVZ0MbU4lCT18BrUWf7H8ikGEB
 Le+2wIbAEve4COam3oI98y/hSgMiT7HzHAj2Qil9xU4IfVnxKt0L9pyknEinBMD1rHoHfE7bE
 gffHZXSy9HjCSJULtSDGKx+sMnQrERimWwWAk6Q3y4QuEx9YKwnKPL8LIJ1yoD2wmHJXL4Bmc
 ZUpM/ewty+ppBGyNnPm/BjAnGibA4v6qD1D6cQSrzuiSgZi7WZbiQZizHTot9KA3aLnQGCu/y
 /+WC9vb3+Vn2a8UP/afPZPoofnVErpHPfohMGn61DxxH/auvl6dLP2rUl6qre/QTKY5ejXTSC
 2dgP2mqy4EqHXumyYnX48Yj5uq9MCxN1LX0KFq8DJJHKILl1Y8Dd0mpD0/8gDDiaPvy/FYiom
 V8nzByszhiXCOgpHrCeCTYe2uz92/Nkwfy+sWzYTwsYbhrwuWkcRvg1gtAdInJFTUG/371O3N
 YVDKc012OUGO9sGi9CgP04PVCcsnJtiavI4V6d1X+MBJV+fj/kzWac4YVGLS5EEEgCOQBrDA5
 EV303o56quEA40PZaNm8t3Q8B1iqFB2VFqHTmWCGtVh8AH6ka
Subject: Re: [cocci] scoped_guard
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2675
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/8e8dcbc4-6614-48d6-98bf-1cc0f5e64bd6%40web.de>

>> Does this language construct support already code blocks which would =
=E2=80=9Caccidentally=E2=80=9D
>> be executed only once?
>
> An iterator name matches something whose control flow graph contains a
> back edge to the top of the loop.  That is not the case of scoped_guard.
> For iterator name, it doesn't matter how many times the body of the loop
> is executed at run time.
Is there a conceptual conflict to resolve for code blocks where only one =
=E2=80=9Citeration=E2=80=9D
would usually be performed?

Regards,
Markus
