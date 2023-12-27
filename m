Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8350FC46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UwN1jdj/YX9hyFBqnaOQu1V1PR41c/f5krQQFt0SYfs=;
  b=bvtcVpSIYva541zekibMXJlepNb2YqQ9Vb2Jopyo5JNFfZ530l2H+5c9
   6K3mFIvk7fkAnpG8tt/292vtmiPPlUcAYrGCr7RvoCc3bmeWVX0oDQ1Xs
   sFVmnQ+Un6jQ0Uhid/G3q4QoqO3hNH8jYKplTi7n8n9ZwxQ5EidHJFVFA
   8=;
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
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144147396"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 17:04:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 940EEE0AF1; Wed, 27 Dec 2023 17:04:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B2AE6E004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 17:04:09 +0100 (CET)
IronPort-SDR: 658c4af9_Yk32DmL0sJCZhf7i++9YpfUd2pZ4e3a4qKJFQvRWHMi+aRZ
 zJvSTT7UzGdYbeUKnBqepQ8PNtuvqB/x+bq9WwA==
X-IPAS-Result: =?us-ascii?q?A0FDAACzSYxlewQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4f1MyBAtIhFOPQYF1MIQ7hzWHTIhvgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoc2Ah4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBJBgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCA?=
 =?us-ascii?q?wMjBBkBAREmAQ8fAQUCJgICRREGARICAQGCfIIrAQMxB640fzOBAYIKAQEGg?=
 =?us-ascii?q?masch8sIlaBYAmBGi4BiBoBhWeDQXonD4FVRIE8C4EJgi2IHoJog2aFNgcyg?=
 =?us-ascii?q?hyDT5FWfQVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBX4FSCoEBPw8OE?=
 =?us-ascii?q?YI+IgI9NhlIglgVDDRKdRAqBBQXgQ5uGxIeNxEQFw0DCHQdAhEjPAMFAwQzC?=
 =?us-ascii?q?hINCyEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwV?=
 =?us-ascii?q?UQMTwNsHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjsCEgwGB?=
 =?us-ascii?q?gldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01CQsbBj4Cp?=
 =?us-ascii?q?k2BDnKBPEjFATQHgjSBYIFhDJ8rBhMvlyYOBpJULodQiwCFTyCoRoFlAzWBX?=
 =?us-ascii?q?DMaJIM2TwMZD44ghCuPR0A1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 IUDQPlXWQ5sfs4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5fgHPK0GCb9jxpJdbiEWAwqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyWMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AuL/k12qQ30DLDZNFIDLu3EDmUe0iSlOexlXrGm2?=
 =?us-ascii?q?5M3lzbaSZClKd3Kwxxg=3D=3D?=
X-Talos-MUID: 9a23:gdNUuQSRCvcWtnp9RXTnggAzNPZZ+J+xEREQzqdFideWBSlJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="75415325"
X-MGA-submission: =?us-ascii?q?MDF6Pkgx3Vnkc6yNtLHVXlPtxzDnNhjyo0Sp0H?=
 =?us-ascii?q?69Q6HS8x+6Pl/FEdzUdGJ0SGeUFy3vuKJJB145nKxVJTDHKIrbuZ7gtq?=
 =?us-ascii?q?xh3qoMmdoz4ga+wjIFhuyjpHHUbB0LGF/qJtH51owYKUakrQaKzQ8jHC?=
 =?us-ascii?q?0ga5SM64AJI8F3j6CWW49cAw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 17:04:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703693048; x=1704297848; i=markus.elfring@web.de;
	bh=pl0j2jlBOHpdYumEB//84LCnmc+A204WKvvK9JoNUAE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Lc7DXIYXmosy75uibtNwU2cS73VVZK/cSY03ClKiUfkc3xCBdEUSUhUXcM/eGCuf
	 A1UIWN9B3ov2GXqI0XIudj3W5EBW9Z9gJ1fS2y6hMbedWD6vfQe4PkP/BHjGmUwrt
	 BV8S1Sxtr2OMJd6m2ScU2zt6gfArVTew+s7tFcTz8VBc2coa4xv9YMSqaaYsRrXcQ
	 zeHkfXjEb7GNuEyGITi/A/jgI7YZRRIweLFtE7qEyUUvAn2j4PSwxbIIJeR3JEhxO
	 nXQY6uNdJYdjqGEIC2zDiFigS/klkNAI7h66Hj95lkG6bxYIc3v7wYp6HxffD+Lvn
	 QLvkSkGoyf+g14M72Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaWF-1qzbcp0V5P-00tfcP; Wed, 27
 Dec 2023 17:04:08 +0100
Message-ID: <fcc9f3ed-b8d0-4999-a06c-12a193a516d3@web.de>
Date: Wed, 27 Dec 2023 17:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
In-Reply-To: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LZLFy8584bM7nNvphHPs21dMyK0NX/xpt7a2sjgekqHU4DF+tEL
 WjRYzV4ttYUlRj83D4tFBpGhcOM+pyUOdHz/+n+XxOJR9XwmI7NIjO0jcbRPnq2irlBhPI1
 k5lrKOh4gkYiiVMVFys6gf/EnPWuWSSD4VYet/9cD1aRbzIDHxqWH8wPNQho9BZeYQmoeyz
 sI6ttaVBn4EQG3K3p56TA==
UI-OutboundReport: notjunk:1;M01:P0:CSPkLoRkgos=;ca8zaDvllZcwLBz4r7X8tu5athr
 2swnmbXxg5vxZkB9gKnLlviRogKVGDF9nzhbue8EZb4Q+BZU/DTtLKc6h88hpx2K2OECRMgbU
 dbzQIp+MWaBHtLEs9+BfDfFK7qvcJofZba7MESK82h52cTvvebloPxGO+Y63Ale2OTiGiWxcW
 YQPCuqOhhSKeZcTSudoCje9/Uhv0HZgSm6WIzM/A/DbmNjTgpm23Zcr+5Pz6oyvfif9Xp0tex
 BfGmJIEHjUnruhlX2YcaRWFPfUlmcRgw5fvidF+ZElxHySRInhMvhZh2za85Q4JRL1TC7lQOQ
 fO9Qkfag6b8moUMWqqLVC0a+TvloxQIHL+/Ev4clZRlRu0fxCve096umXkb60T0zuVe1VQ1e3
 WiutHjb/l/ByZG23vYJSY3gMizKk2l/v4xYBUS97KIsBAtZF51PuxVtUMXnkBzWyIO4LG8IoB
 o2uMk+khs3zM8Zxpbi7OPceEhO1kO4feu8cdULHTeF47pzm0pxuykc8RRpcnEtRJ88GBBkuik
 EwulqbHTlCz2xBmSe5GO+7V+s8mF3T+E5S0LwU5WFiAreyiH2y4DpJG9bW2PN8bMUTjBcoD75
 74tSywDeRvIOK5aFVkQZoOf7M7yoEJO/of2WreZHJeoSswGFpUfsVKU1NigxW0+PSd0VtHloW
 1fKcVONAIFPQFiIjuW5A9OsUWaILggTjAbUFHH6m5+jg2KMbuo1ySyCroRAuRA8eU3iRV6Ozk
 1Z19v4Fgq3boKVUyJGci/As68vXOL/5mxf3+JjBzLh5WllGWRQKMEgtnIGa+YGcv23QT7fPDN
 lVMp2+pW0Vy9UVXKym1ueqEdf3gTvRvDDMlGC6FQRwXtW+UBqXS9w4CFOhTWpafvhCA+Y5kkG
 mqzltRDgxuhznRqYjNunl9qvC0l60YJyCdhl4l7TgMg2LbHD2fwP9kZ73br6Vo/JsTHeVi7Ka
 3pO1DrocWNovKtms3CXZv7rnWu0=
Subject: [cocci] [PATCH 2/2] nfc: mei_phy: Use common code in
 mei_nfc_connect()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1418
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/fcc9f3ed-b8d0-4999-a06c-12a193a516d3%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 16:45:39 +0100

Use another label so that a kfree() call can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nfc/mei_phy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index 937f229f4646..9272564012b3 100644
=2D-- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -157,8 +157,8 @@ static int mei_nfc_connect(struct nfc_mei_phy *phy)

 	reply =3D kzalloc(connect_resp_length, GFP_KERNEL);
 	if (!reply) {
-		kfree(cmd);
-		return -ENOMEM;
+		r =3D -ENOMEM;
+		goto free_cmd;
 	}

 	connect_resp =3D (struct mei_nfc_connect_resp *)reply->data;
@@ -197,6 +197,7 @@ static int mei_nfc_connect(struct nfc_mei_phy *phy)

 err:
 	kfree(reply);
+free_cmd:
 	kfree(cmd);

 	return r;
=2D-
2.43.0

