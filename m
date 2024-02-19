Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FF3C48BC3
	for <cocci@archiver.kernel.org>; Mon, 19 Feb 2024 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Dat72KPVx6JeTGi1wbZi/5pRZEyox0eZb20OuuRoYx0=;
  b=Qqqfrz4i00xpK5Hgf0xRkXwY6OutmwLyPwyK5PP1UnHoP21wrCSLnHap
   T/TAZOjSDxqiecYX76EK5sqh/TYcrEugz7W2TeAgG1+3tHbfcHJC6s4+k
   xLkrqCVfyCTyGfJRy4xRpMfdYH8+GonMiOMifbfx5ABPvZKe8ewHJCKu4
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
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="152556652"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Feb 2024 08:31:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8C1C2E0CD8; Mon, 19 Feb 2024 08:31:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2444AE00B7
	for <cocci@sympa.inria.fr>; Mon, 19 Feb 2024 08:31:05 +0100 (CET)
IronPort-SDR: 65d303b8_/sfj5G2BBT82VlGt+q9a4piq8kPT5NnUw918l+ijV0HqF1O
 Of2oIXnUW8feXd6KdweG/C7rIJp5cF+2aTBuS8A==
X-IPAS-Result: =?us-ascii?q?A0EjAgB2AtNlhk7ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COX9TMgQLSIRTkWmEO4c3h06IcIMWPg8BAwENQQECBAEBAwSEdQoCh2QCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEhGQcOE?=
 =?us-ascii?q?CeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0EBAgIBIx0BAREnB?=
 =?us-ascii?q?AsLGgImAgJWBgEUAQGCfIIrAQMOIwe0NYEygQGCCgEBBq9bHywiVoFhCYEaL?=
 =?us-ascii?q?ogmAYUkS4Q8Jw+BVUSBPIJSMT6IHoJohHiaZlSBAh0DgQUEWg0bEB43ERATD?=
 =?us-ascii?q?QMIbh0CMToDBQMEMgoSDAsfBVQDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDE?=
 =?us-ascii?q?kkCEBQDOAMDBgMKMQcpVUEMUANkHzIJPAsEDBoCGxsNJCMCLEADERACFgMdF?=
 =?us-ascii?q?gQyEQkLJgMqBjYCEgwGBgZdCRoHDwkEJQMIBAMrKQMhM0ERAwQKAxMHCwd4g?=
 =?us-ascii?q?gmBPQQTRAMQgTRChHaEbwyBUgMZKx1AAgELbT01CQsbBiIBHQKhXQiBW2+lP?=
 =?us-ascii?q?aEZNAeCNIFggWEMnzgGEy+DcpM+DgaSX5hYIKhXgXsjgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?BmEFI9HQjU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+9ys36zrVWBGehIVXLmtKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: =?us-ascii?q?9a23=3ASGwt0GudOfCMiStBUjNh+Iz36Is3SVH05S+MJ3W?=
 =?us-ascii?q?mIkoqE5i1RGW9pJF7xp8=3D?=
X-Talos-MUID: 9a23:xsK5Uwh2hKt7NLdGc/f7YsMpEO1t2YWEFHE3sssmmMKvLwJgEgWXk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="152556631"
X-MGA-submission: =?us-ascii?q?MDFKjmRLs4BYk9HW2JTJezEL7/38mAsqrl5hOz?=
 =?us-ascii?q?nu0Y2KBugE2TPE8dSuZid2x84eHKauFHB8dUFQRv65VgDRBIs1smENI+?=
 =?us-ascii?q?yrmCk+lhr92ql/cnR5K2UmF6d/a++bxfyGZgf/SzdxMSXT3vlk7G+kjv?=
 =?us-ascii?q?VUSZx3omHjjDJJn6q8msuvYw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 08:31:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708327863; x=1708932663; i=markus.elfring@web.de;
	bh=bt/E0e/aqHwTqnTLIlKeQJeFU+U40cVQmU4T5a6qBb8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=rFsnVYe328n9mD7yQD3DU8mCymucz+3LyqRwkXklKMEu+n3CzIxV/SmSZbSG3qFN
	 ZE+z6m+R7lKTvtUS6aMYTT/JofbBII+fiSy8DBCj3trM5V/4Car4I346Mfp/liLem
	 MUUHrKaJBSf9TWVLrTf7swea6Zh1p5HbD57tE6Kv0Sr7qU2zKK4aElp15XtuPtt/5
	 MzQv6Ox2yTUw/zJGzJwRBwwoJjwLtTXSEhTj5jUimSzMvQ76yGY6pKZ+Cnn5ZY1CV
	 +hIb4kahYYlZh4Ops3JeaOSFQytIABndsPDPoklKDhCfzZZ9u0UlNe5fYgpMDnEhI
	 +XDLuyIxGquKVqhcYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxMP-1rfajc2bmF-00E4Gl; Mon, 19
 Feb 2024 08:31:03 +0100
Message-ID: <407f678d-05a3-425d-a93b-dac350e9c731@web.de>
Date: Mon, 19 Feb 2024 08:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
 <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
 <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
 <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
 <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de>
 <alpine.DEB.2.22.394.2402180908440.3095@hadrien>
 <30fef057-5f06-47bd-8b62-1bb6fc3fb946@web.de>
 <alpine.DEB.2.22.394.2402181707300.3095@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402181707300.3095@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C6T6ot0RT3IaUxzeskOm2ti2EIwL1vFkf26lvKLT8+dLYZIrk0s
 9zz/Qimv8c6VrFEgx9sO+7HQLr6YBwk5TEphx7fBCxKjmYwQ6Gr1aDoFX0+frrdIvh6W+bQ
 8citsB6yE4YqF6DVXhPbjbeqzXrx7hQFA16L2lQ2Ui6D+M/GaDypA7rHsZ/XAoVlQPMOvll
 DtEInNoUOQCQmBGMrhx3A==
UI-OutboundReport: notjunk:1;M01:P0:Fx9cKEoqqn8=;JzyD5vBjrSTMbBXWDWyl22UiIpz
 F1QwejwlTids5HN+2nKLvVA+idya9aKatDfmvGB4yD6FpPTKiOnnJsDjCv4LOlvtJ0iFDaBP3
 JfvXMHpmwR8P3AZ55CEJLFZkzXspel1+KHkfduiRWgD/Vn4gRRaIVQBXZth1fxrok0IOWyrKZ
 kvc1w1qIkLl1QV0UW6RdwmNJjE2LmmqgFFmzJpcq0k/oxr9sMl1lktnhR14SVSgbDCNePvS+n
 t5e8ysm7qufQHC8yjJrtnBbHlwyJIXsEa+d854n5hQ/9fL2qASJqxpwV3iTDvrv/TuyfFYf5z
 Dlq4oYDRtfDHHSq9ZoWMx1zOPzEuPikqOPDkHWNwdZyrw/hrjhxtt0pIcBOMx3GdXG88SxBKp
 cEIJTqvRTNuGjPauPA7pYqDX1YXkR5ohHycaWy5pN/ZJKKEyYw7JUNRlMCES+kfUVEJz2KuNv
 o0BGMiaCDt8qccECmugpTYC13GQ7QGp0ZPJp3mT/5xYBSePJ5+3oVxovtkQUGrJMWoDgkPKM5
 iTuKBAMNULBWvzemAkFd9ZdUx+VzeQAabZK0RBWyhY6vo9xclTDgUYucBKseXEQk4fCNgiiu9
 fbvowOsN0qOtFG7w4MsbKncSD7tfpZc4jVpAnWQgSXNOYArYHy8T5nLIARw4MBrOULP1C+DkP
 U0yVbpOhMNNsHB4I7pl7vtdS/Un1Mh9U89LIiPMDoDfBbCmAM9mPrtZtfiX8eNen52iMXmUVx
 ypdQovPpwSDmdFA07R/CzYmm1c1mILDRsTskAWkAWyX9NZa2Ct6jhe9W4MMTDzAJw2fPo3PLC
 cUAJYCRIBlURVcLkHeOgx21/eiJAXSuGhmaNGYACVSukQ=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1583
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/407f678d-05a3-425d-a93b-dac350e9c731%40web.de>

> In the former case, it first matches stmt at the end of the semantic patch,
> that can be anything.  In the latter case, it first matches the if,
> then binds stmt, and then can easily recognize stmt earlier in the code.

How will the chances evolve to achieve consensus on the desired
evaluation order for the shown source code search and transformation code
according to the semantic patch language?


> There will be no changes in this respect.

There are several open issues in some waiting queues with the potential
to improve the development and data processing situation considerably.

Regards,
Markus
