Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C4C0219B
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cba4ZwmhnGCFyWrudrOaxS5io42lHQ1n9Sr/fqDukjI=;
  b=AWheD03lyyANXj4GLMOBLI45fAA4bk3wcNrR70pk/mS4TEZogyNJoBfd
   oVlW0jeAz6PYzuCyxk7rL+3SCSP7DEDYrqTMF1ObaKuWRjzUENE2J4ad5
   FYS/yiU/r9ABrblTomftEaGU5X63MRYFA5PKuY31QZYGhIlenZ6P0upri
   E=;
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
   d="scan'208";a="207552576"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 18:25:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 667ACE0261; Mon, 10 Feb 2025 18:25:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1FA07E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 18:25:23 +0100 (CET)
IronPort-SDR: 67aa3682_FCy4F95O7GhkpCre1Yz6VTE1n5Z3df18DJhvd+b8dSRPAC7
 dUc2bNeRvPTlz3Q24IU6Vq8k10YlU9Xk3bAuRag==
X-IPAS-Result: =?us-ascii?q?A0GUAQDJNapnj9lUsotaHgEBCxIMQIFIC4JEgVczBAtIj?=
 =?us-ascii?q?VKGU4IhA54Ugg0BAwENRAQBAYUHiwYCHgcBBDIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhgiCYgGEAAEEATo/BQsLRlYGE?=
 =?us-ascii?q?4MCgkIjA7EkgTSBAeAigUiITwGFa4R3JxuCDYFKgkQxPoN7MkKGGASCL4Fug?=
 =?us-ascii?q?0CKTZk3SAp7HANZLAFVEw0KCwcFYUhIAzUMCzAVIw+BFAU0Cjc6gg1pSToCD?=
 =?us-ascii?q?QI1gh58giuCIII7hEOES4VYghKBYAMDFhIBgyF4HIRPHUADCxgNSBEsNxQbR?=
 =?us-ascii?q?G4HngY8gxRDgUQPgjEKOTKSYoMtjhNroQSEJYRvnFdNhAOTQEaSSZh8pEiEZ?=
 =?us-ascii?q?oFuCSqBXDMaCCgIgyJPHA+OLRYWyDIlNTwCBwsBAQMJkC4QFwyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E4bjFdhL4xbNrL/dEfpVx8UbXdINM+2
IronPort-HdrOrdr: A9a23:c1sY6K2brZi2chUVEeKtwgqjBL0kLtp133Aq2lEZdPWaSKKlfq
 eV7ZImPH7P+VEssR4b9OxoVJPtfZqYz+8X3WBzB8bHYOCFgguVxehZhOOIqQEIWReOlNK1vp
 0AT0ERMrLN5CBB/KPH3DU=
X-Talos-CUID: 9a23:j2K4pW/jexb4zalXih+Vv0EIJZocfVjd8CbNOXKgCUc5Z7aPcGbFrQ==
X-Talos-MUID: 9a23:LkTNUAsuR7Iat5pB6s2nomlmFf1h54SST2sCuMRXic6BKXAgEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="108700636"
X-MGA-submission: =?us-ascii?q?MDH2V2UooZMHfaY7SBlGPttfTKHwPyUVKCLMJm?=
 =?us-ascii?q?r7rHc376B8l5aeh5kLmuqhBLJ30VK5izHUXtmf4m2SJ4VTVVibMEjixr?=
 =?us-ascii?q?avoVRJvtUaouBrLZXzbsPcjOoANt30hV8WOkKpkeWbrQae5pNx4PiqKN?=
 =?us-ascii?q?5bVgnttXy5oUYs9rfWRZ73nQ=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:25:22 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B089D5C5D4A;
	Mon, 10 Feb 2025 17:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A86C4CED1;
	Mon, 10 Feb 2025 17:25:18 +0000 (UTC)
Date: Mon, 10 Feb 2025 12:25:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Reaver <me@davidreaver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <20250210122521.19cafd51@gandalf.local.home>
In-Reply-To: <20250210121246.60b2efbf@gandalf.local.home>
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
	<86ldud3hqe.fsf@davidreaver.com>
	<20250210115313.69299472@gandalf.local.home>
	<20250210170016.GD1977892@ZenIV>
	<20250210121246.60b2efbf@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [RFC PATCH 0/6] debugfs: Replace dentry with an opaque
 handle in debugfs API
Reply-To: Steven Rostedt <rostedt@goodmis.org>
X-Loop: cocci@inria.fr
X-Sequence: 2403
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210122521.19cafd51%40gandalf.local.home>

On Mon, 10 Feb 2025 12:12:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From what I understand (and Christian can correct me), is that kernfs was
> created to be that interface of the "storage" connecting back to the
> kernel. Where the VFS layer deals with the user accessing the file system
> (read, write, mkdir, etc) but kernfs is the "data storage" that attaches
> those call back to the kernel to retrieve kernel information or even modify
> the kernel behavior.

To further expand on this, what a pseudo file system would need, is a way
to describe the layout of the file system, and to have the file_operations
defined for each file.

And possibly, a way to control what directories are made and what is in the
directory when a "mkdir" is performed (as mkdir in pseudo file systems
seldom create an empty directory). It would also need to handle the "rmdir"
on those directories.

Would also need to be able to store permissions too.

Debugfs did this with the dentry as the descriptor. But that dentry also
requires a static inode behind it and the memory used for all this was
really being wasted. Having a separate descriptor that acts like a storage
device and saves the file ops is basically all that is needed. It can act
like a real file system where no dentry or inode is created until the file
system is accessed by the user. And then, this descriptor can be attached
to the dentry and have an inode created for it. But after the file is no
longer referenced, the dentry and inode can be freed.

This is what is lacking with debugfs and tracefs at the moment. I did carve
out an "eventfs" from tracefs to do the above, and it saved over 20Megs in
memory when it wasn't being accessed.

-- Steve
