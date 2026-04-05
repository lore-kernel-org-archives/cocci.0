Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7258E64014
	for <cocci@archiver.kernel.org>; Sun,  5 Apr 2026 05:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=S6GRsior1cvHvVF2xSO0WGzLjXV7Wz76gpCYxK4GSwA=;
  b=vnZJxWYNvaKofhqEXYz753+GsrV9QDpVRAu7mEKwwcgr8fGS6B+eG0XB
   lkLJN8y3qPke36vih+MsA4AO80Cp6vrJ6lw7OuFxnpG90YGysocBNslgm
   i9bHbJiIfg11zCz4+2vyL3qVnh5TnwDBOTSw/6KOIcouoW1RLNUGIXfX7
   c=;
X-CSE-ConnectionGUID: i+V/C2DUSY6JQMc03jEqOg==
X-CSE-MsgGUID: pE3QYv1qS1Gq/hgHzasMhw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,161,1770591600"; 
   d="scan'208";a="271068040"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Apr 2026 07:56:48 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7FE8E80565; Sun,  5 Apr 2026 07:56:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6548D804D4
	for <cocci@sympa.inria.fr>; Sun,  5 Apr 2026 07:56:44 +0200 (CEST)
X-CSE-ConnectionGUID: +53SRP7SQYSBavRhzTB0ZA==
X-CSE-MsgGUID: bCVrMhPlSWCmMOGRkTI6xA==
IronPort-SDR: 69d1f99a_EAh6GAqWWbKyM675SKGaEiBkyUMFUkzFQkrGwwfmEcUcMAD
 tqwDN2Ic+1ecedHgNzzN4/v0uU6u00BLNeVBVTg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EvAwCV+NFpgwsR49RahRpoH140BAtJhFiPU4ZfjxGIe?=
 =?us-ascii?q?YNSAg8BAwENSgQBAgQBAQMDAZItAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQUBAQECAQECBAYBAhABAQE6Bw47hk8NgluBLIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTptHQEBESc0AhgOA?=
 =?us-ascii?q?nMBAYJ+AYIiAQYQAQM2Bw0GtTmBMoEBggwBAQaBWEFQ13sfLCJZgWcDBoEfL?=
 =?us-ascii?q?oVxgkocAXOKJA+BVUSBPIYiAQIBAYIqgw6CaYImgQ6EGQaMNIFKHANZLAFVE?=
 =?us-ascii?q?xcLBwWBZgOBBm4yHYEjPhc0WBsHBYFLiHmBEgGDeWYCAQttPTcJCxsEPYxEK?=
 =?us-ascii?q?IMXVwKCPZM8kTyMYpRjNAeCOIFngWQMiQiBJpU/BhMvl1IOkwuZBo4JlWATh?=
 =?us-ascii?q?UWBfyOBXDMaJIM2TwMZD446g2czgQvEUkQyAgk0BwIHDgKFTwEBjFaBSwEB?=
IronPort-PHdr: A9a23:apeXVR0HHcVT44xpsmDOVA4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeCo601xwaSDNmTq6odzbaN7+a4AS1IyK3CmU5BWaQEbwUCh8QSkl5oK+++Imq/AdjUKgcXJ
 4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+M
 Ai6oR/eu8QYgYZuMLo9xgfGrndVdelbwWxlLk+Xkxrg+8u85pFu/ipftv4768JMTaD2dLkkQ
 LJFCzgrL2866Mr3uBfZUACB/GEcUmIYkhpJBwjK8hT3VYrvvyX5q+RwxjCUMdX5Q74sVjuu9
 rlmRhD1hisfODE37G/YisprjKJGux2hvABww5TVYI6OKvVzeL7WcM4ASmpAWsZRUDFBAp+5Y
 oASAecNIfpUoo/grFYIsBCwBxSjBPn3xzFLiHH50qM13fohHw/bwAMuEMkDsGjWodjvKKseT
 f65wavOwD7eb/1WwzD96I3Qfx4mu/6MR7FwcdfKyUIyGA3FiluQqZbkPzOT2eQGrm+W4e16W
 uK1iG4nthpxriKgyMcohInJnIMVylbL9Shizoc6O8a3RFRmbtG6CZZdsTyROIRqTM04WW5op
 Do6xaMcuZ69ZCUH1pcqywLCZvKJfIaF7A/uWumQLDp7hn9oZKyziha8/EW91uDyWMq53UtEo
 ydbj9TBtn4A2wDQ58WDSPZz8Vus1DCS3A7d7eFEJFo7lavdK5M5w74wkIATsUXZESPslkX2l
 reaeVk8+uiw8eTofLvmqYGGN4BqjAHxLrohltajDuQ/NwgDWXWQ9+ek1LD740H1XatGgucon
 qXHsp3WP9kXq6yjDwNIz4ou7Qu0AS2839QCh3YHKUpIeBKZgIjtPFHDOPX4DfCig1Swijtqy
 e7JMab7DprQMHfPiLbhfbBj5E5A0Ac/081T64xOBr0fPv7+WFX9uMHaAxMjLgC43v7rCNBn2
 YMfXWKPDLWZMKTXsVKQ4ewgOfOMZIwIuDbmMfQr6PrujXEjmV8ce6mp0oAaaX6mEft9OUmWf
 GTjjs8bEWgWpgo+UPDqiFqaXDFPYHa9Q74z5jAgBYK9DYbDQ5itj6ab0Ce6GJ1WfGFGBUqWH
 XfmbYWIQ/EMZzmKLc97jjMETaShS5Mm1Ry2qQP207VnIfTT+iMbr5zuzNZ76eLLmREo6zN0E
 ceT3XuVQmFxmWMIWiM20LpxoENj0ViPy7V3jOJAGdNO5PNJUwI6OIbEweJ1Bd/8RB7Pc8uPR
 lq+X9qmBCs+TsgtzNIWe0hzAs2sgB/b0yqxG78VmaSGCoYo/6zBwnb9P919y27I1KY5j1kpX
 M9PNWq+i6Bn7gbdH4HHwA2lkPOhcq8X3QbM8n2CxCyAphJ2Sgl1BIDMR3MCfQP7qdrj50XNB
 +uLAK4kLxAH5MqMMKpMZfX2gF8ASPq1a4eWWH64h2rlXUXA/biLdoe/Iw31vQ3YAUkAyEUI+
 GqecBM5HmGnqn7fCzpnERTuZVnt+K9wsiDzVVc6mieNaUApzL+p4lgNn/XJbvoJ3a8f/golp
 S91GlmVwN/cTdaN9EJ6ZKsJWdom+x9c0H7B8Ql0P5iuNadn03sXaQdqpAXD0xttC4NPudcnp
 jUmwVk6MrqWhXVGcT7QxpXsIvvXJ231qQiocLLT00rC3cy+/6AS9LInpl+lsAzB+lMK1XJh3
 pEV1nKd4s6PFw8OSdfqVV5x8RFmprbcay175oXO1HQqP7Pm+jnFk8kkAuco0HPCN59WLb+EG
 QnuEsYbG9nmKeoknEKsZw4FO+Ya/bA9Psevff+LkKCxO+MokDWjhGVBqIdztyDEvw91UO3Vx
 NAox/+C3w2IfyjxhhGtv4G/mIxJYy0TAnvq0TLtV8ZaYqx/e5pOCH/7eZTtgI8k2Ni0BDgBr
 Q3GZRtOwsKidBuMYkao2ARR0R9Sunm7gW6jyCQylTg1r62Z1SiIwuL4dRNBNHQYIQsqxVrqP
 4WwiMgXGUayaA183j6s/0Xn3O52oKplLm/caVhFdW76IisxN8n4/qrHeMNJ5J4y5G9yWf6/f
 EvcZ7rzuRoc3Av8EmEYyD1xJFTI8t3p2hd9jmyaNnN6qnHULNpxyRno79vZXfdN3zACSUGUk
 BHvD0Ond5ms9NSQzNLYt/ymEnmmTttVeDXqyoWJsG2643drCFuxhaL7ltriGAk8mSj1srsiH
 QDBthXhec/G06qgMORoVlZlDhnw5oJ2F5p/nY05mJwLkSJD3NPPpyVByDi1aIwT0Lm2dHcXQ
 D8X39PZhWqtkFZuKH6E3cOxV3mQxNdge8jvZ2oX3iwn6MUZQKyQ7bFCgW50ug/i9FiXO6Ii2
 G5Cj6J3uxt4y6kTtQEgzzuQGOUXFEhcZmn3kgiQqsu5tONRbXqudr650Ax/m8qgBfeMuFI5O
 j6xd5E8ECt39sg6PkjL1Si5z4j+e8TLK/8XuAeVlRjokOVfbp483Klv52IvKSfmsHspxvRux
 zlnx5Knp86qL2t3/aS2KgFVPHv5aolAn1OlxbYblcGQ0Ye1G5xnETheR5rkQ8WjFzcKvOjmP
 QKDQ3Us722WEr3FEUqD+V9r+jjRRouzOSjddxx7hZ1yAQOQL0tFjEUIUSUmy9QnQxuyypWpe
 RV84S0NoEH1oF1Ax6phZRz4T3uatAmvcCg9UpTZMxdcqA1PgiWdecXM6+VuA2RS+YCnpwHLN
 WGRIQhFRWhbX0uZGxXoJbOz4dqGquGeCrP4JPzLBNfG4eUMUvCV2dekyYBh5S7Kb8yJMiAkB
 Po+klxKWXQzcyjAsxMITSFf1yfEbsrA4Qy55jUytcentvLiRAPo44KLTbpUK9RmvR6s0++FM
 KaLiSB1JCw9tNtEzGLUyLUZwF8Zij1/PzirH7MasCfRTaXW0qZJBh8fYil3OYNG9aU5lgVKP
 MfajJvy2NsaxrYtDExZUFX6hsyzTckNPn37K17NQkqGdfyHKTDN38DrcPa8RLlX34A2/1W7v
 TeWFVOmPyzWzWCzEUr1bqcV02fCZU872sn1aBtmBGn9QcizbxS6NIQyljgq2fgvgWuMM2cAM
 D96ekcLr7uK7CoejO8sfg4JpndjM+SAnD6UqufCLZND+95iGCdpjKR35Hogyr1axD5JTrp5l
 WGBy7wm60HjieSJxjd9BVBWrS1XgYuQoUh4EaDe64UGRnvOuh4Apzb1aVxCt55uDdvhvLpVw
 97EmffoKTtMxNnT+NMVG8neLM/v2JsJNB30BHjLAQFDQTP5bQk3YmRCnfvU+nDH9vDSRbDzl
 ZBIRrIJDTQI
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:VYMbs6rq4iXQXujYXzLN9BsaV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: 9a23:nAMb822R5c6FRgPOtIQ3ZbxfWZ1+SUflk0zpEnSSAHhTSK+pYwei0fYx
X-Talos-MUID: 9a23:YbtjWgt+1gr1MYlKb82njhpcLuJo26CVN2sItLIpgcq4FHJgEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,161,1770591600"; 
   d="scan'208";a="143269520"
X-MGA-submission: =?us-ascii?q?MDGNHWuvwRdPBJYvcIMQ6VMw3hf11o3zGHqNB+?=
 =?us-ascii?q?roaOunHU3QwwH8ybRiBWc9CjPPDx/OqR5XSILs35OtAgw8kYGl+CAqzK?=
 =?us-ascii?q?paf85cALcdFyZyw3sbEmh3XQm0JhySnyam50816BNqK1zqP139bajdfV?=
 =?us-ascii?q?ayUfgpkmz/VHOXJprZeKd82Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 07:56:43 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3uS-1vYFtI1iva-00iyS9 for
 <cocci@inria.fr>; Sun, 05 Apr 2026 07:56:42 +0200
Message-ID: <272fbb1e-ac55-43c7-aa2b-3fd9ceb60798@web.de>
Date: Sun, 5 Apr 2026 07:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/OpeUs+kHqmGIxfqD1Hbt86SOsWh6gOyb+G+6RndCqRa0WLZ5TT
 JTS1AjGbF4Uh9dkHh8OicQMTqEYD0WQHCogfyhgz6MS/xlaCeulC6fYsRaqQtDbi7P1lptU
 gmF0h6PJl01ghVG6F8E9ZvIbjGKTRuabSQlmZqe9xo08pBppt0iG+Cv2MkGqppsZ/NXhApm
 wpRog25YN6O0hVrqCNxdg==
UI-OutboundReport: notjunk:1;M01:P0:NXg7q6Iglj8=;M2Vq+mzZiAJnCSctxi6xiw923AK
 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
Subject: [cocci] Completing SmPL metavariable types?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3473
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/TAshXzQiCU1rsfFs1WRDMQ>

Hello!

Metavariables are supported to some degree.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/docs/manual/cocci_syntax.tex#L209-288

A few types are still missing according to the known abstraction hierarchy.

Examples:
* https://en.cppreference.com/w/c/language/operator_other.html#Function_call
  https://en.cppreference.com/w/c/preprocessor/replace.html#Function-like_macros
  Is there a need for a special representation of function/macro calls?

* https://en.cppreference.com/w/c/language/operator_assignment.html
  Would it occasionally be also helpful to restrict expressions to assignments?


How will data processing support grow for such items?

Regards,
Markus
