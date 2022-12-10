Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40A9C4332F
	for <cocci@archiver.kernel.org>; Sat, 10 Dec 2022 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OnJdNVNyBO2tuiOh3wagNypPFFS+Gw3UXIxbTMBdt5c=;
  b=A6osVLnV6zTzBQduLr2Oi7EYRvi/atVppGv7P6Uo1jtjZDwPdM8mkbdG
   MHg92ACa9nTDFS+5Q656NGWWCcHKSso3UhFTmOQO04S7EQSEz70bnFhL1
   5UUd0BtlM5pgV3jQOEVeAj31q1dfzGL6eLLFzbHAxaVk/ZN3/NTEyDlID
   E=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,234,1665439200"; 
   d="scan'208";a="82767981"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Dec 2022 20:10:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B0046E0128; Sat, 10 Dec 2022 20:10:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AF4EFE0128
	for <cocci@sympa.inria.fr>; Sat, 10 Dec 2022 20:10:20 +0100 (CET)
IronPort-SDR: 6394d99d_cR/yWREMu7W72zCBUIq3BzY+3fo7+SIRz+yzdHFtcbLxWJe
 XJqP13TQFYFBmwbmV0lhFLOWXJoQYDnM8OuCHeg==
X-IPAS-Result: =?us-ascii?q?A0GhGwAg2JRjh07ASNlagQmDfIFdLgQLRYRPkG8uA4Qrh?=
 =?us-ascii?q?yOHMIpMgWoPAQMBDUEBAgQBAQMEgguCcwKFCwIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEYCxcHDgULBSKFaA2COCkBdYEIA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARYCR1M9AQICASMdAQERGgwBBAsLGgIRFQICV?=
 =?us-ascii?q?wYNCAEBF4Jjgm4BAw4jB65CgQqBMoEBgggBAQacBx8sIlOBXgmBFCyQJnonE?=
 =?us-ascii?q?IFVRIE8DIEJgW4+g31HP4MYgmeLF4I4ihAKgUtSJQQOAxkrHUACAQs7MgpDN?=
 =?us-ascii?q?QkCDEwrGhsHgQwqKBUDBAQDAgYTAyICDSgxFAQpEw0rJmsJAgMhYQUDAwQoL?=
 =?us-ascii?q?QkhHwcVESQ8B1Y3AQQDAg8gOAYDCQMCIVVuAi4RFQUDCxUqRwQINgUGUBICC?=
 =?us-ascii?q?hESDwYmQw5CNzYTBlwBKgsOEwNSgU4EL2CBAgovKJwiIWOBEhlqokWMJJNDN?=
 =?us-ascii?q?AeCIYFPgVAMnmwGEy6Wcg4GkhiXQaJQhSuBeSOBXDMaJIM2TwMZD44sDQmEA?=
 =?us-ascii?q?4osQDQ7AgcLAQEDCYVHAQGEVgEB?=
IronPort-PHdr: A9a23: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
 4qX/J8=
IronPort-Data: A9a23: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
 PrxgKfOxMkzsfmosfkx3Tg7YjqiOw==
IronPort-HdrOrdr: A9a23:DkpVqaxHpNmxuKwSw5YIKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,234,1665439200"; 
   d="scan'208";a="82767973"
X-MGA-submission: =?us-ascii?q?MDGFWer9QhbKWChRfjl4D2z/sET7RSXZHwWVGy?=
 =?us-ascii?q?XNXL/TFHYATPtlKYDlQKTITPlktJRa5VSU+beXddwck2RcfPyX6BwvOS?=
 =?us-ascii?q?vJM3dS9vcJm48OXrmKV4UzWLSrbAQz5txsP/OUc2Xcm4EkTA9FQvL7BC?=
 =?us-ascii?q?h87uqxh48cUArNNyKq/tdeBA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 20:10:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1670699419; bh=VUcYrU6nrv2LEcvk+9cjOz9rQ3fg4SPXnqo8y8yeuG0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fvXHY2WWvpyZ0yMAmQ+cSdDdoQTI+Jik+934PtDE8lAYP866fNr4xKrnCWJuP9BBr
	 iwS1n663hu3cjqFo68txKqkx5l2EJLdJ2L3d5x99/7RzntnPSdhyzSNArlCE4j4Lur
	 MHpdptWmr/gpV3YV97gMz69W0/dmU/P5AnlA3V2ifzDembU9wB5Lg5/ew60M4nfW9w
	 jMeXBW14QuzGtj9vMSZFOA70KyRMgZHp9XI1/Ab/m0oQHwzKK6/V+r8pPL0Vi1iuZc
	 EkTF0f5B2B0AYU4fJkSbLeU2IlmdbWIQ4tmGIRUeHiVHwUVLDHGyES02RICkJroy9d
	 m/wl1bSdLSw8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKM5t-1pNXGO1Pf5-00LdC3; Sat, 10
 Dec 2022 20:10:19 +0100
Message-ID: <18d760dd-fee1-97f4-4460-566f978a21f6@web.de>
Date: Sat, 10 Dec 2022 20:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: Jonathon Reinhart <jonathon.reinhart@gmail.com>
Cc: cocci@inria.fr
References: <CAPFHKzf2pDTK_O9_m23D4R0ryFknAy_bjSSdLsu+ujJcZYCcdg@mail.gmail.com>
 <833178e5-29f9-5e7f-6ec7-8ac028dffdc3@web.de>
 <CAPFHKzeapJcz_LNYajjsKPefeCfO3ZgtYprtVBWLunk8=YgNMw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPFHKzeapJcz_LNYajjsKPefeCfO3ZgtYprtVBWLunk8=YgNMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:o3Oltk4MgPIYnbZ6QWRmjIF0cn9vqPpZFLh0bl4BKcnGM0u1a5D
 qhhBZIkQEsQFJ/YSV3AICE9CGAzJn77vR17VB4cwy/s+jmuDAv0smBOmviCMhNEgIdiyLaT
 q+Qw/M4gk958oK3TvsPC5HyN03MkRx+2efCJNWxxgque2hY0BCfg2a2UfDJlgDYExG01pIc
 XyeYUK1NxlA2M0cLkAZBA==
UI-OutboundReport: notjunk:1;M01:P0:KhSSGSkWI6U=;g+BD5fQ2VtFLsafliVy4uxkG8zf
 L53erchRd6ew3tatC7VryeUDkIHFfF4DNwsgxDcy635CuTl1wgXBE9/gCoJ5qnYXnJMOvLafv
 PlmB4Noi0DZeMH7zbau2v/nkxaITEZHL9V1MkqyOJyD2D+kZsp4U+tRd2H6ENVnxjI4dsnDAG
 k8Percta1I3IOw6ZL0XWkcsnCV4I326FVHrvqdPNgetvZXPojvybRRqA2MtsMXaNP0WSfTMlJ
 pFU7/8dZj0xLsf6XozRqWuCyR1fFBnol6r37JKcEpo+vdqLW2dXO+maqcxLsAqHk2NQaU46Lh
 db+rber5HLYxe3YZoOMu38Yb6rn3GLcfmC57hPs/XQOCwBnV9D8RYF7uWQQgxwVvsQoa6IESu
 RVWd/qt0jv0KIMC+gPR7UmYJA3i4EfiyRtOQbdhT+NTMZW9WMOO9pJXRU6zrLlYxMghalFQiL
 DbrH+ZT24q/mtJQTrnn75feF4S2ouwNRf/ktxLaYtb1EqmXfV4SO4Dz61nYZqyaekekttvDYJ
 awcHiZ+o3mojH+TIdcCp1KyHcj3hZ01F4lrgQ2hotyZsGhqjINRbZyGpFQgWyAvwVMq5CMSJD
 +KYVPR9BcKV+Si0a2V6wrgv0OTNOuM9fO0KgN+px+7UvSUvHKYihH3SexV/TvIEwNW6hh7RKM
 u5Quu1Us5ARB2POhegq07zdEWyzJATHTO5ucyAtdWp8BvfwYRP8e1f/385vYGb5MTkjmXBIEP
 cuj90Qguqse4c4gs9QerktOmuH/roD6Nqbsr0cSqLL98hRO2NtJYK9bpwqMDb9b1aikU61wD0
 VF7aqUJVFmVqHeNGFxdJ8XWotxFMsVUJM5ec6we88R3/M1Zo6qpcLoO1ELD336AAw0Za1V5VD
 j5aLT9Q6znWX3is3FFukXryFbGe5HuvbOWQjvj33hJlkdcjSDCl0M6YYyhypOFpEKp55tSv7I
 Sj11Ow==
Subject: Re: [cocci] Converting strncmp() to strcmp() with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 776
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/18d760dd-fee1-97f4-4460-566f978a21f6%40web.de>


>> I suggest to take the following SmPL code variant also into account.
>>
>> -strncmp
>> +strcmp
>>  (x, literal
>> -           , n
>>  )
> Thanks for the suggestion. I did see that variant, and I like it for
> removing a parameter,


That is nice.



> but I feel it is less clear in this situation.


I hope that such a view can be reconsidered a bit more.

Did you get used to the expectation from other (software) areas
that only the essential changes should be specified in any code?


> Good to know that I'm not missing some other easier approach.

Further development options (and solution ideas) are in some waiting queues.


> I shouldn't have said the examples with constraints are scarce

We can get different impressions from statistics.


> -- I should have said they are difficult to locate amongst all
> of the examples that exist.
>
> Then again, I'm brand new to Coccinelle,

Further learning experiences will evolve accordingly, won't they?


> so I imagine locating the right information gets easier.

You got used to some other information sources already.



> 1. strncmp(foo, "bar", strlen("bar"))
> 2. strncmp(foo, "bar", sizeof("bar"))
>
> Neither is "wrong", per se, but the behavior is different because
> sizeof("bar") includes the NUL terminator, and thus sizeof("bar") ==
> strlen("bar")+1.


Such code specifications are questionable for some reasons.
They were discussed several times before, weren't they?

Regards,
Markus


