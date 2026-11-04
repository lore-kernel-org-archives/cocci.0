Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F1606A32C
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=A5yof6kG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Egu91q9dU04uoNuu9WJS9CZKlSh0KIIUE3pyY4OkdX4=;
  b=A5yof6kGWnMueeBL5nUBqqO6SXw8PKFKYT6m2hrBT5sJ8mFOosSS1VXL
   QWgGtc6/NpmZwyjbDO7m7KujHKDOQ/BUIflRDAILsznclYQsZPzOMUChh
   /TzF+l7Sd6gc/JR5OAr3XSGQhqlXOB3lgwS1wzjBr7kVuPiuFpsfqNqek
   M=;
X-CSE-ConnectionGUID: 53MhpSysTqW5x2QFuNhQMw==
X-CSE-MsgGUID: q/w3my4eRyeRxgncLnARLQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323628"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:27 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6C25B81861; Sat,  7 Nov 2026 11:59:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 38EC0814F9
	for <cocci@sympa.inria.fr>; Wed,  4 Nov 2026 13:58:44 +0100 (CET)
X-CSE-ConnectionGUID: 6xWUW4MITl+NS86fLOPV2A==
X-CSE-MsgGUID: NMsMdw7YQu67acMefswmjw==
IronPort-SDR: 6aeb2c03_O0kv3nXR8vYxGTOghg5nhPITPA8n26FnibFn+U8+umCKyor
 fq1kw1uHVZ5VPF53uvHmcrIi/vkV+DzZIoe8uXA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G+BABRKutqhQscCRJagluCFilCAUhOEycMBAtJhFiIe?=
 =?us-ascii?q?ohdHQOgHwYJAQMBCwEBSgUCBAEBAQIEhDhGAo4eHwcBBDQTAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQFASYZPDUkBiUgBggcBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAQEBAQEBARcCDQd2AQEBAQIBIwQLAQ0BATcBDwkCG?=
 =?us-ascii?q?AICGA4CAhAbKwaDFQGCIgIEJScDAwIMn36bJHp/M4EBggwBAQbcHgEJgXgDB?=
 =?us-ascii?q?hWBCi6IXwGGPYQ5QoINhAgHMT6CYQQYhSKCaoImgQyIGo8fUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYElQwOBBiMPPAUtHXopIR0XER5YGwYFEiAqQUNbgRKBB12BKw4aXQECH?=
 =?us-ascii?q?0YtFYF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxbC?=
 =?us-ascii?q?wsaBRpHCAILAgx0KBEQEx0eJC8FHCZAGwoUbTwBNxUZBH6SYoJxeCM/Lxc1U?=
 =?us-ascii?q?l8cL6UroREKhCCBYQmKOpYHqnGZCI4Kmw8CBAYFAhcBgX8jgVxyE4MiUAMZD?=
 =?us-ascii?q?447gR0BBQKDLoQpyUUmNQIBATkCBwIHDgMLhUaDJIkygUwBAQ?=
IronPort-PHdr: A9a23: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
 NtlfkaJBRlH8Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cRLNOaoKbIKO2Rudh4sW2XAaV5o+eYIsimQD101hICG9Afbo9P
 xG/c5x6faaslsssR0b6LK90ey7MBbhHP1OjbX5X43JYOCOggLBEGgh1+vfKlbbdREWmNQ96U
 4tScdDNOE=
X-Talos-CUID: =?us-ascii?q?9a23=3AjECHWmqIL3t2cqyortcPyF/mUZ41TUDikFLxH0v?=
 =?us-ascii?q?7L105FrOxbmeuoooxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AB0MA2g0Av+OkUrxYzlb9cFzBJjUjxYG1LUwSzqQ?=
 =?us-ascii?q?/ppfbPCdVNjmGkzG1Xdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,195,1787004000"; 
   d="scan'208";a="161734731"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFuB4z6kz8um4ZjXdURIvQfQF1eRPHTDS4Bz1?=
 =?us-ascii?q?RaBerpey9miMyCNnUv4RY/wN1+H1SxQ7DvayXReRa2q3Sxn79Z5qgtut?=
 =?us-ascii?q?ee5gc3yORJ+2zarmiyeM1HIiSLzaXtUHRK+NsSMFUc0xbldgLoPl4LR+?=
 =?us-ascii?q?Q/yq1gAiRTGx74JKdiczYvkQ=3D=3D?=
Received: from outgoing-auth-1.mit.edu (HELO outgoing.mit.edu) ([18.9.28.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:58:43 +0100
Received: from macsyma.thunk.org (pool-173-48-116-148.bstnma.fios.verizon.net [173.48.116.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6A4CwbhS032333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Nov 2026 07:58:38 -0500
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7CB22253005C; Wed,  4 Nov 2026 07:58:37 -0500 (EST)
Date: Wed, 4 Nov 2026 07:58:37 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, tools@kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <ausnPnWk9qSCnWad@mit.edu>
References: <52418f50-b3ff-461d-8e66-c10f70e35b2a@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52418f50-b3ff-461d-8e66-c10f70e35b2a@web.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC] Replacing special goto statements by direct
 returns?
Reply-To: "Theodore Tso" <tytso@mit.edu>
X-Loop: cocci@inria.fr
X-Sequence: 3779
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/-I1311Hd585ck6dXpZ-acg>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 03:23:23PM -0500, Markus Elfring wrote:
> 
> The documentation for the Linux coding style contains the following information.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.4-rc1#n526
> 
> “…
> The goto statement comes in handy when a function exits from multiple
> locations and some common work such as cleanup has to be done.  If there is no
> cleanup needed then just return directly.
> …”

I wonder if the churn in this sort of clean up is really worth it.
There is a very large set of AI-generated fixes for AI-discovered
security vulnerabilities, and so code churn that doesn't actually
result in net benefit in terms of making the code more maintainable,
or more testable, or addresses live security vulnerabilities may in
fact just make maintainer's job more difficult.

I will say at the moment, for me presonally, this kind of cleanup is
very likely going to be significantly down-prioritized in terms of
code acceptance because I'm really swamped with patches for ext4 and
e2fsprogs --- patches which in my opinion are much higher priority.

Cheers,

					- Ted




> 
> 
> Thus it seems that the following script for the semantic patch language
> can work to some degree.
> 
> 
> @replacement exists@
> identifier label, var;
> @@
> -goto label;
> +return var;
>  ...
> -label:
>  return var;
> 
> 
> 
> Unfortunately, patches would be generated then by such a simple SmPL code
> which would still preserve return statements that became unreachable.
> 
> Test result example:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time spatch --allow-inconsistent-paths fs/xfs/libxfs/xfs_btree.c …/Projekte/Coccinelle/janitor/replace_goto_by_return2.cocci
> …
> @@ -1735,7 +1735,7 @@ xfs_btree_increment(
>                 --lev;
>                 error = xfs_btree_read_buf_block(cur, ptrp, 0, &block, &bp);
>                 if (error)
> -                       goto error0;
> +                       return error;
>  
>                 xfs_btree_setbuf(cur, lev, bp);
>                 cur->bc_levels[lev].ptr = 1;
> @@ -1747,8 +1747,6 @@ out1:
>  out0:
>         *stat = 0;
>         return 0;
> -
> -error0:
>         return error;
>  }
> …
> real    0m1,074s
> user    0m0,995s
> sys     0m0,071s
> 
> 
> 
> How should such a source code transformation approach be improved accordingly?
> 
> Regards,
> Markus
> 
