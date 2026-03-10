Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF3AEB105C
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HPL66xu6ufWwmWtPeO/cE7zqEYWvLRdiXRFNaq8HLM4=;
  b=IAFX8rTE8X2hqlKqTia7typQ1dROk/L5x1Uw40gqxRS8RNbb+uYECCeu
   l9UV0smv7J//mTbAW1rASKMa8xFY14ZNP1O3GiBX+o5YSgcjHjulPzezS
   YdOrVjt/2Lfz824GDbQJeuGciTy5yoSMmHvFZfcmpbGBtq99obCWfnex+
   g=;
X-CSE-ConnectionGUID: 4U7c8iyKRC6knms+g3T+kw==
X-CSE-MsgGUID: n3j5Z7skT865JIstKwTxxA==
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
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267117238"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 15:25:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0F929839A7; Tue, 10 Mar 2026 15:25:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 72FAB83950
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 15:08:15 +0100 (CET)
X-CSE-ConnectionGUID: GPq/MosVS+mXyhiFMW+ywg==
X-CSE-MsgGUID: IQDTweniT/SiAvdEqa45VQ==
IronPort-SDR: 69b025cd_dUTl5QFTynqKjihOGqeSovYD2VjvXYRlaMl2jtzRDC+vLDR
 5EGAL+cO4zJlwPnt9nsWe1b/xPDgyUPyIcCnw3A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GNAQCPJLBpgxEsKNhagQmBUIIYKYFlMQMHCEmNU4h8n?=
 =?us-ascii?q?hqBfw8BAwENUQQBAYUHAo0iIAYBBDEIDgECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBATkHDjuGXIJiAYQAAQEBAgEnEz8FCwsOOFYGE?=
 =?us-ascii?q?4IqWIJNJwMFrSqBATOBAeAuFAGBOIhUAYVaGoR6QoINgRU1gnU+iwcEgiKBD?=
 =?us-ascii?q?okKihZICngcA1ksAVUTDQoLBwVeRUMDNRIqFSNLBS0dgSMhHRcUH1gbBwUSI?=
 =?us-ascii?q?SqBSXiCAQ+GankDLl4aDiICOlxKPgtaBYI/AwsYDUgRLDcUG0JuB410PoIzA?=
 =?us-ascii?q?QGBDoFDph2heYQmhHCcaE2qay6HZZBzqUEBgWkDNYFcMxoIKAiDIk8DGQ+OO?=
 =?us-ascii?q?s06KjI8AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
 IMJvJ1p9nyE30bfIcLmN/gC0xp/vGzW
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:ZNjov66wCyfSTkTMnQPXwHTXdLJyesId70hD6qm+c3Jom6uj5q
 aTdZUgpHjJYVkqNU3I9ertBEDEewK+yXcX2/h0AV7BZmnbUQKTRekIh7cKgQeQeREWndQ96U
 4PScdDIey1LHQ/qcrm6GCDYqgd6ejC0YztuO/Rpk0dMj2CE5sQijtRO0KhCFR/QAQDPYY0CJ
 bZxscvnUvZRV0nKv+gH3EAUqz4q8bVmImOW29+OzcXrDODlymp7rm/MzXw5GZjbxp/hY0v63
 LElQu8wq25sf2hoyWsqlM78a4m4ufJ+594GcSQzvIUJDLllxqyaO1aKsa/gAw=
X-Talos-CUID: 9a23:ImxjyGzBlhCxiXOMqjBsBgU7ItliV3rG8kyTJn+pCWdHbYLWWECfrfY=
X-Talos-MUID: 9a23:vYKaiwoA+cFrLJ09U/QezxBbGPt37qKvNAc2kLwYt+SdPHAtBQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140934134"
X-MGA-submission: =?us-ascii?q?MDHugstD7+c5h8jvMOBu3RFa8HElUyn0SAA2bP?=
 =?us-ascii?q?oi6Gfq1t2I7diqth1t2Y/cYS72+TBmVTa/IWUt0nvfwP1cy91TyYA0XO?=
 =?us-ascii?q?ZFVzFmAoLwC5n8QPLiQmUm12hqVPd3MOAOMMHAk2f4EaWzkYugkOx2tF?=
 =?us-ascii?q?Wdh9iykjE7uvYgRbQD4Kb3IA=3D=3D?=
Received: from smtprelay0017.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:08:13 +0100
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0CEFF1C171;
	Tue, 10 Mar 2026 14:08:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 847E92D;
	Tue, 10 Mar 2026 14:07:40 +0000 (UTC)
Date: Tue, 10 Mar 2026 10:07:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
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
Message-ID: <20260310100750.303af303@gandalf.local.home>
In-Reply-To: <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	<20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 847E92D
X-Stat-Signature: 7qtdkkf3por5hcs9du9pir5nqq8uht35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Z3Tx1sMlUDFHS8YYPfSOpiqPw8cg/LfU=
X-HE-Tag: 1773151660-993833
X-HE-Meta: U2FsdGVkX1+JWrMXdInzvBx9l2WUqahyoYUezPLaF3HICGuHpiLcos2NJHmqwFPLfM8ZBXZ6/fmTg/vlHLcqcaFGukyEZOsOE3kBaCKhhIkGksjLucUHfFRW8KX39dTkHeOQhZTWX/A0f9Y+1fWRMEQzHGhaJF2wpPshgb4yUxNCAKdeI6QYyukTSlQGbTY7Uxizi79ndrJuznFkrJ0f1Gh3JC2I5gazyCY5QhqLMJ9a9ShPFpKdZ7NDaPeyx31oXfa0p+bWWHR1R5JbGDYWhbllAgJDuEbxQsOff6UlFUV0L3hTo0f3pFVAKw4ZSe/3wUeKTGah6IcaIcnei7ziR9eK5k/ow6hfmOBOZGq2CLBxHUplOJMJzaQEF/IeU48U6bUZ8WiPpl/JDxwK03ucqBa/7oG+YB+etWyAxh+TKdi7NbCLCb6PbeExJ2cO76n2AdjJCB03SaDGNN90kGsLmA==
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Steven Rostedt <rostedt@goodmis.org>
X-Loop: cocci@inria.fr
X-Sequence: 3381
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/i9c3VvoUZrJvaAvFYto3nA>

On Tue, 10 Mar 2026 12:48:41 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.

Why?

> 
> Change generated with coccinelle.
> 
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Masami Hiramatsu <mhiramat@kernel.org>
> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  kernel/trace/fprobe.c                | 2 +-
>  kernel/trace/kprobe_event_gen_test.c | 2 +-
>  kernel/trace/trace_events_hist.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index dcadf1d23b8a31f571392d0c49cbd22df1716b4f..a94ce810d83b90f55d1178a9bd29c78fd068df4c 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -607,7 +607,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	do {
>  		rhashtable_walk_start(&iter);
>  
> -		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> +		while (!IS_ERR_OR_NULL((node = rhashtable_walk_next(&iter))))

Ug, No!

That looks so much worse than the original.

-- Steve

>  			fprobe_remove_node_in_module(mod, node, &alist);
>  
>  		rhashtable_walk_stop(&iter);
> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> index 5a4b722b50451bfdee42769a6d3be39c055690d1..a1735ca273f0b756aa1fcfcdab30ddad9bc51c5f 100644
> --- a/kernel/trace/kprobe_event_gen_test.c
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -75,7 +75,7 @@ static struct trace_event_file *gen_kretprobe_test;
>  
>  static bool trace_event_file_is_valid(struct trace_event_file *input)
>  {
> -	return input && !IS_ERR(input);
> +	return !IS_ERR_OR_NULL(input);
>  }
>  
>  /*
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad555898693e92ee397a1c9493c7c167..59df215e1dfd9349eca1c0823ed709ec7285f766 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3973,7 +3973,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
>  	 */
>  	field_var = create_target_field_var(hist_data, system, event, var);
>  
> -	if (field_var && !IS_ERR(field_var)) {
> +	if (!IS_ERR_OR_NULL(field_var)) {
>  		save_field_var(hist_data, field_var);
>  		hist_field = field_var->var;
>  	} else {
> 

