Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F43C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 05:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=84y4QeGazzPnxyheSUGC6dxlwC9g9ggxs1w9zCAEAdk=;
  b=cEUyMcNK6t7dW7ZDiBTxRHKairG2oeSjAkX8JkWO9MW9DGUnjHMGCXct
   oBcxyZsU8x5R5VqsUvh8dNRayVeMcbuaVkLKtBTbQBmmROyp1Lzd+ZlTp
   JRwgof3biMxE8cj6/RRGrJpENqqwLLKH1Uj3Zmja1UlkpNUEwo8R6ITEi
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.org.uk
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="207383854"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 06:53:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1FB9E0D1E; Mon, 10 Feb 2025 06:53:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 03CAAE0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 06:53:47 +0100 (CET)
IronPort-SDR: 67a9946a_bYgrmfexbgMK2NWZK8JMmx08TChJBAYo7kRG3a/glWkynIC
 uO9YuEV73+pEZs8DIlpe21vAUQXcO8++ZXA9sGQ==
X-IPAS-Result: =?us-ascii?q?A0FfAABLk6lncq2NWT5aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgVY0BAtIlCWCJJ4Ugg0BAwENQQECBAEBAwEDkAYCHgYGMgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABgQyFew2CYgEzghYsD?=
 =?us-ascii?q?X4BBToGAQE3AQ8BCg4KHBJWBoV6B698gTSBAYIMAQEG3gUJgUgBiE4BhWuEd?=
 =?us-ascii?q?ycbgg2EDjE+iweCM4Fug0CGXYcMiCSNdlJ7HANZLAFLChMXCwcFOXBIA4ERI?=
 =?us-ascii?q?w+BFAU0Cjc6gg1pSToCDQI1ggsTXR+CK4IggjuEQ4M1gRaBZ4NxghKBYAMDF?=
 =?us-ascii?q?hODIXgchE0dQAMLbT03FBsGn3SDL2yDJ16TEoMtsAKEJYRvnFdNE6o/mHypL?=
 =?us-ascii?q?oFuAjGBXE00BIMiTwMZD44hOIs7vTJGMjwCBwsBAQMJhUYBAYsHgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uWtwxKDiMsWINzblHemv55DYdb4zR+YMi2TDGXoedfVwSL39qy
 nOpoV/6faQsl0ssR4b9OxoVJPtfZqYz+8T3WBzB8bBYOCFgguVxehZhOOJ/9SjIVycygdz79
 YHT0EUMrzN5DZB4vrH3A==
X-Talos-CUID: 9a23:jajoDmDJw9ALJzf6EwV89GI+CsobSC3Q1XDSfBKxLWd1GZTAHA==
X-Talos-MUID: 9a23:MK+9/Am0rSmwGwA2xcNfdnpSEelFur6nNXoulIossvGeDXR6JgeS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="108618969"
X-MGA-submission: =?us-ascii?q?MDEK5TfJKNSpK1mjvtcDeUtWSZG4aTCI+OYZHj?=
 =?us-ascii?q?/d1TeKLHsrWRgruXMzCZeV4vQ67eb8IMdAOpvO4O4aKmcP0CPsrsHdtT?=
 =?us-ascii?q?KXFum8n7T2K6AjmWqK9AGbOSzrJ29g7/9mHO/p071qqqM4ssUPDd52Ct?=
 =?us-ascii?q?wIkRVDXrdjm9uZWOb4rz82vA=3D=3D?=
Received: from zeniv.linux.org.uk ([62.89.141.173])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:53:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=84y4QeGazzPnxyheSUGC6dxlwC9g9ggxs1w9zCAEAdk=; b=GtwUm8RXNR9zfA3Ii6m++D/Hq/
	jzj09yeu0o+wuk5zzktvH/89LX/Gb+WkqCRmQ1s8jcV2p281t+bnucxwsm5F8NQpZuvfWV8pmpPVv
	qRAs6wU50Z50+Ua8U+jL/Z8fkKK6bBKsWJkQL6gq7/f2MbZUCu1xxmOekOuYMxTjc1cO8vTFdFR20
	ASru4qTnFRJAIY4l6BAmA21wVopLyliPDWEM97V07PUqll5pwAbkbAMv9vV/GjwbqxcIAy6wfbHly
	Ei8inWO6FRDcqO8TKqOnSkPqEQ8LSR7mSTxkwYHp74th3vHiVxFnjh/o2kALRVkzJeJT0lG4JHebz
	xoEvWhkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thMjl-000000094XM-11C4;
	Mon, 10 Feb 2025 05:53:41 +0000
Date: Mon, 10 Feb 2025 05:53:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Reaver <me@davidreaver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Message-ID: <20250210055341.GZ1977892@ZenIV>
References: <20250210052039.144513-1-me@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
Sender: cocci-request@inria.fr
Subject: Re: [cocci] [RFC PATCH 0/6] debugfs: Replace dentry with an opaque
 handle in debugfs API
Reply-To: Al Viro <viro@zeniv.linux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2384
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210055341.GZ1977892%40ZenIV>

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

Do not embed struct dentry into anything else.

Do not take over its lifetime rules.

For the record:

	Anything of that sort is going to be vetoed.
