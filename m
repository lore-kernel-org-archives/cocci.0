Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF74C77B61
	for <cocci@archiver.kernel.org>; Mon, 10 Apr 2023 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9okWueemfN+9ByPuGDoT5XdPjhe2CYYzp0u74tPwrWA=;
  b=fFcTIvsZxtc1alsWqotFWGIXS000C5J3s4965HEFGn3+stNNU0qP9JGA
   ZrPua1Z8YOeVxiugf24YaYQXd5YWLVuYHtaIm/5urg1qEWM9jmbCHOSv+
   WZuPdFAVQ1rhdp4qMqF7+3wS5OGrWFog3vkOJ3oJF5MdbXToo1rEvyqms
   w=;
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
X-IronPort-AV: E=Sophos;i="5.98,333,1673910000"; 
   d="scan'208";a="102272632"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2023 14:48:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1FDF0E7315; Mon, 10 Apr 2023 14:48:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CF0BEE72F8
	for <cocci@sympa.inria.fr>; Mon, 10 Apr 2023 14:48:50 +0200 (CEST)
IronPort-SDR: 643405b2_KmVIz7yfryZ5bT7htXNuhzDf7CG3fKZyqxhuLuevpB1Nji1
 zjHl/1A+qMYigyWGTuJUsLvQ5wDVyJ4G6efmhEA==
X-IPAS-Result: =?us-ascii?q?A0FFAAAJBTRkhwwR49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YItgUsvBAtGhFORMIQwhy6HPohrgVaBQD4PAQMBDUEBAgQBAQMEgguCdAKFP?=
 =?us-ascii?q?QIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEaC?=
 =?us-ascii?q?RcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkc+A?=
 =?us-ascii?q?QICASMdAQERJwQLCxoCJgICVwYBDAgBAYJ6gigBAw4jB6s/gTKBAYIIAQEGn?=
 =?us-ascii?q?AsfLCJUgV4JgRQtAY0JhDAnD4FVRIE8glMwPoREg1uCZ45hi02BNHSBIA6BP?=
 =?us-ascii?q?IEEAgkCEWuBEAhqgXlAAg1jCw5vgUljTIF7BAIULSUEDgMZKx1AAgELdT81B?=
 =?us-ascii?q?gMLHwZYawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPBiZEDkI3MxMGgQYLDhEDU?=
 =?us-ascii?q?IFHBC9cfAoGS51ohF3DTzQHgiqBVoFZDJ8NBhMvlwkOBpIll3MgohKFbYFlA?=
 =?us-ascii?q?TeBXDMaJIM2TwMZD44gGR6Dbo9IPzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 JdcEtezu3QqG/lcBkk3RbQ/
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:sq1Yxqv+qhZ0hz+9rsioYKNz7skDqNV00zEX/kB9WHVpm7+j5q
 OTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,333,1673910000"; 
   d="scan'208";a="102272630"
X-MGA-submission: =?us-ascii?q?MDGUbw+QCMU7JmcPplsoHNyfIMCJ+MZgmW8pc/?=
 =?us-ascii?q?TkqTMkkPclxF3fa7k3GiWD7oBoXGSwzsV7PvSXVfeHdSVSSDn/orksmX?=
 =?us-ascii?q?TcOO7ZOY1XpsuPkRgki/9aetndSOSfdofad2Vpx8WcjxCCVBLZoNNvOi?=
 =?us-ascii?q?/O2dzgSm41f1BOy/5skTyvIw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 14:48:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681130929; i=markus.elfring@web.de;
	bh=9okWueemfN+9ByPuGDoT5XdPjhe2CYYzp0u74tPwrWA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ahLI0U+nSuwpu5C7/Gk/OjzemIT2vmo4tbH8QqFnbRcwXoRhPPBynRmIHecNB7bZQ
	 5FWgspom38pNUBAHdbe2SFnnebfElzPTCDaNSjl69WD/tmHT8qyK/H4l67wOfA2my3
	 +K0JOFfSaDGnH1Alde97rQMrkTqUjFp9S8pibr8VEhbKmcPOBaR5t8KVRM646mPSk0
	 ZFdr5ZLI3f8+FIZTFrF7IiQ0rp0EdNXZp4HKRjMkRX/esWIpMtlp3k5wJ7bReccygS
	 3/MyTYzIk3USgwp3h641Tg08eODMXqaTcUeIQlNRq3/s6bbyE4rOrb2iCxIUMkZ1/K
	 t1Z0Tw08kOSYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5fb-1prkdw3NDJ-00Y7zl; Mon, 10
 Apr 2023 14:48:49 +0200
Message-ID: <b59a390e-808f-9e11-72a4-38fe1ce8812f@web.de>
Date: Mon, 10 Apr 2023 14:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
 <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
 <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
 <2de88997-0732-d0dd-5178-f9d42b5a3be5@web.de>
 <alpine.DEB.2.22.394.2304100959310.3387@hadrien>
 <31b51efc-afbe-ec34-255e-9df60983ec3d@web.de>
 <alpine.DEB.2.22.394.2304101415040.2875@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304101415040.2875@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SRtLseqwPlzFsmYqNl3Eesxd4yTgl9A9Ey8zJZ5th5jfd+ufkhT
 caAJ7yfW7X+VhQq2U6ZFRm6rwGJuKrFAQ9iPC9+eIalbXBvcSGjIle8ScS+G/0kwzuYU19q
 HYAqFI+M/2uDmS9mjuXfm1XAQPNTmnhwdEbqA099/rGCfFUrOgm05LbWT1vjEakaauZYl+l
 39qvAtkmLg93lGMWNvzYQ==
UI-OutboundReport: notjunk:1;M01:P0:uLSSs1ovIX4=;hsC7XZ8xdnMgF8ow6SgZJ3OnTRP
 PmFpEiCTWBG6XymhWemVU383SSff4lHLJknkhYRlH6DivfkHA/OhHRoUGtdodFuOpE4KAvy08
 McUJTbkuDos38Zv9hGxSYNP2Ik+VKmczpuHE7SG5fz7GPG/vmC8eBAHDs7zJ81Pywz+F0na5H
 mwOEemLRSlUoYB4TRoVc04yM2zJHONqo7amIrVBSJOt3AtIUjStLvCBd69gHpysP1nB4/5mD1
 njZpR5++xftk2T4BxvlAGI53sL6ziIavr+pd20T8CqYUL51pN+OGee2zFFixNnOZoFmhxuuer
 bUV0KQ7Hl2EB2v/+wFlzl7/l1PB5ku0/ScFxOwoGc8RrfiUznN9i2v5/LcBl/7V5TNMoGrnnZ
 6o5orAhNai9q2rVTpyzl1lZKMnVXMZzfb8S8NGscRmu0l+QIolNGhmyAoPHU0js++ogHKlBxY
 FTlm7G6tLy0uozReswUmtwX8glxxc0hg7muyFkl7N1vmAoaeRvq/ACK1AOhge7HRG4+Z/fPs3
 n8MY48HXSift1FnK/JHUTBujqqE0640YNb6HNBhi9g5/NmjnBDHJa1NnPXOExq8A5QAh1mAs4
 6Z5rJcsv4TnJAb9g664CxxlMbnh7E7dUtb575CvIXSg+V3IYZfdO+MnFx1Bh0KavdmFC60/jt
 /MVhThMAduSY2YAKY9vrKL1Cs42dZiPznIH0nhG11SRcvLeB5/Bz3dLtTR5KYdlfVTmV2E9i8
 IWn5GlWutJdxvAiaj+z/wSS8f76g1ziLeNeo1QLln/xFcQUoVEM21Uo1yYhoI5waecBmlsGl5
 2Wkbuo2kYqf9n22wICjuXeWDq2AodMZV7pbYYi2yBm2A91HUNbi/wsKRervW03G4q985WdwwM
 ZFgxCbHwBIy8MUDsxJMHHq3gLWAGlX7vFoXrR/j3BbpPF/mAdXCRkbn62
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1022
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/b59a390e-808f-9e11-72a4-38fe1ce8812f%40web.de>

>> Does the usage of the operator =E2=80=9Cmember access through pointer=
=E2=80=9D (arrow) mean also
>> a dereference in comparison to the asterisk operator in the C programmi=
ng language?
>
> Not when there is a & in front.

Is such an interpretation of programming language specification questionab=
le?


> you can just look at the generated assembly code to see that.

I would like to be more sure about the expected software behaviour
according to programming language standards (than a concrete output
from a selected compiler version).


> The goal of & is to take the address of something,

Usually, yes.

Should null pointers be excluded from =E2=80=9Csomething=E2=80=9D?


> not to evaluate the thing.

Does such an expectation fit better to the operator =E2=80=9Csizeof=E2=80=
=9D?

Regards,
Markus
