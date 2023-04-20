Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C27C77B73
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 10:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VwfV7jjWteVNeIZyEBHOhRehA7DMGYEldb41J1eghgE=;
  b=FNDcuNWWwlmzypRRRNlGmUDGqAGuXafWD4J+EdLQOum2rzV3bH0RVA4p
   58GTLNb3Mbv2H3///mE07q9XnmCWCtTv2bqlbPO8g44xobg076mbha9cX
   1YMMsUPmNyXIfpCtThC57GAH4kk80BDF7ibGFpdhz16ExZY2ygVd9ZFJU
   A=;
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
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="103965139"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 12:57:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AC901E0235; Thu, 20 Apr 2023 12:57:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9235EE019E
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 12:57:18 +0200 (CEST)
IronPort-SDR: 64411a8d_pslfRenEx2gZYeAY5MtU72cpdUguv/lVdwlL4Zwp8o6oKoE
 q6sfe7csOaqfgd/lLkrp4fscJuE0zSu0mAXHuCg==
X-IPAS-Result: =?us-ascii?q?A0EDAABkGUFkhw4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYItgUsvBAtGhFOIHYkZhDCHLowlhAOBVoFAP?=
 =?us-ascii?q?g8BAwENQQECBAEBAwQ4hEcChT0CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBEgJHPgMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCe?=
 =?us-ascii?q?oIoAQMxB6safzOBAYIIAQEGgmSZKB8sIlSBXgmBFC0BjRSDNnonD4FVRIE8g?=
 =?us-ascii?q?0KIH4JnmwaBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5xgUljTIF7BAIUR?=
 =?us-ascii?q?A4YBiglBA4DGSsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGGzQRA?=
 =?us-ascii?q?ggPEg8sRAxCNzMTBlwBKQsOEQNOgUcEgQt8CgYBJiSfSoEOgilLApJhsF00B?=
 =?us-ascii?q?4IrgVaBWQyfDQYTL5cJDgaSJS6HMpAXIKd/gWM6gVwzGiSDNk8DGQ+OIAwNC?=
 =?us-ascii?q?YQDj0g/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 0xu4jY=
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:ng/T66wU9ricccvnFHkTKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AJKaFq2j0Ckkb1DLDRE5o8ljc0jJuam//0mbzORC?=
 =?us-ascii?q?EOVlNceWKcg6p+/1lqp87?=
X-Talos-MUID: 9a23:MxbNbQW/hLLTiobq/GOzqCBECvdF2pm/GRATtZU/sI67FgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="53855087"
X-MGA-submission: =?us-ascii?q?MDEr5XTB/4JNlsZgqy6tN1f6EvelOj42EO5L1m?=
 =?us-ascii?q?2Euw2s2fo7wwcid/W28FVXQz9XTfR4RLbMFd5it8x9PML4GamhAqh0UQ?=
 =?us-ascii?q?7S16IEuWEUcuJBC2HLFswuOhG7++RmoexRdyHgTYPsoOr4P9B6OK9q0v?=
 =?us-ascii?q?/Z7pp5tVMsX25Vf5riXDCLTg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 12:57:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681988236; i=markus.elfring@web.de;
	bh=SZE0cUCDOOXWg8zRxrGD0Q4HTIB4ikPnukA8nJ2WvJw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=nQmmMWw6kXtgLnkt2T/mEMl046gd/PNc+Fy+EOMDpg8jmKQlbHXD05fFXj6AsM+4Y
	 rYgEpKn1uEawwtxE4xJBYuuCRhY4Q6tqNku4Ci9+BcvodfL7vdKyIkp53/uzjJGseG
	 BUIqt42HfMVz6ud0zGFCM8YZQEGiGzdwUvUQvQyq8c8QwittbNmvnZS2oB++LpxM/q
	 90xzfXbVyzDpEEC9OiD1PlA17a8uf/MxVjZYrhaPVwjCBotKIMohJN+HXWVPLTjSyV
	 PeB7+J1JtvABrVMazlQZx+XbokKyNFVfm7UEBoVuo+mt3sctMGk1jfqEIvt9c1M/Tw
	 ZDx18zuC/wAaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1qP3hw3fWt-00aFmh; Thu, 20
 Apr 2023 12:57:15 +0200
Message-ID: <ce12ea4b-236b-d04f-a804-6afdbd38aa4a@web.de>
Date: Thu, 20 Apr 2023 12:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>, Nam Cao <namcaov@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
In-Reply-To: <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYEnXOgTbBYG+N+9oPcwOtYEbImxYiNKTRdLmJXL7Fi7Vb96n68
 gcz1GA/bpP89NLPWyqUzIU0wdMMQ1qTPiuoETdSg4WqHafTtHnYL7H0dAsZgPKPmNEa8rHt
 933pzwi/uaPOmEuK+Stm9Ff/mgJPsj1hygoqdkIT9umRKXCgnBYiE79EGXpH4BxSpc/1gd2
 uwMde8KGc+GaSHBvkyb/A==
UI-OutboundReport: notjunk:1;M01:P0:g7reQkIlh1I=;qKvl7wWpwxIcjcBGfTsv+zv8odN
 7/P+L1Z0VLztrj60F7X/fCV2w64J3Yh4m7lBorm+PfOL3mi4oU0NY3/RpHohLNxVQG1Wsb2SC
 3+2XWznzWV1kzBc6g2dYE7IPGDsxH/i/OzzM+XCZ25wBBI8PEX6m4QKX7HsODUfvU2Iy3JTUp
 tdfo196oSMbBx6dTYpaQ89ZPfMXZUvzJK5TSYOkqCyWHbJhj/vROqfJbeZ6TuH9Dk4DpXlDj6
 uTudaqmSorVp2Jby0dZWNL2XlJbYwhkDn5MoiIKSrq+07Uy2MyweqYHkQ/eLX18x/Mj3a5642
 OA5kpJvxHz7HxT2qXRqmeLSOidYA/w60VKjSrfAjWeonfbSFO+Q2UlTaF4N1VmWGoDLOM+3nu
 AcTF++4EE2OwyPRb19E43yEzheqbdkq1dX68zac0ce7M6jjtRAuP9Wcy3nvi1voSZQJx/0kUG
 wCJcuwGxgomAx3BDZq7KT5mSNoAQxxPCcPfyUl32ZRTaoqIYClU4ImLm0KZ5WzRdOhFH6NTrD
 DDh5gdNHhOBD7VeTdg+P1nOkkjvLKVrWdUzEOwVPlBO0byIye81rAvyr03dXhrqeEYPtfm8rU
 CI8bDI7DH8oYlrZfhuxAT6RPtCv78Ng5m8/fB0AygAjd9MSTKoFtt/FaE95kzuhy/G5FW/LiK
 s5+C05q3aUa5TX49SjeQK0iG3LfkOBhy36KYms+bxcyKycMEqBquD5Tq1U4gI/9ImP+Y991ra
 yT/nEEpOGi/f0crXQ7DMXAxOD8eYh1Kvf7ytEvKKiDi7NRbsMhlvwFVTpgHmxTmTB73XjNNyg
 OoAKbRo5hGWysrFXj/qKv2fidbBV7XsD2Ob2ehX5KPj4U3ucMi+sK4EIN3DOBl8jhG968nZTu
 exgJtM5iMcPdt4Bm35sYNW3zVx3hdIX3MrcX2GGf4Nr5woMpA/VFrQjTr
Subject: [cocci] [PATCH 2/4] staging: rtl8712: Delete two variables in
 process_link_qual()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1101
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/ce12ea4b-236b-d04f-a804-6afdbd38aa4a%40web.de>

Date: Thu, 20 Apr 2023 10:42:40 +0200

* Use two values for computations (in one if branch)
  without storing them in intermediate variables.

* Remove the local variables =E2=80=9Clast_evm=E2=80=9D and =E2=80=9CtmpVa=
l=E2=80=9D
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/rtl8712/rtl8712_recv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8=
712/rtl8712_recv.c
index f0789b5ef59b..3a72d0601dc0 100644
=2D-- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -862,7 +862,6 @@ static void query_rx_phy_status(struct _adapter *padap=
ter,
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	u32	last_evm =3D 0, tmpVal;
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd =3D &padapter->recvpriv.signal_qual_data;

@@ -873,8 +872,7 @@ static void process_link_qual(struct _adapter *padapte=
r,
 		 */
 		if (sqd->total_num++ >=3D PHY_LINKQUALITY_SLID_WIN_MAX) {
 			sqd->total_num =3D PHY_LINKQUALITY_SLID_WIN_MAX;
-			last_evm =3D sqd->elements[sqd->index];
-			sqd->total_val -=3D last_evm;
+			sqd->total_val -=3D sqd->elements[sqd->index];
 		}
 		sqd->total_val +=3D pattrib->signal_qual;
 		sqd->elements[sqd->index++] =3D pattrib->signal_qual;
@@ -882,8 +880,8 @@ static void process_link_qual(struct _adapter *padapte=
r,
 			sqd->index =3D 0;

 		/* <1> Showed on UI for user, in percentage. */
-		tmpVal =3D sqd->total_val / sqd->total_num;
-		padapter->recvpriv.signal =3D (u8)tmpVal;
+		padapter->recvpriv.signal =3D (u8)(sqd->total_val
+						/ sqd->total_num);
 	}
 }

=2D-
2.40.0

