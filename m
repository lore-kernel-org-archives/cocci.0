Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86ADEA8533
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=577KrSVJOsbOyWuHRJhGKfZec10NEZcerc6sw564IJ0=;
  b=jMALiWW/9N4L9ezNTQtRT8JZJEpXWzeG+q1Wd8+DHO/Q4RdwP+XKJbh3
   +DF6tufnyE9kkvmfhhOJ8j1068CJk/0bNlXArxr6HiZN0rV3RMj58YRvy
   X/wxWlLP27nOBYHVX/nFhkiYrrMsOG8nS595+dughUzQdrypP1iuCGqdS
   Q=;
X-CSE-ConnectionGUID: 6GW6MpYHRkKlojH6IRbdyg==
X-CSE-MsgGUID: Ivgw2XVeS9KLxsxrvVKB3g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="266749890"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 17:08:57 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 903CB8160C; Sun,  8 Mar 2026 17:08:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3EC0680EE2
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 17:08:54 +0100 (CET)
X-CSE-ConnectionGUID: I0Nqtu6bSe2HVsj+ykCqPw==
X-CSE-MsgGUID: Gf2wLUtvSeuh+AKjOtp1fw==
IronPort-SDR: 69ad9f16_sOd/Vj4LahLVO+Nb/ti/Q1dgFknra2eZV66JN7e9UdLydmF
 G5n7Xo+I8i8ALywGICeMmc41gNZLWr66tJoyWpQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FRAgDYna1pgAQP49RagQmBUIJBaB9eNAQLSYRYj1OCJ?=
 =?us-ascii?q?IQ7jxGIeYFVgX0CDwEDAQ1ECgECBAEBAwMBhQACjSECHgcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINO?=
 =?us-ascii?q?kQBAQECASMdAQERJwQLCxoCGA4CAlYGARICAQGCfgGCIgEGEAEDDycHDQarH?=
 =?us-ascii?q?IEyE26CDAEBBoFGAgwCQ9hLHywiWYFnAwaBHy6Fb4JlAYYvhD8nD4FVRIE8g?=
 =?us-ascii?q?lIxPoJhA4Ffg1uCaYImgQ6Le4cwUngcA1ksAVUTFwsHBYEjQwMqLy0jDzwFL?=
 =?us-ascii?q?R2BIyEdFxQfWBsHBRIhKoFpeIIBD4ZoeQMuXhoOIgI6XEo+CgFaBYIlAgELb?=
 =?us-ascii?q?T03CQsbBD2Ocj6CM4E5AiJvx2k0B4I4gWeBZAyKLpU/BhMvl1IOkwuYIGYii?=
 =?us-ascii?q?22Beps4gW8LKIFcMxokgzZPAxkPjl+DdYELg1XENEUyAjoCBwsBAQMJhUYBA?=
 =?us-ascii?q?YxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:sVR8mKj4JlIcaDGnYMWxoRkjjXBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: 9a23:iozXXWEjul2Ypx8vqmJGrGgNBt17eEbQllfuOE37GGVCUYWKHAo=
X-Talos-MUID: 9a23:U0vDewQEAGVwBVDRRXTDimt9EPp0/Z+jFUBOuLYEnNWcbCJvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="266749879"
X-MGA-submission: =?us-ascii?q?MDEZ9dKOXxulzyNfdvyb0swsfQnpDIE1lefqke?=
 =?us-ascii?q?C3HDpfvjibCpLOLEb+JiAmfqKMzQSCvO4RkAVCYadd0MaO1dBrCx8ryB?=
 =?us-ascii?q?K6M2derhdYEZK0YUC2wb0P4Y+nS7BDPVrVAFYAlE+oex7SIr33C/s+HN?=
 =?us-ascii?q?oURRkt5Kx27/sP9rRBcxcaiQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 17:08:53 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3ug-1vSegp06V0-00qnEf; Sun, 08
 Mar 2026 17:08:53 +0100
Message-ID: <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
Date: Sun, 8 Mar 2026 17:08:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
 <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OxAIoSKb/6faCe82kSRgeB3Nm/UUz8CyI/fVfhZJmiMlCgJL/7R
 MJudGceAdbdXuLfJb5vHL5htsXFHlw+6j5fdxNfS6w6W6oWuEO7xAybgQiArLHUzaAXmtQ+
 RiTJLOzkkM7OUIlDP9Szu8etNTH7FQXHQaT4JzthHJqv9xrSQWJfKJjoBitHb3NrWVHM18f
 b4zMTp7SC9waMubKJTAUQ==
UI-OutboundReport: notjunk:1;M01:P0:8ZAxO6tellI=;YXcAwL+Yockq++kJKEzTFIUs/gI
 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
 6fCTivEdhN8UtT3qgfUprUYedNSZg
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3333
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/FeM0lq3sGXIuiJd77bZxFQ>

>> Under which circumstances would you dare to acknowledge remaining open =
issues here?
>=20
> If you can tell me what result you want maybe I can do something.

Can you see concrete change opportunities from my recent test results?

1. Inappropriate difference output
   https://lore.kernel.org/cocci/349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.=
de/
   https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00004.html

2. Questionable hierarchy level
   https://lore.kernel.org/cocci/20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.=
de/
   https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00015.html


> It's not a matter of daring to do something or not.

Will development interests grow anyhow?

Regards,
Markus
