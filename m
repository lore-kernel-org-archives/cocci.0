Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A2EC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gtL2SwdYntTMRUof9GtSzfp0KQHAqHHqjXy5kuG7Kfs=;
  b=pjJU+ZGmdQTV3U9q9t2zQyrgN5VAvCT39CTx83WGcEYPl/Ww6SNd1X1z
   roVUz+RtMzWPfAxBC9LwAZqzenfHKAXRegoESwmw/5b1Xn8PEIUg+KVwg
   GMQxb5I85qGgZjG6Y6HfV/VUciSXQVol4sG5qdnyom74je1jXbk5uhqZa
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99041886"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 09:25:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7E200E0D44; Sat, 25 Mar 2023 09:25:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CBAFEE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 09:25:38 +0100 (CET)
IronPort-SDR: 641eb002_Kv0wWXyh+BvT2Oc6d23RbPtF1lXhEGU510H5jxqBNFVSyQA
 vV2JJ6wzzoYpBqbb1XW3/yaRGV6MTWoztaAQBoQ==
X-IPAS-Result: =?us-ascii?q?A0EdAABOrx5khwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkdTPQMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB?=
 =?us-ascii?q?7EofzOBAYIIAQEGgmOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIE8gkx1iByCZ?=
 =?us-ascii?q?4Ioh1mHJ4gyCoE0dYEgDoE9gQQCCQIRa4ESCGuBfUECDWQLDm+BSwJkTIEgJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPL?=
 =?us-ascii?q?EQOQjc0EwZcASkLDhEDUIFHBIEKgQEGASYkmnUCAYJHIAFSIRAKTCaCBJJYk?=
 =?us-ascii?q?kCeDjQHgiiBVYFZDJ8MBhMulwgOBpIjLoctkA8gp3qBYzqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gDA0JhAOPR0A0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 /Qg3r7ya4geZNST5g==
IronPort-Data: A9a23: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
 ewjxw==
IronPort-HdrOrdr: A9a23:sxMAKq/ZSZBm8bFouNhuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re+8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNSftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99041885"
X-MGA-submission: =?us-ascii?q?MDHeWy9oBRLdjFtNTZIyGl0BqL53p+ojvh9/Jm?=
 =?us-ascii?q?IE0EVbLE7AWjShOG216QAnzJyEQFkTs+VoxmZkMxHJdz5RqBJwyQqWr6?=
 =?us-ascii?q?Dexho9hYwOmORrwf67JT0T1XdRkOART8fMydXn5R8v568os6YeG3FUvd?=
 =?us-ascii?q?seCyExO1JGScJC6ZpDQXwg0Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:25:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679732730; i=markus.elfring@web.de;
	bh=rzet3oeQqifD2/J9JN981vN9k4MnNiyB9FIkV+AwXUA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=FU8QP+Bf8XY9P+5RFPRZntlbk09vqnj5wda8SNdq+vIEotkl3WM4o8Wamt4UiI9l3
	 6e/Usjs+j6OL00geLDvMEicjCGsW9CY05JpNLo0/XdO3stmHdo6d4FlCnneWsFk49p
	 wUnfXDnPQEtQPySAUJLy2N3rMqXDYx57/0Gb8CEsPKoqTw6S6tTAp4DhR9xP0MolvM
	 1Ul47rTgYZNrywB/2/Dtmt8Uu4CDcLWcI0DgMpoSBk381hcKTDIL2RaBzQRzXdoQds
	 v95XIDUm3J7wKerMB3aUWts7FN79Y9SJBDct/NIDavEkaDPL1jh1jXCUbOrbaFUF1W
	 7KPFE3JfEPJ/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWsc-1pvRfG0lVA-00KF1u; Sat, 25
 Mar 2023 09:25:30 +0100
Message-ID: <7cdc9575-60a6-20d5-0dc0-1a2a4440a433@web.de>
Date: Sat, 25 Mar 2023 09:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Naohiro Aota <naohiro.aota@wdc.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
Content-Language: en-GB
In-Reply-To: <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tdlQvqeQoGpWZZkBjuH26oAtTfcSLEOA3ejc1w7Yy4kEhNioJUT
 SR+idvnMHC5q2zfv6XJiH1aMmFnRddsohZ82RTBFaTY8kzm26HTasB3we0kk95B3wznF8Zn
 XVO43nJqSFeFqr6YF3IBNn2P/oSnvqx8P6XiYaF/haxBiJzepWLN+rFh9NDVpn9KrHqaaqK
 i/wBmWap9rvmjeRu9P3yA==
UI-OutboundReport: notjunk:1;M01:P0:HPXDImqEDYA=;JUzucp4a97JvMKu6uPmNnYxLAh2
 TzvWtJGEgJKpHdijwfoQSpzvS8fwsbEW6BV3CkWC6xdFDOhEuup8Jm2BhdikkCUSwW8RFOt9i
 p9HsTSJtDw37dKmEuvLaEi0dmjANfyxxvtyrU2B2Q7+mlkB0RPK/gUlral7kof6mX/rezJ3+W
 W9E8WQ4Z2GjZgtGcfC3PHj3x/XutUuAjE0NI1ZJe+3U452zoJqJpksRs384fIFlqWaU0dJkH9
 85j3BUnvabGRBc2d4MkdMVItZIhVJslpmnter4Xy9AHsdX+eb5uualr9Urv01H/eVxyWt7rPl
 x3z+tfaEx+NhvCksiPY5pE/I2eqz0U9msifpLLq43t6pJcGtF308ddETi8drp2XMpUy9W7CaO
 orXyDSfFGrLt0ifPWnJGaskFxBK3HKzgYk56PuS6OAmyOAbkvtxOFSyNGO/4RCgYOj+yu/eu3
 9gMq9AxDpGOqfLpn6dOD0BLp1bWVPCVqz1EsHm4PV+OWWORILBsss2pQJMl2jZB1TNzKz4kNh
 CJblQLcRoRnuRPRpEfIsAez/ZxraylS+p/hHwE1OlXcArTmBdaQM3BSbIWQ2QEL+YECmIkE3u
 aSwhCjQZSPb7Ov+mVp5kNdTnw9VwL8BrNwC8KF5khGfyd/j2e4k0JGPkXyV+PcD9BzHS8CudZ
 efwvI5pY10OS0puxU4UD+LnUY4gGSx72vbt+AgePXskIOwBlmtxjiNhkhrNVoicjP+vRzXq7/
 i8UwMD7eB6s6+0g4zHSHnC6SsedCPeNbikmA9t5rgFlML+wrbTdtMj/fajeohRMuA7Ad0wwiY
 AykHFvcgA3uitbMekOkloEDX4J2B3sylhTbhQe4T/ELIl9I96s73HRjPFhgHErI1O+pKCPXN8
 dhJq1XYIfl5w8FYBlIq/WBeb1ferullPucgB96C5j5FJm4oLpGLXSE90L
Subject: [cocci] [PATCH resent] btrfs: Fix exception handling in
 relocating_repair_kthread()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 922
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/7cdc9575-60a6-20d5-0dc0-1a2a4440a433%40web.de>

Date: Wed, 22 Mar 2023 20:10:09 +0100

The label =E2=80=9Cout=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function
=E2=80=9Crelocating_repair_kthread=E2=80=9D that it was determined already=
 that
a corresponding variable contained a null pointer because of
a failed call of the function =E2=80=9Cbtrfs_lookup_block_group=E2=80=9D.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: f7ef5287a63d644e62a52893af8c6cfcb5043213 ("btrfs: zoned: relocate b=
lock group to repair IO failure in zoned filesystems")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/btrfs/volumes.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d0124b6e79e..de11ad6c8740 100644
=2D-- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8096,23 +8096,22 @@ static int relocating_repair_kthread(void *data)
 	/* Ensure block group still exists */
 	cache =3D btrfs_lookup_block_group(fs_info, target);
 	if (!cache)
-		goto out;
+		goto unlock;

 	if (!test_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR, &cache->runtime_flags)=
)
-		goto out;
+		goto put_block_group;

 	ret =3D btrfs_may_alloc_data_chunk(fs_info, target);
 	if (ret < 0)
-		goto out;
+		goto put_block_group;

 	btrfs_info(fs_info,
 		   "zoned: relocating block group %llu to repair IO failure",
 		   target);
 	ret =3D btrfs_relocate_chunk(fs_info, target);
-
-out:
-	if (cache)
-		btrfs_put_block_group(cache);
+put_block_group:
+	btrfs_put_block_group(cache);
+unlock:
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
 	sb_end_write(fs_info->sb);
=2D-
2.40.0

