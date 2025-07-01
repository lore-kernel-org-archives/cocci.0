Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501AAC8302F
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 06:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=AkHdAd7KonpTiWAO7F3P4uO/4ECOUrpP3u9VUstuJVc=;
  b=qsvmbj5/K3CckgbEG7cPumL20C40GLF3+GvN3H2AJ/xZ5GF7xm55NcCl
   8PZRXEcA/U6JrUtGN98RIEwa60+7h2tAl4VU4n7FIcS5gc6zjpohiyBJZ
   yrnXt5D3UH7u+FdTimi/37dP4BvWPLOCbLkMYeYB/SHS5OpuBjazktnvl
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229707450"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 08:34:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4B0F3E01A8; Tue,  1 Jul 2025 08:34:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E92FE0157
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 08:34:03 +0200 (CEST)
IronPort-SDR: 6863815a_D0+r/sEV9uK6jTtwNHB+jcQ1jNta97gR0EKfFooi2tZybfo
 yfyeTGO1eosTrwsBpuewxodIGM9U434ftZAujOg==
X-IPAS-Result: =?us-ascii?q?A0HZFwBYgGNoiw4P49RagQmBVYJCgQAGVDMEC0kIhE2PU?=
 =?us-ascii?q?IF0LYQ+jw+Id4FpgWkCDwEDAQ1KBAECBAEBAwMBggyOagIeBwEENQUNAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQE8BQ4KMYV7DYJbgSyBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdtH?=
 =?us-ascii?q?QEBESc0AhEVAnMBAYJ+AYIhAQYQAQMyBw0GsRaBMoEBggwBAQaBWEFQ13UfL?=
 =?us-ascii?q?CJYgWUDBoEbL4VsgkoaAQVtihgPgVVEgTyGIgEDgReBBg6DDoJHIoImgRaBX?=
 =?us-ascii?q?gQQT12BXIQXjx+BShwDWSwBVRMXCwcFgWMDgQ9uMh2BJ3+EcoEOhCsrT4UTQ?=
 =?us-ascii?q?ViDUyRtDwaBH1xAAgELbT03CQsbBj2SWYQMLQErgjFGkwCRNqA4gQo0B4I4g?=
 =?us-ascii?q?WYFgV8MiQeBJpU8BhMvl0wOBpMCHphnjgeVXIVZggAigVwzGiSDNk8DGQ+EU?=
 =?us-ascii?q?IlqhBqBC7pEQTUCCTECBwsBAQMJhUYBAYgMgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BSAoWqtqgivCDq9a+bZ4YH0K7skDVNV00zEX/kB9WHVpm7+j5q
 OTdZMgpHjJYVcqKRUdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHRuQ6T9RZQpRoBUdAH0+6VMHfjLqX8KTMtOaYE
X-Talos-CUID: 9a23:g2/Tn2/YT41UWLRB8EqVv2NES548eHrE9mjVeR60FldAUueZSkDFrQ==
X-Talos-MUID: 9a23:6C9DMwZnDsINWuBThTbF1A9eJetSwv7+WGAcu8QblOqJDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229707434"
X-MGA-submission: =?us-ascii?q?MDHLBNPQMt20HU7S4yMC0KiejoJO9S8pOwYU9T?=
 =?us-ascii?q?uNeNqmE8Mhs8rX0ku9/RiuOtADMUH+Mw+CDKPsP29Yji2TjwDlWVvdGy?=
 =?us-ascii?q?OKtquyLBbKkp4yX1nzWq/y164T3OU9aajlZ2SS7SlqY8MUe4rK+KG6Uf?=
 =?us-ascii?q?jouTmY2fcn4DKgyYRQQgEs1Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:34:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751351641; x=1751956441; i=markus.elfring@web.de;
	bh=AkHdAd7KonpTiWAO7F3P4uO/4ECOUrpP3u9VUstuJVc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=atR03pcD1cTK3CiKAY3fLympPTnMp169dYQ86JuZzBmPzn9t5boQT6onwqMqo3UG
	 yP9ugyFAPa8m5linXkwi9DUILvQseQ+kcpGsVFyIRNie3XDYA8296oqfFQCvyvbzj
	 s+sJpRS4ZvIyTa2jAJxMZ7dbg0710jhJ1ZXdBHAqAkGhNP+oz2geMPEaeRN2rKmMy
	 +/hAjeQYLjDahHUzo8QpF+GMIyc9VK07rj95w4tIW7n0rLaFxxw8AczBi6WJDOIII
	 22QsaK24A4AaYsInXjFPG6EaTs56XVCh5K/B7i9yn/5c+WAVQ0NhmK5bCbK4QrIBX
	 0BnVLOl2KTWNeDGW1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1vBd8V2H1e-00jQkN for
 <cocci@inria.fr>; Tue, 01 Jul 2025 08:34:01 +0200
Message-ID: <80682a1c-b4c2-468e-84a4-c7c860d47e4a@web.de>
Date: Tue, 1 Jul 2025 08:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aR/lGHGwOoOQWrG1MbAhORvTvv6enxUK4TkYUHbWcAXlTw+EWOW
 yM0y9DSKXqO9suFBxsl4H7VSMPcU45Rm7TMBST5tOsCx0+AV08OD9lTjor7dCYhv5HOi4Mi
 IvAiz+VnPco1x5iyESSfufp9kxuTM5INnAq93xoRfFezsx7ViV2N4ThyBjIEpnuXdWCmNtK
 5rbUg0oteojtExT0fzF+A==
UI-OutboundReport: notjunk:1;M01:P0:kgnC19eWeSA=;q0EJDgq2bUVrrbdFc2heMMTk0Rb
 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
Subject: [cocci] Excluding files from data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2824
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/80682a1c-b4c2-468e-84a4-c7c860d47e4a%40web.de>

Hello,

The Coccinelle software supports to work with selected directories.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b00c5adb1a485321c88450bdaa9e0d9ff93123dc/docs/manual/spatch_options.tex#L249-259

Header files can also be taken into account for some source code analyses.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b00c5adb1a485321c88450bdaa9e0d9ff93123dc/docs/manual/spatch_options.tex#L196-198

Unfortunately, it can happen then that files would be found for which more
desirable data processing can not be performed so far.
(The amount of preprocessing code can occasionally be questionable for example.)

I imagine that advanced file filters would become helpful (so that other software
behaviour does not influence run time characteristics in undesirable ways).

Regards,
Markus
