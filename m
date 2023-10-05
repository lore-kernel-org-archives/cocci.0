Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE0AE93703
	for <cocci@archiver.kernel.org>; Thu,  5 Oct 2023 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1GyRQJ19JGF83Nl2sSBnUN3kLMI/lZa+dub2avWCtG4=;
  b=vGGMTkJSCjYQiQgMgEoIIJz09RZictz07pIqSHJxu6WRvdH0GUmbjW1r
   fheJWabDaeg2Lw6JmRvfstCUS/Dp0HEBPG8g43yAkMPemBdr0ksklFQeY
   QrbQfxsKcN1NMBO26uR2zggxsTGfnudD8yk+aTBu8BTfrTeNpdWcLG3wG
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129639065"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2023 12:46:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02666E00B7; Thu,  5 Oct 2023 12:46:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D12CE00B7
	for <cocci@sympa.inria.fr>; Thu,  5 Oct 2023 12:46:30 +0200 (CEST)
IronPort-SDR: 651e9404_+5S0ZY8Q+stqx8cm6ralyUSMf7NpzzWiikbJz7mfEIa1tQJ
 g8pz+YYg9wPEtysJmIO3O0QhfaMHkTyGJpH0X7g==
X-IPAS-Result: =?us-ascii?q?A0GSBQANkx5l/wsR49RaHgEBCxIMQIFEC4I3B3ZTMAQLS?=
 =?us-ascii?q?IRTjzyBdjBVg2aHM4dJiG6BVoFAPg8BAwENQQECBAEBAwSFAAKHDAIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGCAuFLzkNgjcrA?=
 =?us-ascii?q?RGBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEEASMdAQERJw8LGgImAgJXB?=
 =?us-ascii?q?gEUAQGCeoIqAQMOIwexG4EygQGCCQEBBq9UHywiVYFfCYEaLogKAYQ0gR2EN?=
 =?us-ascii?q?ScPgVVEgTyDBD6EQ4NbgkYihAWWKmEREwVCcBsDBwOBAxArBwQvGwcGCRYYF?=
 =?us-ascii?q?SUGUQQtJAkTEj4EgWeBUQqBBj8PDhGCQys2NhlLglsJFQw1ORR2ECsEFBeBF?=
 =?us-ascii?q?ARqHxUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNHBksLAwIcBQMDBIE4B?=
 =?us-ascii?q?Q8eAhAaBg4pAwMZTQIQFAM7AwMGAwsxAzBXSwxZBGgEDgMZKx1AAgELbT01C?=
 =?us-ascii?q?QsbBj4CJ5xqgmCBFoJoxFI0B4IxgV6BXwyfIgYTL4NuAZMrDgaRKIEPmDcgq?=
 =?us-ascii?q?CuBagI0gVkzGiSDNlILDg+OIIQrj0g/NTsCBwEKAQEDCYVGAQGDWoIoAQE?=
IronPort-PHdr: A9a23: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
 JdcEtdm
IronPort-Data: A9a23:xTik1qx0vj64spE/YC96t+cYxyrEfRIJ4+MujC+fZmUNrF6WrkUCn
 WRJD2jUOf/eZWenc992b9/g/RwG6p+HydAyTVQ6rlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjg2Uc3l48sfrZ80o35Kmq4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPP3dw3Nh1mAbEn3cYsAz0Ur
 8wDLT0kO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyVo4YBtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QC+QzO9PJpuwA/yiR2jej/avqOWOaSVN4Ijlufm
 07ho0DAV0Ry2Nu3jGDtHmiXruvGgir/XKoAFbiy7PcsgVuJx2VVBgd+fVC8qvK4olWvXspWb
 U0S4Csn66YonHFHVfH4WACk5mGJtFgQVrK8DtEH1e1E8YKMiy7xO4TOZmQphHEO7afamRRCO
 p61c9LV6fhHtbqIVTSC+73SoT7a1e3564MdTXdscOfHy4CLTEIPYtbnUdtpVqK45jEwMS+l2
 CiE9UDSmJ1K5fPmFMyHEZTvnD+m4JTEJuLwCsM7QUr9hj5EiEWZi0BEJLQVATus7GpUc7VZg
 EU5pg==
IronPort-HdrOrdr: A9a23:jL+ITaopk62tW7HBnCHTuYcaV5r1eYIsimQD101hICG9Afbo9P
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AJwfOmGkT94aZdbsnXYo3NvTtU2/XOV7D5S7qfx+?=
 =?us-ascii?q?ENVlOaOaXFQXKyLhhnuM7zg=3D=3D?=
X-Talos-MUID: 9a23:Jb/W3ArSARbAazupRwAezzY/ZNUyw/+MMlgcisgWps65GQssHw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129639060"
X-MGA-submission: =?us-ascii?q?MDEQGt+JhUHuQI89H9r0kmASL2jZXEIGGycEEu?=
 =?us-ascii?q?wOul07kyf04Js6y/as9kZWihqOcJfNC8G/eovNU+NfheSRnQsLZyL3+r?=
 =?us-ascii?q?tDGsyvf9jMogSOSVgYOeNwCdxZEqn8uRt9tVazHFJB3+jEFMRd81dcth?=
 =?us-ascii?q?GTCUl1dtkehWK07nDhZ1It1Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:46:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696502777; x=1697107577; i=markus.elfring@web.de;
 bh=1GyRQJ19JGF83Nl2sSBnUN3kLMI/lZa+dub2avWCtG4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=cyk5cu3KlYFqk+Vd2d/jgbWYYer6hjKL4YaZziZu6a6lHP1xRkJabYxwf8ltEv7cx52leKaZ+fA
 3nOtx0VgeW7wcKy7jEfwgI//9DSGKGsG0Wqrjncdkojn76t22tUAGfrFeKkQubKzyzlf94Xm/koux
 lqYyYmMhf67Vt58w4sP7u2wlp+HCcdrMoHoRGJiNgO6Q7vS7PQK3+y8NMhVzBlbEow/Yh2YhkZwwS
 XMYtRvaQAGUYeVUYVBhrJPrwXRVFnYHcdo6LPHYSCxFPyyYMQk3IHj7ZnDoN8kGuJZU8cNrLMcFnA
 E9vvp/QobJxACe3JBQ74iLhvDrp6GpYZUdzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1qjw1B2GSO-004it8; Thu, 05
 Oct 2023 12:46:17 +0200
Message-ID: <f2560e5c-63d7-403a-bac4-e05be2ccf479@web.de>
Date: Thu, 5 Oct 2023 12:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d71be555-d569-4ccd-9f06-4b33d8095e6f@web.de>
 <alpine.DEB.2.22.394.2310051159410.3375@hadrien>
 <29542ba7-5d13-4089-abc3-5ab314af4fc6@web.de>
 <alpine.DEB.2.22.394.2310051222530.3375@hadrien>
 <0d4309f1-9b52-47ab-bae1-e19be92346eb@web.de>
 <alpine.DEB.2.22.394.2310051242370.3375@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2310051242370.3375@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+E3Kl+W8sX50/RIMRZGO1aG858OwCTzesBxz5qOo4zRUCixH22J
 /u9Rbcru9Xnmeei76+a8b23ihJhsr9lYwcZhQnTZF6f7aePpYGW+XvAuNjSI1Ee/GmRFnKj
 PExOGPQs6t3qI33b+Aj02HuWqCMuwGRkR6vIYaJ9hvyd8RBzJw6rmJs4vC92L8pP0tJ1hYu
 pS99akGgz+QMZXWj50eQQ==
UI-OutboundReport: notjunk:1;M01:P0:kHKiahO+0cw=;tcNP4sV6D0+meDDRBIJAjwAsROv
 9/hpSjQBOcYaYrwd4CLu53kCFXCFJ5Li3GPvFkb+/PJoQImSDXH2EWu7sB5G9sCNFt1Nh1v1Q
 /hrMEJ7WbvKr2vr/nKXEkx3OfjVgkGG86na9vK1Z5fKLtcwJdRTkHNCz9zNhjXMsCwT3KM+Ca
 k7xlak9dNIwUe66rANZrg1iJTiXy8pPVWHNjXt5nGVcbsDQk7Z+OpBBAi2qUYYVIo5twf1FLg
 /TOiBFiN3CrNumZR0xRklXk8Jf3iQxLvZFBuQ71//v7dNnT+/AeFZLIIDkFaMUY/6eRZu4nPg
 pJhfblHsD5UcuOhxiFwoKCnVaZzjA8ZrAFYSh4+etlWEX81U55tfy9AYhUPDcYiIdxjjEcgOJ
 n5vOyHmnd0UMyher7fAdSOsT/BUlhmBMYiUdhiu/VqGrh9+FOCZWxQIUpezgsQ0eUNME8QwtR
 cRmHGoV+m98fU7pbqCBbP13vQzk0WnqCcFfudRtCbJWTTDU6h69GfO3yPR05h1/2PwMUTCCKv
 lrEY5vQctr0bMjMlCMqtm+abncftJ166eSlOXQ4uIi7bg/5SeK4HJkDvqG307qC7e6dcHs8ki
 6rE8qDxus7w1AQ5nUX3udXM6dWQCvvdbhdk89QhF2OWqq07LwB1OE4ELl7wpL+ZKnNf5q+wjD
 S6kxjwZb4rssu5AxwPn+O2IipS5OeiDCSV2Vra8eb6aBTuUpnEhF0dCimm0AbVVNcE5QNvKPr
 HGh4uEdrmOja+NA7ZrhNMd1NKwD4F6F+hqt0NcOfZSdfdjmE+VoySYlfmClonq9EDne7A519v
 05ZtHLDmlUEVbTdoaKlCSad4A9Kzx+G8Po/ORCZLIguNh1xWpG5y3wIt+IXGhYm/Bj80aIAAi
 /yyj+wF7jP3SkdiHcFEPCFpXIw4DF22Qm06BYQj/2/CdeWDLEtO1XjR+rMTnNxn5gZiH5eWif
 2Kpy2Q==
Subject: Re: [cocci] Searching for variable definitions in C++ source files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1250
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/f2560e5c-63d7-403a-bac4-e05be2ccf479%40web.de>

>> Can source code like =E2=80=9CRPC rpc(this);=E2=80=9D be interpreted in=
 the way
>> that a macro call would be applied there?
>
> It is indeed a parser conflict with function calls.

Will the chances grow to support such an use case better?

Regards,
Markus
