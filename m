Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78FBCC6B33
	for <cocci@archiver.kernel.org>; Thu, 15 Oct 2026 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+iNt1ZN1awP3QtLz+KT7PKyGu52nrjki8HDScJnxeYs=;
  b=BWNu4J5wAlsM3ka9x8GsHHUBgpMCOs2KA/iOvvBaAMb72b+x2B1yfRgE
   f2A9FLr2ys36fZBfmSzXnj4qE3cNBR2bivLxdZOeJiwRGS4h7w87S5QoO
   fS73P2MCKc3Iaq7FdtDVqAs7ezZblePvtSF0cJmca8Jn2eaD6UOcy03zx
   M=;
X-CSE-ConnectionGUID: RJyFXBrQQXqVa/dba6FVqw==
X-CSE-MsgGUID: jb41yx4VQ/OBa2BKx2Cb/Q==
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
X-IronPort-AV: E=Sophos;i="6.27,159,1787004000"; 
   d="scan'208";a="300323114"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Oct 2026 11:24:25 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4DDB5812CE; Thu, 15 Oct 2026 11:24:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7008181D30
	for <cocci@sympa.inria.fr>; Thu, 15 Oct 2026 09:37:58 +0200 (CEST)
X-CSE-ConnectionGUID: Ln7xVunNToy+Q1kO3hnkew==
X-CSE-MsgGUID: FN+vTzcIR8KsWdyG+9Ezsg==
IronPort-SDR: 6ad082d5_tElhuwIlsG9WuVU+ju3EVYZjYMYt3hYNRAoWMFs+QS0ROrd
 PN+b1NUEh7KaASjprS0eR0vYRi0/5moa4Z/IW7w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HOAQDVgdBqhSIym1paglmCQYFsMwQLSY1ShliCIQOeH?=
 =?us-ascii?q?BSBaAIPAQMBDU4BAgQBAQECBIR+Ao4VAh4HAQQyBw4BAgQDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAUBJhk8NjBoBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CDX4BAQEDOgYBATcBDwsYLisrBhODAoIqSwcBu3iBNIEBggwBA?=
 =?us-ascii?q?QbcNIFrCRWBOIVygm0BinUnG4FJRIEVgys+hCmGX4MylwpSeHgsAVUTFwsHB?=
 =?us-ascii?q?WBFQwOBBiNLBS0dgSMhHRcRHlgbBgUSICpBQ12BWjwjGTZ6gQlegSspYAECD?=
 =?us-ascii?q?hdGLhWCBwKCVIEjXQIBSUEOB0VTCSVDEkcmIggSCQETGjALgRs4PAkoQRcMZ?=
 =?us-ascii?q?Q4MHQUhUQgCCwIJDW09NxUZkzMegmWBD4FDZWGWMbAWC4QogWafdgQWM4QEl?=
 =?us-ascii?q?BeSVC6HZpB0glmmaYFvAzCBXE0wCIMiUAMZD447iHzJKUI1PQIHAgcOAwuFR?=
 =?us-ascii?q?AEBjFaBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:jN0zh6HZD77Z8ak9pLqE1MeALOsnbusQ8zAXPjNKKSC9E/bzqy
 nAppgmPHPP+VMssTQb6LS90cq7Lk80l6QZ3WB5B97LNzUO+lHYT72KhrGC/9SPIVydygcQ78
 ldm90UMqyXMbAy5vyKmTVRTrsbsb66zJw=
X-Talos-CUID: 9a23:9yaFkmBHzrzu/436Ew1hq14qB8YDTnrMj06JIGjjCWBqRaLAHA==
X-Talos-MUID: 9a23:PxhtNQYXodrab+BTmRmvmg1wP+ZSs4e1N0wcvtZXltufOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,159,1787004000"; 
   d="scan'208";a="300292266"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFmOAH8xgCLbrOgQxl6E0c2FqEzwS8KGXDohY?=
 =?us-ascii?q?4PAqLnvtpyxJryxEQZoGbVu4QbQu7qdz/hCQyVhVLFtZfh+1mFdJveyH?=
 =?us-ascii?q?ifmdEjW2DU6J/E5DAoG0mDKg7hBy4aDdnIDTd+LgSAcksRGsT5UUxfDu?=
 =?us-ascii?q?huePiCyy4fgmEVBEn57pcWAg=3D=3D?=
Received: from casper.infradead.org ([90.155.50.34])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 09:37:57 +0200
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHG2B-0000000BlKh-3lc4;
	Thu, 15 Oct 2026 07:37:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00B403006DD; Thu, 15 Oct 2026 09:37:50 +0200 (CEST)
Date: Thu, 15 Oct 2026 09:37:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, cocci@inria.fr
Message-ID: <20261015073750.GI4121339@noisy.programming.kicks-ass.net>
References: <20261014134745.3032405-1-christian.loehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014134745.3032405-1-christian.loehle@arm.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] sched: Replace nr_iowait_cpu() with a bool
 accessor
Reply-To: Peter Zijlstra <peterz@infradead.org>
X-Loop: cocci@inria.fr
X-Sequence: 3752
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/ysGMTkAy6E43xzfZVcBvMw>

On Wed, Oct 14, 2026 at 02:47:45PM +0100, Christian Loehle wrote:
> The menu governor was the last consumer of the per-CPU I/O-wait count
> that needed its magnitude, apart from nr_iowait() summing it globally.
> Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
> that use. All remaining per-CPU consumers only test for zero/nonzero.
> 
> Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
> and s390 idle accounting callers. Have nr_iowait() read the counters
> directly so that the global total and existing accounting are preserved.
> Replace the stale menu comment with a description of the predicate.
> 
> Include the Coccinelle recipe for the code conversion, verified against
> the original files. The helper's comment is updated manually. Reproduce
> the conversion with:
> 
>   make coccicheck COCCI=scripts/coccinelle/api/cpu_has_iowait.cocci MODE=patch
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  arch/s390/kernel/idle.c                     |  4 +-
>  include/linux/sched/stat.h                  |  2 +-
>  kernel/sched/core.c                         | 13 ++---
>  kernel/sched/cputime.c                      | 10 ++--
>  scripts/coccinelle/api/cpu_has_iowait.cocci | 56 +++++++++++++++++++++
>  5 files changed, 69 insertions(+), 16 deletions(-)
>  create mode 100644 scripts/coccinelle/api/cpu_has_iowait.cocci

So I like this; but I'm confused about including the cocci script. Why
is this?
