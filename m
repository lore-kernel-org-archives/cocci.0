Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D8BC76196
	for <cocci@archiver.kernel.org>; Thu,  6 Apr 2023 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qUsm4I+mvOq8tbWGQKcZcYlYiFNc5bRDBNSOSp9d35A=;
  b=ewhFk92WOzkX76y3aIiqwur4vlJruefgRR+ifq8YjlbHr7C2wF9WQ0j9
   R2HCnYnUKM0jptPFHF1DvxRVyV8R4i8um5NLI3FRkv3MCvfGGFsJdqZBh
   KHKDscVn5MqbtOW2TEhw2wH68Ml0rvOek038c2m0QcnN0eN5l/xIWcAUb
   8=;
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
   d="scan'208";a="101233516"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Apr 2023 18:18:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 49685E0157; Thu,  6 Apr 2023 18:18:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C7FBE0157
	for <cocci@sympa.inria.fr>; Thu,  6 Apr 2023 18:18:34 +0200 (CEST)
IronPort-SDR: 642ef0d9_MQTUJC9HumaYuU7xnkdpuLVwqWyDztN0dOoi5B7m94sPegU
 HEKfcA87J3s9lntVQPR4Qf3TJR+pXvWA7tDxM3g==
X-IPAS-Result: =?us-ascii?q?A0F1AgCG7y5khwwR49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FORATGEL4cuhz6Ia4FWgUA+DwEDAQ1BAQIEAQEDBDiBU4J0AoU9Ah0HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBARoJFwcOEAUih?=
 =?us-ascii?q?WgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICRz4DAyMEGQEBE?=
 =?us-ascii?q?SYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQetR38zgQGCCAEBBoJjmSgfLCJUg?=
 =?us-ascii?q?V4JgRQtjEs/gzZ6Jw+BVUSBPIEVgiyIH4JnkWGICjwKgTR2gSAOgT2BBAIJA?=
 =?us-ascii?q?hFrgRAIajmBQEACDWQLDm+BSmNMgXsEAhQbJQQOAxkrHUACAQs7Oj81BgMLI?=
 =?us-ascii?q?AZYawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPLEQOQjc0EwYFVwEpCw4RA0+BI?=
 =?us-ascii?q?R8GBCRmgQEGASYknlIBUjtMgirDNTQHgiqBVoFZDJ8NBhMvlwkOBpIlLpdFI?=
 =?us-ascii?q?Kd/gWM6gVwzGiSDNk8DGQ+OIBmEDI8JAT4/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 8bEkg==
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:tioUqaOny7rII8BcTtqjsMiBIKoaSvp037BN7TESdfU1SL36qy
 nApp4mPHPP5Qr5O0tBpTnjAse9qBrnnPYf3WB2B9uftWLd2VdAQrsM0bff
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,323,1673910000"; 
   d="scan'208";a="52387897"
X-MGA-submission: =?us-ascii?q?MDEgP4ml7FPycB+1MfZ5278qH7l1T+SjpAf0h4?=
 =?us-ascii?q?Zjb4x+N7qNi83fsR+GBe1FE5wsnOwvMyKSU5jXkBWFPVsSW1JAa73fff?=
 =?us-ascii?q?IGcjh18QXJw8DuyLvwkCMG+xyG4JRqATY9TMbQmV4PFWV2XHmqu2QvC6?=
 =?us-ascii?q?xGLLAYNOAmi1R3N1jKIhdm1Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 18:18:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680797900; i=markus.elfring@web.de;
	bh=nrHtp4VKGcVVGGLKNcZAdpQ6I8sK8d26ayCOJKQFIsw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Soks3r4RgIOu2iEgpfbNS9Ug2vyUnnQlgBKxxKHEYwOpsO6NC0DuF+TO3OJAj3len
	 TmhUg9cSYRfOuvZI9j0l5MK2PfZ/CgbU4dRkx7XQMm41pSzS5lK6le2rGRa8h/0als
	 yodmZgWBHZ42fVJTezUbAbIhBWHqGp7wnhA/Sna6Ew/KvyBTFn50BUq5FkBrvzFpBt
	 GJpIAkft7jGJpxYiZ+JZLzM+NTRWnJ2UksD50H4jN0t8iuIpqBqCYib2WXGOpzSpmz
	 2G98aIRX+ygGCyzXT8LKGAvwuyMpnSCvmTaTj9lHp97cZG+w4gmGmqEuL/uTN2aLqp
	 e0/ZpZZwGKOrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxsD-1q506l0VK3-00NerF; Thu, 06
 Apr 2023 18:18:20 +0200
Message-ID: <dd87eed0-a903-652e-4cf9-1681d1ca7b47@web.de>
Date: Thu, 6 Apr 2023 18:18:19 +0200
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
X-Provags-ID: V03:K1:xfFzNfFPTqsOa/D5imh4bjTaedpVGlTjPre2ja/j4/8Teze3uWd
 du0rpLBsyvGo9fin0j/sUSTo+8Oj7TyrbDJQHFqGORn6F7+y1zraHH5/c8J1HcmpzYqA2tq
 aCziCVI8qUue3W8PbZXIF6ksLXIv2HhOVsJhneIvY5xTnV9p2vzjg3gzJkboE4cFEK09VEH
 SkzdoCkOOd72kbwSeFlQw==
UI-OutboundReport: notjunk:1;M01:P0:Pq/BLjTn+mY=;MOxToszINY3q/wOE4PwfsPl0YJ1
 lK78ZHnW6cWhKDWpO/IKE+fX0GmtcOpuoO78opk2yfWXIAFXqZvyFn2TZXj3DI6AbhS8PmKw6
 0l/4FA6GTjkgfWE7vOAyKqt5Cv/n/m92ZwKM082U05O2bnQMGAtFXU1BvkgqppIv+Nzn59iD/
 NGLDbtls7Ql6SJL9n8pltYzZRckCvwe69jmThnonTQR4Ym1ctAryA4ahToAO2OlNB/6w/j+EV
 TOeXH9Jk51xJ+FvAa1Hkaq6KBHNKEJh/jP7PZiNoU8YUp2V1dv4ORPiyefBlgrNYkCXUek5Ng
 F+bo7c2Db4d7YRa6dlqQ5Htvd2g2/0kPXSNCdI9v6PIplrPlEed+h+3XbS/ITcIPj/eMQXyFI
 JFP7MdtvhtEVhBhje8GlQuxZdeSEDTe7wvHlk3PrBPpNxjIVBNNEu1hW/iKBWSparW7BvtEz7
 FTYahGA4gFRp3wCIn/EupQc4t/EmcLxsHt8Bpi/cdbYSyDLGY1UKFlSJk+LG4/LpHQPhTqrSt
 6I7+HjKKQipiMpFslXxweisFKs5cVzrW5F6mZztQ6Bl00KQsLml37O00tFvyWiRfBUo16v3G1
 D7zSASrFqf3Drv2gMl7MMWvk4pokklic1PWovkLYsAocXMsAWVxgJBlLURLo/B7s/als2E1eE
 uTOXCVf/M2Qc952lJY5O5CHP03AtAabJ5fonWevNJ89MmHRgxllffZI3vieJwCJXpE/FQwW9r
 sae+eH9cMJV2IWL2KpZ2RWjh2jDx9nqniRY/8AV8jnpyofNabll0Meef3HAvJ/dBxIsT2zlY5
 AFX1WaLhyRs/l80hkAsN8YLH/k/PSzWG1YQA4UOUs2Mo9GWYoAkkfJwzgrnt6DNRA3sJ99lkF
 A4eXNYwLsWGpEeQtpx7Qo0HUqXKFetPkgdha684IWRUzjBBz1yKRfRpT4
Subject: [cocci] [PATCH 2/2] IB/uverbs: Delete a duplicate check in
 create_qp()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1008
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/dd87eed0-a903-652e-4cf9-1681d1ca7b47%40web.de>

Date: Thu, 6 Apr 2023 17:30:29 +0200

The check for the variable =E2=80=9Cind_tbl=E2=80=9D was repeated directly=
 after
an other if statement.

Thus move the common code into the previous if branch.

This issue was detected by using the Coccinelle software.

Fixes: c70285f880e88cb4f73effb722065a182ba5936f ("IB/uverbs: Extend create=
 QP to get RWQ indirection table")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/infiniband/core/uverbs_cmd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/cor=
e/uverbs_cmd.c
index 465f55de4684..bd741c507bad 100644
=2D-- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1329,13 +1329,15 @@ static int create_qp(struct uverbs_attr_bundle *at=
trs,
 		attr.rwq_ind_tbl =3D ind_tbl;
 	}

-	if (ind_tbl && (cmd->max_recv_wr || cmd->max_recv_sge || cmd->is_srq)) {
-		ret =3D -EINVAL;
-		goto put_obj_read_ind_tbl;
-	}
+	if (ind_tbl) {
+		if (cmd->max_recv_wr || cmd->max_recv_sge || cmd->is_srq) {
+			ret =3D -EINVAL;
+			goto put_obj_read_ind_tbl;
+		}

-	if (ind_tbl && !cmd->max_send_wr)
-		has_sq =3D false;
+		if (!cmd->max_send_wr)
+			has_sq =3D false;
+	}

 	if (cmd->qp_type =3D=3D IB_QPT_XRC_TGT) {
 		xrcd_uobj =3D uobj_get_read(UVERBS_OBJECT_XRCD, cmd->pd_handle,
=2D-
2.40.0

