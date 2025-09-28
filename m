Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4225CAC5BB
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5kSYwI1fExW/VBymyR86n7aGbGDd7UxkPNzpe285Cuo=;
  b=cwGvLENT5Z9AwQ8+lOTIjZH7L7dVvO6QehDomCm/fPvLiRGJp/BLEucA
   8Xx/LWoIh8+BQvsT01kby8QPjvAR5fmfoIITjALx6/RS7NrwPRkL3Hnuy
   u+eVQXAYqnVCQ204KwVPC+N6K4otEVy+zu/vY/5v+AJ7B2j2UWbGB1iHj
   g=;
X-CSE-ConnectionGUID: /u5Thk5ySiO6dWf0zBAaVA==
X-CSE-MsgGUID: fb6aDqEiRiWaUKkVoe962g==
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
   d="scan'208";a="241371635"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 14:00:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4C783E0B0D; Sun, 28 Sep 2025 14:00:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DC1B3E0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 14:00:34 +0200 (CEST)
X-CSE-ConnectionGUID: HOxN2x7JTaCpKmwaNd3a3Q==
X-CSE-MsgGUID: Ps6MFykpS8iuIQb40pUq0g==
IronPort-SDR: 68d92362_EsbPrAjmG/gnBOguvzcdDaES/aZNG0QS21h+JlH+lJYzEIC
 2HDPPq5YLNkZVqM8nw8B1sUSbYArWVlls0hAPqg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EGAACBItlogAMP49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYI/ZSNUMwQLSYRViByHNIIhA4Q7h?=
 =?us-ascii?q?zyQToFVgX0CDwEDAQ1OAQIEAQEDBIIMgnQCjEYCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAkdEAQEBAgEjBBkBAREmAQQLCxoCJgICVgYBFAEBgn6CI?=
 =?us-ascii?q?wEGEAEDDyYHtF1/M4EBggwBAQbaXx8sIlmBZAmBGy4BhWuCZAGFbDuDQnonD?=
 =?us-ascii?q?4FVRIE8gwM+hEODW4JpgiaBFoNYNoIohECFO44zUngcA1ksAVUTFwsHBYEgE?=
 =?us-ascii?q?DMDIAo0MQIUDRASDwQWBS0dcwwoEmWDB4ENg1lFK0+CHHKBAHQ+GUGDUx4Ga?=
 =?us-ascii?q?w8GgRUZSQICAgUCLBc+gWsFARwGHxICAwECAjpXDYF4AgIEgi+BEoIPC0ACA?=
 =?us-ascii?q?QttPTcGAwsbBj2YM4V8gQkRHjqWFwGvazQHgjiBZ4FkDJ9sBhMvhASNE4Y7D?=
 =?us-ascii?q?gaTBS6YWCKjf4UggWg6gVwzGiRPgmdPAxkPjiEMFhyDdY8KAbhOQTU8AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:v+a77aAXZypbghrlHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AzUKUBmmY/2EUl3N+mzIZTLAGEgHXOV363FGKMxC?=
 =?us-ascii?q?aNW9CUJ6QVla29PhtyPM7zg=3D=3D?=
X-Talos-MUID: 9a23:qee3eAvCIcqs5YDSIc2nvCo8Eel54LyVWEEQsKwM55GcCDUoNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241371627"
X-MGA-submission: =?us-ascii?q?MDG813X5RP0h6xm+JqMBIgy9FqmMOmkY/RO5rD?=
 =?us-ascii?q?l1nfakB7fCcE/gPQ8Azwfm7HlQVG/duEU7K3BKwCu3zhXBdJLPvCAXYb?=
 =?us-ascii?q?oQGt6TD6TwK1ltb3VRWwXQqkL4PKoxutsfOlCCN3HjizAqTf/zXr0mZu?=
 =?us-ascii?q?vodRwWvIe+DXJj87NfisluXg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 14:00:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759060833; x=1759665633; i=markus.elfring@web.de;
	bh=5kSYwI1fExW/VBymyR86n7aGbGDd7UxkPNzpe285Cuo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=klqOJub7aVEase4NRs9heDLJlXSe81jwoJN0cLW2VhydwqvXrHFaMe5QOzPnL53t
	 w7ZMtpJvf22W1Zs4+w3P8juPYs2rXFUp+/+cGoVJz71YgLZfeFaG2acmD6xBgLdm1
	 0dZNmsiLIFz+Clt1ajr9T1I6ZAyjpQSr+B3Qv/zykO4XCmKJewEwYMizvU98apB2H
	 whrvV2wI5romcXzYiNocI1nJ5KnwG8bU+Q+anu1fj8p6UC5cYR5V87gLA5E4dV3vE
	 QNr9Xdhbs4BxEdm8+j000Qj+23D6+m9njBMPS0Yb16FZJek8CaM5oTaEG0dcba/8k
	 Y3f15ic6lsiWf3bMmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZI5-1urbeC20AD-00TjJO; Sun, 28
 Sep 2025 14:00:33 +0200
Message-ID: <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
Date: Sun, 28 Sep 2025 14:00:30 +0200
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zfRoYHOv6NQNX00nJwlkyn01nCtvVFnA6CNWxWYxczxDu5V7M5M
 lFTjtzJl6c6WhN3yNpedS5tjCPdW5XPZYK3Q0sOTA64oYhaXCAx6yr3CTOCuJYTVj7mu7pP
 JVGnLIQCX7QTCp/yIOckjYa4Sgise9SiYDwEgke2IGX6gl8msx8c6GX5FwHDWCdmciIgEht
 crTONWAzPUibicFTJI/sQ==
UI-OutboundReport: notjunk:1;M01:P0:ruhJg9TlPTE=;13uZiVnD11nrb44LTjzDnsZTiSB
 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
 sqzqQ==
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3045
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/8b0034a7-f63b-4a98-a812-69b988dd3785%40web.de>

>>> +virtual context
>>> +virtual org
>>> +virtual report
>>
>> The restriction on the support for three operation modes will need furt=
her development considerations.
>=20
> I don't understand what you mean?

The development status might be unclear for the handling of a varying numb=
er of operation modes
by coccicheck rules, isn't it?


> I did find "format list" in the documentation, but spatch fails when I
> try to use it.

Which SmPL code variations did you try out?


>> Would it matter to restrict expressions to pointer expressions?
>=20
> I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
> didn't find anything. Am I doing it wrong?

Further software improvements can be reconsidered accordingly.


>>> +@script:python depends on r && org@
>>
>> I guess that such an SmPL dependency specification can be simplified a =
bit.
>=20
> You mean drop the depends on r?

You may omit =E2=80=9Cr &&=E2=80=9D (because the rule is referenced by an =
SmPL variable declaration),
can't you?


>>> +p << r.p;
>>> +@@
>>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print P=
TR_ERR()")
>>
>> I suggest to reconsider the implementation detail once more
>> if the SmPL asterisk functionality fits really to the operation modes =
=E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.
>>
>> The operation mode =E2=80=9Ccontext=E2=80=9D can usually work also with=
out an extra position variable,
>> can't it?
>=20
> Can you please explain?

Are you aware of data format requirements here?

Regards,
Markus

