Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E066C4332F
	for <cocci@archiver.kernel.org>; Thu, 20 Oct 2022 04:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=laWAp9omnxH0zWs5pzxFOxEN2Mr+7wDy4a23HVXimhM=;
  b=Qoj1x9bo4P+IzPZ4RUC+BCGzBi62Q4BTgniRhSDA0kGOAOaMqd2gMU7l
   ipPN7Boofvx2JA3JaPrT7+SBkV7D52pGqOcNuY/TxebtN0EJx9htGYuSx
   FcRYgYW2wEjvkirDTy7mAuaJv94SpGtxKQ6dQKSsMdB5GHfXmNgBjb7Tj
   E=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,196,1661810400"; 
   d="scan'208";a="66066556"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2022 06:43:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98231E013D; Thu, 20 Oct 2022 06:43:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B5116E004E
	for <cocci@sympa.inria.fr>; Thu, 20 Oct 2022 06:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=laWAp9omnxH0zWs5pzxFOxEN2Mr+7wDy4a23HVXimhM=;
  b=r+ZOH44HruQL6qbOmvRtREq3hHg6gn1rf80U4i3LsQbvvgWacpjKLY25
   IAX3P6SHMCMxRmZyUS6Vxc6sous7RTpFxOk256bjY+ufU+1zoZ1UYSjlD
   w5Fg5HltQSZmuTOALa9cMtKVYB2Qsh/lFYDcknL9no8cvdGkik379XfoR
   U=;
X-IronPort-AV: E=Sophos;i="5.95,196,1661810400"; 
   d="scan'208";a="31917493"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:43:37 +0200
Date: Thu, 20 Oct 2022 06:43:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, "Darrick J. Wong" <djwong@kernel.org>
In-Reply-To: <202210191620.171E11C@keescook>
Message-ID: <alpine.DEB.2.22.394.2210200639050.2988@hadrien>
References: <202210191620.171E11C@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] coccinelle is skipping include files?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 655
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210200639050.2988%40hadrien>

> The example I'm looking at is fs/xfs/xfs_bmap_item.c, which starts with:
> #include "xfs.h"
> #include "xfs_fs.h"
> #include "xfs_format.h"
> #include "xfs_log_format.h"
> ...
>
>
> Here it is working, if I explicitly as for "xfs_log_format.h" to be
> included:
>
> $ ARGS="--very-quiet \
> 	-I ./arch/x86/include \
> 	-I ./arch/x86/include/generated \
> 	-I ./include \
> 	-I ./arch/x86/include/uapi \
> 	-I ./arch/x86/include/generated/uapi \
> 	-I ./include/uapi \
> 	-I ./include/generated/uapi \
> 	--include ./include/linux/compiler-version.h \
> 	--include ./include/linux/kconfig.h \
> 	--jobs 36 --chunksize 1"
> $ spatch $ARGS --all-includes --cocci-file t.cocci \
> 	--include fs/xfs/libxfs/xfs_log_format.h \
> 	fs/xfs/xfs_bmap_item.c
> --- fs/xfs/xfs_bmap_item.c
> +++ /tmp/cocci-output-742963-d11c3c-xfs_bmap_item.c
> @@ -625,7 +625,6 @@ xfs_bui_copy_format(
>         len = xfs_bui_log_format_sizeof(src_bui_fmt->bui_nextents);
>
>         if (buf->i_len == len) {
> -               memcpy(dst_bui_fmt, src_bui_fmt, len);
>                 return 0;
>         }
>         XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, NULL);
>
>
> But if I don't explicitly ask it to process
> "fs/xfs/libxfs/xfs_log_format.h", it doesn't match,
> no matter what "includes" option I try:

You may want to start with the option --verbose-includes for such
problems.

The problem is that Coccinelle can't find the file.  Your .c file is in
fs/xfs, and despite the lack of a complete path, the header file is in
a subdirectory: fs/xfs/libxfs.  So you could add -I fs/xfs/libxfs to your
command line.

Another solution is the option --relax-include-path.  This should cause
Coccinelle to look over the entire kernel to see if it can find exactly
one file named xfs_log_format.h.  If only one exists, that has to be the
one you want.

julia



>
> $ spatch $ARGS --all-includes --cocci-file t.cocci \
> 	fs/xfs/xfs_bmap_item.c
> $ spatch $ARGS -recusrive-includes --cocci-file t.cocci \
> 	fs/xfs/xfs_bmap_item.c
>
> Weirder yet, it doesn't seem to even _try_ to include the right headers.
>
> $ strace -f -e openat \
> 	spatch $ARGS --all-includes --cocci-file t.cocci \
> 	fs/xfs/xfs_bmap_item.c \
> 	2>&1 | grep '\.h"' | grep xfs
> openat(AT_FDCWD, "fs/xfs/xfs.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_mount.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_inode.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_trans.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_trans_priv.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_bmap_item.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_log.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_icache.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_error.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_log_priv.h", O_RDONLY|O_CLOEXEC) = 4
>
> Using --recursive-includes open a massive amount of headers, but still
> not fs/xfs/libxfs/xfs_log_format.h:
>
> $ strace -f -e openat \
> 	spatch $ARGS --recursive-includes --cocci-file t.cocci \
> 	fs/xfs/xfs_bmap_item.c \
> 	2>&1 | grep '\.h"' | grep xfs
> openat(AT_FDCWD, "fs/xfs/xfs.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_linux.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/kmem.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "./include/uapi/linux/dqblk_xfs.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/mrlock.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_stats.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_sysctl.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_iops.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_aops.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_super.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_buf.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_message.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_mount.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_inode.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_trans.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_trans_priv.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_bmap_item.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_log.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_icache.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_error.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_log_priv.h", O_RDONLY|O_CLOEXEC) = 4
> openat(AT_FDCWD, "fs/xfs/xfs_message.h", O_RDONLY|O_CLOEXEC) = 4
>
> Any idea what is going on here?
>
> Thanks!
>
> -Kees
>
> --
> Kees Cook
>
