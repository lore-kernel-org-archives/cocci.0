Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1433EC0219B
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YupFuRTWyC2FWOIalehNWhN3LP8EQ5bXCn3GWv8bQqw=;
  b=hZBe9jXzx5/mOcdOUMBmNv4L72biTlGmKDghHrbjLJQBDkw+iU3JnR++
   KhRZ4+okiLGbX9c5Zg2nkL/R4TIM1e5VB/zeYvFwGumW6dD7Sex7CWV9w
   df3LZkOR/ns0ckbC2oIUYPA9pyABidb7eyACGL/KbGILgMwdlUuKqoTMa
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linuxfoundation.org
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="207390378"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 08:08:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4A4D4E0D1D; Mon, 10 Feb 2025 08:08:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 55488E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 08:08:26 +0100 (CET)
IronPort-SDR: 67a9a5e9_I2I8oDojjbAK3IY+3OSgj8eYHP7uLYu8G0Q+2vbi6I2Sjoo
 FTSjMf8CDjZH3q08qvf9QzktBW7Ctjdo3Yjav7w==
X-IPAS-Result: =?us-ascii?q?A0EdAAD3pKlnhdlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCGiiBVzMEC0iMc1+GU4IhA5JMHIssFIFqDwEDAQ1EBAEBAwSFA?=
 =?us-ascii?q?AKLBAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBQEmFew1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDOgYBATcBD?=
 =?us-ascii?q?wsOCi5WBoMVgmUDsBqBNIEBggwBAQbeBQmBSAGITgGFaxuDYnonG4INhA4xP?=
 =?us-ascii?q?oQphl6CM4FugVaBaoZLEoQngmWIJI12UnscA1ksAUsKNQw5KEhIA4E0D4EUB?=
 =?us-ascii?q?TQKcYINgTI6Ag0CgkBwH4RLgjuEQ4M1gRaBZ4NxghKBYAMDFhODIXgchE0dQ?=
 =?us-ascii?q?AN4PTcUGwafdIMvCy0jEYEPAYE8UxoHRZMSgy2wAoQloWFFlzCTD5h8qS6BZ?=
 =?us-ascii?q?zqBXDMaCCgIgyJPAxkPjiEMDQkWdgECh1zAGUI1PAIHCwEBAwmLU4R8gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 aSFHDvKWPRKiKZ6fm0tiwLGv5ZLX/lGQv8cCCI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tFvzKq4kGRNi51AUfgPXwBfXdLJyesId70hD6qm+c3Jom+ij5q
 STdZUgpHrJYVMqM03I9ursBEDtex/hHNtOkO4s1NSZLWvbUQmTTL2KhLGKq1fd8m/Fh41gPM
 xbEpSWZueeMbBe5fyKhnjAYq5Qu6j8zEiK7d2us0uEdmlRGtxdBzUQMHflLqVBLDM2e6bQI/
 Knl7t6mwY=
X-Talos-CUID: 9a23:hFk1l23QyRkp33T+lKWgjbxfP9wVLl3611DpAmDhIHdYcqaHTmXB5/Yx
X-Talos-MUID: 9a23:ZxjAGwqXxHAXGOqHzlsez2hcGNxU2o+DMlFXzYUAvte0EgpuJw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="108623471"
X-MGA-submission: =?us-ascii?q?MDFUhT0ulZrASGJeaPmQaVDZEL/1BbFl0ue4J7?=
 =?us-ascii?q?dcgfpgBLZ+tvFKR/TPWskPQAl43mAF+SHcGC0Osdbl1u+W6HBesqCPpA?=
 =?us-ascii?q?CYj1mUzUBx8rh2wMmxPIR8CpXpesWmHdNdYwxHxTIzYh2ecXjIPb8I5U?=
 =?us-ascii?q?t0MWU0W8VWYbPc+PrTgr9mJw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 08:08:25 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0BE895C2719;
	Mon, 10 Feb 2025 07:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65D5C4CED1;
	Mon, 10 Feb 2025 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739171302;
	bh=xmvJW278o88o2TSb1VIZDRp8UkUFXbbIsI0ctYa0fXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3VUYUh9EiNiJ2K1v7tS6sdU+5IbgfD25scRhwksR7+Xl5kHL4zSXFfy2KODsdfxq
	 W3b6dqmqs1braLlD67nbV5M72WHW6weahVWBDUnB1OvZyjKxN29RNG9VMOH84q6Inx
	 Vh6Jh3CqU9xj4Nf6jiefOZKnyFQ8TZYOCzc8sacA=
Date: Mon, 10 Feb 2025 08:08:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Reaver <me@davidreaver.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Message-ID: <2025021048-thieving-failing-7831@gregkh>
References: <20250210052039.144513-1-me@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
Subject: Re: [cocci] [RFC PATCH 0/6] debugfs: Replace dentry with an opaque
 handle in debugfs API
Reply-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 2386
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/2025021048-thieving-failing-7831%40gregkh>

On Sun, Feb 09, 2025 at 09:20:20PM -0800, David Reaver wrote:
> Overview
> ========
> 
> This patch series replaces raw dentry pointers in the debugfs API with
> an opaque wrapper struct:
> 
> 	struct debugfs_node {
> 		struct dentry dentry;
> 	};
> 
> Intermediate commits rely on "#define debugfs_node dentry" to migrate
> debugfs users without breaking the build. The final commit introduces
> the struct and updates debugfs internals accordingly.
> 
> Why an RFC?
> ===========
> 
> This is a large change, and I expect a few iterations -- unless this
> entire approach is NACKed of course :) Any advice is appreciated, and
> I'm particularly looking for feedback on the following:
> 
> 1. This change touches over 1100 files. Is that okay? I've been told it
>    is because the patch series does "one thing", but it is a lot of
>    files to touch across many systems.
> 
> 2. The trickiest part of this migration is ensuring a declaration for
>    struct debugfs_node is in scope so we don't get errors that it is
>    being implicitly defined, especially as different kernel
>    configurations change which headers are transitively included. See
>    "#includes and #defines" below. I'm open to any other migration
>    strategies.
> 
> 3. This change is mostly automated with Coccinelle, but I'm really
>    contorting Coccinelle to replace dentry with debugfs_node in
>    different kinds of declarations. Any Coccinelle advice would be
>    appreciated.
> 
> Purpose/Background
> ==================
> 
> debugfs currently relies on dentry to represent its filesystem
> hierarchy, and its API directly exposes dentry pointers to users. This
> tight coupling makes it difficult to modify debugfs internals. A dentry
> and inode should exist only when needed, rather than being persistently
> tied to debugfs. Some kernel developers have proposed using an opaque
> handle for debugfs nodes instead of dentry pointers [1][2][3].
> 
> Replacing dentry with debugfs_node simplifies future migrations away
> from dentry. Additionally, a declaration with debugfs_node is more
> self-explanatory -- its purpose is immediately clear, unlike dentry,
> which requires further context to understand its role as a debugfs
> dentry.

First off, many thanks for attempting this, I didn't think it was ready
to even be attempted, so it's very nice to see this.

That being said, I agree with Al, we can't embed a dentry in a structure
like that as the lifecycles are going to get messy fast.

Also, your replacement of many of the dentry functions with wrappers
seems at bit odd, ideally you would just return a dentry from a call
like "debugfs_node_to_dentry()" and then let the caller do with it what
it wants to, that way you don't need to wrap everything.

And finally, I think that many of the places where you did have to
convert the code to save off a debugfs node instead of a dentry can be
removed entirely as a "lookup this file" can be used instead.  I was
waiting for more conversions of that logic, removing the need to store
anything in a driver/subsystem first, before attempting to get rid of
the returned dentry pointer.

As an example of this, why not look at removing almost all of those
pointers in the relay code?  Why is all of that being stored at all?

Oh, also, all of those forward declarations look really odd, something
feels wrong with needing that type of patch if we are doing things
right.  Are you sure it was needed?

thanks,

greg k-h
