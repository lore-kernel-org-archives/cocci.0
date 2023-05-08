Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F71C77B7F
	for <cocci@archiver.kernel.org>; Mon,  8 May 2023 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=rD0pDZdrN0pW5/pUjwuQNQIyEGRz3fL3hf1FIfS2Rz4=;
  b=m0hEsw+ZmFcjhZV16RXZ7VpWY8R22RXlbzXhSbSQsJlcVfav85xgTtWA
   51xl2KOalNHBkjvVmh/qMEqp5ime7cjJLF/PSjbBiXKfwlmRJUv7CdEdD
   xSNA/2QsJ5ZaDskSgwveG8MbdDmhQ57aH+n/XDydcVo9izVXD1aCtiRoW
   s=;
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
X-IronPort-AV: E=Sophos;i="5.99,258,1677538800"; 
   d="scan'208";a="106812030"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 May 2023 11:11:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 31D73E0D4A; Mon,  8 May 2023 11:11:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9557BE0D40
	for <cocci@sympa.inria.fr>; Mon,  8 May 2023 11:11:36 +0200 (CEST)
IronPort-SDR: 6458bcc7_u62xNEP+MjibQtVtl+kFVtkdUIheqJiGcFQaR3ifvpP00GW
 As2KDR1zo4WSzlWhLWBI49jIZeZGCKQQuqKkKfw==
X-IPAS-Result: =?us-ascii?q?A0GnBQA3vFhkh07ASNlagQmBT4IudQNTLwQLRoRSkQeEY?=
 =?us-ascii?q?Y5wiGqDFj4PAQMBDTkIAQIEAQEDBIILgmoBhVECHQcBBDMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNgjcifVM1AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEVAj0KaB0BAREnNAImAmwIAQGCegGCJwEDMQcMq?=
 =?us-ascii?q?jeBMoEBgggBAQaCZZkoHywiVIFeAwaBFC6HUh5eiS0PgVVEgTwMgkeDUQIDg?=
 =?us-ascii?q?iqDDoJnmDFngTB0gSeBLIEEAgkCEWmBEAhogXRAAg1kCwtsgUCDCwQCEUIMF?=
 =?us-ascii?q?AVYAoEFCBIBEwMHBwIBgRgQOgcEPjIHCR8xJQQOAxkrHUACAQtyPTUJCx8GJ?=
 =?us-ascii?q?x8CggMEgQl8UJguA4QSgj2TB5AeoEY1B4IsgVYFgVUMiG2BIpUBBhMvg2oBk?=
 =?us-ascii?q?yEOBpIpHpdkjVeVEIVDgXkkgVwzGiSDNk8DGQ+OOYQMhGGKZz80PQIHCwEBA?=
 =?us-ascii?q?wmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PwhrIfvNMklYQl5TA==
IronPort-HdrOrdr: A9a23:i7PcTaPUFrLmn8BcTuOjsMiBIKoaSvp037BZ7TETdfUzSL3+qy
 nOpoV+6faQsl0ssR4b9uxoVJPwI080lqQa3WByB9uftWDd0QPEEGgI1/qG/9SPIU3D39J8kY
 F9bqN5FNr8NlRii93miTPIa+rIjOPnzEiy792uqUuFoDsaEp2JZGpCYDqmLg==
X-Talos-CUID: 9a23:RN/ssWCveN3eYnj6EwJGq3ElQckFS0HilW3uB2qlMn42U5TAHA==
X-Talos-MUID: 9a23:GodoTATguKJrgw8+RXTPmhpPCcVs5J++FXA8k68rlfWLDQx/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,258,1677538800"; 
   d="scan'208";a="55415013"
X-MGA-submission: =?us-ascii?q?MDHR7LURGvSnEGfgwNtgpsBYITG6PAHi1ufh2z?=
 =?us-ascii?q?k5rgB+MkCOZlzQf9ZvVXOVDDExY0bkymxc2lVBLiIs6gofQx8/K5lb50?=
 =?us-ascii?q?x6YU8DryoC38JGPjXw5krCA1SUGCRCDY6HdAUTQP6H5Y1VqYnXGvFixj?=
 =?us-ascii?q?KLLltlxrZiuGI5qxWhy96Qkg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 11:11:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1683537094; i=markus.elfring@web.de;
	bh=rD0pDZdrN0pW5/pUjwuQNQIyEGRz3fL3hf1FIfS2Rz4=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=PVoZO+QE8jMPOOln3ApX8vr0B7KZJSqqMDV71dWm/aIlK36q3n7ZITSaCZ0DFonj/
	 MJER/VqxqTGWUl1GJH9HF8GKz15BlCjLKxCuDgK2IpsRyElT/bayz/4j3u1aEBD1bC
	 divkiEuHIvMB6eY3bXE4Hx0i/tD7nld06ySh7m1XqFmETalTAvxX25VsutXvQ/iPdM
	 39QSPCxSoRe8hgZnPQebD3Er3e7pEsCJfkMsk7RJfwFuUz4SLlstfauMBPcANDzogY
	 RJSV9VMfYBB9D6DN6YXzFxEeTEx0oyAJsfKE0lkI4wVGspZZ7YmRlMwOUtJiRaWpg1
	 g+GCx1FA1i9iw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl0p-1qYWKJ3VUL-00qF2t for
 <cocci@inria.fr>; Mon, 08 May 2023 11:11:34 +0200
Message-ID: <4c5c9622-cdf5-f0d7-9815-b8c8b611d4a2@web.de>
Date: Mon, 8 May 2023 11:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FWyJXYOO3NeA7h+Kec4wB0lV5+m2wqa2zTa6Ol/eHbQAcn4TDP4
 TofOAxLKCXxbrS6mKWtf78vJ8Lr0ATqVX8+7QfEcFcmLOHo1p0G9XIYRltpXwWTaeTtLo0E
 1xy0HkauirOtIvLdciRpZObW5xWi/NNr24rMIw24rZs6of8RCTkCpGPI3enqMcJ6c+uM6f7
 8MHCumzPkUBWUWobGZeiw==
UI-OutboundReport: notjunk:1;M01:P0:f7ORtUuPhaI=;BXxCw/HSWq7Pc+5UEEs3GNNuxIZ
 llPb1O1QTvml6771a6yx2BkcA2JkrBlVf/ztF+RhAm3/6x9iMRXaSgWbqnPONTsnJyD+rhODn
 XuQyrKNF/CX/j0DGidp4EqRIyNXVTfBA+jTCqDYopDz96AxNW+0X7sel7wjH3ph0e0h4kIYXh
 cdgZQy9aBdYqnT3G2R9ICwMR0hOPt6aWZIMAELZbGygFa+IQGU2o1lTduCKhLqtkolbO1bme9
 35ngA+utvN/5NDahDpfkaDJXlZrpTCsRrSkT7IzfQnFZVW/+dUWXEz2pF66uO94XQjJk1dAJe
 1+UdKfOpFgGldmvfnmUCfxuWl/qRoVKF1RkY28bUiN/dLTl43M9yISX3efMJ4bhqhzmV7gUHe
 BKe1IpRIpct6ZRVSOr+cJJKA9DnXm35BexmWRhbS+0zIiC2jeN4PctjdsnZ4CoOoJQogFj9uD
 pBcru0Vazg+gBKcDZG19UsJXpitdtjOY3Jq+LlQNmpdyo5kgaeB3ZGPmei3lcvJmQ3hhvJDK6
 fPoBQ2bUqyb121m6qC1MVTz9jksZ/9oXl/vqu5AcIlJUWxSJdNB+Kkf5zJd+5gX7ukUhAMge2
 3FpnvvLu/HGm6HDLW4+n7wFWHHzKllI6M+hc0kqjsAtm3azqtl4H6pbaWVr2c/3PTC7v298Io
 NASZHvm3U3eurprz+rz+FrcbeL9YSh9wWXxcgrFx9d6pq7H3ESna4ShAUYj/KnsAgzjU3J5ry
 UiyEhxmpdRddUve4UjLEsduO8Kb4bpQMc8qzNTsSUj7rY6l9ukRfKrqjHectb1zxkWFn2PtZD
 1qgkwsLHDfmDVW0Fkg2LRpllGy2X63E5lE5JVUQbVZ7lMf7xWtA7fgpNaPFYXpDwLEGEXrjHG
 dmk5RGutsPzUfhLeTPCiRhRoHaFTjX325N8w7+HmVgpamIWr/pkOoVmntSgtixa03auczpZXc
 alTTQg==
Subject: [cocci] Extending support for Coccinelle data formats by more
 parser generators?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1142
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/4c5c9622-cdf5-f0d7-9815-b8c8b611d4a2%40web.de>

Hello,

The Coccinelle software provides customised data formats for its application domain.

Will development interests grow for the corresponding support by further parser generators
besides tools like ocamlyacc and Menhir?
https://en.wikipedia.org/wiki/Comparison_of_parser_generators

Will better parsing algorithms become applicable?

Regards,
Markus
