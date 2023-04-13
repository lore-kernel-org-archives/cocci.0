Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681D4C77B6E
	for <cocci@archiver.kernel.org>; Thu, 13 Apr 2023 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=u6GJleiguZfwvzbh4EP3iohTS/VxJi3mCnJ3m1Kxid4=;
  b=Qp3rEBxVik4oXX+pesjlGJxcQAcl8yaP3HIJQ4Hn28JnYPkgARZ7cQag
   oKY55y/K2fAODXs8Y3uh1cF9DkVjiwi/b9LA+3EiiYlcjghrhM65ZC2N1
   glu6Fnvh0Mo8ZZV7PJZ/Haetj1Zh2hAV+6p2IirlGuJybANRIShmSWKtJ
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.99,194,1677538800"; 
   d="scan'208";a="102983585"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2023 21:10:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40A3FE0B0D; Thu, 13 Apr 2023 21:10:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 068F4E0171
	for <cocci@sympa.inria.fr>; Thu, 13 Apr 2023 21:10:38 +0200 (CEST)
IronPort-SDR: 6438539f_FJELYxLxCoB+B96anxWVcePaPVygHFPKgHMyzJ4Uv0bnRMv
 iOgd6Hqa362slnS6fGk04160/sqaZ9Z0asrTkNA==
X-IPAS-Result: =?us-ascii?q?A0EdAABWUzhkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkLgOEMIcuhz6IaoFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4JqCgKFPQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHr?=
 =?us-ascii?q?2F/M4EBgggBAQaCY5koHywiVIFeCYEULQGMSj+EMCcPgVVEgRUnDIJHb4QLh?=
 =?us-ascii?q?BSCZ5FoiFoKgTR0gSAOgTyBBAIJAhFrgRAIaYF5QAINYwsOb4FJY0yBewQCF?=
 =?us-ascii?q?EcZJQQOAxkrHUACAQs7Oj81BgMLHwZWawIJIxETBQMLFSpHBAg4Bhw0EQIID?=
 =?us-ascii?q?xIPLEQMQjczEwZcASkLDhEDT4FHBIEKgQEGASYknhVyAVI7TIIqkjuxADQHg?=
 =?us-ascii?q?iuBVoFZDJ8NBhMvlwkOBpIkAS6HMJAXIKd/gWM6gVwzGiSDNk8DGQ+OIAwNC?=
 =?us-ascii?q?RWDbo9IPzQ9AgcBCgEBAwmFRgEBgySCWQEB?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDTQI
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:d4A5ca7uO9So2QqiFQPXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:/vHTt2BXbBMm+CP6Extg5U0xN/olSFjc6n7gIV6DJmtqd6LAHA==
X-Talos-MUID: 9a23:Z6QO4wQ+D7EDif6ZRXTVohBCbv5I35iSM38dkY4ogOKuaQBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,194,1677538800"; 
   d="scan'208";a="53295986"
X-MGA-submission: =?us-ascii?q?MDHOgdX7iAhHebQq+vDkUldmurKVXMj5buPatj?=
 =?us-ascii?q?dTzrqaUKKUtbthXhv+lxcZGcS9g8lEE77PWOcEs1j+hNtz79wYmGTG40?=
 =?us-ascii?q?e+lTANT6F517FmHgY5BU1EOFmAVFHyC05tzyUKam5uJQGUUU99twFAU0?=
 =?us-ascii?q?iRZC7OKG7hzKvscW/VLBKhKQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 21:10:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681413021; i=markus.elfring@web.de;
	bh=etgwSojex9PX4ClJJ4ZDADnd5Rb0VCULwOMRsjrfFwo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=OC2876/dpjwEZC3oHOziWm8h9Y2q0LwHmdGXNnXR02h74HDhVFzH51Y0/z1eBl86T
	 /rsQ0xJGRd2Gy7NQEalh/ZdE9BgvR5XRE98le1DmnVoQLhi+MLX5E8J3Hff+QCFjZv
	 pGObMM92/vyVZE3o2hSx32LEiEsisOGVcuE9X4WivJGbms6CbERduLN8Qyiz4mTgnZ
	 /VthOv+vzCtgs1WjUsNbdU1yjeUkT1rnFkvjHNDOUqP1PHEyFIcCvX/91ruFjHRPrK
	 bjWY4uGCvXCyy+DjOaA8MNEd8G08nuRNa+08ZtbG6EZo/opTxRVTrwRvyT8LIn2Q7q
	 mqx/gbQz9qNwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1qdMXK45aY-00v6iT; Thu, 13
 Apr 2023 21:10:21 +0200
Message-ID: <5800e1f5-8681-e140-fef0-8b2c3b4b6efa@web.de>
Date: Thu, 13 Apr 2023 21:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, cluster-devel@redhat.com,
 Andreas Gruenbacher <agruenba@redhat.com>, Bob Peterson <rpeterso@redhat.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zh0RTJP5q0rgxB+HvwHxCTIRPfYOBiTjaUj5vdlTUeSZZz40fte
 JNcySvqRN1Op2KyW6VLx62tCpDnb2+6Mv0VjeN3l2+yWQ/EX/7s4EFJyvfqKhD4caOMMM2o
 fpICdIdsKmcbT3g2gS5xW1g4Ccx+36DsLEudGm+4QMTEKlVoPz3ZILU8diDKalGA4RDyuvV
 cUuKP7ceyHYBorep4D77A==
UI-OutboundReport: notjunk:1;M01:P0:qU6sB90HaPM=;pZmRwxFzoiaYBAML4I4MWiPN1UJ
 Q/9V9z2KTrKZo2d93YlhzOr162XSAzr8/aV3zAg4j3nW3A/ECw3Rsk4WuJCIUY/nwP13B4so8
 KXLitE23D0nwUurhQmD8EzoWev8V/EkltsBfHqC3Yo0YVX+KLoci81BIvHOQGnSZKr7V5ghkx
 6cqT7OSEdAvYvKQXOwUm2ED52QRurG3Nmme1wRBn4FGP1EHnVX04iAWuss6wH0Hyb2RZ9tPyb
 n1mjfACRUQYP/1yBhW1W17AXdANQO+OLjhtJTqGz9GBAOAVq0nA+6Rdm5WfQSHnf1Uq5sudX4
 79KVI58vJEKmBf0aMBLRUy/gTJPYPRk3HenHxCUBRaz1scKg6bsBkBlMill5R1oud6yI9eB53
 FsBbbhnscYDVN06+BUMjQnRgdmjHuUieDBpz3tpNGyHNP1CSWgfjHIkfjB6caqyc8oW2PbJut
 v6UTPSZe/v4EjzJHBotBTbNPP58Wxt1ht3oFMibfcHEJ+ookvm5/111Sobbp8WYZ09XdD5gsc
 8YOLT9HoVXDApbCrafnThIdK49cK5PS1ceAAH3Du3QahpxsFw81t3CJ19nGoFa23lTY3OckAk
 Cf10D/N9KimyRW4xLhFK1vjVJ5sbWr7hzHnj2ePO3w2s7ogipV+s438D+OxR+UbOMoDF/7Fap
 Tqco1NK//n+MazXQI+1ckFgaZ3fdCXc/qnPioqYE0CRVRl52JspaklE64hjNDbIF+tK5feKdb
 hQ8Y4iez6BRx26nV4hmyLwkRuVu+K4OhziaMs1k97i7QIj/ON8lVpezrvTmG8px8pt1Rnlech
 NiXx3Fg8FfuV69+gZ+57W3CAG7HWVhIZorrFdSFQulTkzUR3OXrcIJh1tTngjJpT2FvZiMSw2
 n4HpDrm6mWiV9NQF9GA7t0f8ggScvif7RtiATymOLX/1ZmQgsIxFE075s
Subject: [cocci] [PATCH] gfs2: Move a variable assignment behind a null
 pointer check in inode_go_dump()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1042
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/5800e1f5-8681-e140-fef0-8b2c3b4b6efa%40web.de>

Date: Thu, 13 Apr 2023 20:54:30 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cinode_go_dump=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cinode=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 27a2660f1ef944724956d92e8a312b6da0936fae ("gfs2: Dump nrpages for i=
nodes and their glocks")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/gfs2/glops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index b65950e76be5..6e33c8058059 100644
=2D-- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -535,12 +535,13 @@ static void inode_go_dump(struct seq_file *seq, stru=
ct gfs2_glock *gl,
 			  const char *fs_id_buf)
 {
 	struct gfs2_inode *ip =3D gl->gl_object;
-	struct inode *inode =3D &ip->i_inode;
+	struct inode *inode;
 	unsigned long nrpages;

 	if (ip =3D=3D NULL)
 		return;

+	inode =3D &ip->i_inode;
 	xa_lock_irq(&inode->i_data.i_pages);
 	nrpages =3D inode->i_data.nrpages;
 	xa_unlock_irq(&inode->i_data.i_pages);
=2D-
2.40.0

