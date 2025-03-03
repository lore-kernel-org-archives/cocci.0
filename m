Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B40EC282C5
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pQr1WZ548ecZB3xoVxnsW4k7x9sHO8xZY4WGSA4vMwU=;
  b=FovML45vqo02lg+WrHjcODzdcMniRKmdzudC49s5fSIlQRNhKCkd/rx3
   lnv7NJxEAbQlHf/7gZYGwakTdL0TSdYi2sVSjPxi9hs1t5XqMMeqJ2wKC
   atBxLxCMgmR51Jae5BDPvFuq5CVPbLsZwIrXoAfpNbuxMdub/ecsX8tjz
   M=;
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
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210797201"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 09:23:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29A7DE0D1E; Mon,  3 Mar 2025 09:23:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CE2B4E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 09:23:20 +0100 (CET)
IronPort-SDR: 67c566f8_QC+gbja99Dvgm+mp5rkL2+mA9OtKuO7Ukbv1slxK0xehUKP
 6Hm2g3JNT7+jqPVXBIaOyy9/3RiNKe1nhLR35oQ==
X-IPAS-Result: =?us-ascii?q?A0FbAgARZsVnfgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDfVozBAtIhFaPT4F0MIQ7jw6KS4F+DwEDAQ07BgECBAEBAwSEd?=
 =?us-ascii?q?goCixUCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQIUM0QBAQECASMEGQEBE?=
 =?us-ascii?q?SYBBAsLGgImAgJWBgEUAQGCfgGCLwEDDiMHDa5+fzOBAYIMAQEG2lwfLCJXg?=
 =?us-ascii?q?WUDBoEaLgGFa4JjAYVShBZ6Jw+BVUSBPAuCRzE+hEODW4JpgjOEQGeBbIpTH?=
 =?us-ascii?q?C2CJYpYjlNSexwDWSwBVRMXCwcFgSlIAyo0MSMPgRQFNEE6ggtpSToCDQI1g?=
 =?us-ascii?q?h4kWIIragQFgSSCN4Q9hECFUoIRcWwDAxYPAYMfdxyDT4EthGodQAIBC209N?=
 =?us-ascii?q?wkLGwY9oW07hEKBOYEYlDWDPa9SNAeCOIFmgWMMiimVNQYQAy+DcAGTVA4Gk?=
 =?us-ascii?q?n2YfSKNY5ssgWkBN4FcMxokgzZPAxkPjiE4g3U3yAFCNQI6AgcLAQEDCYVGA?=
 =?us-ascii?q?QGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:Sjgt5qE78e9EDwsSpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:I3+klmGxNI8dj/NXqmI9ql42FN84KkbW52fCDhOCMGpAQ7S8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Aom6jEg6jdk6Gi9Uwpgre7mBUxow06b6JBXouzq4?=
 =?us-ascii?q?Lsu2mNDYzAzy70GqeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110460805"
X-MGA-submission: =?us-ascii?q?MDFZoGhoYh6gLPNk+n5y5dWtZCXwNWhCuyBXNk?=
 =?us-ascii?q?81vwiI/StB3E7sMOPfOHkA5qZ1xChqw/JJDDPRHcu6wipfiSrrx8QbGq?=
 =?us-ascii?q?8nPr39EGnNdwnmR5nLWbwnRCtUrAPEYgEdY0nbGDY00bKvjCp4MqeH7F?=
 =?us-ascii?q?lOsUmMYx2V4lDKx/LSDPyxrA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:23:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740990183; x=1741594983; i=markus.elfring@web.de;
	bh=pQr1WZ548ecZB3xoVxnsW4k7x9sHO8xZY4WGSA4vMwU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IHyrl3N8nH/24Fv2D59sEna66ZDL6YcZx1VuTjYlv8zOxC6kfM+Hn4Dzqg9oOzhK
	 k9S3xBw8V19ADKeFb8D3lG1/azmFLeKXxgimfL7aEDePqPgOHLVTnnfV3HD4g8lB+
	 D0yD8Bpby1Hsx41T/KE7FS5tuurVvcN4IPMx+jAvLghHyhLTuaycUqNc76zK7fAM2
	 t86Dcok96zxz7qU2Z3t3iLdw/Ba76G2fKm5qXt8jj8XmcBe0T/bQFMUx89AePKhS2
	 XkXbdtVyhEYb+AVxIM3BtgNxnEA9+LzWOH4sqNwmxqT+ZkcP7lH7dvxU/MbuKO6TY
	 m1mxmHHEoDMS++nMlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1t1bHv22Fw-0171x0; Mon, 03
 Mar 2025 09:23:03 +0100
Message-ID: <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
Date: Mon, 3 Mar 2025 09:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ariel Elior <aelior@marvell.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Manish Chopra <manishc@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FYo4KR0DHw8kUBrjrDdkOAm8f/u2tVyaWSQA2DnGNc9JQQ86MDa
 bwKKYeavDxHfWlkAduCnA25E+m3vTJHha1KI0SBitDv5vFfARQ5dauvVrFkfEwldr6cbXGt
 rQCLvY3oVIof17p3AwBXCexkZzFqAr/NbbgHPUCe435Or7d5J5W3ZbwPWaQ1l8mwih/Qifp
 C0Slqd/P/qBIyY3LvcXTQ==
UI-OutboundReport: notjunk:1;M01:P0:RCqRm2Eproo=;ZlnPkZrhZ60vOLSzosM2YPI9Wto
 3AmsBSv9KLN+XyU0X1LyjqAKQErpWV7K6f05wETBTPAZ58PzopnFENYzawmjl1X/VJKmGLojS
 2gI2KS0iET6vrphGGHhXKi1Hzd7UTG7Lj39AHYffLz/t1iUOGLHlOWsI8GFWdwmBzMhOxZ936
 jYsVdJjPsUKRoTMKQOvziv+Mix+NSl631TqKmwCd8F3MqQRsafqZN/j8A96UMPA+u/hWgspI/
 9BFmyqSk8N+rtYm6BbOlqYeGPM6dm7F+s8L/R04JR0fGXVLPmWHCtci/efVhlIZ2VKj0Kt1Cy
 MZ5iIzxadso6cB0Eh2vnv/jnbWdxxK8JvKB32CK7PFz7BOC72Um0Mdx4Mwb4iGPgdCU3Ef/5o
 4VWXjwFQaDqGBf9oxZkyIK92y24Ybyj5px1tl3SEoN2GsyFXt4LYjQSTJlgKtcHant1XcaBKd
 z9T23ZxWcLPomObRfxz9YgU3ddGaCWfX1CD5eabzjnXNeBYkB7V19WFsf5M4Bh4mxYjbF+g9B
 dOPVAUUiWwzOjW9oT4gBl2m4nlOvthkrYx+2uERqnvVmuNCJFkcIdyhNUHIeWtbo4riP+coH8
 o2bMu7Yj4Vt2tMl1Xx+uJ702p61Z9m2sh28JanSW+YB1ReG8jWmulP6cex8cFvIf5YgpmPceM
 z2kn9sRul/TcxXewJUsiZ4fdBQxO3nj5o6W0vDB/3zkQtBcFs80op67pZc4ARQYIZKGCFwcZv
 YWV8xMIHVpy4+ByUeiwCpSwlACl6HLN49KVgXKgR738RfUxjcFwe8DoaJlywHbGDP2j8einMB
 tzEb+f9Emed0rVpPoyce8yguveZDnEPDQcXWDkkXblFxKzP7A8wFsbkMM7mgi04hIt+b0W6Do
 ot/IgkptfQSXr70rj0yADvh9OsOfeTw9qnm34ZW0xSPk/laeR6qCudvliP9ZI5EIlUpp7ynW4
 IalZfSiycRjcPxf20I/4YC3YpTkeOf6YBbfQCTnQ7CnB5Uv8gDVrG2mwGlJsh91ew8AQVxPjU
 ZN4fqMenZfLLuUHdrURqhYgHJcUYdTIiRjEsM09zj8qgylPtdJfrLSN999h5uF2rsvUK6ZfZH
 QxNmHT2jYTH4y7BkMNEpMYBNwfVV0aexJkcfZJFuuMAp9kxLqy6GV5CsI+K4IsDtvzyjqum2v
 yYZ/H+KLAoXzWRB60R4NCTPpVyRzW4u7m8hqQOEa2Hs1diHLgvYsaaHnDCycHT25ag/Dc5oJV
 ALfintfOGP14oHY+hM0pjag4b1Z5c2gCfof8jFqfEbzRoSDAJwJtLnqVzKMwX2cxWYRy6GUG+
 lr/aBRLLD+XwerMop4uYGSUXvpDHJzevnvAOL+/dx5nGQez9eJiTFeV3qXsk8DR+lTcqBijvd
 JvvjGhM4eJ6sY8FOKdVMKc46vz5mYYJCU3jp9EwmyKr9e0Nm9G7IDXFqT+M9NgKMnptPfcxZ7
 447OJIA==
Subject: Re: [cocci] [RESEND] qed: Move a variable assignment behind a null
 pointer check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2475
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/64725552-d915-429d-b8f8-1350c3cc17ae%40web.de>

> The assignment:
>
> 	p_rx =3D &p_ll2_conn->rx_queue;
>
> does not dereference "p_ll2_conn".  It just does pointer math.  So the
> original code works fine.

Is there a need to clarify affected implementation details any more?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers

Regards,
Markus
