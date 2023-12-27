Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F805C46CD2
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pGonUuDy3CER2wOZ3Gd4BwadmayPF5lAcvNKP95kDqg=;
  b=tst/Z29DWbVDR+0y60gEbS4oaMrBeu8DVpmGQwhJXUY82w9XuqjWOe9F
   FEgDJgbgxOdhRxsEkJ7wYDjgEClslkXBzGgqiNew5OfIQ4+lasYdg4y7D
   Dg3kfuTwvjeQ2CBiRtw1HYauXsct/dy1sw919smXWuso1D4I8Cq6FkQb1
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,308,1695679200"; 
   d="scan'208";a="144118041"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 11:07:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E0ACE0CCC; Wed, 27 Dec 2023 11:07:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DFD1E004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 11:06:59 +0100 (CET)
IronPort-SDR: 658bf744_zE8lDkXbmZlpLVqZ8NHSKJN5ZuqMVnehisyPFZQt9mxbFbn
 os2ij9vl5sL2OanbV1XWNM9LLR7Cr8Auq15DJPw==
X-IPAS-Result: =?us-ascii?q?A0EoBwA+9otl/wQP49RaHQEBAQEJARIBBQUBQIFPgjkHe?=
 =?us-ascii?q?FMyBAtIhFOPQYF1MIQ7hzWHTIRrhASDFj4PAQMBDUEBAgQBAQMEOIMzgRQCh?=
 =?us-ascii?q?zYCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsD?=
 =?us-ascii?q?YJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgYjBBkBAREmAQ8fAQUCH?=
 =?us-ascii?q?wcCAksLBgESAgEBgnyCKwEDMQeucH8zgQGCCgEBBq9YHywiVoFgCYEaLogbA?=
 =?us-ascii?q?YUlQoNBeicPgVVEgRUnC4JHb4gegmiJGwcygh2DUJFXfQVBcBsDBwN/DysHB?=
 =?us-ascii?q?DAiBgkULSMGUAQoIQkTEkCBXYFSCoEBPw8OEYI+IgI9NhlIglgVDDUERnUQK?=
 =?us-ascii?q?gQUF4EPbhsSHjcREBcNAwh0HQIRIzwDBQMEMwoSDQshBVYDQgZJCwMCGgUDA?=
 =?us-ascii?q?wSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADaR8yCTwLBAwaAhseD?=
 =?us-ascii?q?ScjAixCAxEFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI?=
 =?us-ascii?q?3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4CpkyBDoJpDQTEfTQHgjSBY?=
 =?us-ascii?q?IFhDJ8rBhMvlyYOBpJULoVlgWuQTyCoRjWBRSaBWTMaJIM2TwMZD44gOINzj?=
 =?us-ascii?q?0dANTsCBwEKAQEDCQGBVYNwAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Hz1PAaAdW1ympanlHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:Kxvwp2weY713oig1FvYTBgUvIccUTUXll079OkPnO2t4GKePZliprfY=
X-Talos-MUID: 9a23:FpzSvQWF/2wv1vfq/CLqqTx6HfxN2ue3WB8VjM1FtpevHhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,308,1695679200"; 
   d="scan'208";a="144118040"
X-MGA-submission: =?us-ascii?q?MDEXn7tbD9yPdQt9noNpDHxQJ4Pg/C2vYbeQhP?=
 =?us-ascii?q?vSZh2/0xNqZqeL61XeBoKev8gXeqEWlnRR79k26FofgqMKBwZdL6FuYX?=
 =?us-ascii?q?FYWhsjRDPviQ8zcVjLtGWEiviVkV/jpYU7hZU6pIcxMDIB9oJYoZdWQv?=
 =?us-ascii?q?QM1gN/r9xQFZXW+F5IMN7R9A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 11:07:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703671610; x=1704276410; i=markus.elfring@web.de;
	bh=jn1IbyEVOZrfvN7XBCt9j+uuHZsv/fW9fsgamye8t/8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=nzD+b5TdpN+n+8NxtQNY4AU5fCw+GUxGO+l30gVKS2BB8EQS/oIGaanY0qd1le67
	 z5ONw168vZxrvn5SQUI6/jy4XFBEECPLA8z7KB4J193PprPn8nDnKlMhPyBqskpaH
	 e9UFE4MD16FpGve+SIHiCYc4j+USRnTTPRHijmRnAtVf12cI7EfnxPNqFIL6ag8O0
	 U88kXehW0ybP7ZZGpJ1Xkg2c83OhMvMIPmvhCRHQK2DP2JKOqJT2QlREWVnIwjaib
	 Bj/rSJ7HVtJ8cOJXihsZQSe8DPFDGogQL6jsb89dI37j8lpHv2ElejRJXi8y6tdSs
	 c1xaKXfPTidhkNd19g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1rGmeK2Ir0-004HkY; Wed, 27
 Dec 2023 11:06:50 +0100
Message-ID: <3c6ebb2b-b3d5-4698-aa89-9960872cbb4c@web.de>
Date: Wed, 27 Dec 2023 11:06:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 kernel-janitors@vger.kernel.org, Sathya Prakash
 <sathya.prakash@broadcom.com>, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
In-Reply-To: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gkazMb/O4l2GzERn48IcvpwT5y8HvZR1g45mK2lRunaPBwbiMdd
 TRJ8HoTpw/tsxHi5+rASq8Op6y7D41VS3CrLChjltMjsYIdfY6ToXfF/i6HBQJIDjWI1QOm
 nk/r6J69+UBrf8TjzIotfhmZXVBDkUhT1qrJg825ztHtHcjo+22VfAY/w9w3cYl0qu8Ppf9
 VnDUk9T3JCK+TeziBuCTg==
UI-OutboundReport: notjunk:1;M01:P0:xMCx7VgZ08M=;IAkFRS512RJ3iuU4GJ7SK9fOEKu
 Gqy65n38ZJpJYi7mBsUhtWPhM1vMlT4lg9/7Bp0uOp7L1AiDvG9j7aS5UWbEWuSKlVrNTyegO
 lq+T3Wjul3GOBU2d0zJZaob9emJIfVEuvmJbU03JHlJG4ILhiSrZr7YCvpvaiINtbLktpOLOh
 ujB9RXqwLmda1sQ6cAWJYpWRL7n3R4y1pcnBd0SO7lqydhngJv2K8E09gndhxFfT1GqA+wWWu
 V1gzqW52bxzYykEaIb3kMpXpzz6Lm4oslsGpxBWD2JotW9FI29Vkt3x09PvVTaNgb9e3E7lTS
 bpDr5bZlWRCqi94mqGR6vY3P4ARWPtWh2xQpbTiVNxFl/mEavOU+Egg7spifMEPhSLUpFiwZX
 xg+YJvVb5yEQI8N05KE/y7syNkvXrqvNWqFmpID466PrsCz3Vmt1xHLE6B4IHMGyx5cP04E1h
 NcOdSNOhsCnbpiOJNJOdN/vJdACLZXenyZrtmMLabYisyl9blyCb1KB3z3SPuxJ//RNFCKgQK
 WzvVtHuKtStfguYEV5rETXTXDO+o8QfbpnxDz6elU9OEV1J+bdSUdjdh+0COSPQQ58sFow+4E
 OuPU5E4QWmBXReDnJsjQKwxpMSEm9WjA74T3bgZIHqdTyOazFUFmzgZVtIL+/T9M9+qnrgaQL
 x0TTwLD8BNVRMx3I1ysaWy6WkwreHuKegXI4tVjU5Ar0Qb0bn1G1sZIWlnrvRIBBtgsMkDKde
 ehn5uCf2E+R0QRBNNPc9Z/uhwFkc9F5yjmguiwXTqSGnFOHc4riSIN0M5EN/Z8odwOeLhLwCJ
 wGHtQmJOqPFIvpXpxx6aawibzxXg0JVqs/A6UMRAuFz7xF0dbfxpyCZWi8YWouMeh3DfbYV4w
 8hKAAKcW1NdDth4mthohG30ypbyeCQLEYWh9RABBpfpYJKTSLtegW+conJQy1Vdk185yY751Z
 ifBF9Jttev8m7ncWCL47erxIwR8=
Subject: [cocci] [PATCH 2/2] scsi: message: fusion: Move an assignment for
 the variable =?UTF-8?Q?=E2=80=9Cphy=5Finfo=E2=80=9D?= in
 mptsas_find_phyinfo_by_phys_disk_num()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1411
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/3c6ebb2b-b3d5-4698-aa89-9960872cbb4c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 10:42:03 +0100

Move one assignment for the variable =E2=80=9Cphy_info=E2=80=9D closer to =
the place
where this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/message/fusion/mptsas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mpts=
as.c
index 452635a50c4c..02f7d11fd828 100644
=2D-- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -4169,14 +4169,13 @@ static struct mptsas_phyinfo *
 mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *ioc, u8 phys_disk_num,
 	u8 channel, u8 id)
 {
-	struct mptsas_phyinfo *phy_info =3D NULL;
+	struct mptsas_phyinfo *phy_info;
 	struct mptsas_portinfo *port_info;
 	RaidPhysDiskPage1_t *phys_disk;
 	int num_paths;
 	u64 sas_address =3D 0;
 	int i;

-	phy_info =3D NULL;
 	if (!ioc->raid_data.pIocPg3)
 		return NULL;
 	/* dual port support */
@@ -4190,6 +4189,7 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *io=
c, u8 phys_disk_num,
 		goto lock_mutex;

 	mpt_raid_phys_disk_pg1(ioc, phys_disk_num, phys_disk);
+	phy_info =3D NULL;
 	for (i =3D 0; i < num_paths; i++) {
 		if ((phys_disk->Path[i].Flags & 1) !=3D 0)
 			/* entry no longer valid */
=2D-
2.43.0

