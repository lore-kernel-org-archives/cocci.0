Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29E0C02198
	for <cocci@archiver.kernel.org>; Sun, 16 Feb 2025 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YUOrNjyCUxCYSr3CqmNW6o7ayhOQc/m+u9OcswWgsjs=;
  b=Q2/qvD8chm97Snrs+Co1fHcVPqAgnU2Iz47Td8Br4uKSZZOFP+QOWli2
   IT0NkfHtqlBd0D+Y+IRYt2i3/PAbeHQMhkS7U4CZtuK6b4JEJwgAHHAJ7
   t5gK0nMHJ2zyTBg1rx3l/hLvbyREWpQCewWkqicOHmbmdMM+WOoTcXdVw
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,290,1732575600"; 
   d="scan'208";a="208483312"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2025 10:10:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA18DE0D1D; Sun, 16 Feb 2025 10:10:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E040AE0260
	for <cocci@sympa.inria.fr>; Sun, 16 Feb 2025 10:10:07 +0100 (CET)
IronPort-SDR: 67b1ab6f_1WJz816bd+1Mu4LkuK52GrY30c+mzx9FUrN8FoIXjcnQIb9
 vfJMKj8+e4LWdnCLQlrM+/Osn/FP9/5KFFwu3yw==
X-IPAS-Result: =?us-ascii?q?A0FnFAD7qbFngA4P49RaHgEBCxIMQIQXYnUzBAtIhFaPT?=
 =?us-ascii?q?4F0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEhQACiwsCHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn6CMAEDD?=
 =?us-ascii?q?iMHrwWBMoEBggwBAQbaXB8sIleBZQmBGi6FbIJjAYYmCYQzJw+BVUSBPIJSM?=
 =?us-ascii?q?T6EQ4NbgmmCM4RHZ4lniGqHe4sEUnscA1ksAVUTFwsHBYEpSAMqNDEjgSMFN?=
 =?us-ascii?q?EE6gg1pSToCDQI1gh4kWIIragQFgS2COoRDhEuFWoISgV0DAyIBgjFweByDH?=
 =?us-ascii?q?jWBOYEZHUACAQttPTcJCxsGPaAuzj40B4I4gWaBYwyfXQYTL4NwAZNSDgaSe?=
 =?us-ascii?q?4hDkDoiqQyBfiOBXDMaJIM2TwMZD44hhC3GGUI1PAIHAQoBAQMJhUYBAYp4g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:TBO37aPD39fwOsBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:BE/9yW+cRhG5sN4CRASVv340A58vTSTn8HTzOW+SBj1Eeb26UXbFrQ==
X-Talos-MUID: 9a23:84HydgiKlfRnn78EiT+ArsMpEtpF8aajWF8xm5g7kfuebixhBCyRtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,290,1732575600"; 
   d="scan'208";a="208483304"
X-MGA-submission: =?us-ascii?q?MDG/1TbnNWXxPGgMPwtnP0Vicu6zFIhKud1uCI?=
 =?us-ascii?q?QaGm+HRkZfmSNv0CtRRks3RchyDISEUFCa/Mfdj6CQ/b4SePY/DdNeSz?=
 =?us-ascii?q?PVj5DW6Md+DF0pAoppI0quBp9tVCB5A9FUsxZKv301uew6rdjXCui7xH?=
 =?us-ascii?q?/u+UlcjdKvoySwDxvFtPm27A=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 10:10:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739697006; x=1740301806; i=markus.elfring@web.de;
	bh=YUOrNjyCUxCYSr3CqmNW6o7ayhOQc/m+u9OcswWgsjs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SgRX0QuovbjPeAwboj0/usJ/oXejUPCqYN8ygbEPfe2nCl8oAPSnqcgssAiNTPwJ
	 Vxuvabhj5D4TR+ki7bgkxEwqM807wwXxJUOAz8ggVhIh66W+slh/MBjA/DOvabmTz
	 v+bKuZj7GWp/94k3R/QeZbQtr73v9s1HbNcxAcEgX+wbBl9eOIi0xMrD3OGG9k+T7
	 1OIml87cb5ZL8Y/hGJCpz4HXIttzy+AiFmelyZm7fxj6dNcflJZv5Sz+qQfSZcL9+
	 lv50wOjZaW9HpqxXOdjd3+2+avSgtkrISienEpyLEeb1DqkcWExYl75feKd848y13
	 nJfaK0YxE+iHLcFdxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1tFXDP3Qhx-010dD2; Sun, 16
 Feb 2025 10:10:06 +0100
Message-ID: <bce1a2d0-7e0a-4f7f-8c2c-1c55b2ea3ade@web.de>
Date: Sun, 16 Feb 2025 10:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
 <alpine.DEB.2.22.394.2502152014120.17391@hadrien>
 <4c36f3b9-734b-4db9-9f12-0f433e452038@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4c36f3b9-734b-4db9-9f12-0f433e452038@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xMQFE1x4V33tT+5ulSVBVuvbNNiCOfg0Tw6vA71Bgd+Q9i+IdEr
 updJPRizrI86/k7DxNciscMGWM0Utb0OC9pzDSXy+C8pxjR1STUqbSWxnZqoCJGPjL6UuQv
 Zr+BlFZIrp4Gmnh6ztdp5XUrBQLEJUD4VNiIVKu3RBVn8VtRVcrvleRDOV8rInl8vDdST4+
 /AAt3lS7+dXFE27Eroh0A==
UI-OutboundReport: notjunk:1;M01:P0:P5ah+AQrvq4=;vmEE7F2WgXPiu7LNVYL9WvEDOnS
 ZQrZp+hmfsJ05wXYHieNrEuNMyKCUg72m2VYxZ7dc0e3hL08dxoir1aUGCnU/8YihbhPpoZ1e
 NGVr+L8oaVpl9MXiJm0iXZLtgrkIGx0KoP5SRQh2faed9sH8aojLafp3fEowvZSHMgrN17s7s
 aft5sLP5rmL9sRMRDArP9+C6OD+AThKEvmncSgts/4Cjeia1I9FCkPaGt+TB53O6T7n6MwE9g
 yU3RPeUjDNaO4P14QCtJ9vUrbfODrslF/qoTL7JJM0hRx19cJkg9Sc4WZInL/3jyKpY5ULVqs
 4rsENdct94xTAm8+8tuavia+MM68WF85jGcdmey4+WBqUrrrFRwlwnshO9tRmT6XmXfVKf/FV
 SJ7degnFZpEMSbOGdgJT08wHR27LM16e5hfstNSOcPF4IjZwYZ7Bxk0J+FeKlkb3zUJgMwvPW
 P9IZtU6NxGb3uzPAdtg8Gt/gCDf5+mWwrGAqujzCjbZMn0hHfB4FeAAJLK52s9BbzE9mPDfmk
 O+5BYqyMmS/c5lF47irAYYRzDN3aZ2vClgX5WXzlyhK/FWnoQFOXWU/Erwd40wfO9AUMU09k8
 PKU5SKfqNsMjEEyfaN+L5a322EALEHZ7a/Ul6zdV0JnwZatrQcnPq4I8RiJbuE2SlqXZfttYn
 jO4T9Gi15QdhBsF4+glKmmtZyg29FA75UcrAbcLh/X1eG3ahERBVpWnS38ahQwVIXAuDyF4k4
 RImh8hugrK7Tt3ACar8ibKonwu3OOTJFmUXPRmX4/Wkjt2M35hkhufk0UsdvdEK+yTIF/i1K1
 vngltJMd0fd9kWTfKzX7zHd8JHZREbnNESxbpW0w5oJKl8MMyGCdLTtEBi9FdodcrDbe5/bbg
 NGKJNrGuBHQhgVavVUI5+ubVjJDaYKezamzRH2+5lhUY1ZDe9OgEvYCoJruPLiCA/+h61hPBJ
 /26wmAKyj68i4WAlbCx2EAqGgvsQbOjmVpDpBDAkicJDAc90nzf8CJoR4H/7nJubrCFnCnR9f
 xkh0M/rV8+C8EwGT8ZKMKChRfKdT55Mq4yiXmcwSXt6Ov9npZ8Z/ErNjU6i4A1CfXCiCJDYf1
 VsHUyG8A4vd+95K+ubuleEYwsDfIroBiNBiRumTe+CYz+w9KzohtAK5gaiYIMUSMCNVPQvDzL
 t9yg97BoZg0bF67uyq4a+RSmxpovlfaJ1tW41K9y0DFAeYEv1vlO8Wm+7ukUqXWldI4onH0z+
 bsoM8XrGlNveHnP4GJnQmkkE9FqnJsZrpebi+U5FsIFR/YTeyturyh3z9DDTH7LoSk1G02tjI
 8XW4yrOnufxzKPulNXtblbJ3eVFBMy9QAKEg941iQ3hqLfTFYipGPxOKAIcxx4pHUoDEmsqEl
 udguz5huMyQwUiPhvcnyr7K80vOWsGVeHi8lZ2PdStSBsmNcwsoqaGGx/zNAjjjOoCyRwv8fT
 bUtLOXA==
Subject: Re: [cocci] Adding statement after declarations with zero-length
 match after
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2422
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/bce1a2d0-7e0a-4f7f-8c2c-1c55b2ea3ade%40web.de>

> Splitting the rules worked and does what I expect:

Interesting =E2=80=A6


=E2=80=A6
>     @depends on patch exists@=E2=80=A6

I suggest to reconsider the need for such SmPL dependency specifications o=
nce more.

Regards,
Markus
