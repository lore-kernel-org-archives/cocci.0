Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DB7C3DA6E
	for <cocci@archiver.kernel.org>; Fri,  5 Jan 2024 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TpZdsuCJ/LQUXRkO2KeSrq2qhKY8RGZkiuCp8YApITg=;
  b=nPVq1LYOJQRvDMoaUTLDM1JrETNPw4TphRK2amntzfhw/f/5YfW6/hPH
   fde25lCgYFUSjEHgR/Le9M5F3o6Iv2C9noW5kGfQxdeaHmoOiJa9cp+fZ
   ekcSldLita3T4rlL55JIqiqe/INC7BajnMPHKLBT+ZhdC+hrBLW07+qs3
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="145129058"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jan 2024 18:19:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82A62E0CCE; Fri,  5 Jan 2024 18:19:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 439C6E004E
	for <cocci@sympa.inria.fr>; Fri,  5 Jan 2024 18:19:27 +0100 (CET)
IronPort-SDR: 65983a1e_i+YJpE/XwdsAbuzX/aVR1pItlgWav+PmBl9E2VtJ0lpVxOR
 MWyTyV1NVNPyYT9Rv4j2Zi8Tb1aN/OKAdsDppag==
X-IPAS-Result: =?us-ascii?q?A0EzAADtOJhlhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4Yh1TMgQLSIRTiB2HJIF1MIQ7hzWHTIRrhASBVhSBLD4PAQMBD?=
 =?us-ascii?q?UEBAgQBAQMEOIRHAoc5Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBASMXBw4FCyeFbA0IglQBEIEMgR4BAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEXAkdCAQICASMdAQERJgEECwsUBgIRDgcCAlYGARQBAYJ8gisBAw4jB?=
 =?us-ascii?q?7EQgTKBAYIKAQEGr1gfLCJWgWAJgRouAYgaAYVng0F6Jw+BVUSBPIMDPoN8g?=
 =?us-ascii?q?QaDHIJoghyDHCaKIIUcUn8fA4EFBFwPGw8eNxEQEw0DCG4dAjE8AwUDBDIKE?=
 =?us-ascii?q?gwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzsDAwYDCjEDM?=
 =?us-ascii?q?FVCDFADZR8yCTwLBAwaAhseDScjAixCAxEFEAIWAyQWBDQRCQsoAywGOAISD?=
 =?us-ascii?q?AYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwdjAxkrHUACAQttPTUGAwsbB?=
 =?us-ascii?q?j0ClwB7E4FMc5M6sX40B4I0gWCBYQyfKwYTL4NuE5MlDgaSVC6HUJBPIIIxp?=
 =?us-ascii?q?hWBYzqBXDMaJIM2TwMZD44gGR+Dc48JAT1ANTsCBwsBAQMJhUYBAYNagUYBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:/qX0UKOormaivcBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:WKnbWGDASSKVBMj6E3l21WoxSu4YTl3A/VKOKmK+M01REZTAHA==
X-Talos-MUID: 9a23:gxg8Ugbu3iwzN+BTpS/Sp2hCF9VTvb23Cwc1k9IDtveOKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="75974667"
X-MGA-submission: =?us-ascii?q?MDGIoJyfSiQmcAqDzV2pXpdsxYB0fy246Hdnyk?=
 =?us-ascii?q?axMXJZbPXCoFfZCTPMcqWth18I4EeF0wo6v6vhGry0G9MVgswOrZF3ya?=
 =?us-ascii?q?WO4hoSdKGcwHAg5pEfXE0hXoe5Y/3CT0SnrQ2PVMPwuKMiWSI/pXti4N?=
 =?us-ascii?q?FDsVz3nR44pldjST//H+WqZQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 18:19:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704475159; x=1705079959; i=markus.elfring@web.de;
	bh=c9a72mh2hIDNLywI3xHSiIa41+RUwXrfonhkfw8ihFg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=w41Y8yUzzl7L3+IINq8nygYzaZVDOQ5yRxV6AZdvboQ6r9yPwsuCJxyYgql45lrr
	 l8iQ/Z3ZLXiDdWnwr/3zvRk6E7sjZpK27oxnj3HjupD3h0EJb1qVOjiaL96jFxB5H
	 bcSFVj80MZVrxcxOGv1KmRjw/dBYMIaFhVLSBtmDzzLQGARw/vd8+xI3HJttZF661
	 tQee9IGBjRkEeNE5oQl319v3sQQx5vd87k7K8k3jbAi/CL6mOnWrMCo/0QxJsvMyL
	 8gA/Wmvt9XahNUz6rAXub44CxNXolu5x+btyt6z74FOKmYmT4IiQrkDEZ523i3ypv
	 +uMhc/lwPWpal+sCnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1rZsUG1vlL-00MhqL; Fri, 05
 Jan 2024 18:19:19 +0100
Message-ID: <ac431904-993a-4c43-a54d-c183b08b7874@web.de>
Date: Fri, 5 Jan 2024 18:19:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
 <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
 <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
 <08ddf274-b9a3-a702-dd1b-2c11b316ac5f@web.de>
In-Reply-To: <08ddf274-b9a3-a702-dd1b-2c11b316ac5f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fd0DEtRES4E/LNEVX/4GnP30EuZ7SbZmpQ0+c+lSzsJF09hqG+p
 PogCSbXrZbPvufXCVapRZNE9wk9BJ9El0JY+t4w8HAgsTEk6+404fOWX2YDbBz0+3fT1Ozg
 f9z2FVRsbdVL86A5PKSFOsws3EIGiRm61Qc9IQ+gKi7h0gfwbBqMmLbPTY5HAkrZ3wwwFUW
 3XuOttoKqOtWYLDq1er/g==
UI-OutboundReport: notjunk:1;M01:P0:2ese3NzFQnc=;JA9Oql4YFmQCNSHqtztlSaK4GAq
 +fjthp9Vnvv9dESoVYKzh1FrY8Z/qHa3Jw2C5YmaPHUEtZbBwCyf9sR/Ll+Zm9mXGRIWQe9o/
 /UjuKok/SyzZO7FK3X7iQtG5+QnGddNp/39DzCjJdCDHX6DxK95aN6LHMHqFG+yA8mzebV1j4
 DDW28DBcCM6fCIu/Zl0lf2di+c+47luBKHq5Fc6UAK/cqaB7pq+x+2UvnLcXk1RQHy4D6Vj7b
 0VL96ug72UMDfQrs7HoWBpOyleG8AP156TnGGGlNcnfCJhnl0CnbDx67tkhKmimlLyA4vtcXL
 Ij7TzXHpR7VugLIerNgO+BTelyt8S6qDvWn9rjebFvy7oSKyAhGxmcKvzXPZBi0rD7f7EKK20
 AfPyroG+x86lfOLFLLKOa60lWip2/kGoYn2vM/38qRcxPYSq4M0rEHy14h4Rz5h5CU6F3DjzU
 SPLVukFPjF85byQnZZkQRsnh1tYlQr4as0DOO2U69K31KJdFMzvknf8fNSC0BElk1jz0ud7dJ
 4OAgjrqcW2w6p9T5pOCCRJgyxpdbsoNov691is66TJ1tjd42/N7pWSonNYIPSrQDATRilWr40
 CjEJRFPV3/2M90D+/tPviPmSCQJghrBW4ncWNAfqgm1IcLMnuQXRfVUx7BzFfJHuTCWSxJqje
 zpeOYgINfnxVrtZfFh364t36ZWK8eAi2bxY81WzAaYPYzwF/bIpWS9C3H/sAeckj1YRzhFnmD
 Ezxz7hwyVZyEFWmtk76AojgAIPDMSGo0yT3v1Z6OffUxdfotJQjwLl+YIwfHtPzBe5S4rlxiH
 nKWJHk2X8RZ471iToxQGj4/hIesJjKmfQMdeO9wD27oK9L9lFVEoPrxq4eyFMqBhH62PqJ7e2
 9eRmjd3Fj50LIov224u9ZHL0TGpLqASzoT0t+THqJOZ8nF3UOHDP2NrclAQw5fF2YY7BGXPd/
 y0UBkVBoV8GM2hlKh3H9t52bdHY=
Subject: Re: [cocci] [PATCH resent v2 0/2] powerpc/pseries: Fixes for
 exception handling in pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1432
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/ac431904-993a-4c43-a54d-c183b08b7874%40web.de>

> Date: Tue, 21 Mar 2023 11:26:32 +0100
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):
>   Do not pass an error pointer to of_node_put()
>   Fix exception handling
>
>  arch/powerpc/platforms/pseries/reconfig.c | 26 ++++++++++++-----------
>  1 file changed, 14 insertions(+), 12 deletions(-)

Is this patch series still in review queues?

Regards,
Markus
