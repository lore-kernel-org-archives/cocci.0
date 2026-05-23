Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA89CCD5BB8
	for <cocci@archiver.kernel.org>; Sat, 23 May 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Yszb5ybJAlfX3BXM9eFbxS+uhKe3DZq0goJzkERyg0o=;
  b=evKDYCYZpWWun/n0EFZGx3FeKe/LIn/yHEbnBoijXkKihoSqryi1icWK
   emwFqJnybLr+3IRqNxjPgde3ivW89eLXIVUazi1GbCIpjWzp43cndo8/4
   3gg82vaCxTjD4dzpm5Mwx6JNMdm0XpSGUHfLBt3Q1gmXyM7ZombG27eIQ
   c=;
X-CSE-ConnectionGUID: rgfpvkGfSMWwSMbtcja1WA==
X-CSE-MsgGUID: TMQE4BfFT9SA0ormyCl6EQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="277964376"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2026 16:24:50 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B8A1483190; Sat, 23 May 2026 16:24:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A16E981D6B
	for <cocci@sympa.inria.fr>; Sat, 23 May 2026 14:34:56 +0200 (CEST)
X-CSE-ConnectionGUID: kDCmheNRSNuev2JaAN9Bfw==
X-CSE-MsgGUID: 1E12YbHuRBuYWU5W2SlAuA==
IronPort-SDR: 6a119ef0_EwEoBDaZov900drXUOmNikHVfK/HZDIsVWSi9Seti1C2jWD
 +mb7RsVlTN5dABgf7ge1MXBTTdsu5qNqyW6fkJg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HRAwCfnRFqgAMP49RaglkCgj+BCF40BAtJBASEUI9Th?=
 =?us-ascii?q?l+YC4FVgX0CDwEDAQ1ECgECBAEBAQIENwGER401Ah4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw4KMYZPDUkBEAGCA?=
 =?us-ascii?q?IEsgSYBAQEBAQEBAQEBAQEdAg06RicEGQEBESYBNAIYDgJxAgEBgn4BgiIBB?=
 =?us-ascii?q?hABAzYHDQayNX8zgQGCDAEBBoJq13wfLCJagWcDBhQBgQouhXGCTBwBBW6KJ?=
 =?us-ascii?q?Q+BVUSBPIJSg1AEgUZlgw6CaYImgQyOdYFKHANZLAFVExcLBwWBZgOBBm4yH?=
 =?us-ascii?q?YEjPg8IM1gbBwWBS4JygQMBhSIjLwNOgS2BbwIBC209NwkLGwQ9i1AbD4NTG?=
 =?us-ascii?q?JV5swM0B4I4gWcFgV8MiQmBJpU/BhMvl1IOkwqZBYwPgXqVX4VYgWg6gVwzG?=
 =?us-ascii?q?iSDNhM9AxkPkiMzhGDCAEUyAgE8BwIHDwKFTwEBilCCBoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:y4WXLamVbjtvsZjIy9eGTvPDPNrpDfL03DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ/+xoWZPwJk80kKQf3WB/B9iftWXdyQmVxeJZg7cKoQeNJ8SWzIc0uJ
 uIGJIObeEYY2Ibse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:W35YwWGU1WOETRCDqmJk2GURGs0DSEb70XrOeW2xIEA4YrOKHAo=
X-Talos-MUID: 9a23:gc2GAQSrTDqKLOJnRXS1qWg4Bc1I/p6EFXEyrMg54fKAHDFZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="147401501"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFoV1xxzU4ROT1cjjskZITFY1kwmIJVfUy/Jl?=
 =?us-ascii?q?2q/6dyvag4p4eb44FiG5RTP0ZkWc8IMbo0S60grFQbDUvuHuqz95S4EO?=
 =?us-ascii?q?TlPYf4saWOeDCHTbk1K0AmCY/dA/QJy3r/LJHIqs3nqPa7mK5sXeDQhD?=
 =?us-ascii?q?KjBKfrX3H5dr3VfQZzMuIXRw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 14:34:56 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1wahBO3KKK-005skp; Sat, 23
 May 2026 14:34:50 +0200
Message-ID: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de>
Date: Sat, 23 May 2026 14:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: vulab@iscas.ac.cn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ix030sSO4sZi57vXPNneaFX3wazL02RZA1kI/qyMdvEfdsgjfmx
 gPvcDK3NTAOYTI2/29C07dZaJ5A1PiVDh9jRexefnPdKRcWvQJc9R13DO6ep+NhEeyU6S7W
 /oTXG4l0AIeGUgyRhb29t0C9TcSwb0zxXU6TC1s9H8V8WGzWl/r8wedvz+4fC94HsFjcqm5
 Gc43VjmZ+QX640YZmfq+w==
UI-OutboundReport: notjunk:1;M01:P0:cSzz+iZzIS0=;egLx9wwGdT+2PmNi9MxHqaMLqgr
 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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Checking evaluation of another SmPL script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3502
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/FHE879O4762UwUw0ewXO7g>

Hello,

I would like to try another small SmPL script out.


Example:
// See also:
// [PATCH] pNFS: Fix use-after-free in pnfs_update_layout()
// https://lore.kernel.org/linux-nfs/20260518131036.1337001-1-vulab@iscas.=
ac.cn/

// https://elixir.bootlin.com/linux/v7.1-rc4/source/fs/nfs/pnfs.c#L2128-L2=
385
@display@
identifier i;
expression e;
@@
*pnfs_put_layout_hdr(i);
 ... when !=3D i =3D e
*trace_pnfs_update_layout(..., i, ...)


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --version
spatch version 1.3.1 compiled with OCaml version 4.14.3
=E2=80=A6

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_UAF_1.cocci fs/nf=
s/pnfs.c
=E2=80=A6
@@ -2169,9 +2169,6 @@ pnfs_update_layout(struct inode *ino,
=20
 lookup_again:
        if (!nfs4_valid_open_stateid(ctx->state)) {
-               trace_pnfs_update_layout(ino, pos, count,
-                                        iomode, lo, lseg,
-                                        PNFS_UPDATE_LAYOUT_INVALID_OPEN);
                lseg =3D ERR_PTR(-EIO);
                goto out;
        }
@@ -2216,7 +2213,6 @@ lookup_again:
                                           TASK_KILLABLE));
                if (IS_ERR(lseg))
                        goto out_put_layout_hdr;
-               pnfs_put_layout_hdr(lo);
                goto lookup_again;
        }
=20
@@ -2229,11 +2225,7 @@ lookup_again:
                dprintk("%s wait for layoutreturn\n", __func__);
                lseg =3D ERR_PTR(pnfs_prepare_to_retry_layoutget(lo));
                if (!IS_ERR(lseg)) {
-                       pnfs_put_layout_hdr(lo);
                        dprintk("%s retrying\n", __func__);
-                       trace_pnfs_update_layout(ino, pos, count, iomode, =
lo,
-                                                lseg,
-                                                PNFS_UPDATE_LAYOUT_RETRY)=
;
                        goto lookup_again;
                }
                trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg=
,
@@ -2268,7 +2260,6 @@ lookup_again:
                                                TASK_KILLABLE));
                        if (IS_ERR(lseg))
                                goto out_put_layout_hdr;
-                       pnfs_put_layout_hdr(lo);
                        dprintk("%s retrying\n", __func__);
                        goto lookup_again;
                }
@@ -2285,7 +2276,6 @@ lookup_again:
                                        PNFS_UPDATE_LAYOUT_INVALID_OPEN);
                        nfs4_schedule_stateid_recovery(server, ctx->state)=
;
                        pnfs_clear_first_layoutget(lo);
-                       pnfs_put_layout_hdr(lo);
                        goto lookup_again;
                }
                spin_lock(&ino->i_lock);
@@ -2356,7 +2346,6 @@ lookup_again:
                                pnfs_clear_first_layoutget(lo);
                        trace_pnfs_update_layout(ino, pos, count,
                                iomode, lo, lseg, PNFS_UPDATE_LAYOUT_RETRY=
);
-                       pnfs_put_layout_hdr(lo);
                        goto lookup_again;
                }
        } else {


I find some generated diff hunks inappropriate for the mentioned source co=
de
search pattern.
How can such questionable data be avoided here?

Regards,
Markus
