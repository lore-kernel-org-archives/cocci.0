Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE504C282C6
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=D7+bOdSKzrxQTuFq1CY/qx2E6hue+i+kR6PvAKN6CDQ=;
  b=L6s8Hl2a4MIsr0LjSUg0o/jhvfDkzlhkQsS23Z3vZvgsE0lZpbIgqzHJ
   i4JP+JuMkBddypcpzZwP77SNImfOJYJElxbQOuqMa3hC7TPZvWQ0i2o6L
   2SBZ0UV8fc8TvA0VLXtEwVyoe3ZK3d/CTEAJxCZuKsMoUtm7NKNz7GM9t
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="210967673"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 21:31:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 67C99E0261; Mon,  3 Mar 2025 21:31:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D3B55E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 21:31:48 +0100 (CET)
IronPort-SDR: 67c611b4_6EHnPZV0hnps5I/rHvhW00SY9RP1CREU4zgXxiXpw+7+LUJ
 yF40UUqeBopAG1HFnnJpKNUizngJVvI/Fv2Da7A==
X-IPAS-Result: =?us-ascii?q?A0HlAQD9EMZnfgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQmJ1MwQLSIRWiB2HMoF0LQOEO4c7jEKEBoFWgX4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEOIFUgnQCixUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQE7Bw4JATGFew1JAQwBggsBgSSBJgEBAQEBAQEBAQEBAR0CR?=
 =?us-ascii?q?0QCAQMjBBkBAREmAQ8fAQUCJgICVgYBEgIBAYJ+gjABAzEHr2B/M4EBggwBA?=
 =?us-ascii?q?QaCaddzHywiV4FlCYEaLgGFa4JjAYYmhDwnD4FVRIE8gkt2iB6CaYIzgWqDP?=
 =?us-ascii?q?ahYgU0cA1ksAVUTFwsHBYE5OAMgCjQUBBkCFBwBDwYQBGp6gkVpSToCDQI1g?=
 =?us-ascii?q?h4kWIIragQFg1uEPYRAgj9RgkKCEXGBF4IxhVGBLYRrHUACAQttPTcGAwsbB?=
 =?us-ascii?q?j2hbjqEISABUiEQCkwmggSTDJNpnx00B4I4gWaBYwyfXgYTL5dFDgaSfAEuh?=
 =?us-ascii?q?2WQaiKpD4FnOoFcMxokgzZPAxkPjiEMFoQLyBxCNTwCBwEKAQEDCYVGAQGHW?=
 =?us-ascii?q?4J5gUsBAQ?=
IronPort-PHdr: A9a23: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
 sJmolpzS1E/UP8XWBwNIQ==
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:5dinwK10gJdN8POTM2fx7gqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV96faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:stzJVmO/vYbgVu5DBjla7XYkIOMecFbx6VDcc16ZTjc4R+jA
X-Talos-MUID: 9a23:UASubQZLgUfCKuBThSGxmw86OsJTuYPwMBk8ibUEpJOAOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="210967671"
X-MGA-submission: =?us-ascii?q?MDHFqpQo914ZJq98EoZIlHlM1aFTwHiPZ0wKqY?=
 =?us-ascii?q?/EY7FycEAGuDmqtv46mCoj10R3eGoenqRQthO9Iscj5ppaaam+nY5tps?=
 =?us-ascii?q?pzEE2i8ZCMnzfyOC/ShLXNtxv+z/i5s8MDMTGRI9l8P5LzWfGRQ1vyEg?=
 =?us-ascii?q?lNCF2RH0F+tifMNS6FevzZJA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 21:31:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741033907; x=1741638707; i=markus.elfring@web.de;
	bh=D7+bOdSKzrxQTuFq1CY/qx2E6hue+i+kR6PvAKN6CDQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MfyNYO5Rf1IJaR1bl+5D5IsmJseNDY+YIie8758fLsUuri15hqT7OmtuxDBDLEkr
	 +b2BCWTckRH7iqlAQsSswvQPN3R7GzupXlX+wUGPpM0ZB9UGMBQNVqFZcgJVsj5Mm
	 KQpBNZjng1tLYogquBk5m1qen5lw6p+qtHxYR0vhEGaMPMvG3z08f3UvjxbxmxtT2
	 Nf5PRQUo/JgcvqQv9n+tEvS6guLUTKrVj9gytk75E/w7Bd5LxIAQqtflav8oL4CnK
	 Sd342HevHymEA2CHayV1yciCAlvHtqGvs7TXLCJNoVAPP3hMNGCO5LNK7CxPAO1m0
	 MBC0/Q1C8TIvuRnShw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi537-1tKnNS2NY9-00ZvTN; Mon, 03
 Mar 2025 21:31:47 +0100
Message-ID: <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
Date: Mon, 3 Mar 2025 21:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
X-Provags-ID: V03:K1:csYVwvzlghPepZ2AyyY46eRwA8AS8BMfd7Ao//GWrCPl1A/GPLx
 yj8777LveO9YiAnzu+Isjxx46A/wzaMMh4+Mei0pWllSt1K7tKExTVXsM1jRO4mBZ/AFap4
 ZGQs5wk/ZupNx4PS4mkNzeZlE2UBN+JxipFft3d7SY6vJRyW8vLluaQ1AImETEakmh45VRP
 Qh6fvi0Yl43mkeYhbF9vA==
UI-OutboundReport: notjunk:1;M01:P0:TMOfPqAf9qA=;q6Vge51zuOVBjj6nlCJUUhQUdU5
 fGQgPLo6XTWTDAkVhVwF65N5FuyhGq2NGBUKuAKpsL5xruexqlo9wDpJLIkd0Er+Gj0Oj36TQ
 qtNlBd65iIADb1O0lrufmP8uug54EEa04vRvN+xQWhqV8UQCnsdiU814FHCz6DsJ0UtYyzJbF
 BmZs6xXs+MYDbxFBA9IaB5F0+MLFu/w1FSxqWhHAg3XXUyAshRr8qUe7HSiCIOucpc+c9eQml
 GLDInfjUYHTdf41sUjyIy6FFAiCPmntplZxo9IiZld5sNhtqxZvsu3yE19eZWgup9QqlmYwzY
 amHpLBDE7qUw7VmqVG4VZCoBrmuDZRzNYBj+4OzXYXDdicXl1PUNgLx8M5F4SR4cTg9QH5vgu
 MXvgbZVNtLAg9vVqpkfsQnfr3yw+FTmWpA2I0acyw5oIPf7a6eMEUy2c3jiih9FrBW7oSsK0G
 v6gtT22jHTg/PZfwVya/yY/rT0UDVB0H6UlUUQTPrmbahyshOiC8rKFDkSWW4c+GLY1MgVKli
 6jOYCXqlB5AQt4+PLrqPUj0/Ucvma26rreL+Cti1W5jbAK7C2Fenx3hOIZH4dnNxL/3Ye8zww
 w6ZM4WZJV/YZN2ZQ0mrt8Ap1BSeIhMal2YKFr+3UUDlnPa8D/d8HO9TYQ9xr7Bom6MXyIzrfp
 2fT4SwGNWHYEMrxM/rvxBdm1Yid1g/qMseGcvRhxrFIN/vbEDH4sB7FRm+gteBwzvZtwAkaPI
 2e1ZIBt+DjE0LmcdJX4ai8WwlMmB+Pju42Vyb3rNDILrFIhgIPg6Xu9V9OP4qOgkidl0v7KjI
 1z2DjNe38lZYZUBbDLgAZaAuLXwNkPt7WqqaX4OC1bVsJhBCjbCyOrmIpqW7wVaEB0Z8SVrNH
 A4vYDcUtAOsHsaPTOMwcX9jHjIkEsqgyElixVLifECkKlq7xD5k7msNrJtuGSEH1czrK7gx4A
 0nIlsiRqJclYGptiA9q0zgkVGNOmttbzjPju2W6QZ+EKG+8hmnOUH0TS3nd1RoclnNmN3VAxC
 AfiugjotANNOOlu3IVDcVFTIoN88hr6CIN3lL/oahQybP9DnBHn36V2oA3DVC7JhLyok0aqhG
 vOkmyoDCUTkXwLKwFoeiG+WAU77hoZ2TYajr9DzzJk4ex//bD1H9mM6NkfRSMXvhJJzVBQuQj
 yZ4HEaT5uWlBNkW8qstMSP0eJLWVnyIJKzwTdCZaXTyCd0Swy1Zz84t23pIqBvhhKiK7+qjyi
 oYvNUgWfDCEgnFLLMrVQBTafJnzQcWA26U7x8nAvgbgnh1LWJjz1efS0OkvZGsy0ZpmW4xNpD
 bM/AQFk+Bj2wu1CMvfQmwFVz9hIg0fbKB8IrguRNvpX7CWOohqK4k1OaXX/+tNwhhVqyPxxKt
 s0EoBnfB4elxaDNOEGmszmfuifIALAgtqdyyHDY8zZXVvk3QpybaW9NEE04LuBuqORZBy23he
 XMXkYjdnk2mY8Xg2G65K84lm6f0g=
Subject: [cocci] [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2486
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/09fe60d4-8eda-42bf-b2d4-ada265a09ce5%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
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

Fixes: f7ef5287a63d ("btrfs: zoned: relocate block group to repair IO fail=
ure in zoned filesystems")
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

