Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF24CCAC5B5
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AcVJZ3zjTGDdL14Tw7LuQrtPZgPW/ebeShaSrL2ipR8=;
  b=ucoacSVkLOFKt+9WyBHRaLPYdoaudlTVKniYHtxNWPcRlP1KhaVZuVfE
   H956p9If8grM3WjVkf7+8QPQ0aPzzEB0hVLABbhzwUGMkjbmQLXfEZLct
   xIINWttxxBX9ufUKa68prgddYt1mUMuP8BXn0fRSqkbeqO8BFztp6v7Pd
   U=;
X-CSE-ConnectionGUID: F+lZxEwwQ0eFNzd3UTdc2A==
X-CSE-MsgGUID: wpqS53I4QRmFVLgqVADYYg==
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
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241377796"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 16:16:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1BC78E0B0D; Sun, 28 Sep 2025 16:16:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E4A2E0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 16:16:33 +0200 (CEST)
X-CSE-ConnectionGUID: ZXovp2H7TPGx9ltFeLyxMg==
X-CSE-MsgGUID: 1QljTesUTQ+9+nFrvAdAYA==
IronPort-SDR: 68d94340_SE/dfgH7fjE4WRTM3zcuaM+iMZyOL4kfhSSPC1bVxnTmpJn
 BXkrx2cajimNaG2NuwU1cQ3gQPD3rzP07qdtG8w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EFAABkQtlogA4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYI/gQhUMwQLSYRViByHNIIhA4Q7hzyQToFVg?=
 =?us-ascii?q?X0CDwEDAQ1OAQIEAQEDBIIMgnQCjEYCHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgImAgJWBgEUAQGCfoIjAQYQAQMPJ?=
 =?us-ascii?q?ge0WYEygQGCDAEBBtpfHywiWYFkCYEbLgGFa4JkAYVsO4NCeicPgVVEgTyDA?=
 =?us-ascii?q?z6EQ4NbgmmCJoEWg1g2giiEQIU7jjNSeBwDWSwBVRMXCwcFgSAQMwMgCjQxA?=
 =?us-ascii?q?hQNEBIPBBYFLR1zDCgSZYMHgQ2DWUUrT4IccoEAdD4ZQYNTHgZrDwaBFRlJA?=
 =?us-ascii?q?gICBQIsFz6BawUBHAYfEgIDAQICOlcNgXgCAgSCL4ESgg8LQAIBC209NwYDC?=
 =?us-ascii?q?xsGPZgzgzyBXWMMNEkvOpYXAa9rNAeCOIFngWQMmGGHCwYTL4QETYxGhjsOB?=
 =?us-ascii?q?pMFLphYIqNcI4UggWg6gVwzGiSDNk8DGQ+OIQwWHIN1jwoBuF1BNTwCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VrGIt6/BVNEyYQUCk0huk+EYdb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYVYqN03I/urwX5VoIEmskaKdhLN8AV7MZmfbUQeTTL2KjrGSuwEIeReOlNK1vJ
 0IG5SWYOeAdGSS5vyKgzVQfexA/DHRm5rY49s2gk0dPT1CWuVF1UNUGwybGkp5SE1vAoc4Lo
 OV4o5iqyC7cXoaQ8ynDj1dNtKz1eHjpdbDW1orFhQn4A6BgXeB76P7KQGR2lM7XylUybkv3G
 DZm0jS57mlsdu81hjAvlWjnKh+qZ/E8J9uFcaMgs8aJnHFjRupXp1oX/m4sDU8sIiUmSkXue
 iJhy1lE9V46nvXcG3wiwDqwRPc3DEn7GKn4UOEgFP4yPaJMg4SOo5kv8Z0YxHZ400vsJVXy6
 RQxV+UsJJREFfpgDn93d7VTBtn/3DE1kbKqdRjx0C3bLFuI4O49eckjQlo+dY7bVbHAbkcYa
 BT5Jq23ocaTbuYB0qpwlWHjubcEkjbJS32P3TqivblqAS+o0oJtXfwvPZv+0vo1KhNNaWstN
 60Q5iA0os+O/MrUQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AM+1n+2hqndMPfYpwe4X/InA2+jJuQE3a0m+KAxC?=
 =?us-ascii?q?EMUl5GbmJZ1K06bNBnJ87?=
X-Talos-MUID: 9a23:EjKBsgbBsVbRKuBT7gbohg1vL/pU2uf/S0Yji4svt+C1HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241377793"
X-MGA-submission: =?us-ascii?q?MDGQSDdQETrBcGbeDtgSueP1deeCMWKPrRZFWp?=
 =?us-ascii?q?Og4vHbiatPNO4wOqyy0QXC+4gV0aqAZbYP/xZnAgx0LK/vmvLEFtdecE?=
 =?us-ascii?q?Wd8Z0q8zfSSk0ZQlA9LKZzvoIv6b3IVDbHvz7ztRnL8dHCTLCLwutTcl?=
 =?us-ascii?q?3WT8HR7jBWf1iS+mPWC+NKFA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 16:16:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759068967; x=1759673767; i=markus.elfring@web.de;
	bh=AcVJZ3zjTGDdL14Tw7LuQrtPZgPW/ebeShaSrL2ipR8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qWLpetk1NOdGaf834cP6bUAVVXFqBWk7p79h8VsWG+rMBT72O5Bv3ZigEEmNtFKV
	 jMaAd2xrXQ84vKBBNU6caX4n7t+3Bsk8SP/LJAI8OHifh4z0Z0BgauwRQD10fRg1f
	 jlgdq0KQWgv1W7JlTdHoleFzrUeq/0pVuHL3WplNzwi6Towj0vqVz9sRCDhc3Xgae
	 XCilKeizePykF6FAbgB7Uh74SjUSWpm2U0sfymlJT8eV+k/L8UijxNTRUdXk8XOuP
	 OOc0jyet1l+rvi3zWPKgpYee4joYQwue67BcociliLSYbfhOB51cMCAWhgNsT+UlK
	 aL1FrLD57fdNC5wY2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZMK-1uYGT13572-00qilt; Sun, 28
 Sep 2025 16:16:07 +0200
Message-ID: <5b8b05c8-91db-40a2-8aff-c6e214b1202f@web.de>
Date: Sun, 28 Sep 2025 16:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
 <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0hatDYEYy2uD29QN3EaTBTxU5tOZ6ZzrC5GplzxlKO1EXaS/LXk
 wOxwomn9HNCRV8/CAKUNk3V473/donib2HWXdP9U+DaiKTBXcI/8HRRbDitvM2ak8deQQfC
 B2pqx+kHnv9qLO/oGNZnhaBbkvZkaVazKppZV+65sxD4/zkl6hCi/7Qsw+b5ExD7OK1o5O2
 j2HWjmR1BqaT70uYtC/wA==
UI-OutboundReport: notjunk:1;M01:P0:Z4NZJCk4/dw=;dA3orOOxN1X2hVgjehhdf9uVwzt
 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
 03S+Q==
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3051
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/5b8b05c8-91db-40a2-8aff-c6e214b1202f%40web.de>

>>>>> +virtual context
>>>>> +virtual org
>>>>> +virtual report
>>>>
>>>> The restriction on the support for three operation modes will need fu=
rther development considerations.
>>>
>>> I don't understand what you mean?
>>
>> The development status might be unclear for the handling of a varying n=
umber of operation modes
>> by coccicheck rules, isn't it?
>=20
> I'm sorry, I still don't understand what you mean (the problem is likely
> on my side).

The development status is evolving somehow.


> Do you want me to change anything?

You would like to achieve further software refinements.
Did you notice remaining open issues from public information sources?


>>>>> +p << r.p;
>>>>> +@@
>>>>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print=
 PTR_ERR()")
>>>>
>>>> I suggest to reconsider the implementation detail once more
>>>> if the SmPL asterisk functionality fits really to the operation modes=
 =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.
>>>>
>>>> The operation mode =E2=80=9Ccontext=E2=80=9D can usually work also wi=
thout an extra position variable,
>>>> can't it?
>>>
>>> Can you please explain?
>>
>> Are you aware of data format requirements here?
>=20
> Apparently not, I'll be glad to learn.

Each =E2=80=9Coperation mode=E2=80=9D is connected with a known data forma=
t.
The corresponding software documentation is probably still improvable.
Can you determine data format distinctions from published coccicheck scrip=
ts
(and related development discussions)?

Regards,
Markus
