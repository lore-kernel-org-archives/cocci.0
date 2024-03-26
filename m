Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EC3CD1283
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2024 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9bQCFkqtTockg5huZ/DSpKM2bRESequYaPDA9A0vKdc=;
  b=ND3tGLlsVV3RK23QzXZTXnVbbOt1z4ita6dX/ouVHoKOUlFzjE5i6gxL
   jE3EaC53y0x2NzQKSfFJQL10x5o7U+SZ8sVJ/i+nLZrJpfjdT87bXBMAe
   U4/rs385F1FquMSVk2pxBGbbFMXtEFOUUOnugUMxBdPrh9+q/lE/ANdkq
   Y=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,156,1708383600"; 
   d="scan'208";a="158545783"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Mar 2024 14:26:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7BD32E0146; Tue, 26 Mar 2024 14:26:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 66F3BE008A
	for <cocci@sympa.inria.fr>; Tue, 26 Mar 2024 14:26:50 +0100 (CET)
IronPort-SDR: 6602cd1b_EGY3TxGocBCkmau+VeMnYiN/ge/+usotTASH5pYTj3WMuAy
 CQAJKkp5DnR125gp9q29/y4uMfkwk8Reiy8dWDg==
X-IPAS-Result: =?us-ascii?q?A0FiCgB8zAJmhw4P49RagQmBT4I5fANTMgQLSAglgSUCg?=
 =?us-ascii?q?wKPRYF1hGuBVY0xiHCDFj4PAQMBDT0EAQIEAQEDAQIBDYE8hCOHGwIeBwEEM?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFb?=
 =?us-ascii?q?Q2CYBh3F3QwAgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAg06ax0BAREnNAImAnMBAYJ8AYIqAQMxBw0GsWiBMoEBggoBAQaBW?=
 =?us-ascii?q?EFOrHUfLCJXgWEDBoEaLogMGgEFZYlvD4FVRIE8glKDUAEBAoIrgw6CaIVNg?=
 =?us-ascii?q?SWKXQGTdoFSHAOBBWsbEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQAZIC?=
 =?us-ascii?q?wMCGgUDAwSBLwULGgIQLCgDAxJJAhAUAzgDAwYDCjEuT0EMUANnHzEJPAsED?=
 =?us-ascii?q?BoCGxQNJCMCLD4DCQoQAhYDHRYEMhEJCyYDKgY2AhIMBgYGXCAHDwkEIwMIB?=
 =?us-ascii?q?AMrJQMgcBEDBBoECwd2gz0EE0QDEIEyihmBFIIrgiCEOwhAAxkrHUACAQttP?=
 =?us-ascii?q?TUJCxsGIh4CpEcBg0ZZgj2TJLIWNAeCNoFgBYFcDIh7gSSVIgYTL4Nyk0QOB?=
 =?us-ascii?q?pJlmGKNc5VAhVCBeiSBXDMaJIM2TwMZD445g2EzgQuSFkI1AgEBBzACBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:PfbkdauxiwXehGTAaHgnBg1D7skDVNV00zEX/kB9WHVpm7+j5q
 OTdZMgpHjJYVcqKRUdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHRuQ6T9RZQpRoBUdAH0+6VMHfjLqX8KTMtOaYE
X-Talos-CUID: =?us-ascii?q?9a23=3AQX8qVWryotOXaXVgx2kA6sXmUd8XYib95V6IGH+?=
 =?us-ascii?q?bIzt1ToCpEV6v06wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ANga6ow7LJQM/R/mk0p+V3zyjxoxQyamgTxg0t6k?=
 =?us-ascii?q?7tvW/OS5gKSWCnQuoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,156,1708383600"; 
   d="scan'208";a="158545770"
X-MGA-submission: =?us-ascii?q?MDH95EHZ3gPWqFHIXkdzRRckb69BJ6E22ViKl2?=
 =?us-ascii?q?5Qb+8bWxWH0e3vzGtAbiZvGr5b6zm2kOpcDxpkBOg3locSutZXYnQzhb?=
 =?us-ascii?q?8PV0jGkSLJNytUT8uuVZEmBeXqWXMjW1oiLHtOVMAbhHONPkmU/GgM14?=
 =?us-ascii?q?5x8I14aaM3xNZpE2lvED3/rg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:26:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711459609; x=1712064409; i=markus.elfring@web.de;
	bh=9bQCFkqtTockg5huZ/DSpKM2bRESequYaPDA9A0vKdc=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=K90qtweKsp56mePrCzGS0SSp9UV/u5U0L1J8H2K0bnPbOiYEJNFcwxz/V92oUopg
	 EjDTGaCH7sjeQgOadK9lu4wHxwrgeqa2w3YJfJGVJ25bdWYS0I33fVL7iWB2SL46j
	 DuRpn4poZo8AouUorkFighI3WegkKm2O54pJN6HfpqiTb9xw4m5guWXXdm04ebn78
	 NKCE7Sh1YzNGPTLv+J4K30UD9CPm48VJFUd/T24+zKUGlco/kwSDDoSHY1BcOcQX8
	 ENRt1RWxF64kDqDm14ceeKF7VQCJDrIT5OQSY6dCYgaPmuddJhhBNy6aMSNXFBIko
	 XumxDWcqny+jKB3YUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1s9NX51WO6-00LWyy for
 <cocci@inria.fr>; Tue, 26 Mar 2024 14:26:49 +0100
Message-ID: <0264b7c7-99bc-42bb-a8cc-1cd247f34d96@web.de>
Date: Tue, 26 Mar 2024 14:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lAVXLbf8ywKz96TL8Ydl6Mk9Zjj9RRX81k0KeqFIhKroQWNwXs+
 IrKz6tD6ooBBvoiczMMyXUlGXzLwqmjx3/WxMV8MMoRCvolD5XS3UQmsbbnE4BEpsy9AphD
 7mwe/mZuu2jYhfVOfM8pVKoD/mULvyVyiCp/X+KrBgZCo8za1xgQYDptAUeOaTB09WrJVkd
 fIIBDn/6yG43rFXUk+mmA==
UI-OutboundReport: notjunk:1;M01:P0:CsHQSNrV0Z8=;lLHeRSDxmvZRezMh3Qego5yLSVw
 EGiMWlIwO7zLgX+ck4TqIESWNjV+rUDQyhpeHnqNIcDDhaVFoI/bmPKp/OztAU0Ik5hZ1Qrhu
 RzirdDeNxezhlF3uYd+djUHYrXkBYGXg5Cn9wVpVE7HJSQgy4qz8EIS8w90gZsWiUfnc5GVEL
 YSpV0Rvoe2JSWI/c9Mla/chlaRw3dSMbV/TjtSal5xaxfsn+d6x/wl6jjoldTTRza6cfMAEk2
 D77ls4iPRbG8JCL7vnFg7dnbW3IJcIeBD+fbsq9upCUWD+E9TB/9Gm9SiHIDWDwo6Uura0DUI
 QGslM/M7alosSviNVw5uto8TlHGii0zNdL831qqgG9YJS8aR5bXMu6hj9zybYnhTyzQNXrAnY
 QfGLZNh+rW37kaAxxpKo8T6bFRBDRqccozTE1Oo221X7qNovcIV7wDzqZfPwIGTJ4qTXwMfiX
 Qet/fEvoiyCDwqxJKNDScuuFWqg44SPrY0y1ADkxa1QjI/JhKjQiIzxyy7rQj+hfDuizDD0TI
 4Dp8NyN0lwQh1zyi9LPnJDr/Ue3EWRMX7tVcaPWYI/wqwSkeb8mvFJp//Ea85kAav7J9Z3Uq3
 cUXjD55p+zhPMGdwfLHotCTvagPcqSAuL6cV4GqZBtsEROKdq9YLQKAokFj2V/4Q4cKBiV/tC
 dEYoigfUs9VRfCnpLPxVVUkMP7hPrn/8s1CKBaq9Ifr6+cu8M4p4/8fGvcLcWsTVweHz6rV0m
 No+q84FC9x2zBwxDkUjT5zqabGNqmuwYV3GTGZCE3tmdyhynCRjWQW+jtjFFWSf/wZIZiee7I
 kJiJKQVTf/SrCG7MVqOByzX09ki4LNBL4QOiQUU3f6O50=
Subject: [cocci] Improving support for return macro variants with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1620
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/0264b7c7-99bc-42bb-a8cc-1cd247f34d96%40web.de>

Hello,

The semantic patch language provides special support for =E2=80=9CLinux it=
erators=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/0011af1760e37caada1f9=
d48e2c549bd519bf203/docs/manual/cocci_syntax.tex#L471
https://github.com/coccinelle/coccinelle/blob/0011af1760e37caada1f9d48e2c5=
49bd519bf203/docs/manual/cocci_syntax.tex#L471

Will a need evolve to extend data processing support in similar ways
for macro variants (like =E2=80=9Creturn_ptr(p)=E2=80=9D) which indicate r=
eturn statements?
https://elixir.bootlin.com/linux/v6.8.1/source/include/linux/cleanup.h#L78

Regards,
Markus
