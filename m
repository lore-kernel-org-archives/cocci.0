Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92684606A31A
	for <cocci@archiver.kernel.org>; Mon, 23 Nov 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=pdrHZAlh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M8AenZwvV8w3wm5n1csuPhHEsuDa2/V8kXLW0zHSUzo=;
  b=pdrHZAlhGKn7qTd9k+0ZkHvE3pDvHuuWSpQo2eR7r9WmLti5I1qMCkvR
   k33QiU09DVs/pe6jZX/P5jvz53NpiOPrqCso7xddGlNiuXPW2Ro++pGVi
   KwWD5+WL+WkUNAO04wJXoys9xZRupr5B8r7Scp/2blG3kK8UgE6zNc4ir
   o=;
X-CSE-ConnectionGUID: 0tht+2ZxQzyVrD2W9wQWvA==
X-CSE-MsgGUID: Cm6ODJj5Q5KWxZIxiuag2A==
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
X-IronPort-AV: E=Sophos;i="6.27,227,1787004000"; 
   d="scan'208";a="306841124"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2026 12:01:33 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 39E0E81BB5; Mon, 23 Nov 2026 12:01:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AFAF980111
	for <cocci@sympa.inria.fr>; Fri, 20 Nov 2026 19:14:59 +0100 (CET)
X-CSE-ConnectionGUID: M0eZghLmTr+HxaAi/ALZVA==
X-CSE-MsgGUID: 51Z0ZDtOR2WDKDCPrdeUpg==
IronPort-SDR: 6b008e23_4xL642HluGYdcnEGs3HsQwcyGfRIgTg9J5jSCEG+s6wEANd
 0kygmIBrmDt0m7ZL+Zcq1RqsX9XM5WI8qxnp3EA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F4AQB9jQBrjxABWcdahRpCAYEpMwcISYRYkXefaD8PA?=
 =?us-ascii?q?QMBDU8CBAEBAQIEgUoBgzMCjiICHwYBBDQTAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEBBAEBAQIBAQIEAwEBAQECEAEBAQEBATkFSYZPDYwaAYEkXkgBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEUAg1eAR8BAQEDIxUIAQE3AQ8LGAICJgICVgYVAQGCf?=
 =?us-ascii?q?oIjAQEETAO6D4EygQGCDAEBBtw1gWsJFYEKLohiAYV5G4RiJxuCDYE8gwU+h?=
 =?us-ascii?q?T+CYIJqgiaBDJhkUngcA1ksAVUTFwsHBWBFQwOBBiNLBS0dgSM7FxEeWBsGB?=
 =?us-ascii?q?RIgKkBDW4ESgQNdgSsoXQECH0YtFYF2AoJRgSMCWwIBSUEOB0VTCSVDEkckI?=
 =?us-ascii?q?ggSCQETGiwKgRo1PAkmPxUMWwwIAxoFGiYCHwgCCwIMdCgREBMdHiQvBRomP?=
 =?us-ascii?q?hsKgQwnHx4bDgIfEAYNbT03CgsZBD2UY4QngiqlOGuhEYQroWMGEy+XYpMQL?=
 =?us-ascii?q?od9kF2jc4VSCoF1I4FcMxowgypQAxkPjjuIfMlIIzU9AgcCBw4DC4VnjDWBT?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
 BX8oKdGw3SZEo4dwVIRgEkDrV5JZoe8dRSnjwE=
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:QBKXnq+/oxWHhpuqo6Zuk+BHI+orL9Y04lQ7vn2ZHyYlDvBw8P
 re+sjztCWE7wr5PUtKpTnuAse9qB/nlKKdy7NhR4tKPzOW3FdATrsSj7cKqgeIc0eSmoFgPM
 FbE5SWY+eAaGSS4/yKgzVQOuxQv+WvweSHhfr6x3woZR12aqd6hj0JdzqzIwlZRBRiDZF8LY
 Gb5cZMulObCA0qR/X+KHkZeuDJ4+TRkpHrawNDJxNP0nj3sRqYrJD7Dj2R1VMmSDVNzb0+tV
 HMjg2R3NTZjxk1pyWsqVPu0w==
X-Talos-CUID: 9a23:xqSKqG4nw8EhmyTV+Nss0RYZKM8lVnjh1jTwM0aRCCFAbI+rYArF
X-Talos-MUID: 9a23:aEsmbAj1D68CC+SiNtCELsMpaZ5au5aCFGc3y6oqmOWvDTZ8NgqFg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,223,1787004000"; 
   d="scan'208";a="306608185"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHz4g/adYC7TkrKp2LxNpZ+sid6O73fjwswbv?=
 =?us-ascii?q?2uq0tEid8YIqdjQLnnR7ZpVCprqDQU4Oj7FGvh/mjtQjxffGbsZe1qc4?=
 =?us-ascii?q?+XP5dl4q8qWm6Zr3Jqv4rdS5xmYN4tWdyNxUD+iGiI1/oCV2ha13FU1U?=
 =?us-ascii?q?Dq3QvONDPw8jG8xq5of7Awsg=3D=3D?=
Received: from 013.lax.mailroute.net ([199.89.1.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 19:14:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jWNlr51krzlfcV7;
	Fri, 20 Nov 2026 18:14:48 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id r9AP0Byaez3m; Fri, 20 Nov 2026 18:14:47 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:7cb0:c51b:a346:33d1] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jWNlp5hTDzlfcVB;
	Fri, 20 Nov 2026 18:14:46 +0000 (UTC)
Message-ID: <849463ae-c636-42ca-8cc2-667d84fea6fa@acm.org>
Date: Fri, 20 Nov 2026 10:14:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marco Elver <elver@google.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
 cocci@inria.fr, kasan-dev@googlegroups.com
References: <20261120092646.3062639-1-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261120092646.3062639-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] coccinelle: locks: Add must_hold.cocci
Reply-To: Bart Van Assche <bvanassche@acm.org>
X-Loop: cocci@inria.fr
X-Sequence: 3818
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/WlSrQZWMKtm7PFs4wbyAJg>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 1:26 AM, Marco Elver wrote:
> +ATTRS = re.compile(r'__(must_hold|must_hold_shared|releases|releases_shared|'
> +		   r'context_unsafe|no_context_analysis)\b')

Should __cond_acquires and __cond_releases be included in this
expression?

> +def missing_must_hold(f, a, E, pf, p):
> +	e = re.sub(r'\s+', '', E)

re.sub(r'\s+', '', E) turns (struct foo *)p into (structfoo*)p. Can this 
cause a silent false negative and garbled report text? Collapsing 
whitespace instead of removing it would keep tokens separate.

Additionally, missing_must_hold() re-reads the file, runs splitlines() 
on all of it and regex-scans it for every match. Has caching per file 
been considered? Would this help on a full-tree make coccicheck?

Thanks,

Bart.
