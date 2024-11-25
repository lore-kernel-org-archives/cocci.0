Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6E3D58D40
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 13:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=uJAIw4NRLq8gPH2WGcZzJEEzWyzS+Ol80sO9ivIQoRw=;
  b=NQHEJ5PaFi8JRECjdd9QjFzFYvqcq3yGRCfHWYjqQS/UvXGLPZqMc1CA
   wrg9AQ/xzNBzEXz9CK7kSO76jVMfaRueF5l27wlmK7MZtmjitmbPVIVPR
   hFKwKqijAuCtl5a+6zzb4X8yqlXj8bgXpOogdouLuS/t81p1R7uJLQmsD
   g=;
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
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195661721"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 14:16:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B311CE0D3D; Mon, 25 Nov 2024 14:16:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3180DE00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 14:16:50 +0100 (CET)
IronPort-SDR: 674478c1_2P+AxtvMTYIblyQrg2c6F1HWWAxUG+q9N9GWagKv46y5caH
 UxIZVfoNFWBqezN8JF7Ljv9Dunc9i08zS3MnbPQ==
X-IPAS-Result: =?us-ascii?q?A0FYBwASeERneA4P49RagQmEF2IbBlQzBAtIhFaRQYRrj?=
 =?us-ascii?q?xGIdYMWPg8BAwENPQQBAgQBAQMDAYIMjU8CHgcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABQw4KMYV7DYJbgSxlCTgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQI9Cm0dAQERJzQCJgJzA?=
 =?us-ascii?q?QGCfQGCLwEDMQcNBq9UgTKBAYIMAQEGgmjXcx8sIleBZAMGgRouhWqCSBoBB?=
 =?us-ascii?q?W2KFQ+BVUSBPIJSMYMfAQECAYIqgw6CaYJEhQ8lhQaDEmiHMpQBgU0cA1kyA?=
 =?us-ascii?q?VUTFwsHBYF2A2SCYoE2gVGDEUqDSoFCgQOCSmlNNwINAjaCJH2CTYElBAWDa?=
 =?us-ascii?q?4RphF6GBh1AAgELbT03CQsbBj2fd4EcR4UCgjGTQbJXNAeCOIFlgWMMiQOBJ?=
 =?us-ascii?q?JUyBhMvl0MOBpJ6mHuOAJVShVaBfiOBXDMaJIM2TwMZD5JOgQuDVsI/QjUCC?=
 =?us-ascii?q?TACBwEKAQEDCYVGAQGLcoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:0OLHnKC87DFZhKzlHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: 9a23:K6DxBGwQacNpQbFIOx4zBgUTOfF/K0HhlUzyABCRVDhNQYCaQ3yprfY=
X-Talos-MUID: 9a23:cITH/AU7mcGPPhzq/GDAlDZMOudQ2LS3K0ULsL8U+PePHwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195661689"
X-MGA-submission: =?us-ascii?q?MDHgDQw57ItVnTInJEJu95kGh8h1IE/93byIkf?=
 =?us-ascii?q?n/LTjqTYh6/9Lew5gvpzeqSUIsU1D7JqBIxwT2pCS0iQhEoehFVCOLaU?=
 =?us-ascii?q?EIX9V6eV7W7vYOqWSJ+gJbogXLdTeB1yEqyA+Syx4yL284/uvy5K3hAv?=
 =?us-ascii?q?tAcnirBQ8jlbpRlEHEs6Xbng=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 14:16:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732540608; x=1733145408; i=markus.elfring@web.de;
	bh=uJAIw4NRLq8gPH2WGcZzJEEzWyzS+Ol80sO9ivIQoRw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fkpneGlJd9NTz80zcIeRxgFOvfnYfFEuVFmPYmk5fDwD3mv8C9uYZT1SIELdywpc
	 3FKMk2grGtAcejsZ3iPY2yqqxecAYnWfiE2GMEUi8veTxM7HYvg08Vj/ZsLLhiLSM
	 nKiWaufDddp1rBco0dvCA3aZSszyA+2D1zd9t75QPDUuCfKxlzsQW8Trv9PLw19ip
	 fRpk4cpubkJruWSdmYB+ObB0pKf8buzTW+fRamVXzZlimM2/Ax1pV1e/tY/uQNcuJ
	 rbUkWhQ6/KZabGBfBn5VsHF2T6caBtU9fJH0zybdG6ozCGu6xw+xueoY33zmRznwN
	 Cb4iCuegzl9qoUz7Eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1tG7Bi30Gw-0089pm for
 <cocci@inria.fr>; Mon, 25 Nov 2024 14:16:48 +0100
Message-ID: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
Date: Mon, 25 Nov 2024 14:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lqu8E2Fb2LpC62+gfzjzBaD+AnFtj6tk4ukeGEuz6PJkqV+NfC0
 c/zFYiDaUD86jsgVwMJh9yAmmGnP2GHxr1Qam9iqS79hYGWF11MmtkZBqonSo0ykeCCySQt
 xIdJj1KINy84263zPIw/SslchPWMX7jEQFBLM7vandSEmY4t9uvnWsYhSJYxm9les6xxsyQ
 wkK2sNd+CR8cVc0kYsu5g==
UI-OutboundReport: notjunk:1;M01:P0:TXqlUa7a71s=;6eCGvlydMaCCwKh2WqK+pCdVGOM
 kAt7u4mE6nFWJyF3s410vEVZtN82xaUvmrD6KWc5joEeRubJNUhabJRggQS66RN0uL+o2QFZV
 GR2jJtIndF2mHwWVQXY7FxAhlJ2j+9p9e55soeaXDEkcQQXk54cnmaEqdMOOZDhW8PsIZ2cg5
 rQ+JQ5Aku+0c1odsUROtVVjvf59kaSc2Oc+TGF3BpCVy5ZHDKyoVsKTaxGO88RRAwIc4i91r9
 igyjgshxo6cFBel33xJYS8BmBvh1/BxswFwa9BnhMk70lSVhztW5NJUh1dPm/stPCuAVGU75G
 N3VYJvIuVGYkBbDCOCTi4mxr0bmXT6aucYkXpQfMD+pMbbSFL18NK5mNC4+faT5rofyIAfbdM
 Cx775TwnmmHui6XXuk7pefaADpD9FerdxH9kIHBXP3BA63rCCx6UxocWteCwpkcElqli7smuu
 ELv5EplY9P21XMCHvJSavCDG3WXUifY8vYtftIBx4gRaXnqdNouDY8Er1wpIiNvDhw7l0nmXj
 ApadLvwYc+mZriDg7M8TrIm0fpNjGF0u5EApyPeLdGl04LZn7ZBay/cCFHCbuXfKhIe69bgtJ
 GJdpJqTXThaJJ4qgpFUnjV8ASshPoTHJWymbSEFKWXfJIjtCD2zmNK8BagLJ8mf+BsGTNy7YC
 Y3jOURzpOe4+LFcLCROqrD15ECiPEHlLu/bldFZkjtyW59U5MtTvcrHy9iIJKpBgsDwfgWFa0
 W1qlMOHQbEY8VAhF+XsvZJFYJSItFlEJudyUYgW7qjHDVJ+ysetf+/I8Ci3/pzvp0xMzKc9jR
 mGzY3J+ufNQRBhH3RKJ/vOZOWi7JtYyULrrx2ZXdLQ++bVN/cywU76CW0XItCx30+228ojDk1
 dqplwC3jEea36xq9pLfMJCrXP9uLMTUSd6qw8uxIuY3BDyvTelzVkP00d
Subject: [cocci] Reconsidering application of selected SmPL isomorphisms
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2097
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/434d257c-f0a5-483d-9fcb-3303301ad867%40web.de>

Hello,

I would like to clarify software development consequences also for
a simple script variant for the semantic patch language (like the followin=
g).


@show_questionable_checks@
expression e1, e2;
statement s1, s2;
@@
 if
 (
*!(e1 || e2)
 )
    s1
 else
    s2


Questionable test result:
Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/janitor=
> spatch --parse-cocci show_questionable_OR_checks2.cocci
=E2=80=A6
(

(

(
if (*!*(*e1 *|| *e2*))
|
if (*!*e1 *|| *e2)
)s1 else s2
|
=E2=80=A6


I would interpret such data display in the way that the isomorphism =E2=80=
=9Cparen=E2=80=9D
was applied here.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/04f71e76b0857ca12ec72=
07b26368df78d2b57d4/standard.iso#L389

I find the shown SmPL code transformation inappropriate at this place.
Would we like to apply De Morgan's laws instead?
https://en.wikipedia.org/wiki/De_Morgan%27s_laws

Would we like to reconsider the application of the isomorphism for the swi=
tching
of if/else branches accordingly?

Regards,
Markus
