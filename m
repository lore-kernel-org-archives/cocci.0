Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CD0C282EC
	for <cocci@archiver.kernel.org>; Sat,  8 Mar 2025 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wnaFnq8dRO9gFVA8JHHfB78Z71QkjyiRewpeR9JfmGE=;
  b=oi6Up/IDlkBTCB8zCH+rG9GITdPhLfYLHPjvkAAihybZPTWn+gNIgdKk
   B6ID0gjlRl2ykZFaj7RyQwQsLyqOuT9dM7KM+hPhryqZt8oR1Q06S6UGA
   1FKmkkcSyAH8wLQEXI7b2u7xerxMiyJRLy4wFYJQ868pR43cZNsx20HwK
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
X-IronPort-AV: E=Sophos;i="6.14,231,1736809200"; 
   d="scan'208";a="211872279"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2025 09:39:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0B5DE0D1E; Sat,  8 Mar 2025 09:39:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 19C36E0260
	for <cocci@sympa.inria.fr>; Sat,  8 Mar 2025 09:39:17 +0100 (CET)
IronPort-SDR: 67cc0236_Kgjlph8gwccpEBn+0dDoa8E8CZv8FH9xphQEum0hhmIlO7Y
 0coTiqYYN+pY+22g8RcgjO+DxPKRWhsCSINUqIw==
X-IPAS-Result: =?us-ascii?q?A0EDGQAzAcxngQsR49RaHQEBAQEJARIBBQUBQIFTgkRid?=
 =?us-ascii?q?TMEC0iEVo9PgXQtA4Q7hzuQSINUDwEDAQ1BAQIEAQEDBIUAAosaAh4HAQRHA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgkBMYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgImAgJWBgEUA?=
 =?us-ascii?q?QGCfoIwAQMOIwevTIEygQGCDAEBBtpcHywiV4FlCYEaLoVsgmMBhVsQO4NCe?=
 =?us-ascii?q?icPgVVEgTwLgng+iB6CaYIzRYJ4gQNnmgGPIFJ7HANZLAFVExcLBwWBKUMDK?=
 =?us-ascii?q?jQxIw+BFAU0Cjc6ggtpSToCDQI1gh4kWIIragQFgSSCN4Q9hD+FUoIRgV0DA?=
 =?us-ascii?q?xYPAYMfdxyDTHY8hGkuMh1AAgELbT03CQsbBj2iV4QOLQaCUy0Ik2yRZ6E9N?=
 =?us-ascii?q?AeCOIFmgWMMn14GEy+XRg4Gkn2YfiKpETWBSiKBXDMaJIM2TwMZD44hDBaEC?=
 =?us-ascii?q?8dLQjU8AgcBCgEBAwkBgVWDcAEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:jZ+aFqkhXABXWqBkwl9Hu/dErejpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3Au6SaEWskWQvwthoR7Z0OF3C56It4dVz89mvKBHS?=
 =?us-ascii?q?0ImJreOaNZUaeyaRrxp8=3D?=
X-Talos-MUID: 9a23:79+NrwQFtrvcN7haRXTlq2tAFp50+ZiRK2AWiLxboI6DNwhZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,231,1736809200"; 
   d="scan'208";a="211872276"
X-MGA-submission: =?us-ascii?q?MDFJz54MquuMeGcjjlCPKq8GjfkD6pBbOCbmAJ?=
 =?us-ascii?q?BUecm71R1cFrWVl3tjnm/m6ivWPCB5cnIHSkperIh9wZU3RDq1jsjMW9?=
 =?us-ascii?q?a4OVCHmJUcdLP2FkOfTHlsrhUazOjWbpfVvvktXHhwolWWmCbNP+inVj?=
 =?us-ascii?q?dMcetP+l4LRXyyDQFjenkg5w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 09:39:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741423155; x=1742027955; i=markus.elfring@web.de;
	bh=wnaFnq8dRO9gFVA8JHHfB78Z71QkjyiRewpeR9JfmGE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uOoJv5s0Nnke7Je2fj+UhxaB3BeaFEyc2tPLc8h4FPxEySum+MDkfqfuDuvO33/j
	 t2b0pDFS2q+v+6wIOHy7dzvyt9p7EYDIxXk6BRwb01pio9N+T69WWqBp3iOBPwC7b
	 TjJOwKyBdwai6HxI6VIJNI+MGclePBXOCiy8UltBTCN6rNx/WjPyFITnTB8SmMG/Z
	 p/EVL+VA0yl/Tp1w4kQ+FRywxKyRhlEfJr/3/FtVZ02g8sI9O0wecQH7vkyT/+IIv
	 8YeR8RiKE+976goWA5MgAU0rxlLvuivnK4RUuCl51+K015yYBtyEA2xENg6e4BswB
	 /mhpQY6hisqMSE37yw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.79]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mcpqq-1tIJyT1YSw-00asSl; Sat, 08
 Mar 2025 09:39:15 +0100
Message-ID: <26d75b7d-e9e1-4037-8f25-b8d93bd0950b@web.de>
Date: Sat, 8 Mar 2025 09:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>, cocci@inria.fr
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OSPutIUORqyRGk45vleHgsHwF8EMbAkkqA0uukc4DU9cstOS8Qu
 CH2lNLSk52QjfiYWs6YR5JAVDavwRLAcemj+rGrBPWWbsYODuxQPCW8dc8IXLpLywm4qEQ6
 rSVIWPu0ooFp4g/RGVaThUiXrkkT2YHnc6h1/O98fbIT8xAj9tpo4pANP1bTFU4ROEWsu5v
 jtOUmk+weXdO7tSZyxG/g==
UI-OutboundReport: notjunk:1;M01:P0:qdzOGk3Ucr4=;vxcnRk5jHuYP1gZvDZqEc9wtvCR
 3fHE5sezQlwmLpOPHVij7V8DMdrTxaEMMdu+Kmdj2f5POksaDIjaIVy8A9GplKkbhtBcfpUic
 2vAqq5WwfGTn9UToHUMhu06DiPHtMfPA/OQy3WYRySVjCee6lGOBC8lmdPTaBGq/WhPj1zFvq
 RxMYbL7kezE+geXpPx8MnQ2r1vXCXTExqVb0tR4PRRDU9ahXmdht9NgDZSn7zH3jzs7HRsb0t
 u79zl3dCDjAU+ROgPNNIvPklGp/XaLirNHs0M6VSh/2ATq8g6BPzcs8vv1lof/Hxid+LzIuwj
 5ZwSucehFCYbk55rvXONY5lvJyP1gU5btx/Wj7GxVyX+YBjBEB1WY+Fwtw2wppE0A00XlRTZU
 Gv9hkh2ZLuey7ykYwd63DipM++HxXqk1Iwp7GHtsLlqY7+YIVs1ydlgYKI4Qc0C/MEtd+SJP7
 ucg4nIsKzi28amuD2yhLS/aAMIcw426mIotSBv4nxvrCBFQ2ZCbOX6lJny5+TCFhxnIBUXO+l
 6xlTmmf7PVX5RWevQCV2A1FBOuzIuVUMNXHPU4biWer/B2e9VGgYTU9q7XFuz4U+JkPGGeRAB
 48Hrgfhmq8y51rkRE6hAzhhYu2eYnTjFcfPAXq5eq6SLglSdkwjA5ryK11SKv4gfZHJ78E2pw
 MBYyQGE4KZCtUg67vaG14uMve6S/S+0kJ7Dq0bX83Q3hk+blDl3fQ9wF4e3Iyw0o4mFdKm6IM
 A1Yjh3BUxuInYaW0pWCNVBNn6aInES0pJBR8lGj0GP/9sQIDmsNr4BPTHI8Aix1jFcb68UexM
 i5TsxqqV086qXwsfUaBS+52RCrENlymB7He/ANeDkdtX92fBE1fGE4NJCDMwP4K8ADbCWl8FW
 U+Bdp98AuT9v6vH8w4HJ3GFAdU5UoqnltHhpsicj+WHHBAXu2geMSlAYK3Qbw0fLnNtw1uNIw
 9uRb8B2odo5/XwvbwS2XJeI5D99bZ24V53ZY0DclBieBj3MmczSzjSC0geIubqsazW0+d3Br2
 NAssP3NmhjxLBUx2d2MZEI/OUive+JcBSr2r3YmQyF8diXAp29fHE955RqksuRbAmGievXjjA
 7QVfk7uIUxFhPGlA5sNAL/oR9T9sKghHFEdEC72O8CE58YU5fV6weygdcE262DPS3lUQFocCZ
 /qEkoar9b6PkLEEWK/P3q6DqzCIj+RkLfT8uLloZdS+mJmn28SbuwfKaAR9xfpn6rCO0DdPe3
 3gzve+U2ZcpT4P/3KaO3ow5vu/D6vfzmbZ30VvA1TtI6lPleOv28maQHyy/AYDi93oCd3jbuO
 qPQ4PRbRtZNFVBE9vHJCoTwL28qvAS6VEoUG8GwZ742RbtFQjdkAdysgujGrwVji2y5K8eSYQ
 8DH3fr62WQMQFPY/LBkzn1fH2CAN2gek3+yBtvVP1/29RBXpn+QiIaMPpJB4un0bLawhQ7YvF
 kcJZ9CxemEmrck1+Im7a0r251KH4=
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2576
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/26d75b7d-e9e1-4037-8f25-b8d93bd0950b%40web.de>

> I tried this out and it does seem to fix the white spacing for our
> particular cases.

Thanks for such positive feedback.

Will your development interests grow also for further SmPL code variations?


> From here, I just repeated the process until git bisect told me which
> commit had the breaking change.

How many iterations did you need to try out here?


> There were a couple gotchas where the checked out commit didn't compile
> but I managed to figure out which changes were needed and manually
> pulled those in each time.

Do you see chances to improve such a process anyhow?


> I think the white spacing is a hard problem, because each project will
> have their own style and rules. For many cases, the expectation is that
> a human would manually cleanup the results.

Various contributors are struggling with desirable adjustments also
in affected areas.


> In my case, we run this as part of our build process to clean up code
> automatically, and don't commit the results.

Thanks for another bit of background information.


>                                              I suspect this is counter
> to the original intention.

It seems that you got into a position where you may stress the importance
of safe data processing automation.


>                            One option would be to run a style formatting
> tool after transforms, to allow a tool dedicated to code formatting vs
> trying to make spatch and coccinelle do everything these can do.

Are you looking for ways to avoid extra efforts for code reformatting?


> I do think improvements in the way you can specify spacing would be
> useful but may complicate the already difficult syntax of semantic patches.
Adhering to code style requirements can be challenging.

Regards,
Markus
