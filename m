Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F42C7EE23
	for <cocci@archiver.kernel.org>; Mon, 27 Feb 2023 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QkbV26wUL7q/a/HK00+6KFobqpJyB0lIa8tZqJEdBGE=;
  b=tvpqE1XGV8b9XLUMsESK+kPNtT1E9rm8Jz7NEyu1fvQ310FYnLPIja32
   oN2ZRSPtbJ3Hw23GeBOpE9TdYh33H2juGk/JyuRAS+xJAiqZZYbSzMGn/
   UXBeUDaQAzYUE/byfQb8HC+5WrQN8JCHxauLtLrfXMz0Gw74Dc76vm1p8
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="94562948"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Feb 2023 16:59:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4EEA5E0166; Mon, 27 Feb 2023 16:59:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 34439E00A1
	for <cocci@sympa.inria.fr>; Mon, 27 Feb 2023 16:53:18 +0100 (CET)
IronPort-SDR: 63fcd1ed_ZjZ4Wa3AwmkOyyLj70jZt8ygMJslr+bI5He5Zv57jGK038O
 9BtPoVvO0E6y8yJcw65T8kvlUeOp/sEDw4SR/Lg==
X-IPAS-Result: =?us-ascii?q?A0E5AQCo0PxjkNlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLYFfLgQLRo1RhX2CJQOfVAEDAQ1EBAEBijcCHQcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBAQEBFwkeEA4FIoV1gjcpAYN+A?=
 =?us-ascii?q?QECAgEnEz8FCwsYLlcGE4J+gwAjAwOvA3iBATOBAaFAgUCMQIRtJxuCDYEVN?=
 =?us-ascii?q?oJ0PosDBJYiCoE0d4EjDkp4gQkCCQIRb4EUCGiCAkcCD1w3AwkDBwUsHUADC?=
 =?us-ascii?q?xgNFjoTLDUUIC0BM2wvEhIFAwsVKkcECDYFBhw0EQIIDxIPBiZDDkI3NBMGX?=
 =?us-ascii?q?AEpCw4RA09DGWwEL4FfBgEoJJl3FV4uOYEkOJZJAY0AZp9YhAOET5wOTJcDk?=
 =?us-ascii?q?jWXWaJ2DoUTgXkjgVwzGggoCIMiTxwPoikjNDsCBwsBAQMJi04BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:Nr2ANaEH2QYjxBagpLqE58eALOsnbusQ8zAXPo5KJyC9Ffbo8f
 xG/c5rsiMc5wx9ZJhNo7y90ey7MBDhHP1OkO0s1NWZPDUO0VHAROoJ0WKh+UyDJ8SUzI9gPM
 lbHJSWcOeAaGRHsQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="94561503"
X-MGA-submission: =?us-ascii?q?MDFR4uj6CzqbcIde+EukKjz2i3pnfORE1G6RT/?=
 =?us-ascii?q?6vOh8kojqcP9t9e4dmGpjeTPJXd+rxMQtfrVVXWlGPeaeOmOeovSpmE8?=
 =?us-ascii?q?ctnlRhYMr1UcCe4QgL3CNmsB2dG3VsgZnhsfaRQITnXObCRzvSeIuQt1?=
 =?us-ascii?q?7tdjsHGGqFc8Zrjktr5re64w=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 16:53:17 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9A48A60EA2;
	Mon, 27 Feb 2023 15:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D4C433EF;
	Mon, 27 Feb 2023 15:53:11 +0000 (UTC)
Date: Mon, 27 Feb 2023 10:53:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Schspa Shi <schspa@gmail.com>, linux-kernel@vger.kernel.org,
 cocci@inria.fr, mcgrof@kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, buytenh@wantstofly.org, johannes.berg@intel.com,
 gregkh@linuxfoundation.org, tomba@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch
Message-ID: <20230227105310.08d9a46e@gandalf.local.home>
In-Reply-To: <Y/zPv+L2iqOkD2Oa@hirez.programming.kicks-ass.net>
References: <20230227075346.69658-1-schspa@gmail.com>
	<Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
	<20230227102808.2cea9705@gandalf.local.home>
	<Y/zPv+L2iqOkD2Oa@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC PATCH] cocci: cpi: add complete api check script
Reply-To: Steven Rostedt <rostedt@goodmis.org>
X-Loop: cocci@inria.fr
X-Sequence: 872
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/20230227105310.08d9a46e%40gandalf.local.home>

On Mon, 27 Feb 2023 16:43:59 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 27, 2023 at 10:28:08AM -0500, Steven Rostedt wrote:
> 
> > So what exact race are you trying to catch here?  
> 
> on-stack copmletion with a wait_for_completion that can return early
> (eg. killable, interruptible, or timeout) can go out of scope (eg, free
> the completion) with the other side calling complete() on some possibly
> re-used piece of stack.
> 
> IOW, Use-after-Free.
> 
> Care must be taken to ensure the other side (whatever does complete())
> is either terminated or otherwise stopped from calling complete() on an
> out-of-scope variable.

I got that. But as you were stating as well, when care is taken, the script
appears to still report it. The example I gave has:

        req = blk_mq_alloc_request(q, REQ_OP_DRV_OUT, 0);
[..]
        req->end_io_data = &wait;
[..]
        hba->tmf_rqs[req->tag] = req;
[..]
        err = wait_for_completion_io_timeout(&wait,
[..]
        spin_lock_irqsave(hba->host->host_lock, flags);
        hba->tmf_rqs[req->tag] = NULL;
        __clear_bit(task_tag, &hba->outstanding_tasks);
        spin_unlock_irqrestore(hba->host->host_lock, flags);


And where the complete is:

        spin_lock_irqsave(hba->host->host_lock, flags);
        pending = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
        issued = hba->outstanding_tasks & ~pending;
        for_each_set_bit(tag, &issued, hba->nutmrs) {
                struct request *req = hba->tmf_rqs[tag];
                struct completion *c = req->end_io_data;
 
                complete(c);
                ret = IRQ_HANDLED;
        }
        spin_unlock_irqrestore(hba->host->host_lock, flags);

So the spinlock is making sure that the complete() only works on a
completion if it is still there.

I guess I should have asked, how is this script differentiating between
where there's a problem and where there isn't.

If you remove the spinlocks, then there would most definitely be a race,
and I'm not even sure if the supplied patch would improve this much.

-- Steve

