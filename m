Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59531D1BDC3
	for <cocci@archiver.kernel.org>; Mon,  4 Nov 2024 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=f+t/grP18swoU0Pvo0GCCZyaKOosgwjXym2cRfxH7nc=;
  b=u4OrvChbRmz8NOjPQtb03FCiQXZkvglicll+6Lsn2yVxuMcYukV0EQ0r
   YETd9Lgy4GYDykl1fDVLky2WZrmrZ1XiMpIQVTNB5v/vKfFzB+CNnWkmz
   H+KZtxmP0b+1zK4DLlryJzg5Xz3JHxDVe3FN0WSgeLXAh2asJDFt76NLs
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.11,257,1725314400"; 
   d="scan'208";a="192095640"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2024 17:34:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 335B4E013D; Mon,  4 Nov 2024 17:34:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 320EAE00B7
	for <cocci@sympa.inria.fr>; Mon,  4 Nov 2024 17:34:30 +0100 (CET)
IronPort-SDR: 6728f795_pNIh7B54SiSK6hZvfbq5mjDOKn7rRi74/ESSC9F1wQhvFE4
 ifQAOfuhQ200OF99uOCxyx/qTcBBRA85GNiiDuA==
X-IPAS-Result: =?us-ascii?q?A0FWAwAW9ihneROg6VVagQmEF31aMwcISIRWg0+OIqATD?=
 =?us-ascii?q?wEDAQ01DwQBAQMBA4IMgmoBCQKKMgIfBgEERwECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEiIA47hXsNgls7ghYsDX4BAQECASMVRgsLGgImA?=
 =?us-ascii?q?gJWGwEBgn0BgkEjAwSvOIEygQGDHNsXgWYGgRqGGIJiAYpgFxAVBoINgTwLA?=
 =?us-ascii?q?4JEMT6FEIMOgmkEgjIVhR8liRWXQFJ7HANZIREBVRMXCwcFgSkkLAOCUn+BO?=
 =?us-ascii?q?YFRAYMfSoM9gV4FN0mCSmlNOgINAjaCJH2CUIElBAWDb4ELg2WEbEYdQAIBC?=
 =?us-ascii?q?209NQkLG0OeRUeEYi+mVKFqhCSMFpUuBg8BAy+DcQGTTRSSeJh3qSGCIUmBE?=
 =?us-ascii?q?000BIMiTwMZD44tFoNYxAdDNTsCBwsBAQMJjyqBSwEB?=
IronPort-PHdr: A9a23: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
 yyUs908+jmb
IronPort-Data: A9a23:/zVHP6OyRWEPytDvrR1Lk8FynXyQoLVcMsEvi/4bfWQNrUolhWZSy
 mQeWjiBOP/bMzDyKNsnadu+oE8D7MTcz9YwSnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQbNNwJcaDpOt/va8E835ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXGfHLL0c50Cn05Gq4o2v1yAXtA7
 KchfWVlghCr34pawZqgT/V0wMQkN9XweogY/Gxjpd3bJaZ7B8qYGOOTu4cehWZYasNmRZ4yY
 +IVZCBibzzDZRpUPVlRA5V4geTAanzXKmUA9wrE+fVqi4TV5BdP67u1NeTzQO6hWe9YtAGjt
 zj93nusV3n2M/TElGbVqi3z7gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRkUuiQ5RfL
 FcI4Wwlqu4v9yRHU+URQTW4r3ejrCUGXeZfNM4KyBqIyrDa+l2gUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYS/DnltzhW7sURX5PVM/iTk4oRwtzPOLnW3epgnKUs4lEKmuksazEja23
 jPiQMkCa1c73ZNjO0aTpAGvb9eQSn7hEl5dCuL/AzvN0++BTNT5D7FEEHCChRq6EK6XT0Oao
 F8PkNWE4eYFAPmlzXPWGLtQTO73vKndaFUwZGKD+bF8qFxBHFb+IuhtDM1WeB4zWir5UWOyO
 hGP0e+vzM8CZhNGkpObk6rqVph6lfe/fTgUfuzZZ98GaJxseUeG+j1jf0idwyj2nVIykKoyI
 t+Gco6oDHMbFalrpAdatM9DuYLHMhsWnDuJLbiil0TP+ePHOBa9F+1ZWHPQNbtRxP3f/23oH
 yN3bZLiJ+N3CremOnG/HE96BQxiEEXX8riv+5EKJr7TeVoO9aNII6a5/I7NsrdNx8x9/tokN
 FnnMqOB4Aug2S/0Ok+RZ2p9abjie596oDhpdWYvJFukkTxrK4qm8K5VJdN9cKgF5d5T66d+b
 8AEXMGcXdVJaDDMoAoGYbfH8YdNSRWMhCC1BRSDXgQRRZBaelH2yofWRTe3rCgqJQirhPQ6u
 Iylh1/6Q4JcZgFMD/T2SfOIznGrt31Miugoblb5eIlOdHr38axBCS/4vtkoKe4idDTBwTq70
 V6NIBE6/OPina48wOPrt4ul8bi7MrJZMBJBPm/56b2WC3HrzlC7y9UdbNfSLCHvamzk3Y6DO
 8NX9qjYG98alg9ot4FcLe5a/Zgm7YGym44AnxVWJ1SVXVGFEbg6H2Kn2/NIvahzxrN0nwu6d
 0aM29tCM4WyJ8LXPw8NFTUhc9i8+6kYqhvK4dQxBXfK1it90b6EcEdVZj2nqihWKplrO4IEn
 8YlnuMr6DKEtxl7Cebe0xho9FmNIEcQDIQhlJURW7HwhiQRl1ptXJ37Cw3N2q+pVeliCEcRD
 wGxuLvjnJVZn0rLTGoyHyPC3M1bnpU/hypJx14jeXWPvMbJptYq1TIA4zgXaxlklEVa391oO
 0xAFU58FYOR9RhG2elBWGGNHVlaJRu7o0be9XoApFf7fWKJCFPfCXIbAvmc2nwZ/0Z3XClpz
 JvBxEnLCT/VLdzMhA0sUktbmtnfZN1W9Dyavvu4Hs6ATqIIURC8joCAPWM3+gbaW+Uvj0j6p
 M5vzuZ6SYv/EQUy+6QbKY2r5Y48eSC+Bl5pYK9epfsSPGTmZjuN9yCEKBmxduNzNvX6yxKEJ
 PI0FP1fdSaV9XiolS8aN54uMrUvvf8O5fg+QJ3JC1MCkYOiqmtOjMqN2An43HQmUvd/o/Ybc
 4nxTQ+PIkaUpHlTmlLOkvV6B3qFUYEESTD4jc+I87QvNpMcsetTX1k4/Zmqsl60bgZ23RKmk
 znSRq3RzuU4lJpnxdrpNqBlGSGyF8nSVfuJwi+3od9hfdPCCuaQlgI3+33MHRVaAqsVYPtzz
 Y+yid/Q2FjUmoo2X0TyuYizJ4MQ6eqcBONoY9/Kdl9Eli68aerQyhok+VHgD6dWkdlYt/KVd
 yHhZOSeLdcqCspgnltLYC1jEjEYOaT9ToHkgQif9/2sKBws4TbrHeOd103CTD9kL3cTGpjEF
 AXLle6k5YlYoKRyFRY0PaxaLKEiEmDze5kNVoPXjiaZPFmKk1nZm7rFlDgc0x/pJESAMv7H5
 cPiekCjWjW04a3G9YQM+cg69BgaF210juQMb1oQsYw+wSyzCGkda/8RK9MaA5VTiTb/z4z8e
 CqLVmY5FCHhRn5RRH0QOjg4stu3XYTi++sVJwDFO2uPbjuuQoOHG6d6sCxnpWp1Etcm5P/yM
 skQoxUcITDoqqyFh85KjhB4vQuj7vDcwWkP9wb2lIrvAH7yxJ0UgWd5ElMluTPvSqnweYaiG
 YTxbWNCR1q8Rwj6FoB9eBa53f3fUCzHl10VUMtE/DoTV0h3AgGNJD0T9twfCoE+Ufk=
IronPort-HdrOrdr: A9a23:yQCPq6l4QOik8k3YiF8Yj7e/u4DpDfIv3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7gr5OUtQ/uxoV5PsfZqxz+8W3WBVB8bHYOCEggeVxeNZh7cKEweQfhEWn9Q1vc
 xdmupFaOEYZmIVsS+V2miF+pobr+W6zA==
X-Talos-CUID: =?us-ascii?q?9a23=3AmQ4K7WqGw2fbIH+E9liYyxXmUcAqe1rP923WH0C?=
 =?us-ascii?q?fKlZJU7iVU1GJo5oxxg=3D=3D?=
X-Talos-MUID: 9a23:X1/3kQRwHa3qdIRDRXT3ugphbMJWxZ6cI1wnnL9BgNjeDg1vbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,257,1725314400"; 
   d="scan'208";a="100709475"
X-MGA-submission: =?us-ascii?q?MDHtia29WNYvKXxfViYfD1S2GE0n2iJtvUJ0Oj?=
 =?us-ascii?q?yygKM7aqGiT2b1JsGwwRCWuykCfIyd90jl2I74pyDzzVSaAa9kVHxah0?=
 =?us-ascii?q?JRjSHw+VoDKS09RqDYLUqGZCzMZcjJuc/DngydvKlIO6zzLyUIoSTxYo?=
 =?us-ascii?q?QTJgr0xHXv+a2E7QXpt2rXEg=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:34:29 +0100
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t8027-0000000022E-6p1x
	for cocci@inria.fr;
	Mon, 04 Nov 2024 16:34:27 +0000
Message-ID: <05354787-2a60-4c3d-8818-0d23c8e2e015@knosof.co.uk>
Date: Mon, 4 Nov 2024 16:34:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <9aea38d0-4738-475a-b354-f26b44766544@web.de>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <9aea38d0-4738-475a-b354-f26b44766544@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Importing source code into graph databases?
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1964
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/05354787-2a60-4c3d-8818-0d23c8e2e015%40knosof.co.uk>

Markus,

> Would you like to discuss any approaches to import source code into such
> information systems?

Using a graph database implies that a particular kind of
query is so common that this representation saves time.

What kind of queries did you envisage running, that would
make using a graph database worthwhile?

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

