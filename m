Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8525BC0219B
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4u4Z8DwdSsBiBIG4c5Z2rgo6CiSyS0oIh0DsYtfR8IM=;
  b=gR5Bjcb5pbTo0k2fkteV8/nvvg8OFUVnGyG9kPo9fQUJayzH0aFAOiyS
   r+P+TV3vwOc/gXiG5i00z9mHkd2yb2dxdEmJsKbC6fI8e0Si8J8Miru8y
   1TNpF6kXfM05xXz6aUnpJziOo1cWYnwyOwGMGxTD3CUfWXX6apcbeuCWf
   0=;
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
   d="scan'208";a="207550403"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 18:12:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BEC13E0261; Mon, 10 Feb 2025 18:12:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A1DECE0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 18:12:47 +0100 (CET)
IronPort-SDR: 67aa338e_WO2F2sOtuoewBtA5K2aSAN4JSq1RxLTVKtHbuGb4vrYH9n8
 8meS4tr0X6qzud0CfwmztY7+24zN7673E2yT2UQ==
X-IPAS-Result: =?us-ascii?q?A0EhAAD6MapnhVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBAtIjVKGU4IhA54Ugg0BAwENRAQBAYUHiwYCHgcBBDEID?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhgiCYgGDf?=
 =?us-ascii?q?wEBAQECATo/BQsLGC5WBhODAoJCIwOwJniBNIEB4CKBSAGITgGFa4R3JxuCD?=
 =?us-ascii?q?YFKgkQxPoN7MhYshhgEgi+BboNAik2ZN0gKexwDWSwBVRMNCgsHBWFISAM1D?=
 =?us-ascii?q?AswFSMPgRQFNAo3OoINaUk6Ag0CNYIefIIrgiCCO4RDhEuFWIISgWADAxYSA?=
 =?us-ascii?q?YMheByETx1AAwsYDUgRLDcUG0RuB54GPIUqAVqBYDkvA5Jigy2OfqEEhCWEb?=
 =?us-ascii?q?5xXTYQDk0BGkkmYfKRIhGaBaQE3gVwzGggoCIMiTxwPjlnIJCU1PAIHCwEBA?=
 =?us-ascii?q?wmQLhAXDIFLAQE?=
IronPort-PHdr: A9a23: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
 5m2oCAYs+qMRN04P6rdIOxO1FcC38qz
IronPort-Data: A9a23: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
 b4biYdAD6B6F0H/YZcUhu8=
IronPort-HdrOrdr: A9a23:jDTIwaGitS04ryEmpLqE58eALOsnbusQ8zAXPo5KJyC9Ffbo8f
 xG/c5rsiMc5wx9ZJhNo7y90ey7MBDhHP1OkO0s1NWZPDUO0VHAROoJ0WKh+UyDJ8SUzI9gPM
 lbHJSWcOeAaGRHsQ==
X-Talos-CUID: 9a23:vJDPbm+Nlj/YrSa/mRGVv0kzOMcsKXDw9UzVMR6EDGd4aJq6CkDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3Ag8B6ew6f1gbRIYXZrKvn9WnaxowzyqOXM14qz64?=
 =?us-ascii?q?ipuK1MTVuGCaMvCqOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="207550393"
X-MGA-submission: =?us-ascii?q?MDFvrtBO2WQLhCGfocwBNWHLrYzWKCh1RlDITZ?=
 =?us-ascii?q?RjKq7E4/qg7N/MfZ2D+12gdg6+MZScYpbJmYapNzUqOUn9pKox8VszrX?=
 =?us-ascii?q?kF/RBMmF6eb57rc5cyZd4ydU2WdHTh8ATf/BdWSZMtjQVLSZ4ssPvEl8?=
 =?us-ascii?q?xCfk/6owpm/3t95WfLk3kMzw=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:12:46 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8FB58A41C0C;
	Mon, 10 Feb 2025 17:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D2C4CED1;
	Mon, 10 Feb 2025 17:12:43 +0000 (UTC)
Date: Mon, 10 Feb 2025 12:12:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Reaver <me@davidreaver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <20250210121246.60b2efbf@gandalf.local.home>
In-Reply-To: <20250210170016.GD1977892@ZenIV>
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
	<86ldud3hqe.fsf@davidreaver.com>
	<20250210115313.69299472@gandalf.local.home>
	<20250210170016.GD1977892@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [RFC PATCH 0/6] debugfs: Replace dentry with an opaque
 handle in debugfs API
Reply-To: Steven Rostedt <rostedt@goodmis.org>
X-Loop: cocci@inria.fr
X-Sequence: 2402
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210121246.60b2efbf%40gandalf.local.home>

On Mon, 10 Feb 2025 17:00:16 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Mon, Feb 10, 2025 at 11:53:13AM -0500, Steven Rostedt wrote:
>=20
> > No it will not be fine. You should not be using dentry at all. I thought
> > this was going to convert debugfs over to kernfs. The debugfs_node shou=
ld
> > be using kernfs and completely eliminate the use of dentry. =20
>=20
> I disagree, actually - kernfs is an awful model for anything, sysfs inclu=
ded...

Then what would you suggest? It's the only generic system that is
appropriate for control features, where the underlining "files" are
actually functions to modify or query information from the kernel.

The entire VFS layer is designed for efficient management of some kind of
storage device, where the only interaction with the storage device is
through VFS.

For pseudo file systems like debugfs, sysfs and tracefs, the underlining
"storage" is the kernel itself, where we need a way for the "storage" part
to work with the kernel. The VFS layer doesn't give that, which is why
debugfs and tracefs used dentry as that interface, as the dentry does
represent the underlining storage.

=46rom what I understand (and Christian can correct me), is that kernfs was
created to be that interface of the "storage" connecting back to the
kernel. Where the VFS layer deals with the user accessing the file system
(read, write, mkdir, etc) but kernfs is the "data storage" that attaches
those call back to the kernel to retrieve kernel information or even modify
the kernel behavior.

-- Steve
