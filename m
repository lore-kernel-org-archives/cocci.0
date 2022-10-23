Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6F1ECAAA1
	for <cocci@archiver.kernel.org>; Sun, 23 Oct 2022 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CboK0FudxLHR/SOYXvNqRWmavE7xNKh/s/krPw3Xla4=;
  b=kgSKOreLTKskQ+qyF5dtnKMBbMTDY0uF2Yerp/R6M1emPZc2swBBZpC3
   +KesztixaUvFiAeKo8KPv3t9KWpWfHI6wZfwC7KF5foVbpT7p3yojyi8g
   yGCki7Hf/+qB3OAp9gLwUEod4P9rAYGMjZEr97glyEQTC8A/u6YbgwNis
   0=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,206,1661810400"; 
   d="scan'208";a="67918534"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2022 13:18:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 020F1E01D1; Sun, 23 Oct 2022 13:18:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 23B3CE004E
	for <cocci@sympa.inria.fr>; Sun, 23 Oct 2022 13:18:34 +0200 (CEST)
IronPort-SDR: 63552309_5fy0i+ipyP54Xxc43qki7cGJwUoNmgJaPEKuxhvwUO8h0pa
 MR6HRLVAGPElYeh9y+tqszYO1LeKJv1LeUgsJig==
X-IPAS-Result: =?us-ascii?q?A0DzCQA1IlVjgE7ASNlaHQEBPAEFBQECAQkBFYEqJ4FDA?=
 =?us-ascii?q?maBAVYuBAtFA4RLkHIoaZIBhF6HUg8BAwENFAEBIwgBAgQBAT+ERgKEcQIdB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEYCxcHDg4HI?=
 =?us-ascii?q?oVoDYI1KQGDZAECAgEjHQEBESYBBAsFBhoCJgICVwYTEYJsAYJsAQMNIwcMq?=
 =?us-ascii?q?3CBMoEBgggBAQaBQAGDDR8sIlOBXQMGgREqAgEBhyGEW4NjeicQgVVEgUgBg?=
 =?us-ascii?q?nY+gkuBZRSDV4Jmjw+GRzgDRB1AA0YyDVEcMScOCR8cDhcNBQYSAyBuBUEPK?=
 =?us-ascii?q?C9nKxwbB4EMKigVAwQEAwIGEwMiAg0pMRQEKRMPLQcjcQkCAyFlBQMDBCgsA?=
 =?us-ascii?q?wlAByUkPAdYOgEEAwIQIjwGAwkDAiSBSjEmBQMNFyUIBU4ECDoCBQZSEgIKE?=
 =?us-ascii?q?QMSDwYnRw5KPjkWBidEATQPDhYDY5cCghGBQZUIr0c0B4IdgUiBSwyJbpUSM?=
 =?us-ascii?q?wODUAGTEwaSEy2HE49hjUGaMzWBRCOBWzMaJIM2EgE7AxkPkkWEYYVMPzQCA?=
 =?us-ascii?q?TgCBgEKAQEDCQGBVoNwAQGFFQEB?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qzYOHaBpA9paeHPlHele55DYdb4zR+YMi2TDGXoQdfUzSL3hqy
 nOpoV46faQsl0ssR4b6LW90cW7L0801KQFhbX5eI3SOjUO21HFEGgB1+TfKlTbckWSygce79
 YYT0C6Y+eAamSS5vyKgzVQfexA/PC60OSPmfrUyWtrQDpncqd68m5Ce3mm+zZNNXN77YFSLu
 vg2iOrnUvdRV0nKviaQl0IRfLKqdGOqYL+bXc9dmUaAILit1mV1II=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,206,1661810400"; 
   d="scan'208";a="67918531"
X-MGA-submission: =?us-ascii?q?MDGA/7vqjvLNde6CYCabevPxU/3IMZYVZTY/IW?=
 =?us-ascii?q?xTq9eXmIJHdE+QOOO2UwsSvYDEiKniD19ssvzhmdaV9CH19Vc3+Ynvu4?=
 =?us-ascii?q?dpnCRpD00b3WgwsNOAzeecbZGO8+FplZSEMK8AmVazN6pajMnxfwYFx8?=
 =?us-ascii?q?EDAeqV7FQztpXj77ZY4CnrRw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 13:18:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666523912; bh=Zj0ktlrqp4o1e2CTHjidtoLnfAqWDixGObrUNeCVflk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vt8NLcsrn+qiiVpZoLYopSL7XIK0KIncZhsrqXuTvliC+HKmVmeAgTZGiXgWOohz3
	 B0cbCGYO2uV+T/ZZ0kHSY3WfvXarA2/ZO1s2BVF2E6nZE57ZLzrmvKzmpj1WO84xbT
	 5jUoSHqhURxpqkgtCgLdAqibDAkfQIfMEOTMklQFKWGEnHxjUqM0uzYYSv+n6IeKlQ
	 cdH0AIILWTqWHNHX4F5qOqrxxA/U+xXsyzcvP+59iMGTG0m7TiKsi+1JEnqNG83t3T
	 us+gMmyc2BWf1nexqRCl+cIL+5ccul/egnu4prUFKdSDlYn7xdGBExpsR+Co/rriCq
	 vehx5Ltljws9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.80.160] ([94.31.80.160]) by web-mail.web.de
 (3c-app-webde-bap48.server.lan [172.19.172.48]) (via HTTP); Sun, 23 Oct
 2022 13:18:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-38dbc083-0911-4042-984d-ad608cefb8da-1666523912279@3c-app-webde-bap48>
From: Markus Elfring <Markus.Elfring@web.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Oct 2022 13:18:32 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:etrQjbL0YzB5u6Oj9czcuFI44AIqtVJKesH2ytyngFxitzjkPfG5a+phRbnKbubZxfAmx
 +LRNR+8pK0HX0uEQbv7OXM7NNanKmzPaaIynAY5MoGrVFqMGRUBFyd+QNuBIb55de4hBIDz+lRBy
 dtnCSb0kwTCavl1yhmJNkNniWWlvFCUO7ly5j4jvntZeI+A7KwvRzldnIjy4IV2NZc/b2XCAIklA
 MqwjjgIXLKb1cun6FiyakGQZXiI7A4v30CZKor9SIL7v9VCsQaWsBpKHMyeYAI33p7PeR8VLt4Gd
 FY=
UI-OutboundReport: notjunk:1;M01:P0:NwtBPSntx6I=;RN9JX4/AAy4scaFv/Fjh+UD41D5
 DcmLbyy6sMw8G2lp2FA8M7DAE/lWxCvEwxROPA8tmWhkTvRy+3Ncu0caYPH9M8TgwZ8n/XhxU
 jwjxId+NEJLhQuoV8wtLObto6TTYSc2d1ozYmrcxkgC7q0B4/G2qqSc7jLu5bBHgls48mTZeU
 1NwDYCFt0J3ThkSVE9UMYx+hwrvE7TnQ3/Ytl87Njd/DsP4rD7Dtt4cZ3u9ZoO3bHEtQxIs7W
 kmPKKaUyNT7M5ASWu5+LpQHSNXHPNpKwgbiRHGh9BxghEEC4T9yzSWZl07r4A5J09pgdUOjQi
 VqowQvD9ntbZDtTANwNqWGO9/F+ilT3vhmrVK6dqFwVV2LvuTzGdU3YdiiVmNdgpZcDnmWNFU
 iP87jtHApWho+t400Vg5qDi/dVe3iUGsEyFJCrArM93nUB7pUX3zLghmUYKKR8ijp9fvYyNd+
 Y8po7HgZaf8YPPGdrkKfC1QteBy0jfIkEjUuSQnFrcnkFHcNGun2YVZCmBfP/L7x8mXd7c2ZT
 rBB0wh73HZ7oC5qj8FGrFki6pmgAlILeaWh6Qf4ZlyVwJ+JbjRQtSES2YOdgAt3TbHpdBFLij
 IJN4nzwB7vP7kZ3icmtE+V/PlBYD3I0PehGuA7OvM3ujoZFjcLS+heDNCN3REO+8H+koB2aSj
 rtn2SS3ek2s6fF3SYTLABrVDuQjZaBqSsSJzZoM4AMPYIX7lDS8iLRKshfcFkNT0w+62t1Bzx
 V4lyoBMcFcvQcg3Dfa3r66YzsmiXraCLQTMrmtYGSTmqu5tlj6cMtKPVRi8e75/1MLqK3DRMo
 ZlPnZAfxUEPkv0LX/IjZFxQA==
Subject: Re: [cocci] Checking the replacement =?UTF-8?Q?=E2=80=9Cget=5Fran?=
 =?UTF-8?Q?dom=5Fu32=5Fabove=280=29=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 672
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-38dbc083-0911-4042-984d-ad608cefb8da-1666523912279%403c-app-webde-bap48>

> I just sent these in:
> https://lore=2Ekernel=2Eorg/lkml/20221022014403=2E3881893-5-Jason@zx2c4=
=2Ecom/

I find the following code details also suspicious from two SmPL rules=2E

=E2=80=A6
-   } while (!I);
+   I =3D get_random_u32_above(0);
=E2=80=A6
-   } while (I =3D=3D 0);
+   I =3D get_random_u32_above(0);
=E2=80=A6


* Should such case distinctions be reconsidered?

* Can different function parameters become relevant here?


Regards,
Markus
