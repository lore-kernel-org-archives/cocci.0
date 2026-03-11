Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF531049521
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CodiYBsmL0ndtqHN7u6tywq9/pii3+ZsztJ5W7pc52A=;
  b=YVj9zjoiL31mHG6VTMXBLfzkgc7DyHxsCVsOzSxwJcdgezX0c3egWXOk
   Gmk3NwfpmJvxOPpsFDaY/oTM4rt5SemxhNnaGoOsxGTyUEZ19ZfuvF5mY
   7Do+LomdomEYbs3G1Q8zF0bPAjhCi3QmjFjCIHu7MHyyr0ixz8VFTR4s/
   I=;
X-CSE-ConnectionGUID: pwqbPr74QnSAUaVpvFQ1lQ==
X-CSE-MsgGUID: sG7X3XLqRGKXG4qn4eNLmg==
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
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267245849"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:13 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7D8E5818DE; Wed, 11 Mar 2026 10:46:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 03E60803DD
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 06:13:44 +0100 (CET)
X-CSE-ConnectionGUID: 5q0nWk+ISRmwXSiB7r5c9w==
X-CSE-MsgGUID: YaxeuOq3RUKaz+5NRFtyvQ==
IronPort-SDR: 69b0fa07_mCoEhgMKJw7TbsIIB70KlWo13kzsL2eMxWDjUFLLzps2kiV
 VyFAS3rNPznmsa89YAJ1fMYfR6PQ+/O558BTI7Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FeAQDL+LBphR/86qxagQmBUIIYKYFmMwQLSY1ThliCJ?=
 =?us-ascii?q?J4agX0CDwEDAQ1RBAEBAwSFAAKNIwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGTw2CYgGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINfQEBAQECAScTBgEBNwEECwsYLlYGE4IqWIIjByMnA60TeIEBM4EBg?=
 =?us-ascii?q?gwBAQbeEQkUAYE4iFQBhVoaG4NleicbgUlEgRWDKj6EWIYvgiaBDokKih1IC?=
 =?us-ascii?q?ngcA1ksAVUTDQoLBwVeRUMDNRIhCRUjSwUtHYEjIR0XFB9YGwcFEiEqgUl4g?=
 =?us-ascii?q?gEPhmp5Ay5eGg4iAjpcSj4LWgWCLQIcAwsYDUgRLDcUGwQ+bgeNeT6CMwEBg?=
 =?us-ascii?q?Q6BQ6AfhX5ooRGEJohkCJhsGjOXUpMZLodlkHOpQYFoOjyBIH0IgyJPAxkPj?=
 =?us-ascii?q?jqIesQPNDU8AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:rhBeAqtZpTLF62k2ViwFz51N7skDc9V00zEX/kB9WHVpmwKj9v
 xG+85rrCMc6QxhPk3I/OrsBEDuex/hHPJOjrX5eI3SPjUOxlHYT72KnLGSpAEIcheWnoU26U
 4jSdkaNDSaNzhHZKjBjjVQa+xQpOW6zA==
X-Talos-CUID: =?us-ascii?q?9a23=3A4P6rImhXXX3oXJKDwfwbJI1ZyTJuL2SFykjTYG6?=
 =?us-ascii?q?DM2N2eIaUYwCKpag1jJ87?=
X-Talos-MUID: 9a23:1MpZ/gtHQtn0Jpvc/c2ntThyOdpP+v+UNWMEg9ZbnfOqKT1uAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="140984972"
X-MGA-submission: =?us-ascii?q?MDGUC/Yy24XohMZUIklIJSO4hB3mlU/B729pAA?=
 =?us-ascii?q?Yp71p9OeVXSerKROa2m0DyKtEU9LH2V504LYW0X0TcfFjueuUDib07N/?=
 =?us-ascii?q?qxRwPOAIgF/P5siSYB9Zka+ODvP9OTov1xmpzA7TYvhmObOJpqPYwrsR?=
 =?us-ascii?q?3Qeh/cx+bXEWv/8xMkPewgrg=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 06:13:42 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E663440BC;
	Wed, 11 Mar 2026 05:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B290C4CEF7;
	Wed, 11 Mar 2026 05:13:33 +0000 (UTC)
Date: Wed, 11 Mar 2026 14:13:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Message-Id: <20260311141332.b611237d36b61b2409e66cb3@kernel.org>
In-Reply-To: <20260310100750.303af303@gandalf.local.home>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	<20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
	<20260310100750.303af303@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3393
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/mt8w3clr2ORsi11I1-0EmQ>

On Tue, 10 Mar 2026 10:07:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Mar 2026 12:48:41 +0100
> Philipp Hahn <phahn-oss@avm.de> wrote:
> 
> > Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> > check.
> 
> Why?
> 
> > 
> > Change generated with coccinelle.
> > 
> > To: Steven Rostedt <rostedt@goodmis.org>
> > To: Masami Hiramatsu <mhiramat@kernel.org>
> > To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-trace-kernel@vger.kernel.org
> > Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> > ---
> >  kernel/trace/fprobe.c                | 2 +-
> >  kernel/trace/kprobe_event_gen_test.c | 2 +-
> >  kernel/trace/trace_events_hist.c     | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index dcadf1d23b8a31f571392d0c49cbd22df1716b4f..a94ce810d83b90f55d1178a9bd29c78fd068df4c 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -607,7 +607,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	do {
> >  		rhashtable_walk_start(&iter);
> >  
> > -		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> > +		while (!IS_ERR_OR_NULL((node = rhashtable_walk_next(&iter))))
> 
> Ug, No!
> 
> That looks so much worse than the original.

Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
But if you want to use IS_ERR_OR_NULL() here, it will be better something like

node = rhashtable_walk_next(&iter);
while (!IS_ERR_OR_NULL(node)) {
	fprobe_remove_node_in_module(mod, node, &alist);
	node = rhashtable_walk_next(&iter);
}

Thanks,

> 
> -- Steve
> 
> >  			fprobe_remove_node_in_module(mod, node, &alist);
> >  
> >  		rhashtable_walk_stop(&iter);
> > diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> > index 5a4b722b50451bfdee42769a6d3be39c055690d1..a1735ca273f0b756aa1fcfcdab30ddad9bc51c5f 100644
> > --- a/kernel/trace/kprobe_event_gen_test.c
> > +++ b/kernel/trace/kprobe_event_gen_test.c
> > @@ -75,7 +75,7 @@ static struct trace_event_file *gen_kretprobe_test;
> >  
> >  static bool trace_event_file_is_valid(struct trace_event_file *input)
> >  {
> > -	return input && !IS_ERR(input);
> > +	return !IS_ERR_OR_NULL(input);
> >  }
> >  
> >  /*
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 73ea180cad555898693e92ee397a1c9493c7c167..59df215e1dfd9349eca1c0823ed709ec7285f766 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -3973,7 +3973,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
> >  	 */
> >  	field_var = create_target_field_var(hist_data, system, event, var);
> >  
> > -	if (field_var && !IS_ERR(field_var)) {
> > +	if (!IS_ERR_OR_NULL(field_var)) {
> >  		save_field_var(hist_data, field_var);
> >  		hist_field = field_var->var;
> >  	} else {
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
