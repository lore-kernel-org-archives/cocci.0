Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62F6C4345F
	for <cocci@archiver.kernel.org>; Fri, 19 Apr 2024 06:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Tp4fDh1EM73eA9LppB8jCZQssdvVqY1VS8ada0xBL2I=;
  b=D30a+R5a3zKceH6kuPQTvogHez88G1TTak0bDw48cCNLMGPzUcGbjxy/
   XdMvYnMKJxIhtDDbiZ17thjQaTwQvLb9P/i8vOUs6P8MnHtt4bi8ZmP7s
   BC+8+hmwxpX1YFOz1C7HA+2IZHr6ixSzJDuCMx/JbeE/OWyqCHSl7nAxs
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,213,1708383600"; 
   d="scan'208";a="162353282"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2024 08:51:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE23CE0133; Fri, 19 Apr 2024 08:51:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C3AE1E0035
	for <cocci@sympa.inria.fr>; Fri, 19 Apr 2024 08:51:22 +0200 (CEST)
IronPort-SDR: 6622146a_XyZQb32se4rdM+/KUwnOiAilqRjT2WEjw/nnUhNsZfwRkMc
 cwpCxQtZh82NgUNOECYEKVZFXEY9pgKeej8rQ8A==
X-IPAS-Result: =?us-ascii?q?A0FCAgATFCJmhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CRH9UMwQLSIRWkTuEa4c4h0+IcYMWPg8BAwENQQECBAEBAwSEfwKIIQIeB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ?=
 =?us-ascii?q?4VwDYJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgIBAyMdAQERJgEPC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgnyCMAEDMQexJYEygQGCDAEBBtpZHywiV4FhCYEaLoguA?=
 =?us-ascii?q?YV8CYQ3Jw+BVUSBPIJLOD5pg1qDW4JomzWHB1R9HANZMgFVExwUDSQjAik+A?=
 =?us-ascii?q?wkKEAIWAx0UBDARCQsmAyoGOQISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB?=
 =?us-ascii?q?3WBfIE3BBNEAxCBMgaKDwyDCQIFISmBTCmBKYMHCENxFYEIAoJ3gX0OgRodQ?=
 =?us-ascii?q?AIBC209NQYDCxsGIgEdoTmBDzDHeTQHgjaBYIFhDJ9EBhMvlzgOBpJomGIgq?=
 =?us-ascii?q?GWBeyOBXDMaJIM2TwMZD44gGYQUm3ZBNTsCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:AaO/bqmB6zALq0FTKSqqSuIstR7pDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQ+VxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A3P29VWuiZnITJrGSWuQu26en6It5TnfA4lH5M3T?=
 =?us-ascii?q?iDGF4a53ISFK544pdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AYI7wGw8WbEjIsv+VOpESnLGQf/4r3ZSJKXhWq58?=
 =?us-ascii?q?t6+m4Ky9TFzGkkjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,213,1708383600"; 
   d="scan'208";a="85210917"
X-MGA-submission: =?us-ascii?q?MDEDqg9g24Cp3TteCP9UsPUGnfDCZ/Dy3WVFyJ?=
 =?us-ascii?q?YMRUiTEcj+hbZvcGx7OCRxGpwUEGX8qPTNPjlpojz7MAECbnlYdHC5Vx?=
 =?us-ascii?q?ZBb+PFuzDEEMaPPdgeoPd7I4dWsBxCAdHlmnoBHRHqxhp8kWDOfLaMaH?=
 =?us-ascii?q?bU2QwOEwnwmualIzgZzF/RdA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 08:51:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713509480; x=1714114280; i=markus.elfring@web.de;
	bh=Tp4fDh1EM73eA9LppB8jCZQssdvVqY1VS8ada0xBL2I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hz7scD+I+gTR5ejWD3rX7rgAzJ2u/DHZkEq+PpdaB8wp2N7HJ8+CxD/vpxCY2svA
	 bXbsciwuAxovyCMSnTBnsqPIaKDlc4qjBc8OuA2RjNuUNFcuv/p/U5uAK1otyyQ0T
	 6vp3arBHXC4f2+Gbdh+LLtzaExr4Zkr0Vtrg6O1i6xrYOjRGisCZrHluok1heULtq
	 kFNKoJk3kAi4udxJCejt3rpeKz6lohWvjnI2pivqhoSs+oBP/qjn298cSmUT2CEN5
	 05uIRyQEhNIpYZRHJSoPOcG6rEivtvwKKcEBfESntD/DCuDN5PB/m0i17OvLA9Zks
	 nZ4f/gKLUYKIQJnN/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1sbQd61dvk-00gZyN; Fri, 19
 Apr 2024 08:51:20 +0200
Message-ID: <f1f47166-00d7-49f3-9b80-34aa7b7b5510@web.de>
Date: Fri, 19 Apr 2024 08:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
 <alpine.DEB.2.22.394.2404182255010.3213@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.22.394.2404182255010.3213@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZqBxasO1k8IZLHBuzwDX0hZEP94LaRo3JlVkMX5m417nUWPFam5
 JaWUOpVcL2/fEHCh67X0zRkV687+xjduWG5zNnNaorIpsL+Py5LGtjiJea+eFcdiOk8nwvx
 ivZbmu4QpPs0M2TY+ArXMJrniBX+QNmYzdY/Zf5WzAbjnqZlvOMDp0Pnu6EtvNNbLPSoMVc
 oc//e1kok5W4vhTL71wMA==
UI-OutboundReport: notjunk:1;M01:P0:XpNQKZxqhRE=;nnLa+g7p9oEH0zrRsObeIx72MQP
 7vGqAqqLin1TpJLALxWnCj7UqWgZdegrKpV2m2h0nj7/u47fVVyz3boDtdSKm6nBfDxWzQXJa
 eb/PMN9q0E6asMwSX7mqoCl9/hlTA3PYh4XgK8SJUrRqdZAyYBA5xM8zEOWxAgGlzyPY+ZfoV
 p3rB7ctc2t3QqP5KnAa45QAJzyS+jrlTBEbAsx5gwqydgPCzGn/sF2N9x9wLPOakqFJ5UhwBx
 kUrfl1/u0h/k0MQT6KCDYld0Dy8qJIYQbm7ZtuS4MyYYwA806K5DcyUEO7Kk+uz8hH/A2+uR7
 kVsLP/bMpHoEMw5CaWx+pa+mAZ92pGG8xP4DE92iUIGqt4RyO8XauzyhMw8sQdyieFbQg80+X
 1SDIlZUeyoC2aC4Kzn3n1B8I0/9+CAjm27K+xcf9pMUTJMglKH2FSddfQMGO83+zo7/YAhHRe
 JuHYzFXkXBjB0Zu4XTzJTAMfQbJhSiN5WoXeZYHV/jLdXF9U62h6iv1gNwEdFlU3tdxGrXzQS
 G66Qg9LAAHxFw4A2gNl16HSo9jFTz2LCBNUUsErAcMQ2wU/eHZnivan72gRdx3Ymfq7nFBJg0
 WUXLwOoCBmRS1jmK55wj0t5FJKm/alZRWLi3XZMi0VjhUYS94TCgl6NAM1cGzu6c6x5Mg+PxS
 cShZkSOw4EuO+/9kI0Yy8aQWbcbTdmEYdV3hy35Z+pbGE9xwgl7nUsPme4qdJA9b2tR6QIJZy
 cI+b2WpcGGmI1Eb1rC4+t6FDm8iwnOnRWalGIRwv6sZHUUMhxIHb7BYLKgMp8Pcr4xg3HDDlZ
 YLXFqrrPPCIb3ZenwQewy76CYfwgMrB6oYu+lVKSah7Gw=
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1674
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/f1f47166-00d7-49f3-9b80-34aa7b7b5510%40web.de>

>> Most of the people prefer:
>>
>> return ret < 0 ? ret: 0;
>>
>> than:
>>
>> return min(ret, 0);
>>
>> Let's tweak the cocci file to ignore those lines completely.
=E2=80=A6
> Applied, thanks. (Coccinelle for-6.10 branch).

Was a planned code adjustment published?


=E2=80=A6
>> +++ b/scripts/coccinelle/misc/minmax.cocci
>> @@ -50,11 +50,26 @@ func(...)
>>  	...>
>>  }
>>
>> +// Ignore errcode returns.
>> +@errcode@
=E2=80=A6
>> -// Don't generate patches for errcode returns.
>> -@errcode depends on patch@
=E2=80=A6

How does such a change fit to the usability of the coccicheck operation mo=
des
=E2=80=9Ccontext=E2=80=9D and =E2=80=9Corg=E2=80=9D?

Should dependencies be reconsidered any more for the desired consistency
of involved rules for scripts of the semantic patch language?

Regards,
Markus
