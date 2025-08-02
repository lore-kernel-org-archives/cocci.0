Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8A6C87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OzfipE0+mvzOhXve+kj356HUkyPrjCj5L5R2EaZecU8=;
  b=eo+XVeTF15N4conRZlxsxcnYbytRGbdzTLgOV4O1WVC2f4WQkkIwAakb
   8/DB7abyErYPnmI+Ea7Xot5aLoLijfO0b/yFEGxCMGDVV3mKgEwcUkzB8
   yPIRfV/YI79ErQ3PckmH3XTWVYr5lnzCMqH2J65QeteVv5yNrzf0j1PVc
   o=;
X-CSE-ConnectionGUID: 3QpAdveeSR60aGZt3zyXRw==
X-CSE-MsgGUID: 5Z4mgj2HQa+n8k98bLAOkQ==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233958033"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 15:33:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB62DE0C55; Sat,  2 Aug 2025 15:33:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AF6EBE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 15:33:08 +0200 (CEST)
X-CSE-ConnectionGUID: dgbjm3DKRW6peXqjyp+6Bw==
X-CSE-MsgGUID: UK+dNNK5TKC1Y5gpTRYNJQ==
IronPort-SDR: 688e1394_sig5EUq1eZ6qMNXjJCdx/ufMPCh+6cw9pStR3h/wGE9Stv6
 y96XAsFBDk3tKfLbW1cVCfZ5lOwO++QJOZJr6Kg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GFAAA6E45ogAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQZUMwQLSYRVj1CCIQOEO4c8kE6BVYF9Ag8BAwENTgECBAEBA?=
 =?us-ascii?q?wSCDIJ0AowaAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICVgYBFAEBgn6CIgEGEAEDDiQHsEqBMoEBggwBAQbaX?=
 =?us-ascii?q?h8sIlmBZAmBGy4BhWyCZAGGJ4NCeicPgVVEgTyCUjE+hEODW4JpgiaBFoNjj?=
 =?us-ascii?q?QSIcFJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCcrT4IidYF5Q?=
 =?us-ascii?q?Rk/g1MeBm0PBoEVGh4tAgICBQJDRYFgGQYaQAIBC209NwkLGwY9k1SDIYEJg?=
 =?us-ascii?q?QxxFYEOliavbDQHgjiBZ4FkDJ9sBhMvl1IOBpMFmQYiqR+Bbw4lgVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIYQzvVpBNTwCBwEKAQEDCYVGAQGLW4FLAQE?=
IronPort-PHdr: A9a23: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
 /Pt6az1J8IfO9+js3E=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0XLf3a1E9bElL9aECNhKEQqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3A4vbM7WkOHgflaycfpI492//4ldjXOXHSxnXVeGO?=
 =?us-ascii?q?bM1k3ULClUF2B4OA6udU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABm74nwzz/bWueHaNZuUNeTxGNWCaqJmNS0wrt7Z?=
 =?us-ascii?q?bh+qvbB0tNC+htgWRYLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233958017"
X-MGA-submission: =?us-ascii?q?MDHQ/NvzMhDMrgwQSZt5l0nXKUZw7e8nyJIoFq?=
 =?us-ascii?q?/5QIAJbhigSQqXSp1k5TLwIuZvqf5yZ6exXOSyQNllmSlh7wKFZ2GxaQ?=
 =?us-ascii?q?sJYY7Tn8dvbFceZjf7BX97kUNgKKkEeBzd6Z5u3rnxJBmHdVX4X4zYs2?=
 =?us-ascii?q?/TDpWjKF4tiWXQHHV0qkwnmQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 15:33:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754141587; x=1754746387; i=markus.elfring@web.de;
	bh=OzfipE0+mvzOhXve+kj356HUkyPrjCj5L5R2EaZecU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uUlf520xt7d4EqcTASMO2BJWTV83C5DdAp/oOM4/Kyz/bjXrZmMAImlvdQ/IUm8B
	 hMTPk6UpS2QspHoJqGTy1C3YINGM3l4wWMsV6RwQo29vZVDdnlm3hI2/2MpDGDhFL
	 DA3EctKO0Z1iBaTXvfRxyOIDM6jJdZjAD+s4cp3tAbzx3sFnPLawvN0vuEASVJ+eg
	 0V8tNfFBylx6Z3O7wv1NPd73m9TMVXYpeygaYsKJ0oxCb0L2/USqONr6DoM6yYp9L
	 Yu2dfHMN5km9nO6GIUNLk2lBgsrK84OZgE2Gv+otpZ4S28XKgZC4k7fFV8n6I3gxN
	 uBXySHA2Vub98eFFEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1v08kU1EbR-00VQTf; Sat, 02
 Aug 2025 15:33:07 +0200
Message-ID: <04403bf5-82f6-4c23-a217-0063f802e8ed@web.de>
Date: Sat, 2 Aug 2025 15:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NzD8KTt0NeLEhAstsEgC7LX5yGzK1tPNSrHulCQmAoPdzHGHwPO
 /FLm2AqA+OEhNYizOFggar72OygTj5/gAVDZ3Uc4+saO/x5ZMseC53Sxqmu9Cx4l42B9CKK
 iOyYZWAFGUMZUQxNekKy3fjbjQyc0zBZUxY4rTTKj8L1uVXKXhKhbqjiIuYECOQvyHvAAwC
 YTyuJykMnarnkgTGdcPSA==
UI-OutboundReport: notjunk:1;M01:P0:M40pTRJTy6o=;8pDnIKqODumATcSnfUP95rDlsUR
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2934
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/04403bf5-82f6-4c23-a217-0063f802e8ed%40web.de>

>>>>>> May I expect that only a single call should be marked for such a te=
st case?
>>>>>
>>>>> No, I already explained why two calls are marked.
>>>>
>>>> I see further challenges with this explanation approach.
>>>>
>>>>
>>>>> The shortest path constraint is that for A ... B, the ... doesn't co=
ntain
>>>>> A or B.
>>>>
>>>> This is generally fine.
>>
>> How does the =E2=80=9Cshortest path=E2=80=9D fit to the statement =E2=
=80=9Caction_lock(&blockage2);=E2=80=9D
>> from the if branch in your software view?
>=20
> I explained it already.  If you have A ... B, Coccinelle doe not allow A
> or B to occur in the code matched by ...

How does the second lock call fit to these criteria?


> A problem that you see to insist on causing is that by using * you have
> no idea which matches involve which pieces of code.

Partly, yes.

The source code search patterns can occasionally be constructed with more
unique context data.
I hope still that undesirable data processing confusion can be reduced fur=
ther.


>                                                      If you would print
> the line numbers of the involved calls then things would be clear.

I hope still that a better consensus can be achieved also for safer applic=
ations
of the SmPL asterisk functionality.


>> Can the path distance be determined anyhow?

I would appreciate a more helpful answer here.


=E2=80=A6>>> independent.  There is no guarantee that one match will not c=
ross another
>>> one.  Furthermore, (just in case this is the concern) when you mentin =
two
>>> different metavariables, there is no guarantee that they are not bound=
 to
>>> the same term.
=E2=80=A6>> Will it become more desirable to distinguish metavariable cont=
ents in an
>> unique way?
>=20
> If you want something you have to express it in Coccinelle.
>=20
> foo(A)
> ...
> (
> foo(A)
> |
> *foo(B)
> )
>=20
> ensures that the marked foo(B) involves a different argument than the
> matched foo(A).

Would you like to provide a =E2=80=9Cguarantee=E2=80=9D here?

Regards,
Markus
