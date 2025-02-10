Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C375C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wxkD/+Dx43lW8UB8u0A2GcWAhdKPTUOSt7ryhevlBtw=;
  b=iB7UBQcq7VautNJmmSCtbXyqmy9brICoLQuTymvLDIvobYa5ucfA7Paa
   VikxAvrn7OqfTcZiVZpslrNnashoWrmR7yd0ZNm3ZNazM+E0fffTfxR9m
   fevlIpTaUM7hgE1eJ6I8yTJ5mcw54mOZ0mgvKQSwM/1deh00voOs7uQh2
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="207546241"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 17:53:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4EC25E0D1E; Mon, 10 Feb 2025 17:53:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 26D8CE0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 17:53:15 +0100 (CET)
IronPort-SDR: 67aa2ef9_1OEJERQJc64I+qEBkMAH7TT/0JJWuGzJuJzCpNFMLM+WivX
 +o/xM1kJw+Q0V0VQj/g24nArN5HwQr3eXXCSlYw==
X-IPAS-Result: =?us-ascii?q?A0GIAgCtLapnhdlUsotaHgEBCxIMQIFIC4JEgVczBAtIj?=
 =?us-ascii?q?VKGU4IkhESbXQEDAQ1EBAEBkA0CHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAUBJhgiCYgGEAAEEATo/BQsLDjhWBhMWgmyCQ?=
 =?us-ascii?q?iMDsQ6BNIEB4CKBSIhPAYVrhHcnG4INgUqCRDE+iwcEgi+BboNApANICnscA?=
 =?us-ascii?q?1ksAVUTDQoLBwVhSEgDNQwLMBUjD4EUBTQKNzqCDWlJOgINAjWCHnyCK4Igg?=
 =?us-ascii?q?juEQ4RLhViCEoFgAwMWEgGDIXgchE0dQAMLGA1IESw3FBtEbgeeBTyDOlARg?=
 =?us-ascii?q?QoZgV0fk3iDLY4Ta6EEhCWEb5xXBEmXQ5MPmHykSIRmgX0kgVwzGggoCIMiT?=
 =?us-ascii?q?xwPji0WFsgoJTU8AgcLAQEDCZBhgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 586q6thLl16AkAuhJY=
IronPort-HdrOrdr: A9a23:JWftJq2cro4nidwjwzgC1gqjBHwkLtp133Aq2lEZdPUzSKGlfq
 GV8MjzsCWftN9/YhAdsPyGJ6WER2rRsaR45oQcJt6ZLWzbURSTXfhfBOfZslnd8gfFh5RgPN
 5bAtBD4YTLfCNHZKXBgDVQcexP/DDdytHPuQ629R4EcegNUdAC0+4TMHf4LqQZfmZ77MoCf6
 a0145LoT6peXNSZcS9C3kDUYH41rr2qK4=
X-Talos-CUID: 9a23:xtpuT2x48HOyrrtuSDYfBgUPO+UaLiXw0U7/fV6EBWEqeLCvc3GPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AYm2ekwyHIBtvqOheUIgK7UP8AL2aqI2AEhpTkbc?=
 =?us-ascii?q?0h+iNJQV8BxPNijaUQIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="108697389"
X-MGA-submission: =?us-ascii?q?MDHuxGQtGMC4Jqkz/7JkMLUnctWSg/R+Cf8PR6?=
 =?us-ascii?q?gXMBd1zDj0tziVEZB1BRQUif2GDHycFd9Vd7n/WVtZ3JoT/K2laFKC74?=
 =?us-ascii?q?HDZ4G3S+HKqXjxhU03Rxm3UE2CldcIxxR4lXxbsb5nMOxJh7FCKXDygD?=
 =?us-ascii?q?AhNLNE+5OtC09N85qWOzJleg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 17:53:13 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 60ED95C5B28;
	Mon, 10 Feb 2025 16:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBBDC4CED1;
	Mon, 10 Feb 2025 16:53:10 +0000 (UTC)
Date: Mon, 10 Feb 2025 11:53:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Reaver <me@davidreaver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <20250210115313.69299472@gandalf.local.home>
In-Reply-To: <86ldud3hqe.fsf@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
	<86ldud3hqe.fsf@davidreaver.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [RFC PATCH 0/6] debugfs: Replace dentry with an opaque
 handle in debugfs API
Reply-To: Steven Rostedt <rostedt@goodmis.org>
X-Loop: cocci@inria.fr
X-Sequence: 2400
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210115313.69299472%40gandalf.local.home>

On Mon, 10 Feb 2025 08:08:25 -0800
David Reaver <me@davidreaver.com> wrote:

> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> >
> > First off, many thanks for attempting this, I didn't think it was ready
> > to even be attempted, so it's very nice to see this.
> >  
> 
> No problem, and thank you for taking a look!
> 
> > That being said, I agree with Al, we can't embed a dentry in a structure
> > like that as the lifecycles are going to get messy fast.
> >  
> 
> Ack, I'll do something different in v2.
> 
> For my own education: what goes wrong with lifecycles with this embed?
> Feel free to point me at a doc or something.
> 
> Also, Al and Greg, would wrapping a pointer be fine?
> 
> 	struct debugfs_node {
> 		struct dentry *dentry;
> 	};

No it will not be fine. You should not be using dentry at all. I thought
this was going to convert debugfs over to kernfs. The debugfs_node should
be using kernfs and completely eliminate the use of dentry.


> 
> I was trying to do the simplest thing possible so the bulk of the change
> was mechanical. Wrapping a pointer is slightly more complicated because
> we have to deal with memory allocation, but it is still totally doable.
> 
> > Also, your replacement of many of the dentry functions with wrappers
> > seems at bit odd, ideally you would just return a dentry from a call
> > like "debugfs_node_to_dentry()" and then let the caller do with it what
> > it wants to, that way you don't need to wrap everything.

What caller should ever touch a dentry? What I got from my "conversation"
with Linus, is that dentry is an internal caching descriptor of the VFS
layer, and should only be used by the VFS layer. Nothing outside of VFS
should ever need a dentry.

-- Steve
