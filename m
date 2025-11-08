Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BA6CCFA18
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dVxe3yJfh5t9lONchIC0INOWYz7mPOq0+IAsWfDk0m8=;
  b=vMmUR+Wiy+NWi7raEIHf0cD0VrxSwV1vqcSFrUg7gR8HRfnwGvtpIUCQ
   Y3UnjH4Jy19ZtUT0oMxKCCBqVjpZH5E8oqB4m38KFTwcMgXcQG+BDpVui
   TaJa/3iQy7ODPhYcKCWJYgx5rltLNhqMpEEZn54MD42/NDhprZ958RbuK
   o=;
X-CSE-ConnectionGUID: kwCKBUrWS4yuoho+g8bJhg==
X-CSE-MsgGUID: XET6AabCTr6fzLCcbNFigg==
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
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248308868"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 15:37:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AB973E0C55; Sat,  8 Nov 2025 15:37:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 55D54E0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 15:37:19 +0100 (CET)
X-CSE-ConnectionGUID: awborZOLRTmmNCYMFA6iYw==
X-CSE-MsgGUID: yaBpFSSYSReL+oiCmEci6A==
IronPort-SDR: 690f559c_grnohe/ZPqsyHvaExahZXja69EkZgGOctBkWmuHii0Py7sr
 blTM1MQhKgVjSee5EgHP68dGy2iwytcsGBVfYxQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EvBQBnVQ9pgA4P49RaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIIMgnQCjFoCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBDwsaAiYCAlYGF?=
 =?us-ascii?q?QEBgn6CIwEGEAEDDycHrxmBMoEBggwBAQbaXx8sIlmBZAmBHC6FboJlAYlse?=
 =?us-ascii?q?icPgVVEgTyCUjE+hEODW4JpgiaBDokVkEFSeBwDWSwBVRMXCwcFgSBDA4ELI?=
 =?us-ascii?q?0sFLR2BJCIfGBFgPRdAg0kcBmgPBoESGUkCAgIFAkA6gWgGHAYcEgIDAQICO?=
 =?us-ascii?q?lcNgXcCAgSCGX6CCg+EEoEFhG9AAgELbT03CQsbBj2VBoI3Pso7NAeCOIFng?=
 =?us-ascii?q?WQMn2wGEy+DcZNhDgaTBZkGqUGBaDqBXDMaJIM2TwMZD44hhDO8BkI1PAIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZO8qdq/CW7bnvPsYuU5uk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:x2fV5WNRyAFzgO5DUTZt81QmPeQfTnjY6lzhBmGRV2dYV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AJvs9mQ/xI6myXvTa64IK41OQf9ZhybyAM3s8qq8?=
 =?us-ascii?q?Ln4qDNAd1Fjyc0h3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248308867"
X-MGA-submission: =?us-ascii?q?MDHQWWHplLNbUlrp7bAVbF65/QSkSEDDa1/o88?=
 =?us-ascii?q?VPPmJCogimrYByvhogK9wKtuh3NDCUw1skrM+xt84m4djW+oZkFMmSPY?=
 =?us-ascii?q?LpXdTEgkvXwmblCdyzEjGqM7XuuMv18sbXdW18X8I/BTCJRO1eHJEDXU?=
 =?us-ascii?q?90rUIKexN1sqLUp9MLSbCLHQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 15:37:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762612635; x=1763217435; i=markus.elfring@web.de;
	bh=dVxe3yJfh5t9lONchIC0INOWYz7mPOq0+IAsWfDk0m8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eGd9owM2fpTPZ+8SdEUIgFFkD7WDUEIaKH+tEwVkrwmwPkDanNYCqhfLtsatZVzC
	 XMes7O+DNcL56y2lFK/6bTUcg7ftDA2sIbAgyJxZjukhr/LOX26oxQtq7CgcDUjM0
	 n/r+G5yQYhI19EtpKKKev/mfspQgJaaZhxYXQF1ckLsByNfC0xkYw4zJ8SxSTxPts
	 lFp+h3gIuyh0wmmhdKaRscEaR3CiiPXP4ExZuMIJ5jZiTEKOSdZ8JmTmzUTptdNGJ
	 EcA3oQH5pm2APILK6UDLvjFvmWkttBUvrcgdp9lD+GE8HYnYDxPIt2/9bwZ/mkaff
	 Nuz7oBgsYRPv1gVstg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKtb-1vsRaS21m7-00ZbXY; Sat, 08
 Nov 2025 15:37:15 +0100
Message-ID: <7e3a6e91-b89c-4fb6-91e3-cf43313b9e20@web.de>
Date: Sat, 8 Nov 2025 15:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
References: <d0ebb438-c60e-407a-8cfd-77fe0862223a@web.de>
 <3AFDEDD4-46FE-4E5A-A9F2-72D491568D78@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3AFDEDD4-46FE-4E5A-A9F2-72D491568D78@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PzZnRu+5xkqjZzQCk5qpOyIhNdZL2E+6Qvw/JbStwRQpbmpQMs1
 2YBAv2j/Nk4HUWeWrHv43LUIVeT8jMI82N1/s1HhC/6u1fupSU92x/PoYmbUoVHEuiOZ6dZ
 pPYA7m28bUPy7LsmrQc6tVXa2eYF3FePFowAzvXronPpTgIet/cN88V6VdyKHbSB+zRHr7U
 uuKB9HHTC0hVmOaKRAcUA==
UI-OutboundReport: notjunk:1;M01:P0:59Z/IL+3K20=;E96aLF9j1mng+G6CEITIiyGVDWQ
 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
Subject: Re: [cocci] Searching for switch statements with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3143
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/7e3a6e91-b89c-4fb6-91e3-cf43313b9e20%40web.de>

>> Under which circumstances will such data processing become better suppo=
rted?
> None. All cases are directly attached to the { of the switch, like if br=
anches are attached to an if header. So the nest doesn=E2=80=99t make sens=
e.

I hope that better common understanding can be achieved for more desirable
software behaviour also according to such a feedback.

Which SmPL script variant would you find more reasonable for the mentioned
use case?

Regards,
Markus
