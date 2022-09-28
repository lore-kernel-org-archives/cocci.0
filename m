Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B62C32771
	for <cocci@archiver.kernel.org>; Wed, 28 Sep 2022 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9yraKeK5uK3x23utPhX0jSGRmtt2SsRUG26bzwgVbPw=;
  b=AngGH3az9CygUdb8baKtYbdBQ01WkKF1j82tqcqe22KPQNQjo3WUtXwr
   jHhuyk/2M6icKuMsjtZhmVb3ruX3u92iMtBrYObAW1cN2GLWMgPTYWO2Y
   YHkxQ+daJRNHLbdT4FRRsk7f+hgjd8ILofGigSsnH9n+V7wOOj+ou7qrn
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,352,1654552800"; 
   d="scan'208";a="55021897"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2022 21:06:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BE974E027C; Wed, 28 Sep 2022 21:06:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C176CE0076
	for <cocci@sympa.inria.fr>; Wed, 28 Sep 2022 21:06:06 +0200 (CEST)
IronPort-SDR: 63349b1e_OaUDXf7zcyZ307yzB5AO3EOucUPVjXa5ZBHGD/Z4sGoPau/
 KKTGO21RHKAqBS0hBm00CzSOU4JkZ7oZyFWYMJQ==
X-IPAS-Result: =?us-ascii?q?A0AiEAB7mTRjhwQP49RaHgEBCxIMQIFRgiKBVy4EC0WET?=
 =?us-ascii?q?o5vgXeEWIcYhyWKMIF7CwEDAQ0SASwBAgQBAYUFAoRsAh0HAQQ3Aw0BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFaA2CNSkBg?=
 =?us-ascii?q?2QDAyMdAQERJgEPCxoCJgICVwYNCAEBgnmCbQEDMAesF4EygQGCCAEBBoROH?=
 =?us-ascii?q?ywiUoFcCYERLY8veicQgVVEgTyCUzA+hESDVoJmlHyESiYEDgMZKx1BAgELQ?=
 =?us-ascii?q?jUYAxQDBSQHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk02CAQIBCskD?=
 =?us-ascii?q?wUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTGBsZAQUyJxAJIRwKB?=
 =?us-ascii?q?BoNBQYTAyBvBQo6DygxaysdGwqBDCooFQMEBAMCBhMDAyICECoxFAQpExItB?=
 =?us-ascii?q?ytzCQIDImcFAwMEKCwDCSEfBygkPAdYOgEEAwIQIj0GAwkDAiJbdQIzExUFA?=
 =?us-ascii?q?w0ZJggFIxceBAg8AgUGVxMCChIDEw8GKZ1EJcNDNAeCG4FFgUkMnk4GEy6DZ?=
 =?us-ascii?q?JMDDgaSCpcNp2mCCgEQgVszGiSDNk4DGQ+OIBmEDIotPzQ7AgYBCgEBAwmFR?=
 =?us-ascii?q?wEBhH8BAQ?=
IronPort-PHdr: A9a23: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
 7Dy
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Eac096u/5+mxcy9uCc7jWipD7skDUtV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+VvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,352,1654552800"; 
   d="scan'208";a="55021894"
X-MGA-submission: =?us-ascii?q?MDFeyB4E6YHRyBO2RfnuWaBp6YKUbx7nA+k/bZ?=
 =?us-ascii?q?xXCeyTDIA6S5C2Peslamsju1jZVW83UfLSSysn1pT438EDLWKJaBvHpB?=
 =?us-ascii?q?bIWYoc/eA54J7uDAEOx/GUBO5VwmSdPXmf4zvrvUmbAp9gh16yY6I7G1?=
 =?us-ascii?q?xfzZ1a/Bj5RCTxy0vedSX5Nw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 21:06:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664391954; bh=9yraKeK5uK3x23utPhX0jSGRmtt2SsRUG26bzwgVbPw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cIaXRD1pBMVN0DOwOWSipozu2KtLH2na6vxjJ+379+M22vvs4e4dxiUeUCqu8DuqK
	 LCtsCVJorqBmzxN+c39ePru7CMtbXWSETNL51MVKDrUxWOEeZm94wIDBfAXSuqiUvM
	 tRzTuQxCu0/rEc++agwnJi0aHo4g+p1B7BVcPjhiYG8NuA7HxEnAwx13WWPGcqoSMi
	 RkB/4UQIBImdRF8yHA4eSyCC3yyhf1ElA5q4UZSM7UprnNCDmDbbG7t1z582fz+hsM
	 VjkUfn4c2pGRfzOO74RnrWc3q9d7wtn6UTttazDyEoPYUQGZ/rX5DlZHjG1Hvjsxfp
	 G+N8pUiJ7l6sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14ta-1pOJxI35GE-012pJu; Wed, 28
 Sep 2022 21:05:54 +0200
Message-ID: <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de>
Date: Wed, 28 Sep 2022 21:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZNv1V0XoapNuZJuxWXdTTsDnBW+gZC1t5ayI7s1rowrHjFVqhKE
 I35U/y3iij9mvsai8zwprSSYp5KIp9n9FazBVHzuZe67x+qNGBhbnH/U1Em5gLR6sdzFr6K
 ppKqJ5t2TH4iWfn2akUbMh9vqHpdnRrtvrJQMj7MjWKFgzgT/cJL0D9KcvMg/uS5dSnRRcG
 2deSUSoJFJ4OuOamOHfRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hxdvy+RzLEA=:XN044PX/toWNIV7nDA//vj
 9of96siW/iOe98c1QvrTwQNVlgLbQUvKgkZbPGR4jLSok7XsQTukQ/6E0sj7hojv467N4mY9g
 DLQ1MMv32nWm7C0PfrnvZ3Di/4Vi2xrldgZ5JNMFB+y7Kw/vNA+BKMwx+eMZ3/Ih1nXkXUJn+
 aQ3wcd1KQ2nnT+kbK9A7OIAfpuXXfrlXvbMszmFc8yr17yfKsfoUXxm0uHP90ltlRdbAUb+wL
 lT7i/+svY5QINynIXRUnDroJm8I7ijuN7KOgaEKxxjbPCTBceQQRhZGxEyft+w2Jex7Lg/Tnc
 Hz9NEsd+Iti+C7OQEJTYaXTlqHdKpAVShBl6XgHBuNzHvzQRfRjm4yYnsX20GVnMBRWBUmDcP
 wFFlEwmx7Etu3DefCi3r+F+bJQSQlmTLrjrp6yBtovgkGSnZXtuvBnkJbGL7/GElCB18y4U7a
 pnkbzwQlr5h0eXwlTgElo/Mv7ZObWp8YVsO5kMYNp6CL1PUux/1gyFvuDtYj7o4Zi9Bci0dVb
 Mhe/REoEAPX97D7Kocio1++m1+cnaQccpHv9D1VBRe7HZn5wHY6WGKFGdQ1GEN26sQluf2d5a
 kdVmMYVMxm/FdMp8mXDJIYdeK84sqUkPP2LLYEsAffUUjUyOTIP8iQ4DwJEcx6bhbwy1KyIBD
 x5BQE4efr/HpTCBrCjBkiB9dKHvbu4hV80DEgEmXiQK2cxQrsrQX1E7oEdzlR103KPx6f8Cul
 gRUINq0uR2EvmTYwjj2Ic5wL3BF3Vbw0o4U3WnVRrrHd1GFukefRCpMHXA2NcQEQQpTJlRfWT
 wV2xFx8J6bRsL16BmvkOD8qvZB8FHNdwDwP8L7l0+8EfWSjW4ihxvFWt/S46gMsJ3atLNT9hn
 3kVG0SQMVntGOYeQ/Oe66ZQIclR7NYJVQX1+sWZvm6+Flq0AT4hQoRPA7SLH+5xHXCCyd8sqV
 Q+X2un0iIJMpewwVQpuc17vAhj6Okip4ZSombrx8ZRaRQwZHt/AU2XYaJYNJ+VtaWn0F0l+I9
 xVhFZURrXfh7+hkkiD5PfwLRM+2RIJzYG7L+fKf2NkaNKh4HW4bxw9AZ5Z9mH1GTHS7r9k0pK
 564nNAu6mH6XXDMFsYuN+zn+xqaiT9XjWvr6rJOr5n36Q9/rfKSCsMjU34GdwZyWtG2MIqr9D
 RbleQE24uR0FOQOIM6BE1DHW6h
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 598
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/d9ba411d-2b5d-061e-f985-ff5158b5521a%40web.de>

> @lock@
> type t;
> t o;
> identifier f;
> identifier lock =3D {spin_lock,=E2=80=A6
> =E2=80=A6,mutex_lock_io};
> position p;
> @@
>
> lock(\(&o.f@p\|&o.f@p[...]\),...)


I got the impression that you demonstrate a special application of
the metavariable kind =E2=80=9Ctype=E2=80=9D here.
(I imagine that addresses would be determined from data structure members
according to passed identifiers.)
* How do you think about to explain such an implementation detail a bit mo=
re?
* Can the SmPL manual be adjusted accordingly?

Regards,
Markus

