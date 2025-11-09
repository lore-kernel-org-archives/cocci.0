Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DFCCCFA1A
	for <cocci@archiver.kernel.org>; Sun,  9 Nov 2025 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ouzpWCJ8dXVs/zAlTWg8fs5Bfxqb6GhdSW/r9hXW7lQ=;
  b=lKXrwu7A+LsZQzc+PxG9y52VVCh2F77qMP514QrieovS1MyXqUEr2mvk
   POMHaJ+lm/o80PmjbjsLZE/JGIRShKI1w//lgBQEFV9P+jLE+hvVa8WSL
   89kGT7t9/HPtWS5xtevb33TE1toXi/VZL2Bow+FOSQ45WFfSM5KTT0c3C
   Y=;
X-CSE-ConnectionGUID: shSBePuDQfSQEFp0au2GXA==
X-CSE-MsgGUID: KWR/UNfdQDCHBoVqfWJILQ==
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
X-IronPort-AV: E=Sophos;i="6.19,292,1754949600"; 
   d="scan'208";a="248370850"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2025 18:24:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 93FABE0172; Sun,  9 Nov 2025 18:24:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1967EE0171
	for <cocci@sympa.inria.fr>; Sun,  9 Nov 2025 18:24:01 +0100 (CET)
X-CSE-ConnectionGUID: HG7vfMScSjSczsarmNpRXQ==
X-CSE-MsgGUID: XfZo2MLAQ1CxevZh4bn+Hw==
IronPort-SDR: 6910ce30_qW3WNS2nuM0zMDNe6QO9ZcRBjiUiStIFfkklcGr74cjguDA
 51jznmP3D2RFeQRNCXsr0PChaDnSfNGq/yAH4IA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HPDAAwzRBpgAwR49RaHgEBCxIMQIFFC4JAZR0GWDMEC?=
 =?us-ascii?q?0kIhE2PU4ZfjxGIeYNSAg8BAwENRAoBAgQBAQMEggyPUAIeBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgluBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINOm0EGQEBESc0AiYCcwEBgn4BgiIBBhABAzYHD?=
 =?us-ascii?q?QauN38zgQGCDAEBBoJp13YfLCJZgWQDBoEcLoVugkobAQVuihoPgVVEgTwLg?=
 =?us-ascii?q?kcxgU2BUgSCK4MOgmmCJoEOhieTIYFKHANZLAFVExcLBwWBYwOBCzI8Mh2BJ?=
 =?us-ascii?q?EEYcT1Xg0kiaA8GgRKDUYkeD4owAgELbT03CQsbBj2Ue4J1gQITLJV5kAaie?=
 =?us-ascii?q?zQHgjiBZwWBXwyJCIEmlT4GEy+XUg4GkwWZBo4IlWCFWYF+JIFcMxokgzZPA?=
 =?us-ascii?q?xkPjiGEADO8SEI1AgE5AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 twCR+0DPGE=
IronPort-Data: A9a23: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
 d0VUFYfNA==
IronPort-HdrOrdr: A9a23:WUbQxqANunksayHlHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: 9a23:3sGRn2GqG3fZMHqYqmJH2xEKFOUeeUbf93zCOEaiDEBxco2sHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AMyXP8w2t4lxZdfeLqfT2HfLlEjUj06qcDxootbw?=
 =?us-ascii?q?/4uKUODJCO2uXineXXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,292,1754949600"; 
   d="scan'208";a="130380729"
X-MGA-submission: =?us-ascii?q?MDGYQBm80hKpKfNXCMYCXNQqJ9xs3YejCTfwfh?=
 =?us-ascii?q?uZE0JcYvSC2jqGYFjU39/9RJFv/LgjwRQumeNzfHpu2uvfFNHkYlKM64?=
 =?us-ascii?q?9I1ZpGuyy/8VC++AiQ8mKx0VZ3pYMqYK+yGAWyxGVX4uSnsEQe0aAWtw?=
 =?us-ascii?q?sWjXl1NrdQ8kdbgcpxXtr9Wg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 18:24:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762709039; x=1763313839; i=markus.elfring@web.de;
	bh=ouzpWCJ8dXVs/zAlTWg8fs5Bfxqb6GhdSW/r9hXW7lQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OjP/5JA+nIlLoYZ2fnF2YOoPnRlRNKcj/gmN7gy0tEtoS3rDoenMRX1gcoaaciKc
	 JEIMNPx6mkw+eiKDrjg5ln73f5nLFX3pySRU8Bg4729veD8vtPIgzUsuKSmxHydnM
	 OM0fuYn2wvXUiSb9pln92vKi9qu4IZxNhPzFJN1OysbZzkL7kvsAJMfJsgfCAfP3D
	 cbh0blpRn2EZu4ENh75TRZad23no5jbPJxiZ6dc4jGlAmLCU8Ycaog91rXG07nNjV
	 XsO+anP3I6dHsy/mSumbUe03np/cQlYVlsoQOcvtUiKIX439XiaEFUdJ6qzvNSzDA
	 JkGhAbWMuNVLZ38iJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.232]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPvg-1wCZXt1Ph8-00sCk7 for
 <cocci@inria.fr>; Sun, 09 Nov 2025 18:23:59 +0100
Message-ID: <8be602f8-5336-49f9-9ca4-d00ed372a192@web.de>
Date: Sun, 9 Nov 2025 18:23:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zOKn/HjnLiIPNBT4Nt5JlkA+TiaQ7JqPbR1q2gQsK67PRPnox6s
 hHWljooxf8gW35McBM0IvgV9ARxo4RGueTjYgjo8xAbrcrjJb4KxL3eDzkuXVYvstuC/IOr
 q1t0dqLm8h5XQfGfzg1RnMJQtDmo56XBDqkIL+9f5uM91vwDVg5Ht+HnPFCzchaLe+ysg5a
 Vo/E5700WBeB2+pSFdNYA==
UI-OutboundReport: notjunk:1;M01:P0:p+1A1ItYMtA=;7M4Gju9c1u4ujggfY3IebgF9RQN
 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
 0WS7kuCo6ErBtmzA6bIEwxdrh7qigDo3z+8=
Subject: [cocci] Test case consequences for a special SmPL disjunction
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3155
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/8be602f8-5336-49f9-9ca4-d00ed372a192%40web.de>

Hello,

I got into the mood to try another source code transformation out which
should be achievable also by the means of the semantic patch language.

@replacements@
expression adev, fwnode, x_name;
@@
(
-is_acpi_data_node(fwnode) ? (!strcmp(to_acpi_data_node(fwnode)->name, x_n=
ame)) : false
+acpi_data_node_match(fwnode, x_name)
|
- &adev->fwnode
+acpi_fwnode_handle(adev)
)


Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci use_selected_acpi_functions2.cocci
=E2=80=A6
minus: parse error:=20
  File "use_selected_acpi_functions2.cocci", line 8, column 9, charpos =3D=
 190
  around =3D 'fwnode',
  whole content =3D - &adev->fwnode


But I know that the elements from the affected SmPL disjunction would be a=
ccepted
if their SmPL code would be parsed separately.
https://elixir.bootlin.com/linux/v6.18-rc4/source/include/acpi/acpi_bus.h#=
L549-L559

Under which circumstances will data processing become better supported her=
e?

Regards,
Markus
