Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50856C7618D
	for <cocci@archiver.kernel.org>; Thu,  6 Apr 2023 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O6MMivQH+ZP0Qe5ymbLv3BI74DytHqtx5BrZrdrncPM=;
  b=QsYEoVbfrzQDmx76p+i6XvbNBVAxE/+Wrzy8WJhEUQp9s7tlZvnbXID5
   bSccb8BKU0QSllu7KI6sew4CWXPf7NMEEjT8Cf8TLzhWiDvvkdjpwwy++
   WTE898M/yIPSziCsJZ3Yv29pdvCVBjiJxfMEoorDnndhBA9mZFCmixBgm
   4=;
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
X-IronPort-AV: E=Sophos;i="5.98,323,1673910000"; 
   d="scan'208";a="101232127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Apr 2023 18:15:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E865E03AC; Thu,  6 Apr 2023 18:15:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BA26BE0157
	for <cocci@sympa.inria.fr>; Thu,  6 Apr 2023 18:14:59 +0200 (CEST)
IronPort-SDR: 642ef003_MfM7lAXB8fuWJrOxEnis4iuDGSFW1S7Bb2SUt5wn6EheOfC
 lgdKHogt3P0ALr9x8J4o+lcvjynLR4rgLXyK65g==
X-IPAS-Result: =?us-ascii?q?A0F5AwAa7y5khwwR49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FORAS4DhC+HLpApgxY+DwEDAQ1BAQIEAQEDBDiBU4J0AoU9Ah0HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNg?=
 =?us-ascii?q?jcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICRz4DAyMEGQEBESYBD?=
 =?us-ascii?q?x8GAiYCAlcGAQwGAgEBgnqCKAEDMQetSX8zgQGCCAEBBoJjmSgfLCJUgV4Jg?=
 =?us-ascii?q?RQtAY0JgzZ6Jw+BVUSBPAyBCYIsiB+CZ4Ish1CHZYhGCoE0doEgDoE9gQQCC?=
 =?us-ascii?q?QIRa4EQCGqBeUACDWQLDm+BSmNMH4FcBAIUGyUEDgMZKx1AAgELOzo/NQYDC?=
 =?us-ascii?q?yAGWGsCCSMREwUDCxUqRwQIOAYcNBECCA8SDyxEDkI3NBMGXAEpCw4RA0+BR?=
 =?us-ascii?q?gSBCoEBBgEmJJ5RAQFSKBNMJoIEkliSRZ4YNAeCKoFWgVkMnw0GEy+XCQ4Gk?=
 =?us-ascii?q?iUul0Ugp3+BeSSBXDMaJIM2TwMZD44gGYQMjwkBPj80PQIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YV9AQE?=
IronPort-PHdr: A9a23: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
 ZP+9xp9
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:88rQ0aCkAZUxFDDlHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,323,1673910000"; 
   d="scan'208";a="101232123"
X-MGA-submission: =?us-ascii?q?MDGp9KAroRm9Rm8HM+6fPBXtKQqm737DOxc02X?=
 =?us-ascii?q?RDoF9SfhaHbiHiqLS8a/oV9z6ROso+UcqNtO1d9mR+dfE2LDuOdNFSla?=
 =?us-ascii?q?LezBh9dbdsXG1wfwYU+LNc3ZtloM6mPOPDLVdc/e4boDYICDat95dA5i?=
 =?us-ascii?q?r2XVWnb1UAyzSpWkj4/OIJfg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 18:14:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680797686; i=markus.elfring@web.de;
	bh=BJrmBWYqww9AixYZD44g4r/Rh1TPUozkGnJjVvm2/pA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=H1MIrDY/zGaYbyeqomvRySjc3vspowtPj7BxQOHwFa2TJBfjaLU6MlWvb8YmgcCH5
	 Juz8vKHYeCyv0rhFPhPojRjILe1M8snwf4nanp18W+MczB3P5RNNyRQTAYLFVSpJRe
	 pYNKtjIFn0PC3Y5EA/WUJVZgWqMLpaHvuH3D8jxck+R9vs4WDsadyRFIk4KtVc1p8v
	 ud8jG12EvAu5k/twYcJ0UKX29rutcG2Sv1iKpY54ugPo/vMx5CQtK+6iFVlU5T8xhh
	 Mb32GDLhREzFaQ/GJUeH7Pv8NSYLCWW9SUtrHcdoM2VTh1eGptIOLQ1Qe2zBcDRuG+
	 pcXFVko0fioNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1pqOFg1sVO-00TVqy; Thu, 06
 Apr 2023 18:14:46 +0200
Message-ID: <b6788820-8bbb-4823-834d-21067088ac9e@web.de>
Date: Thu, 6 Apr 2023 18:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Matan Barak <matanb@mellanox.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Yishai Hadas <yishaih@mellanox.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <01af2ec9-4758-1fe6-0d74-b30b95c3e9a5@web.de>
In-Reply-To: <01af2ec9-4758-1fe6-0d74-b30b95c3e9a5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cUK/1YNEx/UIhngvqAZ8l+gb+juxnNtqbzBi9PEMBgorhEL9IVb
 HSlGFWu2xkdvOk+0cUICwTlnXviwVVuVa7o7gnAWXzKdOwySHRdhjTS9bTpd45pIi2TI+YH
 m0zAL7KudI/jRF98qNZYeWVDWaGZp6WtUXANuVXncVlfLbhLjTRj6dNGzezOMk1EBi8j8LV
 DFvKe07l0oxO8wRJQzJRQ==
UI-OutboundReport: notjunk:1;M01:P0:IXP+MVVGzvc=;7ll72wNQaT+El/eu2xnfM7HNzWZ
 +jQ7NfjQiXAt7KJjzJHMEM9N7Te5mjeAV1Stl+m/QNkySFwn/Tg9gXJsgIq38NDUiWhx1L/n7
 Xdytw15i+SMSlCPtqwsTAtC1OVJVSt9OTGHieWtSNN3aGP7qx2vwXsMMVYYb9Z7OtMhFPKxNd
 fdlOv5ZelcvUExex4cBRhFhBCrOHQNRllO9SElKgktfeCpfzidLfZ/vheLYkeQbWOeadxX4FN
 RlfUnA5hrP4DMpa1IlRLZSzTGgGPve0/lqyyC750NKgPGNFxE/SHySZAaiCZ3YIfgYahJLaWv
 M6TedROzPipzht84r2h6jRuIrQhFysSLY6h/7mSp5xcNvOSSyiae30WuNfV5HQzq8Fw00qhqL
 +cZcm+SbBUVOAVEIot2J372aiWlRDCr4HCnaUtLHaaua6w2WwoFU0nsxKR3ObhuCN+o1TqD46
 pgnuvPccISvDyMdcQMrfTpRTdennBu0KBGAu+asWq6OlFvD05cg1aI3XkndO5CX01Y+ASEskd
 GDtHCu18mICtu6ZJvsRqwhPH0nkBRhuYZ5AEBozHbVdkRsVc9HhaDdv7A+eAbcpjLIQFZNXi0
 /EExhMFgefWj47Da12g1TnlWXNOZZU4aZKp4R1Ts1IUFbz2cds3SEeJh0Y43NCMo39L/diQQI
 aGyBGYPcL/0s12jmtnYOMj8fFVrWQ/F+Qrg3dJWXazIXaGIv/XSyrJ5u7yBTVI8pjmCixl+I0
 hRjBAdN4HzNmzz8sAwf0MOs5Lq5CC5kfMICFZ9bL7AyDv3oaxo5kVciVnuAqGj3evRgj4dzrW
 fcXsD3hDC+sbGhWTzS2wdGbPQV0Ch2vf/6gpJKfSjdzzFkjnjoFwCGe+aDg8CE3EuW9X89hyH
 PoymmtnivpANKY1SGOE08cd9WMCYicgbreqf85UI1UmHdLQT9izt28tFR
Subject: [cocci] [PATCH 1/2] IB/uverbs: Improve exception handling in
 create_qp()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1007
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/b6788820-8bbb-4823-834d-21067088ac9e%40web.de>

Date: Thu, 6 Apr 2023 15:48:06 +0200

The label =E2=80=9Cerr_put=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Ccreate_qp=E2=80=
=9D
that it was determined already that the corresponding variable contained
an error pointer because of a failed call of the function =E2=80=9Cuobj_ge=
t_read=E2=80=9D.

1. Thus use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Split two condition checks.


This issue was detected by using the Coccinelle software.

Fixes: fd3c7904db6e05043398aee5c1448682acfb025b ("IB/core: Change idr obje=
cts to use the new schema")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/infiniband/core/uverbs_cmd.c | 52 +++++++++++++++++++---------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/cor=
e/uverbs_cmd.c
index 4796f6a8828c..465f55de4684 100644
=2D-- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1323,7 +1323,7 @@ static int create_qp(struct uverbs_attr_bundle *attr=
s,
 					    cmd->rwq_ind_tbl_handle, attrs);
 		if (!ind_tbl) {
 			ret =3D -EINVAL;
-			goto err_put;
+			goto abort_alloc;
 		}

 		attr.rwq_ind_tbl =3D ind_tbl;
@@ -1331,7 +1331,7 @@ static int create_qp(struct uverbs_attr_bundle *attr=
s,

 	if (ind_tbl && (cmd->max_recv_wr || cmd->max_recv_sge || cmd->is_srq)) {
 		ret =3D -EINVAL;
-		goto err_put;
+		goto put_obj_read_ind_tbl;
 	}

 	if (ind_tbl && !cmd->max_send_wr)
@@ -1343,13 +1343,13 @@ static int create_qp(struct uverbs_attr_bundle *at=
trs,

 		if (IS_ERR(xrcd_uobj)) {
 			ret =3D -EINVAL;
-			goto err_put;
+			goto recheck_ind_tbl;
 		}

 		xrcd =3D (struct ib_xrcd *)xrcd_uobj->object;
 		if (!xrcd) {
 			ret =3D -EINVAL;
-			goto err_put;
+			goto put_read_xrcd_uobj;
 		}
 		device =3D xrcd->device;
 	} else {
@@ -1360,9 +1360,14 @@ static int create_qp(struct uverbs_attr_bundle *att=
rs,
 			if (cmd->is_srq) {
 				srq =3D uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ,
 							cmd->srq_handle, attrs);
-				if (!srq || srq->srq_type =3D=3D IB_SRQT_XRC) {
+				if (!srq) {
+					ret =3D -EINVAL;
+					goto recheck_xrcd_uobj;
+				}
+
+				if (srq->srq_type =3D=3D IB_SRQT_XRC) {
 					ret =3D -EINVAL;
-					goto err_put;
+					goto put_uobject_srq;
 				}
 			}

@@ -1373,7 +1378,7 @@ static int create_qp(struct uverbs_attr_bundle *attr=
s,
 						cmd->recv_cq_handle, attrs);
 					if (!rcq) {
 						ret =3D -EINVAL;
-						goto err_put;
+						goto recheck_srq;
 					}
 				}
 			}
@@ -1386,9 +1391,14 @@ static int create_qp(struct uverbs_attr_bundle *att=
rs,
 			rcq =3D rcq ?: scq;
 		pd =3D uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle,
 				       attrs);
-		if (!pd || (!scq && has_sq)) {
+		if (!pd) {
 			ret =3D -EINVAL;
-			goto err_put;
+			goto recheck_scq;
+		}
+
+		if (!scq && has_sq) {
+			ret =3D -EINVAL;
+			goto put_obj_read_pd;
 		}

 		device =3D pd->device;
@@ -1422,13 +1432,13 @@ static int create_qp(struct uverbs_attr_bundle *at=
trs,
 				IB_QP_CREATE_SOURCE_QPN |
 				IB_QP_CREATE_PCI_WRITE_END_PADDING)) {
 		ret =3D -EINVAL;
-		goto err_put;
+		goto recheck_pd;
 	}

 	if (attr.create_flags & IB_QP_CREATE_SOURCE_QPN) {
 		if (!capable(CAP_NET_RAW)) {
 			ret =3D -EPERM;
-			goto err_put;
+			goto recheck_pd;
 		}

 		attr.source_qpn =3D cmd->source_qpn;
@@ -1438,7 +1448,7 @@ static int create_qp(struct uverbs_attr_bundle *attr=
s,
 			       KBUILD_MODNAME);
 	if (IS_ERR(qp)) {
 		ret =3D PTR_ERR(qp);
-		goto err_put;
+		goto recheck_pd;
 	}
 	ib_qp_usecnt_inc(qp);

@@ -1476,26 +1486,36 @@ static int create_qp(struct uverbs_attr_bundle *at=
trs,
 	resp.base.max_recv_wr     =3D attr.cap.max_recv_wr;
 	resp.base.max_send_wr     =3D attr.cap.max_send_wr;
 	resp.base.max_inline_data =3D attr.cap.max_inline_data;
+
 	resp.response_length =3D uverbs_response_length(attrs, sizeof(resp));
 	return uverbs_response(attrs, &resp, sizeof(resp));

-err_put:
-	if (!IS_ERR(xrcd_uobj))
-		uobj_put_read(xrcd_uobj);
+recheck_pd:
 	if (pd)
+put_obj_read_pd:
 		uobj_put_obj_read(pd);
+recheck_scq:
 	if (scq)
 		rdma_lookup_put_uobject(&scq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
+recheck_rcq:
 	if (rcq && rcq !=3D scq)
 		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
+recheck_srq:
 	if (srq)
+put_uobject_srq:
 		rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
+recheck_xrcd_uobj:
+	if (!IS_ERR(xrcd_uobj))
+put_read_xrcd_uobj:
+		uobj_put_read(xrcd_uobj);
+recheck_ind_tbl:
 	if (ind_tbl)
+put_obj_read_ind_tbl:
 		uobj_put_obj_read(ind_tbl);
-
+abort_alloc:
 	uobj_alloc_abort(&obj->uevent.uobject, attrs);
 	return ret;
 }
=2D-
2.40.0

