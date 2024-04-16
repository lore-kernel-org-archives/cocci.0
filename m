Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F37C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 13:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ca8Cl3XLzplEVm904ERihnCNiIuaG/Q+OtrmyAAJcCI=;
  b=cQb6kC0J8YKRj/jjxvy3Ob5uclThWaAoQvcuqsHB7y7HG8jyahEl8XpS
   ityRlz/0UH9C/PNyPYbrPQZBSQFJmIfEapO8z/L5Q8mtnQmg/9EtxHBHQ
   +K9UANHnEumDzT0SgKpcQq4Gp/81/VyQJ0FZy5Utlqmns+NaKdPAdahDV
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161863559"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 15:05:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C19DE0141; Tue, 16 Apr 2024 15:05:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EC2CCE0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 15:05:44 +0200 (CEST)
IronPort-SDR: 661e77a8_6NNBy3KFYuwLTFIyZUEZsjC5AgcApQdfS7MrT5CLq1xRWL6
 GiFhN0JlCA6B1i1ZClarvYTqemm04C1lnzoMczg==
X-IPAS-Result: =?us-ascii?q?A0GoAADNdh5mhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYJDf1MzBAtIhFaRO4RrhziHTohxgxY+DwEDAQ1BAQIEAQEDBIR/A?=
 =?us-ascii?q?ogaAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?SMXBw4QJ4VtDYJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgIBAyMdA?=
 =?us-ascii?q?QERJgEPCxoCJgICVgYBFAEBgnyCKwEDMQe0D4EygQGCCgEBBtpZHywiV4FhC?=
 =?us-ascii?q?YEaLgGILQGFfINGeicPgVVEgTwLgng+hEODW4Joh0eJI4sRhiVUfRwDWTIBV?=
 =?us-ascii?q?RMiCwQMGgIbFA0kIwIpPgMJChACFgMdFAQwEQkLJgMqBjYCEgwGBgZbIBYJB?=
 =?us-ascii?q?CMDCAQDUAMgcBEDBBoECwd1gXyBPQQTRAMQgTIGig8MgX2BDAIFIQQlgU4pg?=
 =?us-ascii?q?SmDCQhDcRWBCAKCfYFhA0QdQAIBC209NQYDCxsGIx2hC3zIPDQHgjaBYIFhD?=
 =?us-ascii?q?J9FBhMvg3KTRg4GkmiYYiCoZYF6JIFcMxokgzZPAxkPjiAZhBSWG0E1OwIHC?=
 =?us-ascii?q?wEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:BYFOoa2Fk2I/66dqmQd02wqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AZqWERGvW6LyiwPGRXwgkWtQS6IsDbj7/1nbcLHa?=
 =?us-ascii?q?qNkFrUuWnE0Gy25xrxp8=3D?=
X-Talos-MUID: 9a23:p+2GxQTjzCr9F8ocRXTKvW9HP+pX3ZisEUAplbYsm825LQ5/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="84955843"
X-MGA-submission: =?us-ascii?q?MDGuAG+cLoK0DjtDf8Vl7AOONdvH8P8sANi8Q4?=
 =?us-ascii?q?jYNrRvBb+LRE/Cn+0IZgtplLhqckvZvtvOZkxeFzEPi0TqcEFGemPaqT?=
 =?us-ascii?q?Y+mMxRSO35U9v5fHEh+LYLSTnbm42s2FbIsDPf5RdHlu+4jk1r9mENe5?=
 =?us-ascii?q?xTc7y6gf4HLyKrsMeDOBlQUw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:05:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713272738; x=1713877538; i=markus.elfring@web.de;
	bh=ca8Cl3XLzplEVm904ERihnCNiIuaG/Q+OtrmyAAJcCI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PVsbVpvbn3NmKytdDeRSUzNTv99lozcqE2+J6VBtKbbqUuI466dhg6SxG4YCpojt
	 EcbYegfhuxm+kFJXgyC3dw7XaykV5nVLCkUGEkKCt8ToqnwAmIKlmZx8TV5nHugff
	 SKFKjFy25uYu4pSF3BsP1CfWWMXGuwguqfKdMpEGSMXjCT7V6zFMhNkViNGtA7wYI
	 ki4Nu6KiyU/7JRzAgi7uuyktzTwQY3lyXj7gCuJiVWNhzwLr30q5dsg1fTH7DOXeD
	 qqQGRyoZ+cZHTxTf2pol5Ilxqno4JKDdAzxPvnzlvUL+wFsgsK4btyc96jyGMeFaI
	 dYV6Xtla9wDjJOShRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1rp0LG0iQW-0081qf; Tue, 16
 Apr 2024 15:05:38 +0200
Message-ID: <77288a25-6114-45e3-b849-4c48116af78e@web.de>
Date: Tue, 16 Apr 2024 15:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
 <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
 <33a38d7e-26da-46e0-90d4-7137f9ec0c90@web.de>
 <3711cad3-a627-4a6e-8769-ce916c1919ee@csgroup.eu>
 <3f22920-9543-efd1-a32a-477ae18a2b2a@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3f22920-9543-efd1-a32a-477ae18a2b2a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QZe/Xfpby5Yzh4ML5dL/xWw0rfgIaR+vLFPEZOY+KKaRjk3XJ8q
 JQ8iyJRZTIH9iwJR0LdwrgqQaKNhDtH6oyxbyP52cDntgHTbyCmjy+8kqySd6cgr0jrgpQC
 hvKCDyUP2g8uh2oANsmrMHLU4oZ9c/P14wVLNn06QHfSxixH05aMaTEYTj8op34uLrRkpr1
 xpRkH6J4FRKQBrucHiehA==
UI-OutboundReport: notjunk:1;M01:P0:1M1alroXzts=;cqW/3yAUMIIAinMsv1rymEBg+14
 LeCtlnZRH6mesVjMV1Cah0nudr15ldWC9pnjdv2KA49quwI7KQqSCvjfxFQOF6QuclWQs5LQN
 4feSeRqtTZxYXpKhbqjKVs99SY7Msprt4QbjPZfup2ogjk5ci0kSTJKq7fFaiGtXlBmUZW4DX
 fHRRJk//Nc8+SpHtM22puc2R992esQ29XEnD4PYhmeIRdmOf2sVtwEno3JniXTLQ+MSKX/BHT
 nk3HvEpavLKWVM06lsug3Nu2PsfAwJtfW0epszCeOhqNrlyMN0o2BcFfH1EZQxEfytNaMTJNS
 LvMLN/HfIclphTAujelvwVFb7Nx2iLr3vGSWovjplNXaV/L11WVhpkaBQzCmNUg8o+OtyaZhH
 WNbdD+wF+kGerEqyJkZMbKLE/MNysgkk6zwhbeNw9nhCkNESnkZAbGQhL89mfSphGvHrnNzVT
 FMRXaxEeozL6kbXLoHXdQyMP2rSiMsQgmksEpTdzVJe8EaW16QK7xSBAFJsEFfqeusjQwes9s
 zfxR33i34pTmtgQAFH5iiXosrDBVyhwe/hvFvywrsKFQz9S9ktqiT7dUfrhOgTnDzYLV6SE/t
 Su7T3f/ZSvijnx9ezLJEKCOdT1ocutynBNBdANPDspCdUJXx0V3cAm2UkQUx56YIybQ2ZZwoc
 If5RMUwjS8u13FTH/fwOCsW704Pfa7Ju0ICKffMhJF8vz4OBDYkQlT5oOJfmmwh+B7nN49qpM
 KsKdJRktrGtX3qzyymArFnlNmzwnB9wMM0yjGlxd1r4isyERlifi00Y6+XazHF8jaif2Gs2U5
 hhswF+8+j1lPI50UFpMdsIL/DkMvp105vjONzZMl0c4RI=
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1668
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/77288a25-6114-45e3-b849-4c48116af78e%40web.de>

>>>> So Coccinelle should be fixed if it reports an error for that.
>>>
>>> Redundant function calls can occasionally be avoided accordingly,
>>> can't they?
>>
>> Sure they can, but is that worth it here ?
>
> Coccinelle does what the developer of the semantic patch tells it to do.
> It doesn't spontaneously report errors for anything.

Some special source code search and transformation patterns are occasional=
ly applied.
The corresponding change acceptance can often be challenging.

Regards,
Markus
