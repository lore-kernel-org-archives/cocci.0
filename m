Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7E7CCD193
	for <cocci@archiver.kernel.org>; Sun, 26 Oct 2025 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mibbTTLN5+B3sO82KB+60Dfo97BnrllIG7ht+CCAp/k=;
  b=H2AROTzUm1VF25dz+gplrxmymiULI+C55rIr2J3pSHSJzsGnwvySaK/d
   JcfPypH71qoPUEdgpbo+myyjOVpdd/uXxNxEfEKFSi4AecUC11roTgAbo
   zDqVv6Z3MVg2MTWIWFtwLtePFUzgO1n1uMOn8zWXmCWrl1/lL5MeibtM4
   4=;
X-CSE-ConnectionGUID: 19ObNG0bRFOO963nwKW1Tw==
X-CSE-MsgGUID: 58/UNGQKTYKGcP5oABhaTw==
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
X-IronPort-AV: E=Sophos;i="6.19,256,1754949600"; 
   d="scan'208";a="246186111"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2025 12:16:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 258EFE0B0D; Sun, 26 Oct 2025 12:16:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 65226E0171
	for <cocci@sympa.inria.fr>; Sun, 26 Oct 2025 12:16:11 +0100 (CET)
X-CSE-ConnectionGUID: KujXK0lFROCcHY7KpUCKGg==
X-CSE-MsgGUID: FHW9HVhWTpG4itRMlooLVA==
IronPort-SDR: 68fe02fb_DVP2Now8cZCvaQkzx/ss/lvgOastXwqoofgvweuBp/SiapI
 O14sJI+3cOWFt9RDFycxYkh8nenCdrhvAy8r+Xg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FJBwBRAv5ogAwR49RaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1KCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIIMgnQCjE4CHgcBBDEID?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPD?=
 =?us-ascii?q?YJbgSyBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJgICVhsBA?=
 =?us-ascii?q?YJ+giMBBhABAw8nB7AhgTKBAYIMAQEGgmnXdh8sIlmBZAmBHC6FbYJkAYYwh?=
 =?us-ascii?q?DQnD4FVRIE8glIxPoRDTYMOgmmCJoEOhieReFJ4HANZLAFVExcLBwWBIEMDg?=
 =?us-ascii?q?QsjDzwFLR2BJyIfGBFgPRdAg0kbBmgPBoESGUkCAgIFAkI6gWgiBh8SAgMBA?=
 =?us-ascii?q?gI6Vw2BdwICBIIbfoILGA+EQoEFgj4CAQttPTcJCxsGPZN9g1ODEsZJNAeCO?=
 =?us-ascii?q?IFngWQMn2wGEy+DcZNhDgaTBZkGqUGBagM1gVwzGiRPgmdPAxkPjiGEM8UGQ?=
 =?us-ascii?q?jU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N07y38N8+NdnYsY0KBJQ==
IronPort-Data: A9a23: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
 d0VUFYfNA==
IronPort-HdrOrdr: A9a23:paG/gKsbGU/txN/ORkE3jSku7skDqNV00zEX/kB9WHVpm7+j5q
 STdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/hzAV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AedvEaWoVdloVa7nVbt1xFgvmUeM4cE3+lHP+GWi?=
 =?us-ascii?q?TAkZYF56NdHSz16wxxg=3D=3D?=
X-Talos-MUID: 9a23:OBzhAwYifXGDuuBTmR/T1RFcNPhU+4vyCVw3tJEBvO26HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,256,1754949600"; 
   d="scan'208";a="246186109"
X-MGA-submission: =?us-ascii?q?MDEuLmtOg55vfRBJ+FSTJuOZstY8hlSy6S+BQR?=
 =?us-ascii?q?/2xz1MihNvkhenrWReQhH7L2gk1NJz9Bhhh83fFj/u87yrJOE9ktoonq?=
 =?us-ascii?q?H89Auj8Q+XIysW9Ad+5rbBACzXD+0g3oNh8cTvIKrSIwH8g1AQMySll7?=
 =?us-ascii?q?ArU1hVkv62Pjcu37m8AdnZYA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 12:16:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761477370; x=1762082170; i=markus.elfring@web.de;
	bh=mibbTTLN5+B3sO82KB+60Dfo97BnrllIG7ht+CCAp/k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gTLOtnx8t/KcMsT2rPXSGm9ikvXMz5/nSN5JG3Nhj6KWtg7QdW1nA3F3SDoru1+u
	 H3Ans2Yi064Ehn3ZkoyRcy5SMsAgAay85hD94rEKmbHSi/VSkp4iNtGGod05wBXVP
	 vcejC7/XiqD3lyYVDCREsuWNtp8yRh+azOILAp+WF69oE1FfeLh/F9H3dy0LEFSbN
	 qY1hbf3H6qUQDcw/z5N3EK+dqjAza16UzccUNyDQ/4IDItOzba/EtUVyiEeSmZ0J6
	 qIGjBGqwSnn5hjwygb7J3y6EVebLlsVm2yb/ohRmRdwTFnsK0hbSp5UcjRtlW5s4x
	 E/flOX5GRg9ngF41XQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1uV9WD47Zg-00bZ1L for
 <cocci@inria.fr>; Sun, 26 Oct 2025 12:16:10 +0100
Message-ID: <0c6cbdbd-8d31-4c4f-a018-4ccb959f1b87@web.de>
Date: Sun, 26 Oct 2025 12:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <67c4f12a-5b58-459f-b02d-cfa5e6275693@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <67c4f12a-5b58-459f-b02d-cfa5e6275693@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cL7xc/iqA61uEDEfUW6QiHTGzBhnVpnMDOEYMde/1dh53IOWEmn
 NcDUEIXTCdilCVjN3Q2vatBQFJ6gzh1Haxw8XxG7H3fvzZOfCWKLDivsTL1Fh11Yqc5e3rd
 imlgrUdUHGwDLKOwtbkbbv+7bi6WxKIgm4ekuka1uP+UDsaXx8FF9w+MVqer3VPCwfUXXSv
 Aac8gUglCBcLobptvhD+Q==
UI-OutboundReport: notjunk:1;M01:P0:61MR0Xod/pU=;7hoRIjiaZ7ejtXPoBqO2ka7GckT
 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
Subject: Re: [cocci] Searching for selected function declarations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3098
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/0c6cbdbd-8d31-4c4f-a018-4ccb959f1b87%40web.de>

> Unfortunately, I am wondering about the following information.

Another SmPL script example:
@display disable decl_init@
identifier i;
parameter list pl;
@@
 my_type
*i(pl)
 ;


Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_selected_function_declarations3.cocci
=E2=80=A6
my_type *(*pl*) *i;
=E2=80=A6


Will further development considerations trigger more desirable improvement=
s?

Regards,
Markus
