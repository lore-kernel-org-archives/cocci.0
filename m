Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A67C48260
	for <cocci@archiver.kernel.org>; Sat, 10 Feb 2024 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Be4766Q4oHVkNgwUsXouESxbBCcbNL4LXfDB3BVcWXs=;
  b=ESrAp4wQZ6JHW4Ge7uLWGOPjiVN74KYWsoI2D3EGBdCID3pd2MKGOmPu
   9jVtEBnxzkr7k1ocfbpkKonUrHq/TlAxljpBrHgWp7CkrFtBNyJZfW6oY
   n2Uor+AxZeuOXLvyJ1MkzKi7Vxpm4N5c6w7QWx4wuBRYZYH2dOY/juPSS
   w=;
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
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151303752"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2024 11:16:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84B68E00B7; Sat, 10 Feb 2024 11:16:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5AACAE008A
	for <cocci@sympa.inria.fr>; Sat, 10 Feb 2024 11:16:50 +0100 (CET)
IronPort-SDR: 65c74d11_kH8DVQDCnVmfYSqOu/cgH33Q5rU6FmUKqOtQxjCH3vm4zqN
 S68vKcrCLqrC3iTFaz14qWnmbcKfMV6aqLHy/fw==
X-IPAS-Result: =?us-ascii?q?A0HeAADRS8dlhw4P49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YI4gVIyBAtIhFOPRIF1MIQ7hzeHTohwgWqBLD4PAQMBDUEBAgQBAQMEgguCd?=
 =?us-ascii?q?AKHVwIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEjFwcOECeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBI?=
 =?us-ascii?q?x0BAREnBAsLGgImAgJWBgEUAQGCfIIrAQMOIwe0AoEygQGCCgEBBq9aHywiV?=
 =?us-ascii?q?oFhCYEaLgGIJQGFb4Q7Jw+BVUSBPAuCRzE+hAWEGYJogRmdIFSBAh0DgQUEW?=
 =?us-ascii?q?g0bEB43ERATDQMIbh0CESI6AwUDBDIKEgwLHwVVA0AGSQsDAhoFAwMEgTAFD?=
 =?us-ascii?q?RoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMUANkHzIJPAsEDBoCGxsNJCMCL?=
 =?us-ascii?q?D4DERACFgMdFgQ0EQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEAyspAyF0EQMEC?=
 =?us-ascii?q?gMUBwsHeIIJgT4EE0QDEIE0hT6EeQMZKx1AAgELbT01CQsbBiIBHQKkRqQuo?=
 =?us-ascii?q?Rg0B4I0gWCBYQyNcJFIBhMvhAWMeIYxDgaSXphXIKhXgXkkgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIBmEFI9HQjU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qGzP8+MwBG47LJcjBPHdzaXLU
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:CXvOKaCJrZaen7LlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:oHjJ+G1NVXdwzWFxGLg4L7xfCJAjV03g9TTpGFKCMWFPR7S7RmKc0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AxvjLvQzMCOjPqyxaNO7mOELP56SaqJmKLV9T0q1?=
 =?us-ascii?q?eh+KvHzNAGwa00zaKUpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="79276900"
X-MGA-submission: =?us-ascii?q?MDGZdggVVJiUueY2ZYGUEktkgLcF480glmqkOj?=
 =?us-ascii?q?SXIVQDmAdbFOyx3OMem56bCQP4pcHUp+6cP8ABTNrH6ZmOMEJCDRC595?=
 =?us-ascii?q?ryfnf/eQqzhytfVoJ5fP/loXOqM6gDwqiJVrBL+bBVsq0BEubPUEOiWJ?=
 =?us-ascii?q?9IcOZz8FUHlJQ3oVLyyTWPjA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 11:16:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707560208; x=1708165008; i=markus.elfring@web.de;
	bh=dP4/k01nt6dT6vUXlbmotCU5I9rfLoApJRXX/X64pyo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Fh/qgrkALkoX7M1QgJdkdTPtexMVuOawUS13B1bARufK9EGuQ4Hee4zVrdEAUSfu
	 J9hCKZwdI78Vvkq2Z1JfSy1MwLSSTGU+YvQ742PZF8224QpzrlYuJoy42Ws4Fcsdr
	 WMrX2cclKP2RTVhjGmpfDcBNot21p7czn2pmDCzBbwuoJ2l8gUE5ze0BBgJZymg07
	 6W9xud3IHieN0ElAXPcPmhypdK6MCS3pvEo9Bpubebz8aYnjOUSBnet/wuNaEZL13
	 49oxgRs+JfA5MsbzadAcd3Qmkn6aSm5eL8yi6Vko2m2F8F4l/s/IS39SGu2Jiasue
	 WNnCs6h3Izh24pcoWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQgks-1rJqSM2JGw-00NjVg; Sat, 10
 Feb 2024 11:16:48 +0100
Message-ID: <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de>
Date: Sat, 10 Feb 2024 11:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de>
 <alpine.DEB.2.22.394.2402100936350.53569@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402100936350.53569@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yXk7E8YZ/ni2B7jk0Y5dkhebC0YVJ/1XC1fZoxJeVyAyqJy5yVB
 /v2t+Nd5WWqDBKytEb3yH2cs64+05hx/KWahvgv/Dx4eGU98YJ9SkreG0oHVhywddcCm3z9
 8wf+wlh067Hiz71LzkXHUaCClln7bE8ULbloaXzSz+iTIoGuK8z18K4a6oAhCVDqmBlxCY9
 Jiwqf+liJwW0sef1WqzIw==
UI-OutboundReport: notjunk:1;M01:P0:pOrTKW2+ng4=;2R2uhfDFJ3lBRQRHwDnWeDX0jGP
 33cDFvzWPenCDn9h/5WBnDUS7CW5NI8JfopQcNzhwZbUJM8/0wH3ae5n9MlGdF8SEbwYvGohu
 euI+QLAYZEVfi0hOlbS70yxXzTgx9C9IeXI8+YZ5bUMSHZCRoekkhGP48+JI40w8nVpgNZ4v4
 hIXQ7sMtyEKL84KDjepEBrJX+widuwU2Fi1ED3SBc8sHq7c3F/rQu2QERkwErFsSII97VQg0u
 ErEKqa5+IvtF6pnMI6YnJkWG6df5830LeH8cQFPkwkLOYc8/IByVbH+UCnUoTgZnuQjQAjxJQ
 8Jf9SZFonAt2hxL1bWTovWu70S/V6YiWwjzRgpIow8kO6hF2UMGt6D6C/M5GrnbrU59puwDRB
 cR+N4gZ4aiIt77t8tKvF6ktponTIgtDhWG9/hv5ZS/tJoPLwfS0HF0IvDICaTAum991ec+DsU
 pvuacdoSCo/IhtSr79qCTs8XuMJHpkvW/Stcl2hQ4KcnMcVFi2RqcpDuoPZu4e3naHJ+1MjTC
 V+OQArKoeBcCp8m7OSXyTV0SGjezde1y3LktAVsrhNrQDWoIdQPXRXLMu1uhdqjdC8tCgUWJC
 Z0hfMuM8CDUN3UZX6UsuW81xlT9hjv1tzud0rjdYa3GDWzEWPrHbngku+yKIhdNrQ57iwsIRH
 je0fX5Q24wQYWr91UQVHIsEAfBb0F5jYL4vGDoqjt5dTesQToSzLaXBMLARfiqQjhfRLClcNE
 0Q65ejDALPocD6Putx1FmIKeY5BTP4iuuQW77hRAuNL29/w/llFdfovMLMSzcPGf2Li5Nf3Fw
 C1JQr4aQ9S7NfgsRygpLpTBz3V4cXN35YCr8GWGRFKxm4=
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1534
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/1c2bfc73-cf2e-4949-bf60-6fc432ef67a8%40web.de>

> I can never really understand what you are asking for.

I find such communication difficulties interesting somehow.


> Please include a concrete example.

Can the presented idea be clarified also without extra SmPL code
(at the moment)?


> A priori, I don't see any need for changing the way in
> which matching of metavariables is expressed.

An improved software documentation can probably help also
with a better understanding.

* Do we distinguish anyhow if a (position) metavariable was initialised
  by a script?

* May further uses be considered (besides variable inheritance) in SmPL code?

* Can a position metavariable be reused in the same SmPL rule?


Regards,
Markus
