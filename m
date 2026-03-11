Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DD1112583A
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GkAgNZHJ9JPdfVojz2Uvbc0Bs1V/TN/9xj0aLCnFPcE=;
  b=hmYEI+zjd67eai1BqywrzfM7zw740Ph6YvwEFODwA7ZII3w1iLjL0mx8
   JTp0qVMj1SUMcLj9vCFbp75fbDozfmnykh1z8IzOVZ0/naXrrmuGqcKBa
   ABW9xVN4kjjf9hheCXw+iuaCTP0JNqOXiFgaKBiznwgZ3OVXMo54W8EmV
   Q=;
X-CSE-ConnectionGUID: bYWofOMmRk2FobmvjE9hhg==
X-CSE-MsgGUID: Qb1Cn/WvTNqK07E91gM2+g==
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
   d="scan'208";a="267314522"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 15:38:35 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 42C65819CE; Wed, 11 Mar 2026 15:38:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7F39C81952
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 15:04:06 +0100 (CET)
X-CSE-ConnectionGUID: 2Hd5zwS0RWq0pomO183Gnw==
X-CSE-MsgGUID: JTHLrr0rSYSLg/F9kBxVwg==
IronPort-SDR: 69b17643_vHbgpM7tSOeTUP7tlJDgu7g5CFlpyEPzI9hJiaOtaqfWbsi
 qi8QYQIfE1eInLV4HSrJodj5MomtfWJNJP/otjA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EBAgD6dbFpgwssKNhaHgEBCxIMQIQRgWUxAwcISY1Ti?=
 =?us-ascii?q?HygGQ8BAwENUQQBAYUHAo0kIAYBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQEBOQcOO4ZcgmIBhAABAQECATo/BQsLRlYGE4MCg?=
 =?us-ascii?q?k0nAwWvVYE0gQHgLhWBOIhUAYVaGoR6QoINgRU1gnU+iwcEgiKBDokKihlIC?=
 =?us-ascii?q?ngcA1ksAVUTDQoLBwVeRUMDNRIqFSNLBS0dgSMhHRcUH1gbBwUSISoHgUF4g?=
 =?us-ascii?q?gEPhmh5Ay5eGg4iAjpcgQYLWgWCLAIcAwsYDUgRLDcUG0JuB411PYI1qG6he?=
 =?us-ascii?q?YQmhHCcaE2DcaZ6LodlkHOpQQGBfiM8gSAzGggoCIMiTwMZD446zHcqMjwCB?=
 =?us-ascii?q?wsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:VkBHE6uIjpnGlU4lucVn6A2z7skDytV00zEX/kB9WHVpmwKj+f
 xG+85rsyMc6QxhP03I9ursBEDtex/hHNtOkOos1NSZLW3bUQmTTL2KhLGKq1aLJ8S9zJ8+6U
 4KSclD4bPLYmRSvILazE2dH8spqeP3jpyAtKP+4zNRRQ8CUdAe0+4AMHf/LmRGADJdHJI8Gd
 6l+sZaq36BdB0sH72GL0hAZPLbr9nH0KjregELHHccmXOzpALt0rLhCRif2VM/flp0sMsf2F
 mAqQDi/KWktLWewgTf23S71eUqpDL+8Ko5OOW8zvIJIiipsAanY4x9R6aP1QpF2N2S1A==
X-Talos-CUID: 9a23:IsoeHG784DV+/aKW49ssrm4YR9I6SSXn826IO0i9Lj85E5KTVgrF
X-Talos-MUID: 9a23:OrCIUQrmZtNq8btyfCcezxNeFONy+fy0M3E2tZpBlZiHHzxOJDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="141043491"
X-MGA-submission: =?us-ascii?q?MDFOvJaPLnBljlKrRmbDDe6jrtwnzv/HOPVnjd?=
 =?us-ascii?q?t1tB7avveYvzqcWlSIfVPPmvum+4Ukv6PKjZiiG+TqKrvzKvOHE1oUiR?=
 =?us-ascii?q?DFkCTR0lt+x53qXbm2rZQUroKByvejDdppUU5Ur/o8MPGdIP1dVvDXp4?=
 =?us-ascii?q?LDLqrNt7s8rR3wmLwaiRsqUA=3D=3D?=
Received: from smtprelay0011.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 15:03:47 +0100
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4324D139CEA;
	Wed, 11 Mar 2026 14:03:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0CF3220025;
	Wed, 11 Mar 2026 14:03:20 +0000 (UTC)
Date: Wed, 11 Mar 2026 10:03:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311141332.b611237d36b61b2409e66cb3@kernel.org>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	<20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
	<20260310100750.303af303@gandalf.local.home>
	<20260311141332.b611237d36b61b2409e66cb3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CF3220025
X-Stat-Signature: ff8ct3tumfmuryqygkfkcm78w16u4scc
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+skqrXXDxm4il2tsYmj25H0/GTzSRdMUI=
X-HE-Tag: 1773237800-364001
X-HE-Meta: U2FsdGVkX1+aU4mY7bFvO8lRauP/vgjT20dobHa0QHVROVhTP6xZNvlHFy+HnthX7C3DUw86Ksayk8kipkioUde1pGRJffeDzlmGTmiRQAtxOhSsM3gHnZJQZGdgNXBABYZdeE7OsMEvCI5Ff4ZQbbyu3yXHRyZXg5AHof/AO0vcusmeqjpCWWhtLLOcuZIY7+tOVjT7VktVnLaFPp1jjRLc3JQ2sJ4jp/SiL4aHgDK/k//b9d34oAYT+AlJT32Fm0BFv3eObF3U3OAnj7CnGXu0MyQ+0edSgYKqKIiOybnUsF1fYSODF4X+zk3bqwV4HOqJnRMkZevrGktYEsiiqb8/qNY0d6MZ
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Steven Rostedt <rostedt@goodmis.org>
X-Loop: cocci@inria.fr
X-Sequence: 3415
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/4iPhyg3uuHSHW3nm8GxiQw>

On Wed, 11 Mar 2026 14:13:32 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> 
> node = rhashtable_walk_next(&iter);
> while (!IS_ERR_OR_NULL(node)) {
> 	fprobe_remove_node_in_module(mod, node, &alist);
> 	node = rhashtable_walk_next(&iter);
> }

But now you need to have a duplicate code in order to acquire "node"

I think the patch just makes the code worse.

-- Steve
