Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750F7D44173
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2024 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LbjPgimEIpmWFblanNKiAJcH7pqweQJFF1n2/78eoyk=;
  b=l0p/HEtP414ZFxd4ahO7FkRJloeEgvpqpzsyAuolIk9QInNltCFQzGBm
   ViQxQzR+xyC8/aqcvYnA8zCW/uQejBnL0fBVQc3m1HqgC8o+rWgfH/41i
   +TKnlaFuwr+RymOmX6L0TR4XsPczuSvt1FUC3qQ4OHF6GlDo+ZPkpyoiP
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194715073"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Nov 2024 16:33:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB44AE0D1E; Tue, 19 Nov 2024 16:33:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C208E00B7
	for <cocci@sympa.inria.fr>; Tue, 19 Nov 2024 16:33:00 +0100 (CET)
IronPort-SDR: 673cafab_Kwhk2MdAdsZ+qllUr4sHITLwqjj6PvUv1gHvHKkP66G1K5z
 GbPUaamWZMi9V4/YF/XtriPkTkNtl3Fj2W3Mhlg==
X-IPAS-Result: =?us-ascii?q?A0GjAwBLrjxngAMP49RaHQEBAQEJARIBBQUBQIFTgkRid?=
 =?us-ascii?q?TMEC0iEVo9NgXQwhDuHO4dWiHWBaoFqDwEDAQ1BAQIEAQEDBIUAAopQAh4HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7D?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ9gjABAw4jB7IfgTKBAYIMAQEG2lsfLCJXgWQJgRouhWqCYgGFWUuEP?=
 =?us-ascii?q?CcPgVVEgTwLgng+hAWEGYJpgkWFDyWIF2iaHVJ7HANZMgFVExcLBwWBKSEsA?=
 =?us-ascii?q?4F5Tn+BNoFRAUKCTkqDLoFeBTdJgkppSzcCDQI2giQkWYJPgSUEBYNpgQuDY?=
 =?us-ascii?q?YRehCMdQAIBC209NQkLGwY9oF2DNYFdgUMjKaRgoTc0B4I4gWWBYwyfWQYTL?=
 =?us-ascii?q?4Nxk08OBpJ6mHciqQU1gUkjgVwzGiSDNk8DGQ+OIYQtxXNCNTsCBwEKAQEDC?=
 =?us-ascii?q?QGBVYNwAQGJd4FLAQE?=
IronPort-PHdr: A9a23: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
 rAne4rsJT0E/9+GpKP04uDLJcjBPHdzaXLU
IronPort-Data: A9a23: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
 TBdeF2oi31XhaI8/QiMtpKV9NwkUOvT8ggV
IronPort-HdrOrdr: A9a23:mWnKbK3ZMSt7Ab7tIk1QcwqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:Yjp/nGxOcv9hRFCjhH8eBgUvQeZmbHLQ4Ez5CE60VDtTa+3IQH+prfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AQreZFA8nufTu5fKNmPMbfSyQf9tF84ryNGIIqKo?=
 =?us-ascii?q?D4tmObiAoO3Ci0DviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="102063535"
X-MGA-submission: =?us-ascii?q?MDEklIIvLiFOe8HL7l/OuQEYp9McW/PE6MatrP?=
 =?us-ascii?q?URAvKa/mwWbN905O3Pu/oFtnPWghgNYsFpDW7zv8Jci5Et66u3DPntDp?=
 =?us-ascii?q?zMMy80ED6B45KtFcThc+2dGv3hF6u/MGZneLKc0iBw+WP/Si/4EeY55+?=
 =?us-ascii?q?2giXU+z/UVeVotwcCAQZzgXQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 16:33:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732030379; x=1732635179; i=markus.elfring@web.de;
	bh=LbjPgimEIpmWFblanNKiAJcH7pqweQJFF1n2/78eoyk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NShilscKilRhIGus0tKlyrPWd5Tbs73uvPQx/9EE0F42NyCNmPmYd5tXnWHlBPeb
	 DxZUZ8TufOXY3Xze/cC+jHRaAB1eBU7Ojd4H6O2+QWOVRyJKRPo+2WSjy4An/DMVM
	 ZpyWjhZ7UJVtyoDc+AmX76EzJtNSwSzmdgHzCVowh0PEYj5JKWBVNyRD49AgA9U/D
	 vzeREDfQjeDv3EO8Ak4BtYL5O0oWp8xlQCRBZ006M1X62pPHCeD9lqvx/46+WanxY
	 BhYe07bECuUkJSkVQ0icWz9WP7UQTQxWRW0Tg7rA3su6v8/RKYmtLY6YXS1Ykaw4M
	 dGZhFMsypoH5afVGQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6Jxd-1tozyM0041-011Kxx; Tue, 19
 Nov 2024 16:32:59 +0100
Message-ID: <61bd0991-f048-4e2a-8918-c98da1272847@web.de>
Date: Tue, 19 Nov 2024 16:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <e3af9f65-c923-4fa0-8a7d-be1b27d47fb5@web.de>
 <c46ce4f9-30b1-4791-860c-e93aeda8a0d0@inria.fr>
 <2421b61c-a48e-415b-833d-3493d9b7924f@web.de>
 <ee34ca77-699b-4671-9c7c-61fc1f665171@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ee34ca77-699b-4671-9c7c-61fc1f665171@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SfjKYPWYPZ1Hs/6N97TsNiCdIp8e/ZjMw2T1EWMPPwdsVBtI/WT
 LpIViOCkErbyK5YMrgkFHj3SYQttb8hwDFA4qQnf/X2sHao7dQ5xmcUj2T5Il5Xgs0h1eAx
 2Z4w3uXPWMgypYswV0PMT9aA84IxDoGTxfZstsonpQuGdEKSNo8Xu60B4zyL7UD4fHELE7k
 cMDRQoO1ThwG9Op3Knv3A==
UI-OutboundReport: notjunk:1;M01:P0:uY2xdLXQ/xs=;Mjd/yEkI+6fxf/0JAdFb8gQ3Mz+
 5K5MAAz4i4xKo9Xt07WWzTFl4pd1X80biYwdTZG0pQZf3cvHL2+tHHURf+uLRnEcacnMqdyT9
 amyMw+yMGZDHjHdXgHgBCNXHfNlqkeiYb6mJ0sm5wgOGgGaYKyozSsnforv/UHs5Zh+bciy6K
 +0FPJJ5sEwGpHHYP95gZaz+65Lq4Rni5vZedvUCxehKcyUYoOE1PRWPh2xSa3MP2fYysnlMPB
 qqvARRTBQ2yZwBVLKXRkXNZ1FfPM7XYyciK81DG01IBFLcm1m1YHJB9N81c8Ad8zW3vhMeNZn
 KtqE48c+df0sDjP/KR6TiHefDHEWMGGU5WSB+09+Ft+b2jc4IQJClQypLmzZgSlUcJt4UwjCg
 ldRrEWUIJRH6QmwNyUcPqphY7Km34cnqiLZLqD49O3JH0R+9IENIaOXiVv4hljR44LD9/WMzL
 eDZ35x/+zjodOb7yJ7HtsURkZxCrDqwG0n7g1WkgqWiiPSwZPSUDK+KOQG8uKV/Fc1gaGjpFz
 kV4HgR4jxMN30zrRR/SnP5A7p8jrvN+vl5ErHGiMGZlS6horBPYaRVcveSElE8KsugPo7IFaD
 TWmTGTN43P+4S5V65H4aq/CbTUw6VXnhhzwUMpeBrj2OUVtealiU0Tg98GCLKWMAvFnEs0f9a
 mlT2huZPqUdRFfDHxA4OZUyTg4ZpXNHA9FM5t1v+chjR8OTZe9sR7IxS0dUrBm9C4p+l42NdX
 8rLDglHBNFoB91nqARsuF6kag/YDxQSdTQYNxZeIQ5Oa+FA5FBb0Z0wxXkkm0FVyJZPjRYpvd
 2ZA5aWDlhxzayY1DJ5WlHL4lItbMMnZc9XOxI5883MEOynzvmfIffzeSC7XZ80naZ4bs3JVvU
 tNTbmlpiHiI3Crj7LpHCtN6E4Y+Y4lghVVD5BiJ459EWhUD5Hv1I223i3
Subject: Re: [cocci] Marking several issues as =?UTF-8?Q?=E2=80=9Cnot_plan?=
 =?UTF-8?Q?ned=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2092
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/61bd0991-f048-4e2a-8918-c98da1272847%40web.de>

> This is getting ridiculous.

Why do you think in such a direction about the possibility
to choose more appropriate resolution reasons for selected issues?


> All this response is proving is that you are not hearing me,

I received your feedback.
But I find it still possible to come to different conclusions.


> and that you will never, ever change your behavior.

Various development activities will remain as usual.
Would we like to try to resolve any remaining communication difficulties?

Regards,
Markus
