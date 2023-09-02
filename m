Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20DCC83F2C
	for <cocci@archiver.kernel.org>; Sat,  2 Sep 2023 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SZ+zRyR8EELIrcc24ddZCQftfSgVNVGjxzpWcuaITTU=;
  b=rD/dGWT73969N8pMyY8rOOF/iIYyb5gzJznbfqMK5J2UKOg2WOP41SLS
   GkzYJ/6sD3CtHmZVPy9fvr08cPY7qU68YVKrFzRytfl8ZNFZjF95gOlLX
   EMK2kBKWzNom48Lxhk9H/AiOCST1t7wMf1hxnxIY/cRAPShyitEpHq+rt
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="124031849"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Sep 2023 20:26:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8259BE0AF1; Sat,  2 Sep 2023 20:26:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 03D56E004E
	for <cocci@sympa.inria.fr>; Sat,  2 Sep 2023 20:26:19 +0200 (CEST)
IronPort-SDR: 64f37e40_srM3AlfpHV1yZndMQW6Uk/YXBaSybDJ7Y/oCNcl5lJujG6D
 jsKLT9lAE7SJKej2A5HVT3chM+vuZf+O6rQPXfw==
X-IPAS-Result: =?us-ascii?q?A0FFBQCnb/Nk/wQP49RagQmBT4I3B28DUzAEC0eEUo89g?=
 =?us-ascii?q?XYwhDyOfYhtgVaBfg8BAwENOwYBAgQBAYISgnQChm4CHQcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFLzkNgjcpAYMuAQQBIwQZA?=
 =?us-ascii?q?QERJgEPCxoCJgICVwYBFAEBgnoBgikBAw4jBw2pQX8zgQGCCQEBBq9UHywiV?=
 =?us-ascii?q?YFfAwaBFy2ICAGFSoM7eicPgVVEgRUnglMxPoJLFwQBgV2DW4JnhwaCW4Mhg?=
 =?us-ascii?q?iQDBIFADAmBBoNfiRsqgQgIXoFqPQINVAsLZYEVgkcCAhEnExMFRXEbAwcDg?=
 =?us-ascii?q?QIQKwcEMhsHBgkXGBUlBlEELSQJExI+BIFxgVMKgQY/EQ4RgkcrNjYZS4JmC?=
 =?us-ascii?q?RUMNE52ECsEFBiBFARqHxUeNxESGQ0DCHYdAhEjPAMFAwQ2ChUNCyEFVwNIB?=
 =?us-ascii?q?kwLAwIcBQMDBIE2BQ8fAhAaBg4qBA4DGSsdQAIBC209NQkLGwZAAiegO3CED?=
 =?us-ascii?q?8Z4NAeCMYFdgV4MihWVCgYTL5cXDgaSNJgsII1BmmSBYz2BWTMaJIM2UhkPj?=
 =?us-ascii?q?leDQDOPSD81OwIHAQoBAQMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23: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
 oUDQPlXWQ5tfhv1IltoFpoOLcUuNg4=
IronPort-Data: A9a23:k2dCgqN85FmTroDvrR2JlsFynXyQoLVcMsEvi/4bfWQNrUoq0zdVy
 GoWUGiAbquNajSnLot1aIS38h8AsJPWzdBiTXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYAXNNwJcaDpOsPrS8Ek35ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXvUlirwuR3Dns8PNQD991XKlh2q
 /8HfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBfmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yOjK2YB+A7PzUYxy3nOx1A24bHJDP3qY9qlacV/px/B4
 VuTqgwVBTlfbrRz0wGt9nuzj+vLtTH6XYgIHfu58ORriRud3AQ7AxodXlqTuui8kkf4WtRFK
 kVS9DBGkEQp3EmsU8W7QBCy5nKJ1vIBZ+dt/yQBwFnl4sLpD8yxXQDo4xYdADD6nKfahADG1
 2NlW/vsAiFz9qKYQzSR+994aN901Tc9dQc/ie0sFGPpIOUPZKksgxiJQtsL/GudkIjuAT+pq
 9yVhHFWuljQ5PLnE42k8FqBjz/ESl0liOIqzl2/Y19JJT+VqGJoi0JEJLQbATt9wF6lc2S8
IronPort-HdrOrdr: A9a23:am+I9ak6aqHsBDEngdocHvv4JOPpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:LWbaRm7Sy+RFxP68Ktss3W83XcE0a3/nxnaJOEKDKU1QcOOWVgrF
X-Talos-MUID: 9a23:uXONnAhq945PHjFcCCf5CcMpJdpjv+OfAWQxtqofveaoNQZJYm7atWHi
X-IronPort-Anti-Spam-Filtered: true
X-URL-LookUp-ScanningError: 1
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="124031842"
X-MGA-submission: =?us-ascii?q?MDE7NmaQKMQke9UyvadrivHFDQ06l9mydVnyiE?=
 =?us-ascii?q?r6W1VgOx19M3KsEO65V2jvwZLekGzWEnyhiIdmXT/tEuHy1CW7aGOHuh?=
 =?us-ascii?q?R/yfVfrDkRYiTJeNRd8h3tgqymjO9hZhiIheyl36jw1lETd4G1OqUSQU?=
 =?us-ascii?q?3JOVJNxqru1XjM4GrZv4/ZmA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 20:26:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693679148; x=1694283948; i=markus.elfring@web.de;
 bh=SZ+zRyR8EELIrcc24ddZCQftfSgVNVGjxzpWcuaITTU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=No2pbxl2wnL2hybRDP/LAh4V1EuD0WGqSMb6/nB6p5Oyfv9qW2qOERLxJwzGHLf6cREOTsX
 LOr5dKXzQrw8CY5+ihN8KdOg438M/JoyV1FJvJxy0EF0prZ9crzNst1ZA4x9wUGF12PK6ZCr5
 VX5W2QlOxJcllOq1zQ4NE6f72IXNxiy9VEHe34mR7/UkMqg6Nfh8+7Kxmmord4ierHRERBRA3
 uH3KUiMzygQK7C/Maa/lfytUwUz16fYpZaEBnBkykQXvYtP94n25vKH/gs9rgsM1ajgBfJzGh
 XdExl7MPoq2SJAVfXkikN8xF3S08j4+AkMv2G1cROy60UpQsTHMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUSE-1qQtOL3idm-00G8CD; Sat, 02
 Sep 2023 20:25:47 +0200
Message-ID: <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
Date: Sat, 2 Sep 2023 20:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thomas Adam <thomas@fvwm.org>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
 <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KmzuTfdmH5pzhmBmCj9BSpHLy+W0dyTCd6RyNGNa7zL6Mhtt78b
 15+LBRytUIdnEY4QXvcMViMIoff+F2qnZ0rTWQ9jvIQU4UgiE4uHO1bYjBpI8UBfNfBoKLb
 jFOSOgKGbjcoQnDMyb5ydRcyEmIgoLK/yozG3/+OZb/bpegAW/TTQWUv+zCQaVtIqA7C5Es
 FnpbI94kboSL2P7QW2LhA==
UI-OutboundReport: notjunk:1;M01:P0:YObd3rAT8IY=;lZmilQHJugL7934qBVGe9BlAg9C
 RDbPITLvQ/0p+iPBcok0bfXQbu1+HZCW531wqzGEm5vF8p9eHcR98NBhxPlEW5CcfuOPqi4ND
 kybRu0yC3W41sQLLnuBynzYmHtaQNCpO1zPBSjGW8wwXaH+Zd+z1hOjaD5GlDVkCy0jSJV58A
 3M+tEkAC49K+JoiaLz+9RO63/a2S92A3j1MwsKFCJsGm/XUEbpSrLdgvftS+G9s064ZOiEWc9
 ihY5y2Ilr1BxlLYZFShqaNZ6JwrwTeYEcWTxj0XGnEexPHAjhiCpU6sCc3euMMPrIxhWm1Fvh
 3XoA0lR1xemsLp0G81SFPM3kqTAHLJgMgTa7xAZFjB8gekBtEPqke/Bdrc3iKJ9+Xy3rG0k8J
 fFiPqnNMp15ZAnzFy3ZjpgVl9Q1fgfRHpdw749grJIRQ+AmtVrzi0rFaG7iEd0tpbK2egyFlE
 4mD+YDnzEb46WafytxTFwu8eZT/1fY4N15aI485RBWrew+BACEwKHmnTPZmJRkFINg53klzw7
 rfDEIEfsxgI8UR30/uFMJzcuWe144+IUpFYp9ITZInaNg6f210AHi3ZpjNMXnsTUEYftQ42Fy
 I5ynfszjwB1QyZ8xj0FRbrLfIdtISCqWb9Rt2vqhcNoJUcXm5cHsYaXzxMWWKDvAvsO5ZujGR
 I9OqK/oSniLjj0mOOCtlVl8niqa+7rWG0tmLAc3MUVITFQC1iwsMVlmSYAmBaRNQjABwXKRdN
 L+0h2w2pwu+VxHuAVuV94IyBVRyBrHCspPXU9Yce0Kiq9SBY94CPG3PxG1IISrGBeSG9NSAkQ
 i7FCeytGWs4wA3MCSBHdelJcPA9YO4i5xUU5384ixlBALcAqTXZfcxckamj0jNpiWz5ku43a+
 qdFvfICSHuh1ZgCExb7h3Yx+v9G0HdGu6NSiwDZXNgyBPumnDIy9Sm1/xTf0QQ1JiWSfNuTFj
 P6ad55pbVvJXrkc5DeLDNBrH8Ts=
Subject: Re: [cocci] Checking a transformation approach for the avoidance of
 duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1231
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/205fad47-dbef-4cfe-885b-69a2a0d4b09b%40web.de>

>> I constructed another SmPL script variant for a desirable transformatio=
n.
>>
>>
>> @replacement@
>> statement s1, s2, s3;
>> @@
>> -if (tint !=3D NULL)
>> -{
>> - s1
>> - s2
>> - cs->tint =3D GetColor(tint);
>> - s3
>> -}
>> -else if (tint =3D=3D NULL)
>> -{
>> - s1
>> - s2
>> - cs->tint =3D GetColor(black);
>> - s3
>> -}
>> +s1
>> +s2
>> +cs->tint =3D GetColor(tint ? tint : black);
>> +s3
>>
>>
>> Now I wonder why a corresponding patch is not generated by the software
>> =E2=80=9CCoccinelle 1.1.1-00478-g0afff7fa=E2=80=9D (OCaml 5.0) at the m=
oment.
>> I would appreciate further advices.
>
> Probably because in each branch, the first line is a declaration, not a =
statement.

How does this feedback fit to other software documentation according to de=
claration statements?
https://en.cppreference.com/w/cpp/language/statements#Declaration_statemen=
ts

Regards,
Markus
