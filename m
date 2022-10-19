Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C015BC433FE
	for <cocci@archiver.kernel.org>; Thu, 20 Oct 2022 04:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gfh9+gBeSOfRn0EZteRvdOtrZtSElJLF/j3XaRQ/Oo0=;
  b=CYPY/rXtfV0H3s2RifXzJYf4JAKf2N026CEdGmnE9r376Vg7zXemKfau
   0xF+5JRd5eFvD7AyoqMHHOeZi657o+1xMVaLFexMnPcYgJhpzuVG82RV3
   sf5SrIcftvQ0FsnUxcLNB5P/NOmlbaIncyZX9KJpowawy0l2Pn6lY19GL
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.95,196,1661810400"; 
   d="scan'208";a="66066252"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2022 06:38:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DB3FE004E; Thu, 20 Oct 2022 06:38:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0426AE004E
	for <cocci@sympa.inria.fr>; Thu, 20 Oct 2022 01:36:26 +0200 (CEST)
IronPort-SDR: 635089f7_owNWNhB6vTv5DYIMfPnSoYeOg36diCHq4WU6P2JMrFKqnFU
 l+MlygJRyFAhxUXh1JB91u1yPa2JgUhRUjfGu+A==
X-IPAS-Result: =?us-ascii?q?A0B5AwB+iVBjf6vXVdFagQmBT4ItgVcuBFCNTIV0lBWLL?=
 =?us-ascii?q?oF8DwEDAQwBRAQBAYFTgzKEcwIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBGAkZBw4OBSSFaA2CNSkBg2YWFRMGAQE3AYEUAQUBI?=
 =?us-ascii?q?jWFfAOfLIEEQoswgQEzgQGCCAEBBoYOgV0JCQEIgSuPWoEhHIFJRIEVjDuCD?=
 =?us-ascii?q?CKVRTgDRB1AAws7Mg1kIFgOCSAcKA0FBhMDIG8FQg8oL2krHBsHgQwqKBUDB?=
 =?us-ascii?q?AQDAgYTAyICDSkxFAQpEw8tByNxCQIDImoDAwQoLAMJIR8HJSQ8B1g6BQMCE?=
 =?us-ascii?q?CI8BgMJAwIiVoEkJgUDDRclCAU3GwQIPAIFBlMSAgoRAxIPLUgOSj45FgYnR?=
 =?us-ascii?q?QE0Dw4WA5oVAYE8PKQtizmTToNsgUoMnx8RlleSJ5cap0sCCgcGECOBRgIxg?=
 =?us-ascii?q?VszGggoCIMiTgMZD5cmhWohNDsCBgsBAQMJik0BAQ?=
IronPort-PHdr: A9a23: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
 Z9ITaVUBgVdKw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BxfUXq1tqptpUtO6hefkVgqjBIMkLtp133Aq2lEZdPWaSL39qy
 mLpoVh6faUskdoZJhEo7q90ca7MBDhHPJOkOss1NSZLXDbUQmTXedfBOLZqlWKexEWntQ96U
 4KSdkYNDSfNykesS842mWF+hQbreVvPJrGuQ4W9RlQcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,196,1661810400"; 
   d="scan'208";a="31911255"
X-MGA-submission: =?us-ascii?q?MDECyhnrYwTrSSlCH6nFWTlot6mWed7YpdqnHi?=
 =?us-ascii?q?baWgzfCGfpku6GDzG0xa+J+oM/LkWP302VaLV7JqMtsHf6GJHkFdfqTo?=
 =?us-ascii?q?ndm9A7nwS9aYCK/fkqGrb/O3z/2Ax7T9GecJdSKbN8xNxyYaKbuUROTC?=
 =?us-ascii?q?nOGp3e4EcEzllHDBmdnLX94Q=3D=3D?=
Received: from mail-pg1-f171.google.com ([209.85.215.171])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 01:36:23 +0200
Received: by mail-pg1-f171.google.com with SMTP id 20so555472pgc.5
        for <cocci@inria.fr>; Wed, 19 Oct 2022 16:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfh9+gBeSOfRn0EZteRvdOtrZtSElJLF/j3XaRQ/Oo0=;
        b=QsKaTsqYKiKFmPyT/ZQmJ0OLgrA7u1nTZle2kHgC2WiTPkte6iBwEeT+RBnFzsgd89
         awDgsW2b8hXjChk1WFy/OImeny+nuCYlJi1yLlZBtJdbySWo5nXj3HowBkT8VXkw1xci
         hjwGNoELdz3hpBP4HJBrMrC8aFv7E9C/Uq5ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfh9+gBeSOfRn0EZteRvdOtrZtSElJLF/j3XaRQ/Oo0=;
        b=1+2ILRKXWd9nGT/q4K3RQqLAjrOqppeqECRf5JVhvY3FKD931ArkjInNg5YZJrGwQE
         vceJoZSB6eRDtakS3krFvySqJC/bxpWDMEawJOGKvCMTURCqrsE/uYlLVTUqQlTj+R7U
         SasJBpa4sybSq2b4AfXJFOa3VuuV2Zm/OKR9fvFyHz/2DpvxJg4oxH3TAD0qdFfMKlFL
         FzJxxF9snywR0g7QhvV6Wm5O96lbAHQe2q8v7LRMV1l4vWib9Oxq5SpJBXN21xQM+iW3
         oHlYpt0zJWnHU2lMguw1Q2ttlflOX1djaX/aqWUS/HTIOL0idPu1HEGmLvQK/VCWVYbF
         PNzg==
X-Gm-Message-State: ACrzQf1MOV3cCtFFyVAUaQjXO8lg49elQc3BRptVZmLDwEwGb67VcEBe
	Z6dVTx4d+4TxDyFGu26STIhJGgcmJu0k3Q==
X-Google-Smtp-Source: AMsMyM7Jf0szJdQ3hdCKgVegXAAsxXOo+KtYkLrgb2ukHonXPOoKjv1+0AaxhKUlCEudSKY3kDcmtg==
X-Received: by 2002:a63:6742:0:b0:452:59b9:22e with SMTP id b63-20020a636742000000b0045259b9022emr9095592pgc.205.1666222580541;
        Wed, 19 Oct 2022 16:36:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902c65100b00177faf558b5sm11224764pls.250.2022.10.19.16.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:36:19 -0700 (PDT)
Date: Wed, 19 Oct 2022 16:36:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <202210191620.171E11C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] coccinelle is skipping include files?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 654
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/202210191620.171E11C%40keescook>

Hi!

I'm once against stumped by include file handling. Here's my .cocci
file:

// match memcpy() which has a flexible array struct as the destination
@memcpy_fas_dest@
identifier FAS;
struct FAS *PTR;
expression SRC, SIZE;
@@

        memcpy(
                PTR
        , SRC, SIZE)

@fas@
identifier memcpy_fas_dest.FAS;
identifier flex;
type T;
@@

*        struct FAS {
                ...
(
                T flex[1];
|
                T flex[0];
|
                T flex[];
)
        };

// match memcpy() which has a flexible array struct as the destination
@memcpy_hit depends on fas@
identifier memcpy_fas_dest.FAS;
struct FAS *memcpy_fas_dest.PTR;
expression SRC, SIZE;
@@

  memcpy(
*       PTR
  , SRC, SIZE)


The example I'm looking at is fs/xfs/xfs_bmap_item.c, which starts with:
#include "xfs.h"
#include "xfs_fs.h"
#include "xfs_format.h"
#include "xfs_log_format.h"
...


Here it is working, if I explicitly as for "xfs_log_format.h" to be
included:

$ ARGS="--very-quiet \
	-I ./arch/x86/include \
	-I ./arch/x86/include/generated \
	-I ./include \
	-I ./arch/x86/include/uapi \
	-I ./arch/x86/include/generated/uapi \
	-I ./include/uapi \
	-I ./include/generated/uapi \
	--include ./include/linux/compiler-version.h \
	--include ./include/linux/kconfig.h \
	--jobs 36 --chunksize 1"
$ spatch $ARGS --all-includes --cocci-file t.cocci \
	--include fs/xfs/libxfs/xfs_log_format.h \
	fs/xfs/xfs_bmap_item.c
--- fs/xfs/xfs_bmap_item.c
+++ /tmp/cocci-output-742963-d11c3c-xfs_bmap_item.c
@@ -625,7 +625,6 @@ xfs_bui_copy_format(
        len = xfs_bui_log_format_sizeof(src_bui_fmt->bui_nextents);
 
        if (buf->i_len == len) {
-               memcpy(dst_bui_fmt, src_bui_fmt, len);
                return 0;
        }
        XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, NULL);


But if I don't explicitly ask it to process
"fs/xfs/libxfs/xfs_log_format.h", it doesn't match,
no matter what "includes" option I try:

$ spatch $ARGS --all-includes --cocci-file t.cocci \
	fs/xfs/xfs_bmap_item.c
$ spatch $ARGS -recusrive-includes --cocci-file t.cocci \
	fs/xfs/xfs_bmap_item.c

Weirder yet, it doesn't seem to even _try_ to include the right headers.

$ strace -f -e openat \
	spatch $ARGS --all-includes --cocci-file t.cocci \
	fs/xfs/xfs_bmap_item.c \
	2>&1 | grep '\.h"' | grep xfs
openat(AT_FDCWD, "fs/xfs/xfs.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_mount.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_inode.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_trans.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_trans_priv.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_bmap_item.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_log.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_icache.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_error.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_log_priv.h", O_RDONLY|O_CLOEXEC) = 4

Using --recursive-includes open a massive amount of headers, but still
not fs/xfs/libxfs/xfs_log_format.h:

$ strace -f -e openat \
	spatch $ARGS --recursive-includes --cocci-file t.cocci \
	fs/xfs/xfs_bmap_item.c \
	2>&1 | grep '\.h"' | grep xfs
openat(AT_FDCWD, "fs/xfs/xfs.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_linux.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/kmem.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "./include/uapi/linux/dqblk_xfs.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/mrlock.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_stats.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_sysctl.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_iops.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_aops.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_super.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_buf.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_message.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_mount.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_inode.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_trans.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_trans_priv.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_bmap_item.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_log.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_icache.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_error.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_log_priv.h", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "fs/xfs/xfs_message.h", O_RDONLY|O_CLOEXEC) = 4

Any idea what is going on here?

Thanks!

-Kees

-- 
Kees Cook
