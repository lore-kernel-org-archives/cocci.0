Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390AED3C526
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2024 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=upZXouqzwxQ/rYW3Hk+poMo+xwDm7duF/hIK4UrdtxA=;
  b=D8wMu6ZafdGW8NJMzmarTH/cBGIGqCWFSszNDnkqBm5vzws80wQITlwD
   JNYXGNk2alxfvfcIJtUnRMqCD8qbdQwYxfHljZEKR757pQkt1WWhknawH
   uC2GCxIN0R8tQQxHJzBThvR3EpeBcnqC4HdNbxhOMDEpsCY7dG4VAifJv
   w=;
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
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189465657"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2024 20:33:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8FA16E004E; Thu, 17 Oct 2024 20:33:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0E17EE004E
	for <cocci@sympa.inria.fr>; Thu, 17 Oct 2024 20:33:23 +0200 (CEST)
IronPort-SDR: 67115872_Le3QLiTH+CsnlVKpavi8/CYzora7H0WV0iST3+YGC63U4NH
 QAdJWrkoLZpZNKNJ9TACyNLT85uLNBlNlWtdyQw==
X-IPAS-Result: =?us-ascii?q?A0E6AAArVxFneAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYhsGVDMEC0iEVogdiSQwhDuPDopLgX4PAQMBDTUMAQIEAQEDB?=
 =?us-ascii?q?IIMgmoBCQKKJAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABQw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg06RAEBAQIBIx0BA?=
 =?us-ascii?q?REfBwEPCxoCJgICVgYVAQGCfQGCLwEDDiMHDbAfgTITboIMAQEG2lsfLCJXg?=
 =?us-ascii?q?WMDBoEaLgGFaYJiAYlmeicPgVVEgTwLgkcxPoRDg1uCaY0uhFuLaiWIUW6RU?=
 =?us-ascii?q?FJ7HANZIRMBVRMXCwkFiTUKgxwpgUUmhBEIgSsTg1+BZwlghiCCIoEMgT6BW?=
 =?us-ascii?q?QGDOEqDTByBUQU4SYJPak43Ag0CN4IkgQCCUYElBAWDPYEWHUACAQttPTUJC?=
 =?us-ascii?q?xsGPat4gVpHhBWBG8caNAeCOIFlgWMMiieVLgYTL4NyAZNNDgaSeJh3jX2bI?=
 =?us-ascii?q?4FnOoFcMxokgzYfMAMZD44hhC2EYcF0QTU7AgcLAQEDCYVGAQGHBIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:5tPuV6P4+nw8IcBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3Afc3oT2o2nNnjHi/5tjFsSuLmUeM5VWTG/VWMGGS?=
 =?us-ascii?q?fG3pjTeeRSwK/2qwxxg=3D=3D?=
X-Talos-MUID: 9a23:qRw3cwZKohHBneBT5g71jRg8FtVT+731MVI8v7cZmpHDHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="99404375"
X-MGA-submission: =?us-ascii?q?MDF3lfGUCXiStiQKHB5abMN30TuoGnOOWkeT9T?=
 =?us-ascii?q?RAfIF6v70eCxhrshF56ICmMNQ0pOHtF+6VmlLCheSIiP4+Da4+2zR2KE?=
 =?us-ascii?q?XWL25utZQb6YZ1IiqGe9JdlVrG0cg2BtUwfflJMmSo2dp1vOdnvJwK2R?=
 =?us-ascii?q?xgQinD39Lk63bbD4i36xOEEA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:33:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729190001; x=1729794801; i=markus.elfring@web.de;
	bh=upZXouqzwxQ/rYW3Hk+poMo+xwDm7duF/hIK4UrdtxA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KUcthN3rG1rQDdtE8AHEeYRFkcPfv0Stdp1RexPvyhfgkCjQ15XszE9v6hnr7Ubg
	 UKb/pISVSRDkzJDfttpBAqYYq72+7q13wLeObE1RYFAHx7bR41vyEov9JMso/ysGM
	 7KiDVJElcL6UNCyh2ZYUaRoU1AiwJz9dTV3qCGOY9P8IG0i1hTZ8jTfyAV9MprCyh
	 iuA8Lxl3U718WZj0Aaees//zQrsq2IhF4DScNyi0Uu6Q+p+Wrnqp8ks6U1KCFYg6O
	 5p/D165h4PylNjNrScUOvQzYOnlyVkIKKJBs4MBNgkYovEPPgzTPI8NdrQE1iEL4P
	 dTJDNGjiTe0aOqr/3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml46y-1tmy8j3fH2-00lULz; Thu, 17
 Oct 2024 20:33:21 +0200
Message-ID: <bb5c60f7-8401-4c28-b6d0-a814ee713ed0@web.de>
Date: Thu, 17 Oct 2024 20:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de>
 <ced9a857-0da6-4cfc-ad35-9095ea20771d@web.de>
 <d69dc642-7a57-449b-170-a67c3a9fc1c@inria.fr>
 <a89dfb58-621a-4c0b-a0a1-ba01d5df51ce@web.de>
 <alpine.DEB.2.22.394.2410172022320.3480@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410172022320.3480@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QzhXWyctH/N5oKw0zCTREeYN9MDzh7r1+M5guPXrburT8YROnts
 BhEWUw20ufmxmWjY8tYl4gGoVIfDM38ngpgRJvaYhACxuE0sL7gKR51FxHvG5aRNsHpyCak
 zJabNv4xh4A8RNrDXWVNpC6T9c94YXNwB/veUZJdDcuPR3I4PdjiEPlZ4Dkh5MA11BhfONV
 W2jqJNKbMAaV9erBWVorg==
UI-OutboundReport: notjunk:1;M01:P0:H0KfseiDOgw=;aZux72ffnUii1Rhyb1LEgm5qdUZ
 3BjN0Nfw4c7FMn8M31G2Vf7iFRbAPaPz2WiVAd2J3SMCg7WbiBhsTrBHQanVTsgbmOKsvtHib
 tkWQM0E7tc/HQbm19/O5OlTQmn12K9VhpvuITQMZM46Ga6p3ZJtQGpBekzQcNpr9QTHM4J34k
 OheENqir/fJKyAnEsPHrWBEtw0QK8TeVhVDkZiKGSm8/3qgySfsv7kewqhSKymE8w6z6/28bJ
 nqMXXniFG4MxepfH7TR+6Kcpierx83YlygO+WX3T7UQ7cGJyfEXuRLF/v+mzEfsM0TNsN27DC
 G92y7QSds9AKSIUoPI5B5MrX/AFL/va56tpmXDmXf24o6XyWgJJmhZ7QsNi8nr2gd7lpbCVL8
 dwA1bbe/37IkxHGsdtmQsFxIjdWTvZZd6CT8sFgtYoeoD+HpArc3H0UMyPZcaLov4njVAFjKh
 nhkyx0q9vy7N3vjshWFPytweydVREESxBO6xGBJzZyZEHLMt7/PrhrQ7cQA12V6r8bszob1YN
 NoLpX7zK5WHsD/nMZXIypUAYDKW4dmpdbqBNy+2EIIn/saCu7IFxJp2VmKI/APDZv/SdBIk4b
 SrMH94ik0c0JL63DrKpMd5W1nkdNmzWKEnggG8RwnjzYlK0vwJ8WTmw1CLDgG2Oyd8LkJJnqP
 xVgD84WXzFDw4X139AFoDCp+eBjAml8x5d8M5oWQuFk+BdBzEvY/QZjeBwG5pw3kjuanocmpw
 YwWNxH48GiJEizO1VaQmcdCqytSgMeTwYd2DpSNjEXHmTYQb3pwRB6qC1/W4l2fxgzN56NBvK
 e8mnJ9PEfV3R5n6KNr30+3Kw==
Subject: Re: [cocci] Challenges with selection of an SmPL Python version?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1917
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/bb5c60f7-8401-4c28-b6d0-a814ee713ed0%40web.de>

>> Would you dare to install any of the mentioned software libraries (on d=
emand)?
>
> I tried, but it was not obvious to me how to do that, so I gave up.

Is the used component available also in your software package sources?
Python SQL Toolkit and Object Relational Mapper
https://www.sqlalchemy.org/

See also:
https://pypi.org/project/SQLAlchemy/

Regards,
Markus
