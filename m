Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E298C7618D
	for <cocci@archiver.kernel.org>; Tue,  4 Apr 2023 05:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UDEvYOfejZUR4FaBTx6W3FWKJbZJ1S6ynv7ZPnFy/sA=;
  b=LcM4tGi4jgGDIv7xloqHtgOssTUxWA2hrgG360FQErfpOP+lgPS6A7zZ
   Lobs8xSUgOmWm90KBGx8BcURWbymQsW6LdhkRO7xJZa04C3lsrBcwD67I
   PUxKd2dY+CT4z4IXMqXwv3MHbvg8juvAY5tXABrcSPe0tYGBpDV/wJWCI
   g=;
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
X-IronPort-AV: E=Sophos;i="5.98,316,1673910000"; 
   d="scan'208";a="100553716"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Apr 2023 07:37:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2A302E013A; Tue,  4 Apr 2023 07:37:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5ACD9E00CE
	for <cocci@sympa.inria.fr>; Tue,  4 Apr 2023 07:37:32 +0200 (CEST)
IronPort-SDR: 642bb79a_B0X6X3yiVBB4GUkoWA0o4fUE8qp0Jhm5J0fzBwhvDLwxxye
 4T0v1c/YbtllqhjWwKrdp66DiX6NILEdUF5i69A==
X-IPAS-Result: =?us-ascii?q?A0EvAAA5titkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItdVYvBAtGCIRLkQEuA4QvjmyIaoFWgUA+DwEDAQ09BAECBAEBA?=
 =?us-ascii?q?wMBOIQBRgKFPAIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDToYOz0BAgIBIx0BAREnDwsaAiYCA?=
 =?us-ascii?q?lcGAQwIAQGCegGCJwEDDiMHDAasOYEygQGCCAEBBoFAARVBmXMfLCJUgV4DB?=
 =?us-ascii?q?oEULQGNB4QwJw+BVUSBPIJTMD6CYgEBAoFeg1uCZ4EMjSyCeog/gTR1gSAOg?=
 =?us-ascii?q?T2BBAIJAhFrgRAIZoF7QAINZAsOb4FKgn0lBA4DGSsdQAIBC3U/NQkLIAZYa?=
 =?us-ascii?q?wIsERMFAwsVKkcECDgGHDQRAggPEg8GJkQOQjc0EwaBBgsOEQNNgUcEL1x8C?=
 =?us-ascii?q?gZLnhNLLisighs6kk+wNDQHgiqBVYFZDIoNlQAGEy6DapMfDgaSJZdwII0zm?=
 =?us-ascii?q?kmBZQE3gVwzGiSDNk8DGQ+OIBmDWTOBC449PzQCCTECBwsBAQMJhUYBAYV8A?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LtPzwqrUkyx70JLwgIk6ofUaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,316,1673910000"; 
   d="scan'208";a="100553710"
X-MGA-submission: =?us-ascii?q?MDHlNmRtoP0Hc3GqF8oVP7+Ebg/RtPFIq8JVqY?=
 =?us-ascii?q?hKm91ARgGYjl3a9l8aeUKKa5FM/e61yKhaONjsRJT263R/oOeNPGFFBg?=
 =?us-ascii?q?mRy6aR22r5BPBIPZGr5w2AuNOyv70ijvvF1h0lQAUyBiONr8FIKcx5I9?=
 =?us-ascii?q?8d5d9do4ul7ZDXFYFiZBsRpQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 07:37:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680586651; i=markus.elfring@web.de;
	bh=UDEvYOfejZUR4FaBTx6W3FWKJbZJ1S6ynv7ZPnFy/sA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=b0guWJcFPQOEDx7uZS03TG4vRh1HuEab76egw+M0s6zW1YwjCw6YeynBvX8wLqJcf
	 6L7VZANcobg30ICMXRsi4QmEOa+DMUFk7IPM2+SR16FGpXFYpT0kwzszuRWj0TcI02
	 TPn9twlJRMvmr4fQo9pgKLn/fEMeKs2a/7+7YJ0Z1mTr0kVZDI7FX0rnSBByLX3254
	 7qa3+B3cA/T9uzJ0o4CBtc+Hv/UBjdVVWfiHl0+q3f/A7yjFhDuzeh3+dO9iEin9Al
	 Umckw/nojJi7Sh3zb669EzLog7ZogzjiihrZRmdMu2RM6ioIdiObZTEOM9XhDDwlZ/
	 FdYJl7n6E6KgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4bO-1pXzZx1qp8-00BeMc; Tue, 04
 Apr 2023 07:37:31 +0200
Message-ID: <58d22807-63f2-da0d-e1a6-84210cb81e66@web.de>
Date: Tue, 4 Apr 2023 07:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4bd84094-5838-c630-d1ec-d2d6bd0380ea@web.de>
 <b59a8472-95df-b592-78d6-9543aef463ac@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b59a8472-95df-b592-78d6-9543aef463ac@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34SDGdhsGKfpLofFWQct61sMGMpQmYadSWoB8iWbbJFIVNgiJPt
 zMFLrsCtLeUtlgf2FXkqvGLGESflIGvP9phxBRn+l1lSeGtMB+R30GhRMWXuEahgdEidfdT
 h7rO8R7svUVxfNNEtGu/hwfG3pyCM2i3gAc0bZxUQA5MghsCFMGLn5MzHmTwiCS4uKJ2Iw5
 KTp14wcJblDXcihvzzbeg==
UI-OutboundReport: notjunk:1;M01:P0:mLZpJWDn6M4=;0dXtUXACzCi4D8RtdzEcb8RF3WN
 BeycfwreFIbbPwoDy5TBbg8P6XcQgG5Afgnox2e4ITg6BIIDHfc7PGOSFpNXq/uGJzc6HA3xX
 LLH/1XxyayWL1GqmmMZL3sJURE3Ram5TRLQXwj+OkfPew5SU3k+mYoCevvP/f7RWrvW7cE4Fn
 xO14T1ecPnljCGdnF5S17NmRP/GlbbOV54cYT3Q3fYdTAQ8D0sz+i/vDsZP3VLPL2kEMtIZGX
 8mE7w+wHjxpRytHraE2oQ1JXr7DoQUH320ewFqEnJVH+g2R1F6swXF/4K7IBURLFOgphaxZv8
 2H6Vj3iq+/Deri/ijhNDmf/Ge9DNO+F+c3CPQkwijjh0RTM2DZxUS5dDrfMHlajogDjd0hLCq
 +9iKTRG41f1YWSh0AClY/ynDylIBc8/5/KDEPyK+URTqKQv5M3WaHoCdbunfayK7AGV+KL3B2
 xtUn2jSKWK+IJTviMThrmtYBcoD/qpNykP1C0vft1T4vfrmoUwECHOBWWdiRrzTDQXopHIUi4
 ZHugh/t69UPpU2gybpSsP0lGhgQIWuNH6GuoaUvQAUsow6KaYu6NvP8MU5l9LlYS0nPx8sgax
 /BF4+AKC6k9X9k6Lj6SdeksJk2JAy3Kk9dbpl66x7xcS42pFDwZuRzbacFEaihUJTKSryjCDK
 KS3Em+U23ZxKZTDBSHKCPJY9XdaymNsoHF7xhXnDRwMpP5nptnH7aR6tk1mSBgWbO0bLX1VrP
 qxbQ06VbVn03QS5VtjKPwAIHJqUtzwN7S1sts+E2UZRQVCyY73rjwz2EX1pYBEdzBX+xXvGFq
 pjfy0fNOg1Hk6stbDNVkqxW/ikbRPBX8PFRR5G5NKBoetQgncDLP9QiPGsGH1fPgVPviOdkHU
 livYRKuclU2KIk1E9eXUvbm84CORu6MmL1krMGwkw/8JR/t1juew+5DmV
Subject: Re: [cocci] Completing support for fork-join work flows
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 999
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/58d22807-63f2-da0d-e1a6-84210cb81e66%40web.de>

>> Complete support for fork-join work flows
>> https://github.com/coccinelle/coccinelle/issues/50
>>
>> Will the chances grow to benefit any more from parallel data processing
>> also by the means of ordinary output into different files of tasks
>> (or background processes)?
>
> It has been possible to have initialize and finalize code for many years=
 now.

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e910982fe0830c9dccc9a=
8d3a4639484947a7559/docs/manual/cocci_syntax.tex#L658

Would you ever like to distinguish the scope for such actions?

Regards,
Markus
