Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F785D735F8
	for <cocci@archiver.kernel.org>; Sat, 30 Nov 2024 09:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v3XiGRlFoJi38O3HfXRTZmLGrna0ussIYJTi+lvVRgw=;
  b=DQSW9tjYH7JnHmo8Mwc3mF0ePAmKlYGk6hmHlr9k2ooh2CT/jPLB/zpc
   vgU4I5SeSPRTX14gsttwLljd6QmJ73Q7fZPA36muszAzCrQMT5z5mui28
   OnQtYPukZReKg18ilkGdhZ9qgqW4HW8oPv5AWGHf697g4K9RuEh5MaH/6
   k=;
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
X-IronPort-AV: E=Sophos;i="6.12,198,1728943200"; 
   d="scan'208";a="196616389"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Nov 2024 10:07:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44025E013D; Sat, 30 Nov 2024 10:07:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 97D63E00B6
	for <cocci@sympa.inria.fr>; Sat, 30 Nov 2024 10:07:16 +0100 (CET)
IronPort-SDR: 674ad5c4_/9oCMOMqU/7EgL9rp0uBTObQBTTm0R2Lz7lWx5M+Zf4LKlG
 GeV5OcWmVY4fsuzZpNei9d9l5ypUoe0w8Ph+6mw==
X-IPAS-Result: =?us-ascii?q?A0FaBwD21EpngAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VMCgkJiIVQzBAtIhFaPTYF0hGuHO4dWiHWDVA8BAwENQQECBAEBAwSCDIJ0A?=
 =?us-ascii?q?opjAh4HAQQ1BQ0BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJgEPCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn2CMAEDMQexGIEygQGCDAEBBtpbHywiV4FkCYEaLgGFaYJiA?=
 =?us-ascii?q?YVpO4Q8Jw+BVUSBPIMDPoRDg1uCaYJEhQ8jAogYaJwNUnscA1kyAVUTFwsHB?=
 =?us-ascii?q?YEpERAsA4F5Tn+BNiiBKQFCgk5KIYMNgV4FNwo9gkppSzoCDQI2giQkWYJNg?=
 =?us-ascii?q?SUEBYNpgQuDXmUvAwMDA4IRgSuCS12DBkIdQAIBC209NwYDCxsGPaIWhmSTa?=
 =?us-ascii?q?7MBNAeCOIFlgWMMn1oGEy+DcQGTUQ4GknqIL5BMIqkIgX8igVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIYQtxhZCNTwCBwEKAQEDCYVGAQGMJYFLAQE?=
IronPort-PHdr: A9a23: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
 PLmr5dEWVZzGv5IUiyN8/QdLZ0xUj52yNam
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:oOIkha0WGRpJ0PgwtPOIAAqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:ysnKoGwVWDCQQCO5WUtHBgUOXdkpU3LMj03qLhbmDmdtFf6ncke5rfY=
X-Talos-MUID: 9a23:dvZ4FArzkm/ugBtZ6/Uez2xTGO5wup6eNG42jbUEg8ymCgNPAyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,198,1728943200"; 
   d="scan'208";a="196616376"
X-MGA-submission: =?us-ascii?q?MDFbtJ7thk0EIq92lner/tohoo4r+Bd/U7/hSB?=
 =?us-ascii?q?MZWkLiBEhpMIM+lP0vVh3bLzJhxs0wSjcSdTSfAl/H/xZTDlZTa5jP70?=
 =?us-ascii?q?3RLEJlO9fqV52uZ66NlPYLsRTQMCTYddeM1cewIk3jrtGLhdfDx1aSjU?=
 =?us-ascii?q?ssfY6WKfUtzoezY3VP/vvdRw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 10:07:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732957620; x=1733562420; i=markus.elfring@web.de;
	bh=v3XiGRlFoJi38O3HfXRTZmLGrna0ussIYJTi+lvVRgw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tgPJX4Wv3ZqrSWtpjpT8fwPwlaooUGn3Gnh+ZGKLLN+4yb26j0q6bEvPyN83dVbB
	 oK1gMONdvTMUJMZsnV1YJy4zBfecUV9k03RoKNrHxPyyrpQt4AXPFOhpbvmfhKBGu
	 H3mVvC6q1q9i1GJmUAUVrGqjCig2/SSFuzr+CRsww6fgTvojIBLRnPmOLdgX9v+Gz
	 V1KO8Bou5F73ZBx6PcRI2vp+av/U4dk0ro8umASi2aPDuzy0JwZVfczV4KVMU4MqP
	 u1PKJacjJ4DzOdkj67g0xZL8GFezBsQeUnr1AMuKZdEBfrPYthccgAB4L2l667B53
	 ewjTeK7P7E+EjWqDag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2Phc-1tFfY228Ss-005wSW; Sat, 30
 Nov 2024 10:07:00 +0100
Message-ID: <17dd41d7-0bd0-4c38-aaf3-c68b3209f46b@web.de>
Date: Sat, 30 Nov 2024 10:06:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, cocci@inria.fr
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
 <b30c7227-c596-4980-aa46-a75b1d429354@web.de>
 <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
In-Reply-To: <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:srVKkclM4O0bE293ZCMRz8INZsxhExnVXDBpD386uF0bQaeHsc6
 99l9nbI3AYUJxz6sJPK4LWb9tmseRHEVdvS9jN8FyqfN6PWgr+u/xOEDWe9W3OQYeVI70V1
 UEfs1wQox6vc2I0bCQi/KQegp8jMsXsDCZHk4a8FzRtmdTA2HnpaDKdYvSKu5S6cVL5u7J2
 dOf2GXcTl2UZ1Iya2eo8A==
UI-OutboundReport: notjunk:1;M01:P0:PfjgmX8EOI8=;cyofF5wjBKdHn81m0/JDe9DKGLA
 hX1ca9dCR8N2EulZZyzekl7R8J6nNVZ1Xexl0VbYI+D0cxY7uz6qLi+5lDanjQyhb+pT0hs6H
 mw/W+laR37PfvLUO6fMJedkrDnzkwap5obXSlGsy4xBJQ1QoWK/a3pVg+gtGv4UakCThk704J
 1J9yGhrL+dkBh+qMdtyNaHK2lUWMcHtHtEw+7icwKFYe6ywGBCIjHmXDG1QZPGFmijGHf4lI+
 38VfeH/utxkFS1QlY5LOO+TaLo1itnsO6cjMm6kRHECjjcTWQFDrTWruHYq+ebi+K1j/VCdMS
 qTyX2d3tbvEbcDHPFjsV6WkWTttrSELG9jGai5YY5BUKK6F7yz87rI/WapT03gQyQJpKP2aXx
 c3JeWa76YIdRoYLg2TRLioZs/vJvSlH3KOkku9gm6LwcTPezojsDgHSaIvZ/+ctsnNhj+fSIh
 uK9VveYd4zvV2vykb1iJKY0OofNeD3x8fDDaaJuUV1AwpvfNeWgc+7OZHxQCcMsg7A5ROp2pA
 uX6sjHof+N06bkMAKUff1AHLQ33wFK+Qn6ng2jM9FZnZzpXpTe/LwGBGUGGUTlF3qc1jhykME
 biGyBSxAY6OiQYkcpzDPLhn4qFqR4AaM37ENPbzuIH4E3MnUaaRfSBMALK02SaJHtK6wdPCvu
 t+6C0SDzcruNzV+so6xLZiM3U3YEzvkW7gl6fmLN0gigBC2JBuAAiHgEEcMD7qAgA3QEG3fUQ
 9wM7mF525CO/lMsJL8bM4OHVox3i7lUAeQYCr9s0VhwYaG7U7vP5E+zkd4Qb6rIll5LXameNq
 ES1HXKBpcGhC+YbIC4qwMShb4rnHO3pWwxukOXun7sUK/RKAlXyUdJHucEAXNugxG/+DN0QaY
 9inFvHwtplVRGIc8Ggnr9wNuRh3DxiAmhSRxVhvqg/KjnfM4BBdYPGWJ2qvWNCWt0nuj6u1Lq
 vQoUTja7OA4zrLHk7sgx8mlNC4U1nZXniFsMHdHq9AROjuqlm2bHSUsd6aJ3/e/SUDo89oGVA
 GpTmsH+7EJAiHLkQD+/bUewowt7CUTO7qwNrQpgSHBya1WVTzZ+yo+TyCXFS41ycImOyuUqsj
 MvBTa5MyQ=
Subject: Re: [cocci] [01/11] coccinelle: Add script to reorder capable()
 calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2142
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/17dd41d7-0bd0-4c38-aaf3-c68b3209f46b%40web.de>

> =E2=80=A6, his questions don't make a ton of sense.

Would you still like to clarify mentioned software implementation details =
anyhow?

Can the willingness grow to achieve a better understanding for algorithmic=
 properties?

Regards,
Markus
