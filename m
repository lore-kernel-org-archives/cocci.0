Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AEDC6FD1F
	for <cocci@archiver.kernel.org>; Fri, 29 Mar 2024 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=sBqJy0Hp4rfnrp4BnU5cNRWga1kLOi25N1s096uE/Qg=;
  b=mLppw9lIqKWh8/vXcY7Jlram6jdssxAPvHy01aBv+m8qctIGymA5lKWU
   tDlQIscj9BMn9c/qLYG5Z9Z8S38h+9NNeG+Ejfp5vAJ4cOBGv3Jr5UYtB
   aOzuEd8obsljbSqjgHOmEbvfDJWa9TZ4jCXyTTk8eZLQijq8Fh5Hr2Vig
   4=;
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
X-IronPort-AV: E=Sophos;i="6.07,164,1708383600"; 
   d="scan'208";a="159083305"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2024 10:46:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BFEA3E0AF6; Fri, 29 Mar 2024 10:46:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E7EC8E0131
	for <cocci@sympa.inria.fr>; Fri, 29 Mar 2024 10:45:59 +0100 (CET)
IronPort-SDR: 66068dd7_t2N4DPdxgmOLxrRSPB0VZwDEycF+bgO5eSKiraw1La1SYRv
 xQLuP9cq7F3OXZKD0qDBTFuAZiEBG8uDVeAHAyw==
X-IPAS-Result: =?us-ascii?q?A0HBBQDnjAZmhw4P49RagQmBT4I5f1MyBAtIgVACgwSPR?=
 =?us-ascii?q?YZggVWFY4dOiHCBVoFAPg8BAwENQQECBAEBAwQNjHoCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhUYnDYJgGIEOg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEXAkdrHQEBESc0AiYCcwEBgnyCKwEDMQexb?=
 =?us-ascii?q?oEygQGCCgEBBoJnrHUfLCJXgWEJgRouiA0aAQVliXEPgVVEgTwLh0CBBoMOg?=
 =?us-ascii?q?miGVxmKXgGUaIFSHAOBBWsbEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQ?=
 =?us-ascii?q?wZICwMCGgUDAwSBLgULGgIQLCgDAxJJAhAUAzgDAwYDCjEuT0EMUANkHzEJP?=
 =?us-ascii?q?AsEDBoCGxQNJCMCLD4DCQoQAhYDHRYEMhEJCyYDKgY5AhIMBgYGXCAWCQQjA?=
 =?us-ascii?q?wgEA1ADIHARAwQaBAsHdoM9BBNEAxCBMooWgz+CIoQ4CEOBCQNEHUACAQttP?=
 =?us-ascii?q?TUJCxsGIh6nHIMoBYEEkyE8shc0B4I2gWAFgVwMiHuWRgYTL5c2DgaSZphio?=
 =?us-ascii?q?zOFUIFkOoFcMxokgzZPAxkPjXgBQIQUon1CNTsCBwEKAQEDCYVGAQGDJjSBS?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
 DzdH0KxZly+
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nysqKqFV1RWJMZmypLqEBMeALOsnbusQ8zAXPiBKIiC9E/bo9f
 xG885w6faZslsssTQb9+xoW5PwIk80l6Qb3WB5B97LYOClggqVxepZjbcKtgeQfBEWgdQtsZ
 uIHZITNDSJNykese/KpDKjCt4lzZ2u+r2pg+C29QYKcShaL5p79g98B0KiDkFrSE1nCPMCZe
 Ghz/sCnCC4cXAbKv62HWYIRIH41qT2fYjdEGY7Li9i0hCHiT7t07LhDx2Ety1uKQ9y/Q==
X-Talos-CUID: =?us-ascii?q?9a23=3Au2uQuWp5PUACG/TuWm0y4nnmUfkGfHra7GvBH26?=
 =?us-ascii?q?pBFloTe3MaFuowbwxxg=3D=3D?=
X-Talos-MUID: 9a23:DULxZwrznO7RWv7kbGQezxV7O/pt04GJMWYukaQniYqPaQwgYR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,164,1708383600"; 
   d="scan'208";a="159083272"
X-MGA-submission: =?us-ascii?q?MDHdQox8Q8+hpIZOKe7nWV42L7tNCFHjFBBOMB?=
 =?us-ascii?q?YUilud+rDdV10FfTYPTwB3vHqeVuE3jlKnhulexaGR+lmJjtNmqAjbCw?=
 =?us-ascii?q?HBEhIt/ILSWvuOACndS4sUeNQV+pqVpbPg0zZS8Z5masx0+RzkuqEKuU?=
 =?us-ascii?q?paM+HHntf/xGvna4WFaWYt7g=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:45:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711705558; x=1712310358; i=markus.elfring@web.de;
	bh=sBqJy0Hp4rfnrp4BnU5cNRWga1kLOi25N1s096uE/Qg=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=vwncutGlF0Qm4paekRb3nUqDd4VbdqwPR1aGkorrAvkksF3/3jFxiJ2jmt5bh2NO
	 AIjVZa9sjdaUafnw0bd23W6VCW5jRSq2fRn/Qck7so94P/UH98b6pFG0/NxyqMyRp
	 JtZK+MSYBoh5Se+VVgpYIBV06vxEDi/rX1ZFFOjStyMUe0UTrO9hWdeuIhM9lVaCs
	 lPkWbofS3S9afXrVPik4lkVivs9JyC4OfTLsQC2stiQBu49xWUratg19ti1iZC2lJ
	 l6odN4OPLh5pyfOn3rL+fBjyCGOY8MqcwZKf/XeEIIOQeGYT6K3uLuV0+4kQGhSSC
	 hQ+5ZKrYH4RMs2kevQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m9H-1rprpF3Fel-009LRp for
 <cocci@inria.fr>; Fri, 29 Mar 2024 10:45:58 +0100
Message-ID: <88ed7db9-4163-4916-a0d1-efcc35030fca@web.de>
Date: Fri, 29 Mar 2024 10:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7D07uoZ1pCtVybrSWr+c5B4R8nmbdTz4mZsy8duk9gn8lglsHUy
 dV42I4siWnElOJfxzSEYFURENd2D83d35smCinFbwhzIJ8pmEPW9JPCNHfiDmeyGat795qE
 KqMbgeg8+zdrbVBJyFfd22qELu6hhM8rjGI54TtPBau3QoFMaXtO5FxQRuNdvOwm0lyJ1pF
 DT9zJWy25sa+Toqi9Kucg==
UI-OutboundReport: notjunk:1;M01:P0:ldDWq3IY9ZA=;v8P1OH6r5ELyvQK5sbOLoe5LG3L
 TGICUQTcx0eq51WsR93fXLBpLLfPzjHueEyl6330YbtmXou2/KG63tNSJDWuOuOR8oklR7ItF
 IO1ZviI9Dzt0Wd29zcqW6Fx+lqk40SgAELEXlQYzww44ZFIasaUsDVsCH9YnYWY4phl9z4N+f
 IRDGJEzRdRv7C1AYYZ7ydLd8tz8eUB5SFz6kS9JEFGh0fw49Rii6xeqH0mSFKMZJ2e4SojTxL
 uMc9jgMsfkhIPr9CseonJEEJtO0MnSSZ7EuhVD2CHE160/KWBG1q+7kEFGK34aWA5Wqmd0nXh
 9Bvd9wo+JQp/cgbNgoUjQ2UP8JHVqTaKR4cIbtaq0cJaqBUxUL6yEErJikYxQfXVqhE2PoLmQ
 n7OWYbg6zraOxhSEISBpcgggQ7x6qQ9hGUa7QS2mQFqn2DzzpbWUtGLYPG81Ds5ZdoQF+29Hp
 9PnO3PByD+B81T3BkvmInlSnE5hBARd0jwmlNHzWHUYzCSh/Ngg3mRJjtR4pY8LtoUdQf5itm
 NTpuRa4OQ7YaZy2s37FSFxH6kTFT5Ck94BOw+CKxdLZZF2CLZPBOtFyQgyHAEQKXPAsVOTcHJ
 I1Ue43j/gEV4YAgXx+oS2Q6KRcKUSxdXxIovV4sc3qte2Q5bUTFlrfp6jz4d7zqk7flE9eqAM
 IeT5IP1Phe/4mQpxKwsUBz4dHnRa37+47yzuS8fXNPftAG4MBQFE1NJ/hYiJ8o8k1fzlAsi0S
 lcRlQGDMfxKmlRixQLE0aEwHrLzU2sLcaBegC/8o7v7n3LkykSqFcnGOjrYGCsDjzZSx/QI82
 hzOrvGbFA+4Qpt6ewN+Ns+Z/Kwrmr0JSSNHErKkyznrbE=
Subject: [cocci] Further adjustments for pretty-printing (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1633
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/88ed7db9-4163-4916-a0d1-efcc35030fca%40web.de>

Hello,

I tend to prefer script variants for the semantic patch language
which specify only required changes.
Thus I would like to avoid SmPL code which expresses the deletion of addit=
ional
source code so that it can be readded almost at the same place.

This desire can occasionally trigger a questionable =E2=80=9Cside effect=
=E2=80=9D.
The adjusted source code became intentionally shorter.
But the affected code might still be distributed over multiple lines
like it can often happen with argument lists for function (or macro) calls=
.
I noticed then that pretty-printing concerns can become more relevant.

* Reduction of indentation

* Reconsideration for the layout of involved parameter (or expression) lis=
ts


How will corresponding improvement possibilities evolve?

Regards,
Markus
