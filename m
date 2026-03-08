Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFA5EA8543
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4aXaJMzZWAr/LcTAHuGx7oT4+z4ykytZshu8k7LPdvU=;
  b=ClbpR7XyHxxzkEXEX/HKFfO7e+Uhi6dIstJJcWs5i8r9eyMit9f6+u8s
   qGu8Yk5nSP8xzB+ZteuwH44rEcyeYnqdEhgSfr14E9XteENRAy6UE8V/M
   htOS5hNLPtwGT5ZlAX0kFC72ZbvNLmO8h23wVp5EOMQuP32kZSEehTtJp
   o=;
X-CSE-ConnectionGUID: EitNJFyYSuqrAq0dPEsZtQ==
X-CSE-MsgGUID: 3gj7s28rS6iR4oGw99rsVw==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266757914"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 20:54:28 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B2FD381665; Sun,  8 Mar 2026 20:54:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DADAD80ED3
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 20:54:22 +0100 (CET)
X-CSE-ConnectionGUID: njqleCTyTlGq88TFUPqlEA==
X-CSE-MsgGUID: tpDg26wXSNOgru+66a70Sw==
IronPort-SDR: 69add3ee_VGVjYP8/UZdmFfZbczREalCB0qbBe3KAglqsQcYbTxIwl2G
 GjyIsSJ7k+MjUe7UQOPIZDTOdppy6/ec4VtX3Zg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FVBAAF061pgAQP49RagQmEEYFhBDQEC0mEWI9TgiSEO?=
 =?us-ascii?q?4c8h1WIeYNSAg8BAwENTgECBAEBAwSFAAKNIQIeBwEERwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCGA4CAlYGARQBAYJ+giMBBhABA?=
 =?us-ascii?q?w8nB6wAgTITboIMAQEG2mQfLCJZgWcJgR+GHYJlAYYvhD8nD4FVRIE8C4JHM?=
 =?us-ascii?q?T6IHoJpgiaBDoxdhk5SeBwDWSwBVRMXCwcFgSNDAyovLSMPPAUtHYEjIR0XF?=
 =?us-ascii?q?B9YGwcFEiEqgWl4ggEPhmh5Ay5eGg4iAjpcSj4KAVoFgiUCAQttPTcJCxsEP?=
 =?us-ascii?q?Y5yPplQkVOhRTQHgjiBZ4FkDJ9tBhMvg3EBk2AOkwuZBiKpH4IigVwzGiRPg?=
 =?us-ascii?q?mdPAxkPjl+DdchvRTI8AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 GmlUVbOwhkRkdiJndsQLTgjssqi6jQyB+rE
IronPort-HdrOrdr: A9a23:15VNsK+E+OftBMv8tBtuk+GZdb1zdoMgy1knxilNoNJuE/Bw8P
 re+sjztCWE7wr5PUtLpTnuAsS9qB/nmaKdpLNhXotLsmHdyReVxcJZnPbfKwSJIVyAygcl79
 YfT0EmMqyAMbEZt6bHCXiDYrIdKYK8gdmVbI7lph8HcegpUdAD0+4eMGmm+yZNNWx77PQCeq
 Z0z/A31AaISDA4btmbGnJAeO7fp9La0KviaQMIAQUigTP+/Q+A2frVEwW4whxbaD9G27EkmF
 K16TDR1+GMs+yb1hSZ7GPY741XlNz9o+Ezf/Cku4w6KijMlg3tX4hqW6SDsDcp5Mmj5U0nis
 OkmWZUA+1Dr13QY0Coql/W1w7s3C1G0Q6b9XaUjWH/ocvwWTI9DNApv/MqTifk
X-Talos-CUID: 9a23:INa8r2yGX0v8JNI2+yJNBgUSGNkhf1bh3UvUDFboWVpHdYWMTXK5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AJTSyMg9TarrBJl4eIGg+QUuQf9twz6v0Vl89qrM?=
 =?us-ascii?q?htNOZdnIuMmjFtyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="140728241"
X-MGA-submission: =?us-ascii?q?MDFmHK9WxPMH4zd6UIC3XH+3248A09l5GZUklf?=
 =?us-ascii?q?gOYVGlGfcVFygKw0kdT/k40X1nrOviiQ1OEjQAhrYSY0/ZR2sMv3wDqI?=
 =?us-ascii?q?eXUmRmGlvGH62c39+7MjAC6erhH19l+psUcuutJaftJ3lEwTk8hLCJzx?=
 =?us-ascii?q?ZZoUjdMpsH/OXl5egpr7A7lA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 20:54:22 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvsln-1vgh9n3iwZ-010Jo1; Sun, 08
 Mar 2026 20:54:20 +0100
Message-ID: <65d5cb2a-4155-45b9-b95d-946e558c4ad1@web.de>
Date: Sun, 8 Mar 2026 20:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
 <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
 <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
 <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr>
 <cd1bbe8e-ef35-408f-8754-173678bf3204@web.de>
 <f715289c-54d3-2c0-43fd-e6669973c5e1@inria.fr>
 <8ceb30ad-1143-4086-afeb-45b639c87e49@web.de>
 <1265ed1c-65e4-318e-8186-618346a4802d@inria.fr>
 <f12f438e-a89f-462a-b166-d6af025cdc28@web.de>
 <aa67fc7a-62b7-b6fd-d860-fd73623e6b77@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aa67fc7a-62b7-b6fd-d860-fd73623e6b77@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KAnxesgaWuqPS8qXXI0VebZsWG3wVmIIYF0RICa4yIVHhOwS/Qt
 McdJ4Fl0aOlCD6CmjTnfEqnF4+RsWVb9sDuyI2Ipn0Ru03eAtmTsrvk5L1l5lleE1J26UZf
 ATRfkZdf58zBnH6kwF41i/a1ZyXeZmugDpcmYrcsABr3ZQOTXWMBSl0hlR2wFbiOaurB4Yz
 jPOqOWxAGiTRdlJU0yeUg==
UI-OutboundReport: notjunk:1;M01:P0:Vw4iev+wK5k=;Ocfxx9toN2KEwcekzXS9nnkyRha
 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
 UNeIL4OE=
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3342
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/bhDnZoJce3k_aJgbIlyHpw>

> A statement list metavariable only matches the code starting right after a {.
> It can't start in random places.  Nothing is going to chenge here.

Will ever any other metavariable type become supported with which a mixture
of items (including statements and variable declarations) could be handled
in a succinct way?

Regards,
Markus
