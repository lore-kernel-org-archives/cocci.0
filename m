Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8670FC433EF
	for <cocci@archiver.kernel.org>; Sat, 12 Mar 2022 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Sqas582fEJ9yZK8ml7fvorG6qx/ZZhgLBt+J1fbzjOc=;
  b=fOWclGm4iqq2uXmmwgyJbzNdaqZhozBsCLVV/3iJ4XwIWRh3P7T76wSR
   nHT82WCYangOrnNgWsr0gHwQq2M988vcxZApJaM9VtZHW2ORY1nMkXri+
   HY7+PXhCfaRWyOoeXLGKUD/wNfKhioqdqLaoduga6YtLtDj0LA1wnvMAA
   8=;
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
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="25797166"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Mar 2022 16:18:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8E08E0048; Sat, 12 Mar 2022 16:18:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EB569E0045
	for <cocci@sympa.inria.fr>; Sat, 12 Mar 2022 16:18:50 +0100 (CET)
IronPort-SDR: MuEG1uYGo8ZivkOL3VNyxRVKve3C2FzO858kZsijuLe960Z3tjHrVgqi2QTZKlXQ6nL7RigTBW
 olLYsZdBrBjeiQYr0j/8a2T8mlgmJlqyoxSBCPwjnXKg13chifUI0Yaa6HxtIc8yHmjltWlPdY
 ZqPhUwAbhOQVe51n3m29d4xO1Ka7CakfUtmuehvY7jpo4hucNRouwtqW3lcrmz80ZqoWWRTc8D
 xMOtQ5MM5/058h6mQ17oQc0W0ffkALQXycPQrtJmhCfgV8JedszipzPfpQiLoLt/SDueyx4bpw
 VRl20XmxQIBNlGq1dpIXH41p
X-IPAS-Result: =?us-ascii?q?A0BdAwDhuCxihwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VoCgiZpFVcrBAtEhFSQajGSOYongXsLAQMBDTcHAQIEAQGFBwKEJAIdBwEEN?=
 =?us-ascii?q?gQNAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBDwsaAiYCAlcGDQgBA?=
 =?us-ascii?q?YMAAYJkAQMNJQuuKoExgQGCCAEBBoRIHywiUoFbAwaBECwBjU16JxCBVUSBP?=
 =?us-ascii?q?IMDPoJjAgIBhHeCZZhjlH2PKZ5BNAeCEoE6gUALiT+UTAYULoNhklkOBpFpl?=
 =?us-ascii?q?leNE5logXsHgXQzGiSDOE4BAgECDQECAgMBAgECCQEBAo4dGYQMhGGFS0A0O?=
 =?us-ascii?q?AIGCwEBAwmFRwEBjRwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:D2xb6aDbBN0WgxVW/+/kw5YqxClBgxIJ4kV8jS/XYbTApDol3jZTn
 DAaCGiHMvuNa2fwf4hyOd+39kpV68XQzdJkOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPgWVvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYowuJzvxrz
 Y5EjqCPclYGB7DJh/ReUDANRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIq
 ZT0KxhVBvyHr8e/2rGmUa9Bgso5Lc/kFJwSsDdswFk1CN52Gs6eHvmVjTNe9AsXnctrQOb1X
 u4+ZB13NDjLTSxxIH5CXfrSm8/t3xETaQZwo1Werqsf+HnW1AU30b73MdOTdMbibcFcgU+co
 krU/mHzGBhcNdqFyDPD/GjEuwPUtSb8RZ5UC7CysPJn6LGO+oANICMWBHehpKKwsXKBYINwE
 lER5TptroFnoSRHUeLBdxG/pXeFuDsVVNxRD/A25Wmx90Y5ywOeG3RCUTNLLtAr3CPXedDI/
 g/V9z8MOdCJmOPPIZ563unNxQ6P1dE9dAfunxM5of8+y4C7+ukb10qRJv46SfLdpoCrRVnYn
 m7bxABj1u17pZNajM2ToAGX6xry/cKhZlBuuW3qspeNtV4RiHiNPNDztjA2LJ9ocO6kc7V2l
 CNdypbEs7xWU83lee7kaLxlIYxFLs2taFX06WOD1bF4n9h003L8L41W/h9kI0JlbpQNdTPzP
 h3MtAkX6JIKZCmmaqp+YoSQDcU2zPG8RIq/Ca2ONoJDMspraQuK3CByfkrOjWrjp0gbl/1tM
 5msd8vxX20RDr5qzWbtSupEie0ryykyyHn9X5f+yxj7g7OSaGTLG6gIOh2CY7lhvq+DpQzU9
 fdZNteLkkkODrehP3OPqYNKdAIEN3k2A5zyuvd7TO/bL1o0AnwlBt/Q3aglJd5vkZNVoeGUr
 HuzbUlVlQjkjnrdJATWMX1uZe+9XZt7qn5nbyUgMUzxgiomZpuzqrgSfd07cOB/puBkyPd1S
 dgDetmBW6geFG6Ypm5FNZSt/pZ/cBmLhB6VO3T3ajYIf6lmG17D9Ojic1a97yIJFCe26ZAzr
 uHyzA/dWpZfFQ1uANyPMaCqyE6t+2cQkqR+UhKQcNVUfUzt9qlsKjDw16NmfZtTdE+bnjbKh
 RyLBRo4pPXWp9Fn+tf+hZeC89WjHdx4ExcIBGLc97u3aXLX82fLLVWsiwpUke0xlV8Y+ZlOo
 c1QyOzgduIKlhBGvuKQ1lqtIb0Wv7PSS31yl2yI30knq3y0B7kmLnTuMQxnqPhW3rEA0eepc
 hvnxzSZUIll/Ov6HVRXKAdNgiFvEx0LsmG60MnZ63kWKMO6EHRrnKmS09SxZPRhEYZI
IronPort-HdrOrdr: A9a23:e6Y6DKs2WZSSWJpdQkda7VEf7skDUtV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="8365547"
X-MGA-submission: =?us-ascii?q?MDGqY3XY8Phr5NLKrVdHNI8wAKRhLEXe90ecOJ?=
 =?us-ascii?q?VQy3hUPVqMUPkjjvuBHxZJgSgCopmhplB19QSEe6udQ6bSJCUEmTJtQN?=
 =?us-ascii?q?O7/9ZVUppuTN/lQoYVoewltvy8Kv393WLZUlbp6dOKOITtkyGalcB2ix?=
 =?us-ascii?q?HxahpaNKyZgeOALgoAX9ovtg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 16:18:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647098329;
	bh=Sqas582fEJ9yZK8ml7fvorG6qx/ZZhgLBt+J1fbzjOc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JV+4pMUfHaHYbIXFFGW9ZpngqvQoTEYU+DqkCKA+mO0yMinNNisTZ3unOj+8/TB+c
	 R+mMtg5LsBeKL9ZbLa8hXjKd2PamzFbcKQDBbEGoiP4sWS3Xf1/i6tDk33A7w4bDsE
	 52cQ0kwLE22dme/KfGiMmAYxO0SXl2neMVhVlK2w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.146.255]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkElZ-1nrLaT3H21-00kRLO; Sat, 12
 Mar 2022 16:18:48 +0100
Message-ID: <ed8f2b09-4d7b-c07e-9e19-67e6d9bee6fc@web.de>
Date: Sat, 12 Mar 2022 16:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <d9dae057-06ad-f6a3-f4ac-5cd56c9ce081@web.de>
 <alpine.DEB.2.22.394.2203121452420.18925@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203121452420.18925@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zxKCfPY4MDrBpwKJ69qyS8suUwIz66KpeG6/0FxBolPRWQ3SxA5
 +zoKNpj8NLo/+jz2oKjbKEBuYz7N+l/Ht0Z+70sWne3xaieE2uh9e+IXEl4GQmcGXz893+p
 DCqQo0+O+4dNgXkjQu15Jw5aAgyylUl1Mw8nQB6Ox/r65zQUYFtFPWiv8XksQwb1YHyxRCq
 faHh0IcvNYRV6xaMrtXvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mbCjrXY5DqM=:3fztMbhn3jAdYhuO40YjWt
 v2b4Rcd4a2VCN5fhpOep+UcX8IzVOktmn5VazOln+gZw1plG1+HKr+XvTWu4mBrHIh8mC5Lri
 7I4f5y+wfwnAZELAVp7Xwq8nLR1vu1tNfP+OP3URAiG9LzcsaVzwMZerNr1WHRWNR3MQBzr9a
 SfHAcSquZGHr7pm7X5eBg7u4fURBlX7pX+2OTanbFC+lIs49pZ/C9XFpKTOYjvOpm+ncS9505
 UUiFaAhc8YH19mbWrbp7LRlQTF7Iq0pdK+PDSn1BgrMc43xi/bC1+K/8xbLPR5PlD+BZy7EQi
 r96Tq30S1o+gTaeSIzPE/H31T0nnHUk+p/KgraUfRk/6+QNa9UBxuXSsUjvL+qB/HPr/J0ERd
 d77cFVWJVwKq5Db/8hrL675r1qdSiIqhgMdOnWjbdOA+WMgN9v0uMyRpt8oWFoLrd0k7P+AwN
 1ZhocVPJ2cTYcZ3Zs4Bct4MTTed4sXM3HmNbbxvRrvyi7PKA1FIluWg0hF4GYldjUzvKYc87F
 o83RsWopTlufnea8Lfro4Ua4WjE1dgaS+EkXJEhikvrDXttpqqvNlF95zZ/ijM+nTHykZCsgu
 iogmD61t7un+utINPUkgvNXT3Detf1JSAdbBbpCihJn6P3kzVsYC/1PF34ZLqXCU1s41dFFF5
 HQotxYvha1CJWlvhZVwDCKD3bHCkeXnGFsGy0RodK4OXOYfIFnZpvChH8YO+p+RQrQdUv9AqN
 tccYaJZ+p7Y/APQJ4ulJbhk6O9wK9jnGeJlJdApSqWSCTNNNiZKcR6o802PJ9+8odmuSz8bD4
 5cbLBOSAzzRbkUWpNCxReg3V7sJfHgad1od87RfG0cCmNsi2QQTN2CZ3lncVMNzE6mQtYQIzN
 RqjdfaxCK+nGB6sqNKtg9TgMOyuoxke5XzGLh+IBWyauEVbHjKJGv+3G34h93DGrCbJiNbZvm
 bh15nHRnmMJ40xw60jd/OCxBJd/CR/bQjrXoExbvoDVb+t423vx39xpmmHJnnasnUud+R/Zdj
 IoyGfvHx5czXVTbRv6Ap4d+C05O7voepo7wgrxGgwY93iXZSi30/uz5swMZcn+dxGP5ENq0NC
 kdNhveZ/ig2EYI=
Subject: Re: [cocci] Collateral evolution because of context-dependent
 grammar of SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 210
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ed8f2b09-4d7b-c07e-9e19-67e6d9bee6fc%40web.de>


>> Advices were published that context-dependent grammars should safely be handled
>> by more sophisticated parsing technologies.
>> https://en.wikipedia.org/wiki/Comparison_of_parser_generators#Context-sensitive_grammars
>>
>> How do you think about to clarify corresponding design challenges any further?
> The parser has different entry points according to the context.


Would you like to share any more background information for such entry points?

Regards,
Markus

