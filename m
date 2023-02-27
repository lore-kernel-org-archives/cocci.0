Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B87C64ED8
	for <cocci@archiver.kernel.org>; Mon, 27 Feb 2023 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aObvlPkPwUQtCkK/0evwYkAELfOittrRnVHExhl+W2c=;
  b=IdGaa5Nvc3p9FqwrQW7f1pjCIHfL6M2c1w1kWiR5CRCfJ861XPrhsUsq
   Ij05Zfq0W3FDls7eBRAbiOWXcsWY+K11HueitZ49S+CsYj7ERyr99+ucS
   EXpcERWVyiF4HpffetoYFwESisaIKfopUyVXLmIkub4hXEIrUnaE7QWJk
   A=;
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
   d="scan'208";a="94562912"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Feb 2023 16:59:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2F5EAE0152; Mon, 27 Feb 2023 16:59:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E1C84E00A1
	for <cocci@sympa.inria.fr>; Mon, 27 Feb 2023 16:28:16 +0100 (CET)
IronPort-SDR: 63fccc0f_0xNK4D7x5kTolN/t6ewELe1DLTb3rJ7osKwgoSmJ5koQIIg
 3UzOBjbN1GIyzoFwYVKbrJ3u/of+849qyGdtmuA==
X-IPAS-Result: =?us-ascii?q?A0E5AQBuyvxjkNlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLYFfLgQLRo1RhX2CJQOfVAEDAQ1EBAEBijcCHQcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBAQEBFwkeEA4FIoV1gjcpAYN+A?=
 =?us-ascii?q?QECAgEnEz8FCwsYLkkBDQYTgn6DACMDA6xSeIEBM4EBoUCBQIxAhG0nG4INg?=
 =?us-ascii?q?RU2gnQ+iwMEliIKgTR3gSMOSniBCQIJAhFvgRQIaIICRwIPWjcDCQMHBSwdQ?=
 =?us-ascii?q?AMLGA0WOhMsNRQgLQEzbC8SEgUDCxUqRwQINgUGHDQRAggPEg8GJkMOQjc0E?=
 =?us-ascii?q?wZcASkLDhEDT0MZbAQvgV8GASgkmXQBFT0hGhQ4NG8CCAoDEA5QAi0DlUwBj?=
 =?us-ascii?q?QBmn1iEA4RPnA5Mg3qMZYYkkjWXWaJehTmBeSOBXDMaCCgIO4JnTxwPoikjN?=
 =?us-ascii?q?DsCBwsBAQMJinBeAQE?=
IronPort-PHdr: A9a23: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
 wQwhw84Zv4ipm6EC7IfKV3NqC4xiw82g9q32Vis
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:FpZHfKk8TYgtb8N2CS/qCXRmId3pDfIj3DAbv31ZSRFFG/FwWf
 rBoB19726TtN9xYgBGpTnuAsS9qB/nmaKdpLNhXotKPzOW3FdATrsD0WKK+VSJcEfDH6xmpM
 VdmsNFaeEYY2IUsS+D2njcL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="48741581"
X-MGA-submission: =?us-ascii?q?MDEo29XZZsce2b0FPxJLZ4L4vvlfWCq4wTbwj1?=
 =?us-ascii?q?k1teCgYzinvjrF0QrfVag7Kg8MGYbPmxksAaVF4/DeT4g4b1icfywLKM?=
 =?us-ascii?q?q3EmACllb1uj/gp2Rs9hS9bZIsMgj/UssoOsjROtk1yV8UoxkoCiuoRj?=
 =?us-ascii?q?VQgJgsOE1+eBgyNUhZE15zGw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 16:28:15 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5A4FB60EB7;
	Mon, 27 Feb 2023 15:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C35C433EF;
	Mon, 27 Feb 2023 15:28:10 +0000 (UTC)
Date: Mon, 27 Feb 2023 10:28:08 -0500
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
Message-ID: <20230227102808.2cea9705@gandalf.local.home>
In-Reply-To: <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
References: <20230227075346.69658-1-schspa@gmail.com>
	<Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC PATCH] cocci: cpi: add complete api check script
Reply-To: Steven Rostedt <rostedt@goodmis.org>
X-Loop: cocci@inria.fr
X-Sequence: 870
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/20230227102808.2cea9705%40gandalf.local.home>

On Mon, 27 Feb 2023 12:20:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 27, 2023 at 03:53:47PM +0800, Schspa Shi wrote:
> > When DECLARE_COMPLETION_ONSTACK was used, the user must to ensure the other
> > process won't reference the completion variable on stack. For a
> > killable/interruptiable version, we need extra code(add locks/use xchg) to
> > ensure this.
> > 
> > This patch provide a SmPL script to detect bad
> > DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.  
> 
> Documentation/process/submitting-patches.rst:instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> 
> But also, wth is SmPL, the actual thing included is a coccinelle script.
> 
> > This is a common problem, and a lot of drivers have simpler problem. The
> > fellowing is a list of problems find by this SmPL patch, due to the complex
> > use of wait_for_complete* API, there will still be some false negatives and
> > false positives. This RFC patch is mainly used to discuss improvement
> > methods. If we introduce the wait_for_complete*_onstack API, it will be
> > easier to modify these problems, and the patch rules of SmPL will be very
> > easy. In the process of trying to write SmPL scripts, I strongly recommend
> > introducing two onstack APIs to complete this operation.
> > 
> > file:/Users/schspa/work/src/linux/drivers/infiniband/ulp/srpt/ib_srpt.c::2962 was suspected to return a variable on stack  
> 
> What's with this retarded file path? Are you running on Windows or
> something daft like that?
> 
> Please, make them relative to srctree.

Also, you want to state what sha1 or tag you ran this on. The one file I
looked at didn't match line numbers.

I looked at:

drivers/ufs/core/ufshcd.c

Which has (what I'm assuming is the issue that was detected?)

        /* wait until the task management command is completed */
        err = wait_for_completion_io_timeout(&wait,
                        msecs_to_jiffies(TM_CMD_TIMEOUT));
        if (!err) { 
                ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_ERR);
                dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
                                __func__, tm_function);
                if (ufshcd_clear_tm_cmd(hba, task_tag))
                        dev_WARN(hba->dev, "%s: unable to clear tm cmd (slot %d) after timeout\n",
                                        __func__, task_tag);
                err = -ETIMEDOUT;
        } else {        
                err = 0;        
                memcpy(treq, hba->utmrdl_base_addr + task_tag, sizeof(*treq));
                
                ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_COMP);
        }       
   
        spin_lock_irqsave(hba->host->host_lock, flags);
        hba->tmf_rqs[req->tag] = NULL;
        __clear_bit(task_tag, &hba->outstanding_tasks);
        spin_unlock_irqrestore(hba->host->host_lock, flags);

IIUC, the above spin lock protection will prevent the use after free of the
completion. As the completion still exists between the timedout wait, and
the start of the spinlock. And the spinlock will keep the complete from
being visible if that were to run after the spinlock.

So what exact race are you trying to catch here?

-- Steve

