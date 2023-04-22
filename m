Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6772EC7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GJCUysRPMjGgGAa8/yqGvwsv0W26yXTiYy+CWLgsch4=;
  b=NLlznJMJj3JPB8/MkWqSb0vtv4r7Sj63J9xqnEcD05HkpVsxI0U27Eo6
   tphRFGWf6oZlKlfSC42xLRmI7+RmPdGnqsKJ9h12lqVDbeZ+gSoeGmq3r
   d7+RIoZdy4jgY8Vc3diXBZML7A0bBNqTjkzlhWx/SZTOxoqKKPuo1o1yL
   c=;
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
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104297642"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 17:06:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9F9AE01D1; Sat, 22 Apr 2023 17:06:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5EBFE019F
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 17:06:00 +0200 (CEST)
IronPort-SDR: 6443f7d8_aEXGbiOmvQE93kkkAl/imOGqnwQVlfXeoISm4dLkyOjUGoH
 9CuAtWsOUG1zrCYGj5yUyxTa2pg1e077BSSFpcQ==
X-IPAS-Result: =?us-ascii?q?A0FIAADc9kNkhw4P49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YItdVYvBAtGhFOPEIIkA2mDR45siGqBVoFAPg8BAwENOQgBAgQBAQMEgguCd?=
 =?us-ascii?q?AKFPAIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABA?=
 =?us-ascii?q?QEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?g06PgECAgEjHQEBEScECwsaAiYCAlcGAQwIAQGCegGCJwEDDiMHDKp6gTKBA?=
 =?us-ascii?q?YIIAQEGnAwfLCJUgV4DBoEULQGNH4QxJw+BVUSBPIJTMT6CSxcFgV2DW4Jnl?=
 =?us-ascii?q?hiBM3SBJ4EygQQCCQIRa4EQCGiBdEACDWQLDnCBRV9GgXIEAhQ0DgwWBUIlB?=
 =?us-ascii?q?A4DGSsdQAIBC3U9NQYDCx8GRAIfgWwEL1h3CgZKlSeBXYIKLIFFFYEgww40B?=
 =?us-ascii?q?4IrgVaBWQyKDZUABhMvlwkOBpIlHpdZII0zlSeFJYFlAzWBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gDA0JFYM7M49IPzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 zYzjRZiJ/sg/nHg7gVvTrIvjDQ9mg89lIe96Q0=
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:DwQqSK+GVOub32FjYhNuk+AGI+orL9Y04lQ7vn2ZOiYlEfBw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtsJ
 uIGJIfNDSfNykZse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:EDA5L2DsqfUngBj6E2o25UoRXZomTlPE/ib0DkSWG311cbLAHA==
X-Talos-MUID: 9a23:xC4AQAUNMNCfXF7q/Bv1oD17OP1N2oTtEWEwyrA9pMO2JxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54041847"
X-MGA-submission: =?us-ascii?q?MDGSS/R7inVgpN6sPOJs48caNi3g3FccGYiU1B?=
 =?us-ascii?q?lVihLHFQufAD7+ENm62S+5SI55be6kgV7IcKqUsywWwL2t83WqglITgk?=
 =?us-ascii?q?Q5MTMr7LlkQjYS2M/RbcM9E8sXCl8Pdx99BSmgegEPNmMxprRP4p3bFC?=
 =?us-ascii?q?qfTQJQ9lD+ooOfnBNixZFmfw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 17:06:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682175959; i=markus.elfring@web.de;
	bh=oUSDB9f5fg53hk2p6pi1jHwXpKJ/08xKwJftLeEUP1U=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=EHqZO+prgqwWgdK6hle0of8gj/DGgHR+WdR8d93iPHS3gcUX3WnIDgqbJM7I+XP1S
	 j+x7+ET6Ff0FSB080jIZbUjSiM5DgEXc6DwzQZvFMUjUpaPQz+hx8y6gqfrrZkxDms
	 drnBvFTWm7pmuvfHH2CdPeGQsiKTEgu0CZRQQcRIZiwMSGb8uSP4qwBfJXeVxeCpb/
	 X8EQsOFq/1iCz2pwboNBReTKyM3/5kfM6jvv7SY18MEIBVHIFJRGPrOsdqPSu/4roU
	 i8N2IgmvdFvIhJ+XtCVhFGmnmAapdVtXWZmPJq7NpufAM+om0PiflXYYHuo/k9pQnT
	 5lKs6fw1ReskQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1qczMf0WDG-00oM9p; Sat, 22
 Apr 2023 17:05:59 +0200
Message-ID: <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
Date: Sat, 22 Apr 2023 17:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S8wK9i8lFxCROPkcclD7n8XuRLBXpxA4QxxtRvx6+gymnNUwYDy
 MGeu7zdYvP3mxKiCOzqYYvE1hrkJcUydKbDxTe8HMFx+JgOh9HYZN+kLrSjbvP3xUCVP3Qg
 kHFESM0zSdw1XAnkC3d5+tvV3sXdSKaPUlJK3KVLxhUzYVEEgIFnbUwMmPiZ9vhdXoMH9Br
 sqJcfg4XYuSDPjZkIqGmQ==
UI-OutboundReport: notjunk:1;M01:P0:YjgJfLmWq2I=;M22QTl0Zdz6dVMmQ/BTKJhKZOBT
 aiNcAqNk5lHa7X/1Ttuaozb9amVQr6EBQrugRwkw5m1sWUQxRCJ5Wy2FFhJ1/AeGuN9GvxJKf
 npNp7SqQPjuZUltwK7BxToA90RGpVDi8YWs1osJe9dl3eV0AEU33cAHwog4DUS7eDMR9LwNfc
 m6Yub7xqxlSIAUuYUS07nKw0qULlehvPUqEL2cxtq1NB4pyyPp15hZXxb+KVkST3BF6xvrAFU
 YhIGK36yFL5qTXiYQuMDrBTDkVDKq2Bw6MAo0NPnXaf+gTjAIMda7BuUqBACCSbCHv8+zlK7Z
 mRnhVi1vl5rDshSUwQv0SM80/oVktNAlhB/V7+zxnmPubKeGVkeh8DhKwsRp2PhzmaBn4S8dQ
 q99BdCHkpVKM5C33UxACJkzqP+7medxIqRHGiK8TRS72zvpMvRb8yvDi1pyCZUt+Hwop+cWfy
 BWrYZUtTot5l+p3kEAXcTk3V00V7TPsRZTgTAS6H8Kwm0EXOieGJcyBQXapinxkTgEzLrdp9f
 7F2tTZJVx+6xjjkCrsmzdUwd16h83JPUdiJ8irzv1jyGWs1DsGYqJsqCqKpqctk7ofoavNG3i
 OZS2MfJ0xP13e1P2DH1N9NCIBYNn4khmcng9GrSjHa/HixJNOvg57ry/kxpUIKYbQWZkN9b5G
 OPaBfOvAOLriT5/d/j9ZhHFsyu9nr/1zYPkE1dHTDWSWJ1Lt79R9z5AlLAorCaFFfjQOCuz/h
 vfO/MWK2fr+grF2Za4GrZLteMmjcuLdglk2IJZG4xoIhZcSUDKJ4zt2m4yUm7enFCWkvsZoil
 Gy1Z9z5m/5eICXUxKQK1Rr1UWmd03b/Rb0DHB24xa+qF/jwhpl14Oj9MtFL/11k/OqyTSmhja
 dX6tFcqDTZ8Jwm2BZ6wcR5BZOhzkyh4cCouKOsIa6QAw2ZzU9tB5T2XASUBLMZCJr/2z01fEx
 QEG0yg==
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1116
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/e170b7fd-c7ff-c3cf-db35-0427833a8215%40web.de>

> If you want a response, greatly simplify your semantic patch to the mini=
mum necessary
> to show the problem, and provide the .c file, which should also be the m=
inimum necessary
> to show the problem.

Will the understanding grow for a questionable software situation with the=
 following test code?

Another SmPL script variant:
@initialize:python@
@@
import re, sys

@find_update_candidate@
constant char[] input_string;
expression input_context;
@@
 action(input_context, input_string);

@script:python selection3@
text << find_update_candidate.input_string;
@@
sys.stderr.write('text: ' + text + '\n')
match =3D re.match('"([^"]+)"', text)
if match:
   sys.stderr.write('content: ' + match.group(1) + '\n')
else:
   sys.stderr.write('no match\n')


Another corresponding source file example:
void f(void)
{
action(x, "X");
action(y, "++");
}


How reasonable do you find the following test result?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch check_str=
ing_literal3-20230422-debug.cocci string_literal_usage4.c
=E2=80=A6
text:   "++"
no match
text:   "X"
no match


How do you think about to omit extra white-space characters here
before a double quotation character?
https://en.cppreference.com/w/cpp/language/string_literal

Regards,
Markus
