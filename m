Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE9EC48297
	for <cocci@archiver.kernel.org>; Tue,  6 Feb 2024 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=hIVGmn5TOf3fUrvhnWrH5awdxvZ+HCJdcbpnpS3g87c=;
  b=bOrydq10qrkU7BBEGjv5sHlNb9VjMh/lQ74VK6iycFvWyiyNybBM4Nzz
   Rp9yN5y6CwgU7ZyQjdadUku6BQPZAlCS1JMq6raQHdDS6a9+XKInJjigd
   5K7I4iZKL+TfFiGwvVxvFCad0nEwoAmdv6i1gviDrlFbkJH5usYVH3gM/
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150616795"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2024 19:00:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1AFE7E0CD7; Tue,  6 Feb 2024 19:00:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A7928E008A
	for <cocci@sympa.inria.fr>; Tue,  6 Feb 2024 19:00:34 +0100 (CET)
IronPort-SDR: 65c273c2_WFFh01n5pGCFLDEuuue5DDezSEIwoczT7aKn56CioNph8uA
 yN3b+enuEJFMX8UOLilirPHh925YFrtWG6Tchkw==
X-IPAS-Result: =?us-ascii?q?A0FdBADQcsJlhw4P49RagQmBT4I5fFYyBAtIgU+DBINPh?=
 =?us-ascii?q?TaGQIF1LYQ+gVWWIIFWFIEsFigPAQMBDT0EAQIEAQEDAQMNgX6CLogfAh4HA?=
 =?us-ascii?q?QQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ?=
 =?us-ascii?q?4VsDYJVGCJqgR0BAQEBAQEBAQEBAQEBAQEBAQEBFwINMAprHQEBESc0AhEVA?=
 =?us-ascii?q?nMBAYJ8AYIqAQMxBw0Gt3GBMoEBggoBAQaBB0YBDA99rHQfLCJWgWEDBoEaL?=
 =?us-ascii?q?ogMGgEFZYlmD4FVRIE8C4YXAgGBGIEGDoMOgmiCGYM8gSiIPYJEAYovgVMdA?=
 =?us-ascii?q?4EGbRsQHjcREAUODQMIbh0CMToDBQMEMgoSDAsfBVUDQAZJCwMCGgUDAwSBM?=
 =?us-ascii?q?AUNGgIQLCYDAxJJAhAUAzgDAwYDCjEwVUEMUANnHxgaCTwPDBoCGxsNJyMCL?=
 =?us-ascii?q?EADERACFgMdFgQ2EQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEAyspAyF0EQMEC?=
 =?us-ascii?q?gMUBwsHeINHBBNEAxCBNIdWAxkrHUACAQttPTUJCxsGIh4CnD0CAYFUcoE5A?=
 =?us-ascii?q?iINVlpAEgyTIIMCjWuhFjQHgjSBYAWBXAyId4EjlR0GEy+XLQ4Gkl6YVo1ul?=
 =?us-ascii?q?TqBF4Q1gWoMJ4FcMxokgzZPAxkPjjkfg0Izj0dCNTsCBwsBAQMJhUYBAYNag?=
 =?us-ascii?q?UYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Y56ltaPNQ+YgM8BcTuOjsMiBIKoaSvp037BZ7TETdfUzSL3+qy
 nOpoV+6faQsl0ssR4b9uxoVJPwI080lqQa3WByB9uftWDd0QPEEGgI1/qG/9SPIU3D39J8kY
 F9bqN5FNr8NlRii93miTPIa+rIjOPnzEiy792uqUuFoDsaEp2JZGpCYDqmLg==
X-Talos-CUID: =?us-ascii?q?9a23=3AXC1kk2oorfxTe4kJr8qgSDbmUeIGMXzX7HrtGXO?=
 =?us-ascii?q?5MWxXbvrSYm2x+Joxxg=3D=3D?=
X-Talos-MUID: 9a23:XXFjhAt/wjt7QQQgz82ngTh9Cpwr362VC00QvM4C4/ihaChaEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150616779"
X-MGA-submission: =?us-ascii?q?MDGdpEGnGDXfbIDA4cfqQvVIi0EJOHyGJPsjda?=
 =?us-ascii?q?Oc/jwtQqPenotChojfiMeFD4CcMUt7aFfG6f51LwTYtBIQcB9JZ72RVB?=
 =?us-ascii?q?0J0HStTVdfz0KrDUs0N9m76KCExNcf44T9vKfUQNCjju39Ikgo+HvDWh?=
 =?us-ascii?q?dX0GY60Qv8/MIlcI4yxlKoLQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:00:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707242433; x=1707847233; i=markus.elfring@web.de;
	bh=ti6LQOoBZ7sbiGT/jNR+utx7PAG64DC97amOLCskqFQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=JmptA6Sc0r3LCiXvoQJp8xht+njrheaNwpBhW0Y7ynPJX7UFwuXfTkOvvaEJWjsZ
	 eY7cC9F6d0913Tn8WoQOh/Acq06B8+bEgWUKf6ac1m8cG23Es9AxC4DzUtdL3XMtI
	 KShBM93UE0+tJf26umQk5wFRsbKv4tNi4gCkhigUDR2d1VV0NiFNVK4vMj6gxibex
	 raDIpXjDCSaJneljSYymmfHctw86zQQFK7L8q4UM0MmI3pIC/V+IjAobf3pNIh7+q
	 esIwpIfCFRtGgacSHtY7C3jRsCvh9L0urJFQclDkoGXWthdeUVbq/oxEe3YDMGR1l
	 SoDcCdGra6864XG6hQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDv9M-1rhHeP26s8-00AD3o for
 <cocci@inria.fr>; Tue, 06 Feb 2024 19:00:33 +0100
Message-ID: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
Date: Tue, 6 Feb 2024 19:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qstcB1DUowauOF+W7AWtd+VI4m51IZjn37xyP5aRQUT0T5wvrFU
 sjuOeWuQFKQkIgbK0cUmBjuuqYcAB9iljbqBbQ4kBpKlWW5IVYi0ji+aWoSstiY6dm3aErA
 UkVa7NFjK4eLIXexst/SPNzkVANf/v058++F7E+3KnexJFNWR9pSifGVp7+UbhOZnFMOwSn
 B205687Dp2ZoCEedHWyFw==
UI-OutboundReport: notjunk:1;M01:P0:RGd0KtaaGeM=;NGQqBdfVFrbnPBht3D5Mevg6pvH
 r4iwoaFMoNjYAnPten/hv589UU+/HTKXV7eILNdWWtX5Ts8v8QaSvgy21fPFkYaI+AOaAzgiN
 WZ2iKvKyIX4C9MNJ51knJTsCym8U2EEWl9HVIDR9374VhgiyDD4ZWe8MXMd+YjS/fjIyPRAMR
 BVqRy5FkZYFGUFL6wVPWn4xM4hQzYtwE5/+Uq2fp1Uo8J0zOsCqEYRnQjELIQvAV+MiFhPwcH
 13d6/8jF7FgEopVXkDgHayKbvuUxqptT2yU15IgnAkfH05O8egDkT7teA2TKTA0Ah9t8mxOtn
 gkYP+QW0jzgM2c3ZlVO036l6z49v3bIbRpZuEFOIkBK3kXkS9lklI9w2EfFW6MQ+q9pORFM/d
 Ny3sprnnJSdJuPjo3oJASXxzJ8snD9JhiyaXrkxMUG34XqkXDo6aL3VICKiVJ6421bPceUGBB
 CNW5kQTy+NTkoYyykCisFGYqsllU11gdhTq4yy13mN7E2Zis6yKXd/0Ps8zHvL9/Lue3s7LbT
 J1C3oxPyDXSVMhUL+91khyNpPRvKy00Lo3zBFjm4CUeMVcMpIysXE/+vwitvRDg9hr860M+o9
 nzp66WHbkMOJFGGjEb8RgtYf88IYeQqwCRYCtOS57OUlHjRWuJPuBA6AqxNQ94hSi2KaJTVhy
 Lj+y41iJq7Ld8rF4ATglXKeceQYtvAMLhSqlPw7LckXTGipV/9EFhsn+/WGgOHL6lA3zhiJWC
 ozH3nrEuEkajIJPw/D8nhqS11X+jWe1y6kmWNTlSO82LohbHGSqx+injWdBvYtn6PZv8aEkMB
 RfE82uf90cxHJcOJpUWj0f4BoFCQCeI7itYKPzfMIjbWY=
Subject: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1508
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/41052adc-2065-4cf2-9160-2e986de1bf9b%40web.de>

Hello,

One kind of collateral evolution is well-known:
The number of function call parameters can occasionally be reduced.
https://refactoring.com/catalog/changeFunctionDeclaration.html
https://softwareengineering.stackexchange.com/questions/331803/techniques-for-minimising-number-of-function-arguments

Corresponding change possibilities can depend then on the detail
if references to previous data items would occur in subsequent control flow
(or not).
I got the impression that the data processing with the semantic patch language
has got special algorithmic properties.

1. Something needs to be searched in the source code.

2. It should be determined if further variables are used
   behind a selected source code position.

3. The desired transformation can hopefully be performed
   after a precondition was checked.


Thus I imagine that it would be nice to take additional techniques better
into account for the avoidance of duplicate data processing.


I hope that topics (like the following) can influence the situation accordingly.

* Support source code scopes
  2023-10-23
  https://github.com/coccinelle/coccinelle/issues/322

* Support additional code path information
  2020-12-04
  https://github.com/coccinelle/coccinelle/issues/238

* Support for SmPL rule groups
  2019-04-07
  https://github.com/coccinelle/coccinelle/issues/164

* Determination for the number of named function parameters with SmPL
  2016-01-07
  https://github.com/coccinelle/coccinelle/issues/56


Regards,
Markus
