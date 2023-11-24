Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9C5C61DF4
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H6D1IdBSSs120DyH5SPfv6CmxA9KknXRqu0sY0C2LSg=;
  b=Bf0XJ1tkEnFXSIcdpVh4XBG/vQF0MfYPFtCuHag3NE0Ivu0G44IwP8uN
   nC2EZZoIJvKsVJHJuQHHGrfh3qlUew0clKz+nunl9u72XPXiG6fHfpUsG
   uj/oSjBxyBFC9U9bAYpHx15UvKp8kC29DcEvsM+AcMNG4UenzRwge9WFg
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.04,224,1695679200"; 
   d="scan'208";a="138339386"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 14:10:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DDD81E0CCE; Fri, 24 Nov 2023 14:10:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7950AE004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 14:10:15 +0100 (CET)
IronPort-SDR: 6560a0b6_0yo+QD8TEzGzu5t5bxAVDifpP/gG3POsfI7afQycPKWpiS7
 8lExBoTympWMnKc0d9WAoP4mh2b5RvOME0kXhuw==
X-IPAS-Result: =?us-ascii?q?A0HRAwDEn2Blh07ASNlagQmBT4I5gVAwBAtIhFORMjCEO?=
 =?us-ascii?q?4c0h0qIb4FWgUA+DwEDAQ1BAQIEAQEDBIR/AocpAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4KAQUnhWgNglwBEIEMg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdAQERJw8LGgImAgJXBgEUA?=
 =?us-ascii?q?QGCfIIqAQMOIwewFYEygQGCCQEBBq9VHywiVoFfCYEaLogNAYVZhDUnD4FVR?=
 =?us-ascii?q?IE8C4JHMT6EQ4NbgmiJJAeGJoR1igNdIgVCcBsDBwN/DysHBDAbBwYJFBgVI?=
 =?us-ascii?q?wZRBCghCRMSPgSBYIFRCoECPw8OEYJAKzY2GUiCWxUMNEp2ECoEFBeBEQRqG?=
 =?us-ascii?q?xMeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFVgNFBkkLAwIaBQMDBIEzBQ0eA?=
 =?us-ascii?q?hAaBgwnAwMSTQIQFAM7AwMGAwsxAwcpVUQMTwNuHzYJPAsEDB8CGx4NJyUCM?=
 =?us-ascii?q?kIDEQUSAhYDJBYEOBEJCysDLwY4AhMMBgYJHgQOAxkrHUACAQttPTUJCxsGP?=
 =?us-ascii?q?gInoz6CPG0ExTo0B4IxgV+BYAyfIwYTL5ciDgaST4gZkCcgqDSBYzqBXDMaJ?=
 =?us-ascii?q?IM2TwMZD445hBKPR0A1OwIHAQoBAQMJhUYBAYNagUABAQ?=
IronPort-PHdr: A9a23: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
 HLvYrpcSUBzCf4QTEhoToRqHQ==
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:Y0s3Qajqgg/lkN9O9ypnYg4jDHBQXgQji2hC6mlwRA09TyXqrb
 HMoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: 9a23:PDEIy29P+M3c479zLTuVv39PF8d1XSzT9VmKJl2ZDj9qVLyPT1DFrQ==
X-Talos-MUID: 9a23:wjyxKQaGeYJizeBTjwfMiAleNMRR5qWUDmwTnJwtiu3cDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,224,1695679200"; 
   d="scan'208";a="72483857"
X-MGA-submission: =?us-ascii?q?MDEodEHqQMijbLfVQPWwBzjEesvkAQiT7fW3Qi?=
 =?us-ascii?q?Shemv+5UWBptgULtVHCeNZkFWEr0dquzc28KdqGkLTiMBWVFDCFmPZdy?=
 =?us-ascii?q?TX0igyjkksYtzoKtaenvGCzqwBGXQAErM+Z0LrQhSi/ZX21zsP2kcZv5?=
 =?us-ascii?q?mk5z+VVPep9GOGr3l9833D9A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 14:10:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700831413; x=1701436213; i=markus.elfring@web.de;
	bh=YphmC5d4BG3maXurmrouYH3myItb7bke5t/n9OoiJRc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=UxX36wrmMN/3x06UeWBZV0PjMaZeVr/XjdwmrWOAX0y9bvVn3yqmdaugcIvJt6xx
	 +v6axbDBOqE7TQoP05pI8yB5fcOb/YN0DfyQWVM8exGXmavKjI/jH2EeG05YnnkYF
	 SdWiqsCNx1btd1D9hp0HPZnsW3NQHtUrGEOpjyvGwUYcgKUYx7h+Vj8bxkYcWxk88
	 MLnDKakRs0Yet1pMrb5vwkT4InhlzaaXl7iSriB2jjtCQL/QSYyEdQOqx3u2QgjFV
	 pOESdYj5eoqtWG62peHkQXvhQD+fzrcsdB0A/sYBXmBqIuvAX6c/sMnfKBpUEbm/p
	 3fejwUEK2/dgXanpjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDe2P-1qzc381uDf-00AVOl; Fri, 24
 Nov 2023 14:10:13 +0100
Message-ID: <9734044e-1bed-4564-9f52-3ebaea836e69@web.de>
Date: Fri, 24 Nov 2023 14:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
 <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de>
 <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr>
 <d36b547b-a4d2-4e0d-a028-fb9237f99f2e@web.de>
 <d22bd929-b0cb-1b1d-9c8d-3e2e9e1e024@inria.fr>
 <087e1c6a-31d2-4205-8afc-5925cc01b20e@web.de>
 <ee749bea-9fdc-40c6-818f-7c14cb705586@web.de>
 <1c6770aa-c9e8-566-3a28-e9cb36e2f85b@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1c6770aa-c9e8-566-3a28-e9cb36e2f85b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zct+pcXJcwsK+jntUp3Xuz6Svb/sSUczehc16JnftNbTiAt1Hgn
 4lIHcxczknb41zTtgvMcG5sQlPn7a8+KzXIZmB5FeXIkF2LmdCCBOW2lfaqsVcZr4zQpU8F
 tMKXpArbBH8tnmHL/G5YBLLymbVENJ+Oq2hi8Hx257eddkxLhu+PVX6yEyAWdyqqGU46vFb
 TXy2WDOtISk3ILf9nlgCQ==
UI-OutboundReport: notjunk:1;M01:P0:00EaYkv9aVQ=;w22sVQCokGbVE3FJKkvi/fXAQtI
 Ys80Jurgn915jRybhXtTKd/VLXlxQBUC3XYnTHxPej69Cqx+SRrTinrYhtP8kzfyMx0vNfqhO
 AOflokWul1lCkwZzY3CcbBwIza16MLnus0NzYY2jdcajalcQA29CJdog7hojMWaqNW71eq5fr
 oDkL37FicInAI7e0vF18+pd5AndYGZBkHj1SLkzBkSJNxdH4UKY8K9FcQzJ65ZlHSMqB8YGen
 1WHx88KOYNgevOMynzltpCPOpgknqGCWYZpWE6NJatepPZ0HcCFvZCtDaBKNOJrLtwZORFq72
 2zBoyBojqA+JKd9rpfaV4MUjnzs4r/pVqJQl35OBTFjsssTlIy406ujqng3XRDszK57ldybVz
 D/C75DG/R8ki1DiPSr1McrDSbqITmN0rBrjGQG66xMRhjPcdxMafQWeyH49Pju6+IpivleVhi
 FfzrrhKmaVyIzcplESVNBjIpJKc+EJmPsfQD5NK2G8tNELtA0whQb+aawGY1W245zmVgCaKVU
 f9tOMecIhMyJInHNbxvK2YBjo35Z65UFeRh6xrTYHDzQ1sF9wMTT2Gx6GXrQY91JCuya88dom
 /p6DIbexjTvcSP6Y3hChJFGrl4ZYrakLlvu92UnwCLZDh/ZVPmV9wGu0LvS1bEmO79lLvK0l+
 jNyAdSsV1hNv6meWtOHwWvbhukE8Q1n9dyaDqaxNmt6tV4q+ff0KHYr78uBBvZ7TfOpmcXAkD
 DiHUSt/V9C4JArxJHmxPW2ewOkuLAkdaP01FYoMvAscMTNf2CbcGuEzrvX9sJrMBcYUouhkok
 hFDcCYLxMr3WXSxleMJAunDL+0Y5SM+RTRFdwIx8Z5OBo9AQeU+K66u6N2YLauLofefODqq0A
 IDzGoeP5vXAkmYM92p6AkRCMlkycEGYEDomBDb7wOUlPwVPHd4ejP89LcPiEvMO9STp7Zb2XE
 VO5pww==
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1334
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/9734044e-1bed-4564-9f52-3ebaea836e69%40web.de>

>> Test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch ../jan=
itor/use_common_code17.cocci three_questionable_gotos.c
>> =E2=80=A6
>> (<coccilib.elems.Location instance at 0x7f8bd82e6050>,)
>> (<coccilib.elems.Location instance at 0x7f8bd82e6730>,)
>> (<coccilib.elems.Location instance at 0x7f8bd82e8640>,)
>>
>>
>> Would you ever similarly like to receive position information in one se=
quence
>> instead of separate record sets?
>
> No.  One can import many kinds of metavariables into a python script.
> Each execution of a python script is with respect to a unique snapshot o=
f
> metavariable values resulting from a single match.

I hope that case distinctions can be reconsidered further also for
the handling of =E2=80=9Cmultiple matches=E2=80=9D.


>> Can a more consistent data grouping be achieved for such use cases?

I assume that circumstances can evolve in ways which might make correspond=
ing
use cases more attractive and desirable.

Regards,
Markus
