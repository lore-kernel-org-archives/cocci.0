Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F270C433F5
	for <cocci@archiver.kernel.org>; Wed, 16 Mar 2022 23:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SsNLzRNKfncwYy4bOquRkj8PydtMMWmySeK7KGLkleo=;
  b=Pm9oXXrmhagaAdFvcNKS8BqwzXY+bIygcdVtBDuH8pJmpfMoo8Z8g0zm
   +SOHZgVyXfQKZHOJ7AEaNSuCnuIA+uiYbBggzn34aEML3LX6bVvhgJEVZ
   uiE7Die3lWzfzIik0lQsToEEKO0OwWIUWjW5XjFPwvFO8Pqp1ofZM7RsO
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,187,1643670000"; 
   d="scan'208";a="26545641"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2022 00:02:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E82A1E006C; Thu, 17 Mar 2022 00:02:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E549E0030
	for <cocci@sympa.inria.fr>; Thu, 17 Mar 2022 00:02:53 +0100 (CET)
IronPort-SDR: 8ozLnebOzrLyiZflwxGxD6GM9kxTZJ3FS5x1iAUp6Nv3gBJZT+/fsbB7o+ey7SFXko3PYZTfY3
 aJI1LQkfF5dZwM1HNJa3UUob764UE2F4tzP/gjYcRhwDN6+SDPiHXPMp1NiwWuUfFqQ7UnS6Z9
 d07X2wdAyBJ5+Jse9LL5e3sNwblYSGJghNUFQG8MByTqbqwh9Ya5W9PjAq56XHnooVV2SCHkC8
 voSgCChGyfFS+yL3/Esxi3tv/VOpqRToIPHNWhyKT6CA+8I+Bjw2iN4C3EFUlCb5WQ1ZXmUxFi
 hMV2CPw8v6B67eaWJG3R69hB
X-IPAS-Result: =?us-ascii?q?A0DoBAAFbDJi/0Xcza1agQmBWoIoB4FNAQEBKQQLlAuCK?=
 =?us-ascii?q?J5eCwEDAQ1BBAEBhQcChCoCHQYGMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECAwQBgQgsAWMBZwGBTgGBeQYEPYI1KQGDYwEBAQECATo/EAsYLlcGg?=
 =?us-ascii?q?xeCdiGuI3iBM4EBiXuBPIYUVodfJxxAgU2BPIJTMD6KRAScHKIOiyiSa4NTn?=
 =?us-ascii?q?1oaLoNhkmSRdJZZoUiFOIE/OCaBWR8UGggmCoMlTQECAQIBDAECAgECAQIBA?=
 =?us-ascii?q?gEIAQECAY4oFhWOOSEBAQFpAgYLAQEDCY5ZAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:240qg6/CPo8QWSDsej5EDrUDvXiTJUtcMsCJ2f8bNWPcYEJGY0x3z
 GUeD2qPP62CYjGmLdp2a4/n9h8HucTdzIA1QFRl+HpEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 oqs+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zx
 sddl6OeaSMQBKDMlMtBd0Z5Si5BIvgTkFPHCSDXXc27yl2AfmTszvhqAVtwO4AEkgp1KTgRr
 rpCcG1LNErbwbznqF64YrEEasALJ87gN4I3vnB70SqfAOkmTJ3HTr+M49JEtNs1rpoQQKqDO
 ZFHAdZpRE7SRiZ/NX0QMcgnxe6ihFeldB9yq03A8MLb5ECIkFIqgee9WDbPQfSBQs5en26Dt
 2fe9iL4BAsbPZqR01Kt9nuzj+vLtTH6XYgIHfu58ORriRud3AQu5AY+UEv9rOa5h0O6VsgZL
 UEIksYzkUQs3EK5XvvCcT2cmUSJvhIzB/4PMrQ11x7Yn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1oj/5OdB8mObKFi/Fp994uRv3aHdFdzZTDcMRZVJdu4GLnW0lsv7Yoj9e/EOdi82zFC7wz
 j2OoTJ4gbgP5SLq60lZ1QuY695PjsKVJuLQ2ukwdjv4hj6VnKb/O+SVBaHztJ6t7O+xFzFtR
 kQslcmE9/wpBpqQjiGLS+hlNOj3u6nfYWWD2gQwQ8BJG9GRF5iLJto4DNZWfxgBDyr5UWW0P
 ic/RysPjHOsAJdaRfQrPdngVJRCIVnIGMvlW/3QY8BPZJM0LFbvwc2dTRX44o0s+WBy+ZwC1
 WCzKp/9UyxFVfw5kFJbhY41iNcW+8z3/kuLLbiT8vht+eD2iKe9RehXPV2QQPo+6a/Y8gzZ/
 8wGZ5mOyg5DS6vzfSna/IoeNxYMIGRiXcL6rMled+iiJAt6GTh7V6SLme54J9Voz/ZPi+PF3
 nChQUsGmlDxsn3wNlnYYH5Ubr6yD410qmg2PHFyMA/wiWQje4um8IwWa4AzIes87OVmwPMtF
 6sFdsyMD+5hUDPC/zhBP5DxoJY7JEavhBmSJGyofzgycpptXUrP98O9Jlnj8ywHDyyWs8oio
 uT6iliBGcdaG11vVZ+EZuiuwlW9uWkmtNhzB0aYcMNOfEjM8ZRxL3KjhPEAI/YTdUfJyAyc2
 lvEGhwfv+TM/tE4qYGbmaCeoo61OOJiBU4GTXLD5LO7OCSGrGquxYhMDLSBcTzHDT6m/bXka
 PpVwvz4PedBmltW6tIuH7FuxKM4xt3uu74DlFg/Ri2WNgjyB+MyOGSC0OlOqrZJmO1Ttzy2b
 V3TqNNUDrOEZZH+G1kLKQt4MOnajaMImiPf5OgeKVnh4HMl56KOVEhfY0uWhCpGIOcnOY8p2
 7586ssGrQGgihcnNtucyCZZ6z3UfHAHVqwmsLAcAZPq01B3kQsaPMWAUyKmsouSb9hsM1UxJ
 mHGjqT1h4NDmhjIfU01GCWfxuFan5kP5U5HlQdQO1STl9PZrfYrxxkNoy8vRwFYwxgvPzif4
 YS325mZ5Jli/guEQOBGTyahBAFMCRmU4Ar3xkdheKg1iaW3fjSlEYH/Eb/lEIMlH6Z0ejlA4
 KrexXnlXDvucdu32CYuMaKgRzoPUvQpnjAvW6mb8wCtG5ghfSGjj7CuaGcMpgGhB84t7KECS
 S+G484oAZDG2eUsT2HXxmVUOXn8iPxJGYCafcxcwQ==
IronPort-HdrOrdr: A9a23:N7hRhK7xHnNFndQQLAPXwMzXdLJyesId70hD6qkRc20tTiT7//
 rAoB1173HJYVoqOU3I3OrwXZVoIkmsk6Kdg7NhWYtKNTOO0ADEQL2Kr7GSpAEIcBeOlNK1u5
 0BT0GgMrfNJFJx5PyKgzWFLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,187,1643670000"; 
   d="scan'208";a="26545636"
X-MGA-submission: =?us-ascii?q?MDGHR81/eXPek0qIgupRm+flW0TX99XPDd67ay?=
 =?us-ascii?q?BUfjtuiUGC43+j9DDH8YgpPCPLMeFSRjfnhmMnJEjvudyiTUZ6GkYQ88?=
 =?us-ascii?q?hpDWNNi5Dz7AsyhkUnQCqMAPOYU3UaXBW6Ic8X+Taq/dY6gcyfLn7WJq?=
 =?us-ascii?q?Ro12MZgOpkvnuQNjMzzGrvtA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 00:02:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id C3D5747;
	Wed, 16 Mar 2022 16:02:49 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CHuO8Z_Odejn; Wed, 16 Mar 2022 16:02:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id E17D939;
	Wed, 16 Mar 2022 16:02:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net E17D939
Date: Wed, 16 Mar 2022 16:02:44 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203162152370.3177@hadrien>
Message-ID: <ec9b863-f33a-fa6a-c350-7a26dfd06f2b@ewheeler.net>
References: <2ae57eac-cef9-c3e9-4ec5-5330884e7bdc@ewheeler.net> <alpine.DEB.2.22.394.2203162152370.3177@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can coccinelle match when an identifier exists anywhere
 in an expression?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 229
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ec9b863-f33a-fa6a-c350-7a26dfd06f2b%40ewheeler.net>

On Wed, 16 Mar 2022, Julia Lawall wrote:
> On Wed, 16 Mar 2022, Eric Wheeler wrote:
> 
> > Hello all,
> >
> > If I have a function like this:
> >
> > 	int length; // global
> > 	void f(int i)
> > 	{
> > 		return 10 * i * length + 1;
> > 	}
> >
> > Then how can I write an SmPL to match when  `length` exists anywhere
> > within an expression?  The expression format varies.
> >
> > This doesn't seem to match:
> >
> > @ r @
> > expression E =~ "length"
> > @@
> > *E
> 
> return <+...length...+>;

Thanks!


--
Eric Wheeler



> 
> julia
> 
