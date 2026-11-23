Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A9606A321
	for <cocci@archiver.kernel.org>; Tue, 24 Nov 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=D+EJA/v8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=prYaKFvNeeWlQrQJryAk2GXhfdO1aTqsJXUejmAQUqg=;
  b=D+EJA/v8YFTm5jwgis67ZxUnMCIS2yENdABW5xnA1M2IvYOgDRXxzIpI
   J1JHBWEectrQlXii/+5NKKYkIWhtPwFZjdYaoWRKnmku64FPSJ/k5Mq6r
   wfdzWVEsNQ/rMptj7G0dCBl+Byg6fWPInyTKpq2B/X7qvwuvYAWyXZuRU
   0=;
X-CSE-ConnectionGUID: OtDnEeiSTT6W2tJNLGOQzA==
X-CSE-MsgGUID: VHOzw4qjRsyPJBqRp8YZXw==
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
X-IronPort-AV: E=Sophos;i="6.27,230,1787004000"; 
   d="scan'208";a="307039654"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2026 11:09:44 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B1FEA82301; Tue, 24 Nov 2026 11:09:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4D8128053D
	for <cocci@sympa.inria.fr>; Mon, 23 Nov 2026 17:27:13 +0100 (CET)
X-CSE-ConnectionGUID: zPIWkv+MQnWCy7INfhc91A==
X-CSE-MsgGUID: wMVV8+cVSGGRCD2FBy8UKA==
IronPort-SDR: 6b046961_vK4N5pCWB/zY7IVuMS+223J+pRMomXJx0XTomUBnza718wU
 nCwefDp5K+PiBi45oQFnTyBJhRZbyBG8kLK6xyw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EfAgA6aARrjxABWcdaglmCQUIBTlszBwhJhFiRd59oP?=
 =?us-ascii?q?w8BAwENUQQBAQECBIFKAYMzAo4iAh8GAQQzBg4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQVJhk8NjBoBgSReSAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARQCDV4BHwEBAQMjFQgBATcBDwsYAgImAgJWBhMCA?=
 =?us-ascii?q?QGCfoIjAQEETAO8JIEygQGCDAEBBtw1gWsJFYEKLohiAYV5hH0nG4INgTwLg?=
 =?us-ascii?q?no+hT+CYIJqgiaBDJhtUngcA1ksAVUTFwsHBWBFQwOBBiNLBS0dgSM7FxEeW?=
 =?us-ascii?q?BsGBRIgKkBDW4ESgQNdgSsoXQECH0YtFYF2AoJRgSMCWwIBSUEOB0VTCSVDE?=
 =?us-ascii?q?kckIggSCQETGiwKgRo1PAkmPxUMWwwIAxoFGiYCHwgCCwIMdCgREBMdHiQvB?=
 =?us-ascii?q?RomPhsKgQwnHx4bDgIfEAYWBG09NwoLGQQ9lG2EMnWlLIE2a6ERhCuhYwYTL?=
 =?us-ascii?q?5diCJMILod9kF2jbYVYCoF0JIFcMxowgypQAxkPjjuIfMlIIzU9AgcCBw4DC?=
 =?us-ascii?q?5IcgUwBAQ?=
IronPort-PHdr: A9a23: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
 ZX1bdcWkzfbHIRUlgN4bLwsuUlBZoarZhSnjwE=
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:RMQzl66zgsKRdIiOSgPXwM/XdLJyesId70hD6qkRc20yTiX8ra
 uTdZsgpHvJYUkqNk3I9ergBED4exnhHMdOjLX5Xo3SOzUO2lHYSb2KhLGKqwEIfReOldK1vp
 0QEZSWZueRMbEDt6nHCf6Df+od/A==
X-Talos-CUID: =?us-ascii?q?9a23=3AFIGGpGnbxJloGcIoRxVyFk4Z45zXOW/l7UjTPQy?=
 =?us-ascii?q?dMGBWY6zKaHme+Kg1yuM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9ka7oA3rJCLptaw/ONe513+1KTUj/IGQNhBOmqs?=
 =?us-ascii?q?9lOa+HgAqFR2M3AmUa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,229,1787004000"; 
   d="scan'208";a="306923259"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDErMLkA9jAyHgJ0ATUSo0AP3GqqL/s8TTsnPV?=
 =?us-ascii?q?nHphygbnMc+vb4EJ0mdeNj+LDrxiiYg/fwPDC7rpdut0qypA5zOp2Ubd?=
 =?us-ascii?q?lj9X9iQB83FtYSdYsARhIIKeYO53SQou+9S8tK+SZxBYljXnAoK/S9xh?=
 =?us-ascii?q?rLniMsGXr6p9He+2c2PEDdlg=3D=3D?=
Received: from 013.lax.mailroute.net ([199.89.1.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 17:27:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jYBBw6S3pzlgy1t;
	Mon, 23 Nov 2026 16:26:00 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yygoOFxefgOr; Mon, 23 Nov 2026 16:25:59 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jYBBv05J1zlfcns;
	Mon, 23 Nov 2026 16:25:58 +0000 (UTC)
Message-ID: <4f7c329e-d722-427e-8279-14c55fce7d71@acm.org>
Date: Mon, 23 Nov 2026 08:25:56 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marco Elver <elver@google.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
 cocci@inria.fr, kasan-dev@googlegroups.com
References: <20261123104616.226112-1-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261123104616.226112-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3] coccinelle: locks: Add must_hold.cocci
Reply-To: Bart Van Assche <bvanassche@acm.org>
X-Loop: cocci@inria.fr
X-Sequence: 3820
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/2Q4deILVQaZjzrxoORPzAQ>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 2:45 AM, Marco Elver wrote:
> Clang's context analysis treats lockdep_assert_held*() as an assumption
> that the lock is held. A function that asserts instead of being
> annotated with __must_hold() therefore passes the analysis, but its
> callers are never checked.
> 
> Add a script that reports functions which assert on all paths that a
> lock is held, where the lock can be named in a function attribute, and
> which are not annotated with __must_hold*(), __releases*(),
> __cond_releases*(), __context_unsafe() or __no_context_analysis. A lock
> can be named if all identifiers in the lock expression are parameters or
> member names, or if it is a global of the form &name or &name.member.
> Functions that mention the lock before asserting it, e.g. to acquire it,
> are skipped.

Bart Van Assche <bvanassche@acm.org>
