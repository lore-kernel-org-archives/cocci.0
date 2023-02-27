Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6C8C64ED6
	for <cocci@archiver.kernel.org>; Mon, 27 Feb 2023 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aq+VLdY4aNQ5pxLlJPA/q6c9pyCPQ69D53VyrAtsJWk=;
  b=cwLSjGgVBZikM/jXPKgSedAKpt53f1cL2v/eqH7ymiZfNpG3WC9MqADo
   yVZ8dEck0sWm33KNKv2mkqTjJVAnxy3Lh61dZ4pRwLKlESGvc9I7xxrmT
   Mh2U5r7l0guDbgyox1ZtQA3vMZi9IcPJWlGTcBfwmBinwSR439PfoiUbR
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@infradead.org
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="94562932"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Feb 2023 16:59:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C7CCFE0150; Mon, 27 Feb 2023 16:59:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A5F2E00A1
	for <cocci@sympa.inria.fr>; Mon, 27 Feb 2023 16:44:13 +0100 (CET)
IronPort-SDR: 63fccfcb_3B78TUvyD8PNDrQ1E9XQ3KseA0Mhx4neziHARzdHTKmbpH4
 EUALV2EOgCd/afk94PHNXU/qSQuFtNGNxybg1aQ==
X-IPAS-Result: =?us-ascii?q?A0ERAAAlz/xj/8dcm1paGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AgEBAQELAYIsB4FYLgQLRo1RhX2CKBafLw8BAwENQQECB?=
 =?us-ascii?q?AEBAwSEfgKFMAIdBgYzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AEBAoEGE4VoDYI3KQF1gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgInCUleAQQBO?=
 =?us-ascii?q?gYBATcBBAsLRhAcKwaGESMDBAGtSoE0gQGCCAEBBp1JgV4JgUABjD+EbScbg?=
 =?us-ascii?q?UlEhD8+iwOWJgqBNHeBIw6BQoEJAgkCEW+BFAhoggJHAg9cNwNEHUADCzs6P?=
 =?us-ascii?q?zUUIC0BM4EbJAUDCxUqRwQINgUGHDQRAggPEg8GJkMOQjc0EwZcASkLDhEDT?=
 =?us-ascii?q?4FIBC+BXwYBKCSZdxVeLpheAa0zC4QDgVWfIjKDZ6VRl1mjBIUTgXgngVlNM?=
 =?us-ascii?q?AiDIk8DGQ+OIIkGimZANDsCBwsBAQMJhUYBAYYGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 D3eFrDN0sCN/6xU
IronPort-HdrOrdr: A9a23:p+LkKqsUzkT+vOsDb2b9W2HU7skDd9V00zEX/kB9WHVpmwKj9/
 xGuM5rsyMc6QxhP03I/OrqBEDuexzhHPJOj7X5eI3SJTUO21HYSL2Kj7GSoQEIcheWnoQxuZ
 uIMZIObeEYZmIK7voSjjPYL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="94559180"
X-MGA-submission: =?us-ascii?q?MDHwNNwB0yQ4+hG0uhv6LTiUYErCxLIvdi6Ccs?=
 =?us-ascii?q?DTIvhPxob441Z/W5j0yEZyuRA6Dkwz/ReVnXwrF8bCYDW8rQmaVZaavf?=
 =?us-ascii?q?aZnFoAqTrQKznsNgNuaUXJW8Uuzci90M0FScSk5JPLzyDMNyHr7vWhSV?=
 =?us-ascii?q?Ec3+3rOumt+kP3B2ZZ/9PVOg=3D=3D?=
Received: from desiato.infradead.org ([90.155.92.199])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 16:44:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aq+VLdY4aNQ5pxLlJPA/q6c9pyCPQ69D53VyrAtsJWk=; b=RUDVj7c24v4KEFF+H1IMRrl8YG
	HbRzSpgLY3JFQDrOrTk7Ukfj/h/iqQQvbLpG2NfR6QDaJG9SkUNul7OwTRbGAEy+jvEOI51G7cHDN
	pXXogSkKfhhNg4zAmpr7LZ4SWqa22uOFsE6t8YHQnuvaoXjW1tFYjGJTcWcBBAkmV8YEFHwKRVB9L
	d7rxQqsHdgkN/uU14Oayy8gjCBKK0p5TLzu1mPDC9mMKxhf0yIpLb7dmo6PWmw/woMOY1h1FnsM5v
	0Lq7oodnz+TMmYJtv50UwVi0sO+GGuR6n/XAavvvhsn8jAWecrAe52FNBJZUopi9M9GMTVCr+ORIW
	QCBoWs4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pWffU-00EGTN-2e;
	Mon, 27 Feb 2023 15:44:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5DC03003E1;
	Mon, 27 Feb 2023 16:43:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F576209F7545; Mon, 27 Feb 2023 16:43:59 +0100 (CET)
Date: Mon, 27 Feb 2023 16:43:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Schspa Shi <schspa@gmail.com>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, mcgrof@kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, buytenh@wantstofly.org,
	johannes.berg@intel.com, gregkh@linuxfoundation.org,
	tomba@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Message-ID: <Y/zPv+L2iqOkD2Oa@hirez.programming.kicks-ass.net>
References: <20230227075346.69658-1-schspa@gmail.com>
 <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
 <20230227102808.2cea9705@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227102808.2cea9705@gandalf.local.home>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC PATCH] cocci: cpi: add complete api check script
Reply-To: Peter Zijlstra <peterz@infradead.org>
X-Loop: cocci@inria.fr
X-Sequence: 871
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/Y%2FzPv%2BL2iqOkD2Oa%40hirez.programming.kicks-ass.net>

On Mon, Feb 27, 2023 at 10:28:08AM -0500, Steven Rostedt wrote:

> So what exact race are you trying to catch here?

on-stack copmletion with a wait_for_completion that can return early
(eg. killable, interruptible, or timeout) can go out of scope (eg, free
the completion) with the other side calling complete() on some possibly
re-used piece of stack.

IOW, Use-after-Free.

Care must be taken to ensure the other side (whatever does complete())
is either terminated or otherwise stopped from calling complete() on an
out-of-scope variable.
