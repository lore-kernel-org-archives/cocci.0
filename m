Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158AEC433F5
	for <cocci@archiver.kernel.org>; Mon,  3 Oct 2022 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mR9bj4SOOQ1FyU+2r0FecQba63NmN+GINWWd+5rp7M8=;
  b=HclipP2Mp2puTmLhMZr0xSlbtiu7w8yQtjs8LdnCxVq51G+zBtH+zfQt
   jmM2lugdSa3f3ay1mu0QH3ma8T9++sTgWKljmmfOJj0aIyK/eR+7xA7LV
   +oUqgLXC1e0Vwosd3fotxYkLezfaQOvKU/1SGS0Nf/snqKVhTVFxhg2Dw
   s=;
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
X-IronPort-AV: E=Sophos;i="5.93,365,1654552800"; 
   d="scan'208";a="55687772"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2022 14:53:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AB065E0076; Mon,  3 Oct 2022 14:53:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F959E0076
	for <cocci@sympa.inria.fr>; Mon,  3 Oct 2022 14:53:20 +0200 (CEST)
IronPort-SDR: 633adb3f_9ERoKNwRubjHgolXcviK7m8UhvOEdXW0SvYNjP3E++ybVOK
 mvhsLD120bRWF+Vp5Lp4SKjyWYIMqtuPVknXlKA==
X-IPAS-Result: =?us-ascii?q?A0DDAwCd2jpjhwsR49RaHgEBCxIMQINzgQFWLgQLRYROk?=
 =?us-ascii?q?GcxhCiOPYwrCwEDAQ07BAECBAEBhQUChG0CHQcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNgjUpAYNkAQICASMdA?=
 =?us-ascii?q?QERJgEPCxoCJgICVwYNCAEBgnkBgmwBAw0jBwypHYEygQGCCAEBBoFAARVBg?=
 =?us-ascii?q?jcfLCJSgVwDBoERLI8weicQgVVEgTyDAz6CYgEDhTSCZpRzhHAmBA4DGSsdQ?=
 =?us-ascii?q?QIBC0I1GAMUAwUhBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNAgEC?=
 =?us-ascii?q?AQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbGQEFMicOC?=
 =?us-ascii?q?SEcCgQaDQUGEwMgbwUKOA8oL2krHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEK?=
 =?us-ascii?q?RMSLQcrcwkCAyJmBQMDBCgsAwkhHwcoJDwHWDoBBAMCECI9BgMJAwIiWHUCM?=
 =?us-ascii?q?REVBQMNGSYIBSMXHAQIPAIFBlQTAgoSAxMPBidJD5lhgSBsB2FVBIJIoQ6BM?=
 =?us-ascii?q?58RNAeCG4FFgUkMiWeUaAYTLpZoDgaSCpcNjT6aLYF4I4FbMxokgzZOAxkPW?=
 =?us-ascii?q?I1IGYQMgQuJIj80AgkwAgYLAQEDCYVHAQGEcAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kCIj660GglOEh3y+k455UgqjBJYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUdKZW8kZxBno3lvgxQpOxRGttdBz4SMHfnLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,365,1654552800"; 
   d="scan'208";a="25320772"
X-MGA-submission: =?us-ascii?q?MDFPlUk4rKvN/sGzHl0iiJe7rBfO0+Uarmm1T1?=
 =?us-ascii?q?cP7M+5yPlJ3KDYZwvXH2NFmmVR6o9O7fGES3o8JgyVXQ10xFv2Q+i0wt?=
 =?us-ascii?q?6Nl4C2Tot93bY3WG77IQuRh1SYo0iLYD3Zb4c8TT9OpJh3dZuGHqK7GJ?=
 =?us-ascii?q?pOpeMNTEiXIQQ7/pVhbAQJ+w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 14:53:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664801583; bh=mR9bj4SOOQ1FyU+2r0FecQba63NmN+GINWWd+5rp7M8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N6Yt6lo9n/doRKEzEv6okyTkBGXB7KxIvlZlBdurRYrWS+GWXHeTs1eSE6Jfjel09
	 nfC6Z037fOHwDAXNew/6P7j3PBSRsQt4KaZ5zJpkZ2+2IyPVJhEbY/3sygg1sPsVPD
	 lFG0HZT+7a8pExCo5srza3gR26Nh7jthZuxsbr6Ay5EJyuhW918KHaJa4uOsT3bbIv
	 8LE+sNH+x8FBI2VtaDKwAiBITmjsA+JynwJzNcvzPk1KXlYDlnth+XhiUWw7ySnNrw
	 +YUWhU66G5UeM7fPwAxwXKZDhmtNyQWy4ob21zR51oN9N5ufezfB4/opEczIVGXrnq
	 BhjaCPYBfG12w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1ouvsk1Xuz-00JsIm; Mon, 03
 Oct 2022 14:53:03 +0200
Message-ID: <259d6e85-9a07-89ae-9d90-c16e135142f4@web.de>
Date: Mon, 3 Oct 2022 14:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <fbdb47a7-1673-b741-08cb-5703931a8b2a@web.de>
 <20be8691-3860-8c6-a169-1cbc332015e2@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20be8691-3860-8c6-a169-1cbc332015e2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rwrj8KZAqIHg8PsG2yHdopkYerfsvYyNxBhahAls6Bf1bdqEm/V
 YWOkSDtq+IJKAVprbpcE6k7f7YbGGwP5Rjn/Ot8v2VaDkahUTG1o+2GNWSu7ljxvCcbI0wx
 rUNrgVKboqyEPPvJbjW6yPzFXfYdvZ4P6XQapS0EEurkh0aXZ1OfPxnXwCZWURewPJW9fap
 zugM58onxSqVzJZppzisg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E4D3DjVhyNI=:PBpO2xh15hHQSBuREjcRvj
 pRY9r7nh5xCA/ty1ffXLqZmiAy3eSwfeCy6kBL7GNtVZIOaOM9Z9KzvM0P+xfF8kd8Fw5mb+Z
 osTEh6KMLqTJkyd55tFauAO03CcA+VK+J2WGhcWIRyrCTdGSF/vpwtcSASFcpgl/gyGPC4Rg0
 KGYORUrVOdx5ReTcEBk2yEgLX5sTqkVUXAfWtEiJDagYLOTRbOTR+FKm49eIqbUBj8Bm5jYOs
 IZNnwZ0mAk8xOfN9JpSUrgLAVn9SQ8BxnVhEzUI7i0gg4G6jzNShsgv+pYdB7Iv2xIGWHnfCW
 0U4Fwm6wzthGC2lsPYXIdPVffnHSZdXTohqHMWr1uW8c9KRyRRzst/xROZ6m2BfttwNwjiAEs
 MGB4VNXq6UWnjXs8AcQeZs/kgtZnVuc2VqpkyDLXtEB+OwSKJVynMjxsuPKwhvVaawX7luZsf
 JILBn4x0LlOz00UJqLnDdHPmsXk82N3LDq3vndJu6EQwz7kB9d+kZpFILu8BPI6ozIxRHVTGA
 KcMpGUOB2oCQiIy77LM6sj7Jc7td3Nt+thBgRdnLGLOktiMbzlcueMnlGOo7Nh73Br4LpcLIK
 L4NXYZqDH1kgMxY1nMBVqAsjgZCzctpd7TW9JSzBFmnnq3jih0mnet1VGQKS0gQgDVghFT1Di
 8eahv3e+f8pCBgqSx7CFdoJp8QK5V/B03XHggyAaEBFiqFFwNu6eMJ1k+FIeHv0L4Jm3YDkYu
 NV1yhhMWnGvKDvlhy0hX+NUe0FDx5bk5Jo4G34llHiTszdJITRSESxzTqWh6HpOfge+rTdDNk
 RKPaTFrKpek4ewEuQcV9wRTpeEm0PuQjh6nY3VM3gIK3AY7ImyKcbcCTx4Z4aUCAJVdeNqepV
 N9zpk9WfquPxc8UJ4efxeyNELFakOFNdHRtH0H4urbSoMHxsNAVyce1j/1nrnGL7nBnBFdN1h
 fb/RczH+RUCNLsFu9tkjU1Qllf+fpYRfhEv+26lcoTup8+r5tFsTcuLZR0aYZEmJJUKK3Xvqj
 74BVxSdyjDpmIIyt3ESiM4PgOU+jWj7JuvpXqBq7VpcxeccG2dq3AjFGImGDw2amrKJHIAJhX
 L/vmI62XdDbbgo+L/KQvGa360OWruWQeziq5AhDoeCjro/LzpVVhkuKDy9AGU8glGy8R/uBGu
 Ai/fqvfmftkYMRren5QNQ2VoSP
Subject: Re: [cocci] Checking explanations for SmPL functionality
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 612
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/259d6e85-9a07-89ae-9d90-c16e135142f4%40web.de>

>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/19454bc12f6f8cc0a7a6091edb28e8a2ca4518c2/docs/manual/cocci_syntax.tex#L199
>>
>> Which metavariable declarations may be started with a metavariable name?
> This is what the documentation says currently:
>
> It is possible to only match expressions of a specific \NT{ctype} or a set
> of them with a pointer level using {\tt *} by writing these instead of the
> {\bf expression} designator pattern.
>
> It seems that that should be changed to type rather than ctype.

I find your commit (from 5 hours ago) improvable.
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/7cf3e705f8fb5c013cdb10a8e5c05c22938b2842

Will further adjustments become helpful for a better description also for
the grammar of the semantic patch language besides more valuable explanations
in the user manual?
Are additional case distinctions relevant?

Regards,
Markus
