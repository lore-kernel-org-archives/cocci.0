Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20549CF34B0
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2024 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=x1aRqowk+avzQDXULHwlYV3N6dqI2bTShLMMxvbXA68=;
  b=Slx/H1lQzOPxerj+Nxln3k5ek5jBch23EOs0d0FruqnjL5GYYrnWdJ6Z
   EpqxyQWeY8abNl4XUbEMlUW3fKXYAfc0yf4qxpoMq8D/IWy+twQt9AwzQ
   U8SciKn4jqza9gzgJIxp7BJz0z9Ny+LiwUfY2b4ZyBH/PaL/afF6hbJwE
   s=;
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
X-IronPort-AV: E=Sophos;i="6.11,175,1725314400"; 
   d="scan'208";a="186841473"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2024 19:05:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 77AC0E0CD0; Thu,  3 Oct 2024 19:05:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D1F55E0035
	for <cocci@sympa.inria.fr>; Thu,  3 Oct 2024 19:05:28 +0200 (CEST)
IronPort-SDR: 66feced6_a6NZ8k2WglCPnnNYS0YPHspUHVCL8pJVKOa7TcClnU15vzg
 t9rB6gp2n5Py56grCDFMofZdQFTqFfe0HRS+6Hw==
X-IPAS-Result: =?us-ascii?q?A0ETAACbzf5m/07ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYJDB3YGVDMEC0iEVogdhzCBdTCEO48OhG+EC?=
 =?us-ascii?q?IFWgUA+DwEDAQ07BgECBAEBAwQ4gzSBFAKKGAIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQgBAQUBAQECAQECBAYBAoEKCAuFNUYNgmMBEIEUgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEXAg06RAEBAQIBIx0BAREmAQQLCxQGAh8HAgJWBgESAgEBg?=
 =?us-ascii?q?n0Bgi8BAw4jBw2xXIEygQGCDAEBBtpbHywiV4FjCYEaLgGISgGFZzuEPCcPg?=
 =?us-ascii?q?VVEgTwLgkcxPoRDg1uCaYdvih6LbiWBI4c5cJF7UnscA1khEwFVExcLCQWJO?=
 =?us-ascii?q?AqBeX0FISmBRSaBIIJ1CIErE4EGAoJXgWcJYYQ7gjxwYoENgT6BWQFFgRcGg?=
 =?us-ascii?q?VYvGyQLXoFDfzMGFQSBJQU4Cj+CUWtOOQINAjeCKCRqglqBJwQFg2uBUR1AA?=
 =?us-ascii?q?gELbT01BgMLGwY9rF+BW0iDVD6BIUXGSzQHgjeBZIFjDIonlSsGEy+EBYFWk?=
 =?us-ascii?q?WMOBpJ3LodjkGUigjSCNYZ4gXiVb4UzgWc9gVkzGiSDAgEBMglJCw4PjiE4g?=
 =?us-ascii?q?3WEYYoqAbB0QTUCOQIHAQoBAQMJhUYBAYZPgUsBAQ?=
IronPort-PHdr: A9a23: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
 BI72FMWiQsF6zrmpVs6dAOimQ==
IronPort-Data: A9a23:pAl+QKufKS+ADT6mMFa2WBHdzufnVEFfMUV32f8akzHdYApBsoF/q
 tZmKT+PM//cMTT0Lt8na9/iphkG75XRy941GwI6qHoyESpHgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNsspvlDs15K6u4WtA5QRjDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJF05IJJDqvRxOn9Pq
 qQiORAANE3ertvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaHOOVv5kBjW122ZAm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PppszSKkFYhuFTrGPfIa+SWTsJxpUrb+
 TLvwmKmIS0RKcPKnFJp9Vrp3IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyHGWohDGd0XQiBa5UtQ0ALK8vsVjgO1R4sI4Ijp1B1ToihZEb8E68tA7T3om2
 zdlWj8v6SNH6NWopbC1r994bg9e/QAKIGVEaSJsoc4t/Yz4uI9q5v7QZo8LLUN25+EZ3Rnvz
 jrMoCVWa3D/SyIU//3TwG0rSA5AanQEosDZK+kXsq+YAttFWbOY
IronPort-HdrOrdr: A9a23:ED5zjKDyKkVczvvlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo8P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOos1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:AO+s1WzYtxbweRKqO19DBgUIFd06KS3PykzOIhDgM3dJRefIFHaprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Am6QYygzrzJnlXJfGSjXHcRhIYmyaqImzGXgRmpI?=
 =?us-ascii?q?igMXHanxZBjHCrwi8X5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,175,1725314400"; 
   d="scan'208";a="186841428"
X-MGA-submission: =?us-ascii?q?MDHGMs4xYZfF8nhUMQGCfAttd2wQCdmZKa+OI8?=
 =?us-ascii?q?GK2lrrMGvz7OWYTO8UUkea1M3msakMCD18VIx+GsJEpKQZVfEWPnlQJn?=
 =?us-ascii?q?Y7X1wDnBoKAB1C7+MabvpOCxMRT10Khd+CCD+sIKhDQuEeL7MX2YQ+BO?=
 =?us-ascii?q?HktqsNFc5ne6+TRfICM+Bo4g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 19:05:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727975111; x=1728579911; i=markus.elfring@web.de;
	bh=x1aRqowk+avzQDXULHwlYV3N6dqI2bTShLMMxvbXA68=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BI3RaFUO/IqVYSLIno2H+VgC6jRTGjRmvO6ARpvkaeM9bjGR7UaJ+cyudJiy/paW
	 SShRUCuF6za+2AiFLI6lVnpynfYCOXFXqTWcjjt7fFefj/HC/winOHm8gYeyejcNN
	 zep2PkPh2WYZ3TCEvTz9rAc3vK5rTllKtNDjXO1CUUSnbBNBtdzPnw+HR5gNCyRD2
	 yH2AErWcst71WingjBzq0LapmAha0LG4cBgLdfgq5fUlTQ9FtxwVnwfRpvI7mQIgi
	 yZC5IK52zBbs484UzS3E20fbAPULj0apH7OqA5yiGqdOAOiJQ+C6ZCGACWp/XGEwZ
	 ShT/jDC8FEPzfbNKXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1sco2x49gP-00ID8K; Thu, 03
 Oct 2024 19:05:11 +0200
Message-ID: <434320e1-2a30-4362-9212-ca17cdde8b31@web.de>
Date: Thu, 3 Oct 2024 19:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
 <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
 <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
 <8949eefb-30d3-3c51-4f03-4a3c6f1b15dc@web.de>
Content-Language: en-GB
In-Reply-To: <8949eefb-30d3-3c51-4f03-4a3c6f1b15dc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l3pgyZOI07Bh3dnf7Bb4Ey6oOw4CTctWcTQzVYrYpobYkMHHXRn
 OPk51Q8pvjKkh1GXivyDLMXfVDWgV17SXTn7dpTpoMJKyR5B9MPUpKdLhFHDwMw8X8qTCY/
 MpN6c2xOvsHPMUhN+ZeRQBCKXhtupcUjNvgF5A5UqRZRi7WsV5o26c+nIi+Rs4CrKnwe0r+
 5GUf7Wh3YrZvtuVgD4Hgw==
UI-OutboundReport: notjunk:1;M01:P0:H1JxztHArQo=;cU/Cb9YdbVJnqdRJnvh/1yWlVIo
 FGsQCXXnJYaq1CgPuH5q2GZ+CEH611VtAZDvcnNaGLpYX5BAgU4/XAHIGBlD/nTs+SKQg71Ez
 OqRQzxJYKJQgHvBjH/Z3o/sbKrzHDdmuYxN2uclk4dh6P+Jbe/MRnSqDS+MIl9WYxEv/jicPY
 1b2dUSlzSK0eKhi+sgXZo9KRzMsNPW+qBmWJam+j9YiRegdxCFUbfXcYdNhK/tDWO1IL3+jqy
 nBYxZRnoPVlchx9XTqwMsdaZYe8l/AgKKocM1pMgMSuRmm58aosPDTFYVsufYGzywLcfZliC0
 3hE/79L+d227eg3CTeVTOtM8jBn0rVNPi7PP9dnEzC6or/Glmcj+XM9GI41j5wa9sxcbrg0c6
 lGSFR1BDbgrt2/hdpzqcC3WjkI6vWr7RwClPiGauzR4cczbL0e3fop8rCFfywcqDIJGkvxhXR
 HY1MS/npuLYQx3WGJ9ffLQXU+COEPhJY72h9c+PXAgywK/94sl6ixVNdjM21TSKjBojX1HNk+
 DNDyc0aTgcDPS9Es0t0e+ublIE6/Yu9+v04wYA0YydWiIBFpCCF/QQDk16KtCGoky/vjMSxS5
 rSMpHM5W8Zg6tUgI5+imto0tftAzfI7VtYpz3cu/N86DzcbS2Ck5gTdhC2QhHkMoR12wxpAhT
 6sCMn3+R0HBf9Jn6d+YPSY9H4cJ2VVkDCGyX9ARdlrnB6TkaqIhiWoinZUGYEXL3H8SJgArqf
 xkum2OQsKay1suUH7SACttEn9BJIMJyw2iwJw1kz0ZBhc+rKR3Pghhl3e8Qgv/SoLiSp5sEhT
 bbNhhBUhEWjGPwtEl3UmwuBw==
Subject: Re: [cocci] [PATCH v2 1/2] powerpc/pseries: Do not pass an error
 pointer to of_node_put() in pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1907
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/434320e1-2a30-4362-9212-ca17cdde8b31%40web.de>

> Date: Tue, 21 Mar 2023 10:30:23 +0100
>
> It can be determined in the implementation of the function
> =E2=80=9CpSeries_reconfig_add_node=E2=80=9D that an error code would occ=
asionally
> be provided by a call of a function like pseries_of_derive_parent().
> This error indication was passed to an of_node_put() call according to
> an attempt for exception handling so far.
=E2=80=A6

I was notified also about the following adjustment.

=E2=80=A6
 * linuxppc-dev: [resent,v2,1/2] powerpc/pseries: Do not pass an error poi=
nter to of_node_put() in pSeries_reconfig_add_node()
     - http://patchwork.ozlabs.org/project/linuxppc-dev/patch/f5ac19db-c7d=
5-9a94-aa37-9bb448fe665f@web.de/
     - for: Linux PPC development
    was: New
    now: Changes Requested
=E2=80=A6

It seems that I can not see so far why this status update happened
for any reasons.
Will further clarifications become helpful here?

Regards,
Markus
