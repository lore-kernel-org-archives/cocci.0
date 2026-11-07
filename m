Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2786606A332
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=lbK35R6S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=glmAhu6cBm93GaJ89+fisQGN1MVgRtvigg3DMVqGHHs=;
  b=lbK35R6SuAWeBbK93AEX8COZoHQ7etSTH38sXZ1fHo1adNnuhupdt3ou
   sDESAi9n32v89fia9Xej7WzLsnO3iwj77RkZ1TRvdzRMGXHKOYsBfaXtT
   uPDl/dEeWUoyZybNfMTulFxiMA6O6a3oDfxiZpkjlspgntR7pAEJJqRTZ
   0=;
X-CSE-ConnectionGUID: lS9Nf7t4RY+qu3Ca/BPCAg==
X-CSE-MsgGUID: /gl7rX8rQ0uW2oSfs4eYeA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323869"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:35 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0DE0F81BEE; Sat,  7 Nov 2026 11:59:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6191980F74
	for <cocci@sympa.inria.fr>; Sat,  7 Nov 2026 10:10:42 +0100 (CET)
X-CSE-ConnectionGUID: ZBhqIATeQPyNi+chK6+bTw==
X-CSE-MsgGUID: fcU7uqFCQ/68FZ2Ok7bdZg==
IronPort-SDR: 6aeeeb11_7KP1lxKKyxESXdHyC+te+3mUD8SMuoeVKT4FRxNK2Vr+OQv
 NODRy2if6G5O3Dhfk8pwHMdz1zY7CfD5qwnqBFg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E/AAAV6u5qgAQP49RaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgkCBazQEC0mEWIgbhziBdIEPixmHVoh+gVWBfAIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QECBIR+Ao4eAh4HAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBA?=
 =?us-ascii?q?gQDAQEBAQIQAQE7Bw47hk8NjBoBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjH?=
 =?us-ascii?q?QEBESYBDwsODAIYDgICVgYBFAEBgn6CIwEGEAEDNwe9WoEygQGCDAEBBoJr2?=
 =?us-ascii?q?AAfLCJdgWsJFYEKLgGFc4JuAYY0CYQ5Jw+BVUSBPAuCeT6FP4JggmqCJoEMl?=
 =?us-ascii?q?0BSeBwDWSwBVRMXCwcFgSUQMwMqLy0jSwUtHXAMJxIPHRcRHlgbBgUSICpBQ?=
 =?us-ascii?q?1uBEoEHXYErKF0BAh9GLRWBdgKCUYEjAlsCAUlBDgdFUwklQxJHJCIIEgkBE?=
 =?us-ascii?q?xosCoEaNTwJJgQ7FQxkCxoFGkcIAgsCDHQoERATHR4kLwUcJj4bCjZtPTcGB?=
 =?us-ascii?q?AsZBD2TOIcJpHqhSDQHgjmBaoFoDJ9vBhMvg3EBk2EQkw4uh12QfSOpIYFoO?=
 =?us-ascii?q?oFcMxokgzZQAxkPjiI+g3fKXUYyPQIHAgcOAwuFRAEBjFaBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Nl4Do6jnAP86qFFxghj5u8JH4nBQXg4ji2hC6mlwRA09TyVXrb
 HKoB1p726StN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOHhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BkWqF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:X2Pe7W8i6dZGdYgZBP+Vv3w+GtkEW0HQ9U/BBU77AmZKFv6fdUDFrQ==
X-Talos-MUID: 9a23:g+fleQu8LntvtYupws2nijpfa9pxzY+XTx5dv6dcnMrbPyBCNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304316333"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGATg79+cycynLlVP5NJh8rZ2XfwBPTdC6Fkp?=
 =?us-ascii?q?xs2G0LDyK8n1Fiyj2946xMqd9EI0xEli7Lk8YbRso+S4FxFbTr3VPjx4?=
 =?us-ascii?q?OPRhTNLSK/YlpkA31UaqfviUylylo7IHemLP/QGpmJYYjrZwjNsTi2fK?=
 =?us-ascii?q?723wySD19SeKbYXM4oeIireg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 10:10:42 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mw9x2-1wXWNy292q-018GD1; Sat, 07
 Nov 2026 10:10:26 +0100
Message-ID: <f453b06d-20d4-4781-a2aa-48fbdff1206c@web.de>
Date: Sat, 7 Nov 2026 10:10:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Chad Aldreda <ca@modelmiser.com>, cocci@inria.fr, tools@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall
 <julia.lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20261106193517.3267013-2-ca@modelmiser.com>
 <5f30dd50-a764-8e8-8b27-5c26ad10a7dd@inria.fr>
Content-Language: en-GB, de-DE
In-Reply-To: <5f30dd50-a764-8e8-8b27-5c26ad10a7dd@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VbS9fPPQHMwoUY/92smz0i3bafqFtbvOyrVfp39XhH74rM8N+DB
 WrEbCbdznumJlI79oilTM7jlWXgDXwOionj6k3DjSiNDcFK0O4csgoN3B3s9h5dtMrr04ok
 ddh7NrA7sVdubMkUXU0LigAnsC9oLnrQ+XEnPJNNUh6E9ylW4zkM9wIhk6YASPEkqalKdYx
 wh1IYOay4SqM/1cy5e+EQ==
UI-OutboundReport: notjunk:1;M01:P0:9QdrGdG20Xc=;0RNeuG/i/N9SijMKdfhy+8eMV/5
 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
 QI1xjL5rK63POSNURyfstf9A
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api: add a checker for device nodes
 in devm_ memory
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3785
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/bjU03EsUIZ4XUf0hzZnp2A>
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>> +@alloc depends on org || report exists@
> Since you only support org and report, you don't really need depends on
> org || report everywhere.

Would you get into the mood to collaborate with all known coccicheck operation modes?

Regards,
Markus
