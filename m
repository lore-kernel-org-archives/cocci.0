Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549FBC3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NB5WKIRnokEv8QZ/VdZaEjhlOe5tueLbLCFc1azf0KA=;
  b=FPPpTMUemMqtuuU7s05PjmvN1nnLqgJmU7UdhXuluDZ56awaFUsTmpUf
   YgxrhB/a97n0IR45JQPKTaQqjJ3jUI/iEHQb0hOPSuwJDn6YOqcfbXPBf
   TjUbgmTZYmH8cqdPDUAkZFjFXbgBDZRojMYvwibJheOk+tAtlEB0LVNID
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
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="143973091"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 11:22:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6B032E0CCC; Mon, 25 Dec 2023 11:22:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AFDDFE004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 11:22:26 +0100 (CET)
IronPort-SDR: 658957e2_KhpUO7nTxBdMhSmB4P3VjRLlWzNijQDc2VDWUHAWEgH6S2p
 sbikBmSOqX/E6aWCzsDAS02pHVJ7pUrM4FxlJLg==
X-IPAS-Result: =?us-ascii?q?A0ErAADBVollew4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4gVIyBAtIhFOIHYckgXUtA4Q7hzWHTIRrhASBVoFAPg8BAwENQ?=
 =?us-ascii?q?QECBAEBAwQ4gVOCdAKHNgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABASQYBg4QJ4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBFwJHQgMDIwQZAQERJgEPHwEFAh8HAgJWBgESAgEBgnyCKwEDMQevEH8zg?=
 =?us-ascii?q?QGCCgEBBq9YHywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgTwLgzaECoQUgmiJH?=
 =?us-ascii?q?AcyghyDT5FcfQVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBXoFSCn4/D?=
 =?us-ascii?q?w4Rgj4iAj02GUiCWxUMNARGdRAqBBQXgQ5uGxIeNxEQBRINAwh0HQIRIzwDB?=
 =?us-ascii?q?QMEMwodCyEFVgNFBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKM?=
 =?us-ascii?q?QMwVUQMUANsHzIJPA8MGgIbHg0nIwIsQgMJCgUQAhYDJBYENhEJCygDLAY4A?=
 =?us-ascii?q?hIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB1wDGSsdQAIBC209NQYDC?=
 =?us-ascii?q?xsGPgKmSQdTKBNMJoIEsECUQTQHgjSBYIFhDJ8rBhMvlyYOBpJULodQkE8gq?=
 =?us-ascii?q?EaBYzqBXDMaJIM2TwMZD44gOINzj0dANTsCBwsBAQMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qfyPcaDnzcSNoenlHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:5M4WfG/Fe79JC5M8MKmVv3IbRv0DYnr59mvdcnCjFmRPcr+oaGbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3Ab39/TA42Erxv+elKLApBGuoZxoxD46CqGEQGtK8?=
 =?us-ascii?q?WlOq+Kh0zOhidjjaeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="75315019"
X-MGA-submission: =?us-ascii?q?MDGHne6gkYKBADg/ZGfNBpNMZHN4HVoYwwpFiA?=
 =?us-ascii?q?uuS7BK3uO0fqvpOKMjq5pzsxtPiuQRhdoe3JMT+6exCGNoguA8BWHN7C?=
 =?us-ascii?q?b5qTGtW8egPgBWI3uNCBbuesaqlbAP1OU8JPOrC9WH8lqNVDv1rZb/5G?=
 =?us-ascii?q?T7QscMdu6iFTkzNlKeYrGMyA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 11:22:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703499745; x=1704104545; i=markus.elfring@web.de;
	bh=ehzvFIgSeJSu3nZAjymVW905vwyKajE8awgJ7Isa/V4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=oEszm8925iw94XfHKFlwJrQA3oD8t9iCFVEqmEKTAJn/d1LpUVHuRzeCtKqRSVop
	 IDnFqQMAvI3kAaIOoVEmlDgOQyaAmlFWJNLZeLXGI6sb7sQE+j/OExm3fpVb1ygIb
	 rmJGL0JuqwYEE1i4bmUKtlrlrSjEPZ2Jo+n/3pu7+TkKggu0n2qWDDWPDM+yGgEo8
	 K3dfYiV+T0Sa+s9ZA0887eMXL5SeQhF8jDos9A0bvHGW/9lk/8pywFlVdLcfHuf3/
	 7ZlhgUL3tXfdcibkx0FY/Q025QRi3yaR8qPwVJK8ix3kO1zBKdvmnM65ZWtXVfSeQ
	 1hbRuY2FnOyb0KmseA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDQZ-1qk1702OPf-00auKj; Mon, 25
 Dec 2023 11:22:25 +0100
Message-ID: <3184e80d-9056-4a0f-b0c0-8c1fefa62196@web.de>
Date: Mon, 25 Dec 2023 11:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
In-Reply-To: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rl1oMsp960JeDUAqYdAIMvOPYzMZfHe1CPjrgQS8GX9vY8IVCkF
 CO9ZPyUVlIUdzV1NfxsNHpGudjLmqX5lzPWD7LxC6H1HFeQ3L4oqImoT3Y/gWNHLFu5dyKz
 3oYYWmS3TF5mA57xcx4hY8VEcZaVyew4VcCz1/Nu/QTUUZ3KIYkbZE4P1MywpCwQzl2BmU7
 6wCx9mmTI5E005sLqqBXA==
UI-OutboundReport: notjunk:1;M01:P0:DM+q4z1Nt9I=;Yiy9v3GEYKJ7vkCTt0gbBFxvhr6
 QQmXDJcB9xFHFIV/evpPM9LazU4h7+QdcqGygL7EizOHIuTT1vdcmXN5tzm502oFecGQzM/hM
 27qsHBQR0sC6JnWnYUacaNYqdAVyidi7gG9vz38XV8PdrWvhFhnwtJVTkwVj59DLenAdPcrZt
 FgbvJ1spHeU9GQwE9PW84AhL6MjzinuMmWc2awjrhIcCWscB9lN2BMgTmacJtFOrHAbydXwIR
 PsF6/hQCrpFpBbetPGX8VdiLlDL/yb7IPr4Mqn7xBkVMQLrudPY635aAOSpm4tDyw/tU6PSMM
 z8kVNLlZRjXuYAe1PVx126xa8FchFE1tHGfhwByiJY66g+HzNbBPNyAbbqc9PqUJt6b/7cBNH
 VzPHmAoPLAQSAUhEP3Ye856LSNHveP6PdzT/mstARIomDHwKl3buDlKmwfa3ZwLt5Ot8PEA6K
 IxUyXxQJ/QP4Lm1jhCYDG0ew6a6/3jVMockeFZtQO5iPAMZI2L4b5kTW25QI24+ppXdNdXXIB
 164iSOVFSGTKFa97n5+ASz35gV+FkVtHDwnPZMn6tCvUW0DjvXqE+tscu8bKHmuql72hfFAu2
 /XWy/thQlMekjkNHpTdRhg4fqsQbkloBawkz70Hu3XivxMkbruJ63qWqYx66SPDoRFdHsQSHN
 e0QlVCxY9NmYA8rNFg7Qcf/XRdWtteakBztpRv0S+EjY9QtB9ynoXM5VJfCYVNmuUJyggfZER
 f2T2c/xAy4ptlWk6mdLAOxc3/jjZ6AjuXp12ukm6O9vrmjF0Ihc4mqTU3MTl7IAWOHPV53I77
 3bJg7CTTQqYaKHLvK3cpDgxmVrbO0tCPEzH+9woWVn/0lAs7+9Vtpcku4G4yUUzP/XWomgsd6
 6dBojfTz18rfvRP4+nffu5WWSMUf9eTSy9RxuxaPL+Dc/PRhupM5f99a46u9SK704wTtFDd07
 xA/PZJj6AbZw62+6YvDgBaexhdU=
Subject: [cocci] [PATCH 3/3] dmaengine: timb_dma: One function call less in
 td_alloc_init_desc() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1383
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/3184e80d-9056-4a0f-b0c0-8c1fefa62196%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 10:55:52 +0100

The kfree() function was called in one case by the
td_alloc_init_desc() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/timb_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index fc1f67bf9c06..831c67af0237 100644
=2D-- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -333,7 +333,7 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)

 	td_desc->desc_list =3D kzalloc(td_desc->desc_list_len, GFP_KERNEL);
 	if (!td_desc->desc_list)
-		goto err;
+		goto free_td_desc;

 	dma_async_tx_descriptor_init(&td_desc->txd, chan);
 	td_desc->txd.tx_submit =3D td_tx_submit;
@@ -351,4 +351,5 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)
 	return td_desc;
 err:
 	kfree(td_desc->desc_list);
+free_td_desc:
 	kfree(td_desc);
=2D-
2.43.0

