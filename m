Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70411C46CD2
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=AnrNgYuTkUuDJ5unxqasjkNj6NEBYK2o3xE+ygubBtU=;
  b=XHWd8y8My+iygZ1dPMd1FEZ9yxQBG9n0WoMS9S4dc1Kg0Q9+W1Q5SasS
   yK2z2wIGpcCIq7NkIP/J+u771k4D2SQxfgfG2XnNCnI0WUQVmCHht27s/
   WVm9OD5GQvqVTReJ73thcSgpKM6YACVQMq+skPuOb6yMTZfobZCY/XcKO
   s=;
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
   d="scan'208";a="144147047"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 17:00:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D8C1E0CCE; Wed, 27 Dec 2023 17:00:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 18078E0AF1
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 17:00:16 +0100 (CET)
IronPort-SDR: 658c4a0f_wdE1BNBtf4r492ezxWX4zn7KLG23pJZFEmIIxkuuZ/QDe+G
 MoMqcinsJQKaWwRNEkSLIkFQIusCEFp6UHI8FTw==
X-IPAS-Result: =?us-ascii?q?A0FEAQC7SIxlew4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4f1MyBAtIhFOPQYF1gQWDZoc1h0yIb4FqgSw+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDcBhEeHOAIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABASQYBg4FCyeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?2sdAQERJgEuAQUCERUCXgESAgEBgnyCKwEDMQeuMYEygQGCCgEBBq9YHywiV?=
 =?us-ascii?q?oFgCYEaLgGIGgGERYEig0GBIQ+BVUSBPINBg3yBBoMcgmiDZoU2BzKCHINPi?=
 =?us-ascii?q?iKHNH0FQXAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgzEKgQE/Dw4Rgj4iA?=
 =?us-ascii?q?j02GUiCWBUMNEp1ECoEFBeBDm4bEh43ERAXDQMIdB0CESM8AwUDBDMKEg0LI?=
 =?us-ascii?q?QVWA0IGSQsDAhoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxPA?=
 =?us-ascii?q?2wfMgk8CwQMGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjsCEgwGBgldJ?=
 =?us-ascii?q?gcPCQQlAwgEAyspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01CQsbBj4Cpk2BD?=
 =?us-ascii?q?oJ2knKTHZ5yNAeCNIFggWEMnysGEy+DbgESkyUOBpJULpgfIIIxphWBeSSBX?=
 =?us-ascii?q?DMaJIM2TwMZD44ghCuPR0A1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 7IRR7UdWFFnT5sn
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mr4cYKsJd95UJGLDlMa5hGo97skDrtV00zEX/kB9WHVpmwKj5q
 KTdYcgpHzJYVEqKRcdcLG7Sc69qBbnnqKdjrN/AV7PZniChILKFu9fBOnZrwEIcheWnoNgPM
 xbAsxD4bPLbWRSsea/xhWkGNA9x9S9/Lmvnvq29QYXcegnUcBdBxwSMHfjLqSafng/OXKzea
 D32vZ6
X-Talos-CUID: 9a23:WK4XIWG94MwwRCx4qmJkyUIIEP01WEfH52XiLFTjV1pWF6CKHAo=
X-Talos-MUID: 9a23:UOFHcgX6JHYw0MTq/AP2py9ObtVS2bntGm4GkLwb/NGVNgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="75415110"
X-MGA-submission: =?us-ascii?q?MDFVBp/mRauOL5pDtLzCkvezGmzDEjNC+FOtAr?=
 =?us-ascii?q?4Tsdy/AsBIpgfikjJx5bR7YBVTH8U0432TzvfCGRqCk0QDErm4ajEv/N?=
 =?us-ascii?q?m09CsBSir+SfJJPtAthg2b/h3sUDw60r0/W486cv0wONN9+LVyN7YTqL?=
 =?us-ascii?q?gDnWjfNYzEhfYLdgkLjjBRuA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 17:00:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703692813; x=1704297613; i=markus.elfring@web.de;
	bh=HvHevuA8OlpyyDwIVaTUzONXBPQ+x5nXY6hMxtcjTM0=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=sqfGosFLhe3P1dx7l4Bxvacu5snlCUSSYJ7ZzPC7IGCsxDtFm0YkEjtqu/OWJsuY
	 i0Za14D/8h0v2ExfTmNX8r3pNdahuDqF2sZcbFYJgC9KXTvMQ9n3rGXeWTIVfyyOc
	 y0F0kYJRwFYZqMCdPg6aZeGkuqxS34xdFwovAx9otLCOrl4wn9wxzD3g0t7NoaXpf
	 kjzXrU8mABYNXxCqIkE9W72yqXPbbKaBZc+JdYehb20OB7LBJaKA1+z03uu5fEWdT
	 CyPu1LOaxBevY/bqWzIPZ9Is+0yX4GqxZ/KNfCfgOvJJkZzy8Efd0/77c+c7DSRnv
	 EZ6rbxup7Nen08py5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSFO-1rmknr2Zzq-00Wyi1; Wed, 27
 Dec 2023 17:00:13 +0100
Message-ID: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
Date: Wed, 27 Dec 2023 17:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/ZB+Xz9KfutVy44u7ATXxHfRoOlJu8VqT0njohBNmDTFTFN81VA
 58/ninWz2K2SQkMe/JLejpRDslxSPa5e2YPAMXXSKq4siFxsX0NOxum8dc+FtrmTr0gAgmj
 0l3tI0o1ZqwrQCxMA2dPbRWtxzIDhZ85XexQzqCd2wtfSwe1tTN1S3CEe3xuYBK87s9j4tL
 dpZPTGY0SXpR1GsSizd1g==
UI-OutboundReport: notjunk:1;M01:P0:f0e9gz3eaHo=;WM8+2HVOJDENngzP+ReL8RQv+0I
 aUXrbcBV6KciL55pCAKg+ISAW3eTFRj5nZo6LhMQVpOM3DtGgFQzBFMzFy1cy2JFEfw/CjyTI
 bHPvWwDMBnTY0y7DD24b81M9PjlqOPg7bVIJAFIN+IBHqQeXc867FpD0DMACfJyWcxiR5fTPY
 J6OBUi3RMcY5TB6CXA0CcQg/OEr9woQmvjvm1fqZ9IWfbXs0+Fm4Qqokt+rWv43QZndgBmboz
 2PShqWL6Ji6bG0HzjNiNw9lOMXCxst7jchkMgi7ORFdz2G14NXQMHfcwUVg3ON9vTDcU3NpkU
 TBzNckgch1atGYKOebetXdtQUSx4BSbk5lAPcEynStw+An4s/Y8NbvZq1H/IuHizv+X2CKWlJ
 GcFepiVaLkKhB/sQEmDYQ/tZcXwRTpUJHIKUBeHXnJEY6/eVX/4Tg2mR4mSWjpmCEl2p9N5l7
 Sq5ZofrmWXIDZlvjGCS72iurOOhX0JKzBw06O6oCLBP5dzBLoh3PjJGhhAtsl8L/oSy6Bd0E7
 D/tejmehatFg1M7Ltkl7a0a6ZxHTkXj8r7sQ2YwhpxxTeSBMLLyxWEUojcNzk+qKK0GbT7R23
 pyDK0ny4ymBaHrsknHGXD1U5QXi/EGVnw597hoQRsfOHD5nqx9qlljXmgsXb8vc5NfPPC6lGo
 66BpDUWBH9aqJ1whSvuGVZME/hHT2X7vpKd8py1lwm3yhX8f1u7f4M0oJkNZJuOHL/C8Bjr6G
 PwneqTrXwX5/dLeXb7X3a+nddtb1dXiUnDodJzwf3tW0LmmhihEK7evONJNeAhFgGK5aWNSDQ
 MJRaAIaxCuh7Rnlvkd9vTbpytDsU4lUE6iQyPdFC0+fpy1Y82IaSDOtuduyxXKd8X8x0m/U+X
 LJBAO43F1W0f6VspGca7tH9sFAWEua7ZfeGusg+Pwf2DN8mIR+13SCeo681OIoo4WsxFX19EA
 agtDP2+Y0tQA3ivAsR/ymANKT+8=
Subject: [cocci] [PATCH 0/2] nfc: mei_phy: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1416
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/9a683f73-c5a2-4b80-af1b-01540834a3dd%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 16:53:21 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return directly after a failed kzalloc() in mei_nfc_send()
  Use common code in mei_nfc_connect()

 drivers/nfc/mei_phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

=2D-
2.43.0

