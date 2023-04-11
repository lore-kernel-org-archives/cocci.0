Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A648C77B6F
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RCJaSK3ck3Gp/yGEgyme7gJg2TEh8niFRVGoNOLQh/c=;
  b=fEo78qChgq5XWI9ZY/0ErdqOBj41kBoIirIU+3lxHcliia1W4R37jhF6
   S9r8SXtoJxhuOlX4Pjc9MFoij1lxUlceT5FKpJHmQ9RtqjEl2ndZx6DBy
   C+OVrNL5iMCxSLIqFcFlDXz6/YMOAHtg8YjN9DnVDMY/yUw5+dpaKyqbJ
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102498033"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 19:43:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09065E7314; Tue, 11 Apr 2023 19:43:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5DCD7E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 19:43:57 +0200 (CEST)
IronPort-SDR: 64359c5c_Q5KTvqOLZ96vwy+/9hnrbCmpj0xlhnqd1ku118ELoiDxP7q
 YG20s2DdYlDBvieHvfQpuvvxOoEF08T18TGYP+g==
X-IPAS-Result: =?us-ascii?q?A0EgAADqmzVkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHokPA4Qwhy6QKYFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiBU4JqCgKFPQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAkc+AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHrHR/M?=
 =?us-ascii?q?4EBgggBAQaCY5koHywiVIFeCYEULQGMSj+EMCcPgVVEgRUnDIJHbogfgmeRZ?=
 =?us-ascii?q?ohLCoE0doEgDoE9gQQCCQIRa4EQCGaBeUACDWQLDnGBSWNMgXsEAhQ/JQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj81BgMLHwZYawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPLEQOQ?=
 =?us-ascii?q?jczEwZcASkLDhEDT4FHBIENfAoGASYknXxyAVI7TDSBaQ2SO7B7NAeCK4FWg?=
 =?us-ascii?q?VkMnw0GEy+XCQ4GkiQBl3Mgp3+BYzqBXDMaJIM2TwMZD44gDA0JFYNujwkBP?=
 =?us-ascii?q?j80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 Mz1x08=
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:sssqnqxBpe2J8DGc7KjnKrPw+L1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102498028"
X-MGA-submission: =?us-ascii?q?MDE3HB1peNF0570LEZyRP3Qxgr1L5biBMoGKXv?=
 =?us-ascii?q?z9iRjh2PspxcDUodab+zWRidBccDfVhwPLhhXN2wZfgYE/rWbgen3hFM?=
 =?us-ascii?q?Rhf7gfPxFJE7s2IwD9+hYlRiQsRgoO7sZMy6Q7wORwFxRb6nSgi+lq60?=
 =?us-ascii?q?biOOcklaYtkTBsyOgpVesXxg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 19:43:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681235030; i=markus.elfring@web.de;
	bh=GCu7/WiLV6aILtirKTKHmkr82/MeC58q6IT6yz8JB30=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=WH84AjIS28Kiuf12y9KlxfFwHCQPqN9sD5T++epQkjPqU0l4JGcegNpEBOFK/r266
	 F10mS/UODnn1OoeI4PDS4hEflifNVeW4lVa8+NnzLA6e3/7lx+iEs+Wu2iwWM9iR9M
	 hIHwlrvuchAsWIgd6D4R222pbf/bgtH6yY+a8FqqtSL/SuNQhKI6pOHm5+cscwfxQP
	 JfCWNtB0HzQPuGxENj/EpZJlpgFsNv695yntq6kCYjR2qglO9kreIYNqUPGFdwqPy0
	 7f3bBXO09tDjb4j9J3DWIMorZAFZfiMOOTN+qUfg8yRzP65SgwnFJrmO0mBGYF5olG
	 XQVxmaj1XTM8g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxs3-1pyiLC3rRH-00NvYL; Tue, 11
 Apr 2023 19:43:49 +0200
Message-ID: <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
Date: Tue, 11 Apr 2023 19:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 Ariel Elior <aelior@marvell.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Manish Chopra <manishc@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6fYTRZXyZG4u1Lb3sen2pDpitlswLOQFPhVCaSz1Qvx50fIpGxk
 FhcmQvIFyW7NmkxSDzH6E8gJVdP+oA7Nq3Gmt8Zxidd06kq+a4mIrA8R+EKuERkNuG6Xj1e
 aL0BWfZRFlfVsa2G+MZBnQfJcTwANGQj2wIu0BfEdBDuS65/wWsPOqsa0z0rXOzVOi4VHe0
 XRK2MePGvJ7rJUqQXtRlg==
UI-OutboundReport: notjunk:1;M01:P0:17WZs8SJGgI=;itbgoIYhARCQl/uIXZGIl8IH6qy
 ZY1TsmHv5JKJWpOcEzU6LVCK2HEVyzI/MgnfmazBRUOmS8eQLDZEr7MQpXDaBEbxOjPvGR52o
 WzI1uj7SK80rbUS9E5+qgsLUOyy+6JJubajyvjqjq3/M/siWPFm/GIATnRPZRKIGP5aOCldgY
 sRYOcq8vrmRDmaIkqwY234l5+kP9QVLjfJ/22QmTYENANSuDOHiaKvnobiAoCJkFaFy+xFJGf
 kpgr9v4xH4zxP7X+HoXN8zJohbfhXBt8wqmsF/mVyfhEICQgh3Bkh72Z6UoGwsTA/oTCyl1hx
 5VmuIcF2YaSPHSo7JdRVf4F9yFSDEPZgFy8m446D2XeAa0Pvmir3UxAGU1Dpnry/DgQFhrZby
 jTg/5uayDfYkbqQwp73i+f8YR68OxQITIbwpK9c6hxOQiN47WmLi2m8WnzuNTm9dlsN1pFZeZ
 Y2/Q+WE70h97s5eMIxNLqgtmdQwE9Qgk4+WvFhiwh5qzAldCq8jYth7WoeTUXf6Z0zcplmX2a
 jqLEEFahZj8gs8K2iAbrtUzdmNoe+tswj08doTmQo9IJXY/QL8Vs+qR8kANjRLgrEweVIeHi8
 3Mu+CHWcoM1Q6764SdIK0a95U4z5CQPCBa235qw00P0DEpJ108o2Mb/DESQ431nt+6gsXhbor
 bXiDOMLSDjefXaBqR3YYVTec4erb0p+f9OWyEaTIHjgQ51xf0d5XGBuW7MmrXLqzwyqjRRV6h
 X14mAhtOCFRB12dJgENfhtKbQjPoXXlOlOAqmAaIL5nRXUUntkz7avGemAKMlE7NqvGB9P/cW
 nfbd+lSeyHzE+uJW+V+d4gSVVHKVOe4zpF12uMN445+NHeHsEVu9sUB2efbuUbtw9I9ArE0rZ
 Is4S8rPeVgF/hN9gMpAuB6STfaemMhdJnja4JGiDmBzigG6FSO2DW6h5g
Subject: [cocci] [PATCH] qed: Move a variable assignment behind a null
 pointer check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1037
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/f7967bee-f3f1-54c4-7352-40c39dd7fead%40web.de>

Date: Tue, 11 Apr 2023 19:33:53 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the functions =E2=80=9Cqed_ll2_rxq_completion=E2=80=9D and =E2=80=9Cqed_ll=
2_txq_completion=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variables =E2=80=9Cp_rx=E2=80=9D and =E2=80=9Cp_tx=E2=80=9D behind=
 the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 0a7fb11c23c0fb8f5ad37f285f40348f1ab9ccbd ("qed: Add Light L2 suppor=
t")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ether=
net/qlogic/qed/qed_ll2.c
index 717a0b3f89bd..941c02fccaaf 100644
=2D-- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -346,7 +346,7 @@ static void qed_ll2_txq_flush(struct qed_hwfn *p_hwfn,=
 u8 connection_handle)
 static int qed_ll2_txq_completion(struct qed_hwfn *p_hwfn, void *p_cookie=
)
 {
 	struct qed_ll2_info *p_ll2_conn =3D p_cookie;
-	struct qed_ll2_tx_queue *p_tx =3D &p_ll2_conn->tx_queue;
+	struct qed_ll2_tx_queue *p_tx;
 	u16 new_idx =3D 0, num_bds =3D 0, num_bds_in_packet =3D 0;
 	struct qed_ll2_tx_packet *p_pkt;
 	bool b_last_frag =3D false;
@@ -356,6 +356,7 @@ static int qed_ll2_txq_completion(struct qed_hwfn *p_h=
wfn, void *p_cookie)
 	if (!p_ll2_conn)
 		return rc;

+	p_tx =3D &p_ll2_conn->tx_queue;
 	spin_lock_irqsave(&p_tx->lock, flags);
 	if (p_tx->b_completing_packet) {
 		rc =3D -EBUSY;
@@ -523,7 +524,7 @@ qed_ll2_rxq_handle_completion(struct qed_hwfn *p_hwfn,
 static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
 {
 	struct qed_ll2_info *p_ll2_conn =3D (struct qed_ll2_info *)cookie;
-	struct qed_ll2_rx_queue *p_rx =3D &p_ll2_conn->rx_queue;
+	struct qed_ll2_rx_queue *p_rx;
 	union core_rx_cqe_union *cqe =3D NULL;
 	u16 cq_new_idx =3D 0, cq_old_idx =3D 0;
 	unsigned long flags =3D 0;
@@ -532,6 +533,7 @@ static int qed_ll2_rxq_completion(struct qed_hwfn *p_h=
wfn, void *cookie)
 	if (!p_ll2_conn)
 		return rc;

+	p_rx =3D &p_ll2_conn->rx_queue;
 	spin_lock_irqsave(&p_rx->lock, flags);

 	if (!QED_LL2_RX_REGISTERED(p_ll2_conn)) {
=2D-
2.40.0

