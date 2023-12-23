Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DA6C3DA6E
	for <cocci@archiver.kernel.org>; Sat, 23 Dec 2023 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xZfazrSUxy6tWWKhc77GgAGBpvSLtaBI91i+gYJgWuo=;
  b=eYr5WTiYjQYU1tHNBs+mh4OYYOfPsNRbhCLwyd+yeD4cGskCs/dZi2ez
   3BKVuKoQWGvo2xUrh/D6dA+n/RRPrw/9oqrtllMEjfQPPDC5XM08Bg8wV
   2c4mAt3KhE0pXsZwE8iSOFccXl+NRGs0eG2OF4fAsfF7bXstLIjJ7yLDo
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.04,299,1695679200"; 
   d="scan'208";a="143888077"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Dec 2023 20:27:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 568B2E0CCA; Sat, 23 Dec 2023 20:27:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DCD28E004E
	for <cocci@sympa.inria.fr>; Sat, 23 Dec 2023 20:26:56 +0100 (CET)
IronPort-SDR: 65873480_cTYLXtYKvysa3dddgZKVPuReQ8ToERitOUUiWM0vFaZedle
 vvYqOr6FESC/nH8yz6vBHi5qS0yEjoIDgB/EZyQ==
X-IPAS-Result: =?us-ascii?q?A0EIAQDIM4dlew4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4f1MyBAtIhFOPQYF1MIQ7hzWHTIRrhASDFj4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoc2Ah4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBJBgGDgULJ4VsDQiCVAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?0IDAyMEGQEBESYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQevWH8zgQGCCgEBB?=
 =?us-ascii?q?q9YHywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgTyDQYQKhBSCaIkbBzKCHINQk?=
 =?us-ascii?q?Vl9BUFwGwMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIFdgVIKgQE/Dw4Rgj4iA?=
 =?us-ascii?q?gc2NhlIglgVDDQERnUQKgQUF4EObhsSHjcREBcNAwh0HQIyPAMFAwQzChINC?=
 =?us-ascii?q?yEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMT?=
 =?us-ascii?q?wNpHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGBgldJ?=
 =?us-ascii?q?gcPCQQlAwgEAyspAyN0EQMECgMUBwsHUA8DGSsdQAIBC209NQYDCxsGPgKmT?=
 =?us-ascii?q?4EOgnYrkkePT4NOnnI0B4I0gWCBYQyfKwYTL5cmDgaSVC6HUJBPIKhGgXkkg?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIAwWFoNzjwkBPUA1OwIHAQoBAQMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:dJUOR6G/VlPAaxZxpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:YgR2w26m7Ug/QuW+ZNssqH9LBPo0SCzh6G7JBheWJjsyd6WbYArF
X-Talos-MUID: 9a23:npMu7Are+5KGxuoWZHwezxcyb8JUzIaBM2MMs4UMkZaVOXVNMh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,299,1695679200"; 
   d="scan'208";a="75263848"
X-MGA-submission: =?us-ascii?q?MDGPWpZI5LW4+Sj0VfNV0HdL+0KNAyuH4+P9FH?=
 =?us-ascii?q?o9YOPo6SxmtRqZuz6mxedz+64cL+wX8FPCynC7eBUseK+DQHfw0QH721?=
 =?us-ascii?q?ZBd7bVvzNspBi6TiczBpYdCZMrK93VgsoeNdduDvj0S6y3nbaru9ex3K?=
 =?us-ascii?q?gjH5vX6Ofkff3lHNQU34uLcA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 20:26:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703359341; x=1703964141; i=markus.elfring@web.de;
	bh=YdAJatdNn222cw6W3QL2m67wBaRz4XfpDHkOgUq/DzM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=DRvT13IYN86qWWYfaYYHMQGACaB4wgzWoWS3gk3x95GEXcjtp/qQhmP2ddXpxmpR
	 3U1TUhijU+JI2BOr3YuQbPeaxlcgr2ZUrgp/kyMoyG/D3L9EK/kiLjNWO+4xMrA7M
	 XFtoCmHjmcLgRT4z8pmcWWzCxtvsFKlYkv7WilwLnbpoPuzXvSurUbUap5OTUJVtx
	 digFUaZp50o8nTrNc4GPR/GVCvSXZXEpzKHT7BjxiXGjN21dhh1T8tyzc5Vb1HBuM
	 YyF8s+003nVGsfFVSzqDJqMUE5++xPdvly88/TMIGPTgCXm3FNJ+l9eFmApWoEf48
	 z2+jLdCrUJ/q6bvpCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91LW-1rJr8V0A3q-006YFy; Sat, 23
 Dec 2023 20:22:21 +0100
Message-ID: <f46f04bc-613c-4e98-b602-4c5120556b09@web.de>
Date: Sat, 23 Dec 2023 20:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
In-Reply-To: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iwQeDu1WH1Hs/rx34Ekzp0SH4cpBbM2mbWTPb1Ujg9sRMV1MtuX
 gioyvZq/vdlkoLQnvzThvnykPLFZzuC+llhzMCsLGNoubqs4RnjZ3/DO3ZaxyH8kiPh86X6
 4tzaAWtuSr+WpILDljfOuOoWFNvHhfMAF7CsWVVqya2KuKYmykyhq4lrLdAu2/6mZucSe2L
 2HMPjzjgQWhXWBRqK5bVw==
UI-OutboundReport: notjunk:1;M01:P0:yZKPcLNQDaY=;mP4Sq/6d+Osl3c8Mwq3xGfn65G+
 Cy5+3xeihr3bxyKux71Trf6ILjj2DIcDIUmt18T/zGJ62znw0jMhZR6we8zwz/6bFPK7bT1ux
 0vYRROAT6T3jA+FNSPbn2lgKAYciOgQGdR5jrgEggtlJR0TWQHSZ1ZI+8UwCO9Hw9a92SQlYs
 TOMBlmpeFbR4IJubUkjGeS0H+ZCphXEKJpBTjPC7Bcb6YtPclT645Gso2flPViTSPWCplrEej
 HpeUWa+ePUK51LU2zj92Qb+hEICLkrFzWkLwERFn4GVjBUbbX0hFyELc6Si0+h7PGejF1sF0r
 ImuOBZY7SQiTsVHFsemFmZ9n5xkl2PDJeteIz6XuiTxwuK6EavKZjBm6DsVnUyz4IE6A9jRYo
 LimvMDPYW7QF8WRmSNyrEen1UH8rD2saHBG36rnuSyFKC5gKQFTnUZVlB3qeVf6evneM0xhHV
 Dvi/07QxLwnO1MbKIan2zaFBQxGf0VSLZTIpmDaBIPdJOVD62d1LZI0WBrJd/NKfGoYHTCzgm
 Q5Kl96pAVli/Ct1DFdRESfDfPDNgHR0CV0XJE/Effb6Ppu7i71TG/aLLVlCh1eNMThstuJk3C
 OGCMCVO6jyacm/4gHq1Ya66c3zU5w/qfKU2mvHqZx/b89i9Xk0g04aKDz2ZGewVSF+9ZT++8X
 5eMQ7FbECCqK+aGDqhgyCW45yXhLHICdVk/QIfISFC6sLzashmKAi7JT7QC9/ZZxhE+VZT2Jp
 8WoAbMsv7esgEIt2EY6FWwi6ANGovAJ1SfWTswYMFjJokwFCklRQ+Loco+PMX8RRZK4KlAG3H
 u2GDnSSQZ5QH56KhGZb2ucnXqlmGGzc9jlwDpSIeQ8PFwlQksvQyQqyqUHG03lTy8RSY44C+y
 RPMvO2rmKoZ9EM5GYzvgz7lfmLd0LRyTXHFrwIgE5ISh5IZsbmL8l6K6ek6xXbqMpDan+JVA5
 QcrSsA==
Subject: [cocci] [PATCH 2/2] powerpc/powernv/vas: Return directly after a
 failed kasprintf() in map_paste_region()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1365
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/f46f04bc-613c-4e98-b602-4c5120556b09%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2023 19:48:09 +0100

Return directly after a call of the function =E2=80=9Ckasprintf=E2=80=9D f=
ailed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/powernv/vas-window.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/pl=
atforms/powernv/vas-window.c
index b51219b4b698..2f7d1850b1fa 100644
=2D-- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -78,7 +78,7 @@ static void *map_paste_region(struct pnv_vas_window *txw=
in)
 	name =3D kasprintf(GFP_KERNEL, "window-v%d-w%d", txwin->vinst->vas_id,
 				txwin->vas_win.winid);
 	if (!name)
-		goto free_name;
+		return ERR_PTR(-ENOMEM);

 	txwin->paste_addr_name =3D name;
 	vas_win_paste_addr(txwin, &start, &len);
=2D-
2.43.0

