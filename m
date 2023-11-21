Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7200C5ACB3
	for <cocci@archiver.kernel.org>; Tue, 21 Nov 2023 07:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EosEUZ0nK4S+qZnLMvFL/+6ZdrFe0Z8ZAoXFRjOozyU=;
  b=ZKtZFNQm7QfnDL48PbCxQL83FwnulbAQnBh8A/cGrUyQAokq3vWX3raS
   hCaGRejCyELTkrafOMyC3G2rDTO+Km6HJmyUv6mPtu4AqlJp7NVlbb1qB
   FGNieowXAKJyOebiKIq5VXXyTl7HK7wqrTHFKszec2syIi4rfRmGN0Twi
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,215,1695679200"; 
   d="scan'208";a="137518307"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Nov 2023 08:35:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 77D0BE0CCC; Tue, 21 Nov 2023 08:35:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 87882E004E
	for <cocci@sympa.inria.fr>; Tue, 21 Nov 2023 08:35:27 +0100 (CET)
IronPort-SDR: 655c5dbe_Kw6guDt69B9FEOHIgv4onCkvNRk2yseuggkrHD+1nKzAZKr
 sysRfRFIZl/8h73sxhuh3gR4pfZMlxybS/IedpQ==
X-IPAS-Result: =?us-ascii?q?A0EGBQD2W1xlhwMP49RaHgEBCxIMQIFEC4I5gVAwBAtIh?=
 =?us-ascii?q?FOPPYF1MIQ7hzSHSohvgVaBQD4PAQMBDUEBAgQBAQMEgguCdAKHKQIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOECeFa?=
 =?us-ascii?q?A2CVRiBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBESYBDwsOD?=
 =?us-ascii?q?AImAgJXBgEUAQGCfIIqAQMOIwetLoEygQGCCQEBBq9VHywiVoFfCYEaLogNA?=
 =?us-ascii?q?YVZgzt6Jw+BVUSBFSeDAz6ECjmDW4JoiSUHMoIig1KOUV0iBUJwGwMHA38PK?=
 =?us-ascii?q?wcELRsHBgkUGBUjBlEEKCEJExI+BIFfgVEKgQI/Dw4RgkArNjYZSIJbFQw0B?=
 =?us-ascii?q?EZ2ECoEFBeBEQRqGxMeNxESBRINAwh0HQIRIzwDBQMEMwoSDQshBVYDQgZJC?=
 =?us-ascii?q?wMCGgUDAwSBNgUNHgIQGgYMJwMDEk0CEBQDOwMDBgMLMQMwVUQMTwNrHzYJP?=
 =?us-ascii?q?A8MHwIbHg0nJQIyQgMRBRICFgMkFgQ2EQkLKwMvBjoCEwcEDgMZKx1AAgELb?=
 =?us-ascii?q?T01BgMLGwY+AiekMIIoxSk0B4IxgV+BYAyfIwYTL4QBkyEOBpJPmEAggjCmB?=
 =?us-ascii?q?IFqAjGBXDMaJIM2TwMZD44gGYQSj0dANTsCBwEKAQEDCYVGAQGDJjSBQAEB?=
IronPort-PHdr: A9a23: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
 JdcEtdm
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fOyM0qs0s2a5xw/WsOZQh9OZ7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:qZhhX2AkbCo30P36EzBC5RFLNpwESGfc6H6TZHf/K2M2FYTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A9JebBgydQkc/MYITGXxt8zLpKyKaqJ+LOllcks8?=
 =?us-ascii?q?nh5WrOxBKYBy4oWqbcLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,215,1695679200"; 
   d="scan'208";a="72079115"
X-MGA-submission: =?us-ascii?q?MDHmDJKj8kV7Q1MKjNLhBjV1I4oSFOjuzrOvwC?=
 =?us-ascii?q?xtnrtlmeELmMiMURFAhUfVR7FaBiDAicxR0Wbs55XIUG5YYQdoZYeQkT?=
 =?us-ascii?q?0AxlSDNPyOBInkRbqGGSwm78PAj5Iu4ZEctv46CPmNc30X+gO5AA4wn3?=
 =?us-ascii?q?KlkFYZzMLfWkPtFZt3G7aMKw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:35:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700552124; x=1701156924; i=markus.elfring@web.de;
	bh=EosEUZ0nK4S+qZnLMvFL/+6ZdrFe0Z8ZAoXFRjOozyU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=iSjuWaRsQcYFrYo58ibZ+AOguuZUd+C3gBgq8nSVni4KmTs97IWvMvT6pQeyjCVW
	 LzU4Q1uQLVJ8Vb8yQBkMT8ibLDk1Tyj36+bGqEHu9zPt/5c4o37tddwUVd7ExCCqb
	 GsjayoqBhJkUA8OBe893xnayDuVkf2j+74gDgCok0YfF8vF/D3SBbjncA9QkywRzt
	 U/uw0X8SF4Zu0Oojchb4oAKgMKMwrfGeW31AZHsLd8/5THvE3/HQmqroE9x8oPPL/
	 GReuM3ManSXMCNZYdgNcUu3L3xA+j/1bonIEO/OGTmBM8KwOg4wOT/ZhHCh5rS5jM
	 30u+5amJBTWPpnhDMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYbN-1rGery3joX-00xgT9; Tue, 21
 Nov 2023 08:35:23 +0100
Message-ID: <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
Date: Tue, 21 Nov 2023 08:34:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Amit Dhingra <mechanicalamit@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de, kernel-janitors@vger.kernel.org
Cc: linux-spi@vger.kernel.org, cocci@inria.fr, Mark Brown
 <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de>
 <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hi5eKYljFyBKSF9GeUsBiWyfByALJmAv3HKwvtad5NVY+MXQ0ZV
 jkx4/iy5jLRQU+ijXzNSSfjItj94nVM5bAjdjMO6gWA237hkMof1r/UCMzh9VzHT6BtXUi7
 s0XZUMiwlWlbq7SJEFqhb7RqZy1X9QdqQEVMNq6aO2u8ZHnJ70qCUGIVYIZ2h8yvV5skeIw
 RjGDt9lZDDzVJGLI8QVnw==
UI-OutboundReport: notjunk:1;M01:P0:wTbQSrQEXqE=;XVsxU66yTz0omK/kA3Zk2un9oxN
 WCuwBpuA1L6gElfpabAQT4/Z0mtrFIGDXUG1iHT+dMLnxtUnPfuuuTdRETtSFchK7QPEle/no
 OLoPBkOTamJiadTrgrSPPdMfBUcDUqDVYoH740AuFnbJR7ehUBoCi++L8ylgUgrEm7D/01Dbs
 eoh4ciWrtcaQ5tHTC2fbh8qCDKGzKZtWer5r6i0UX8fvC7cnW3auJRN8G7ysZsdC2acfpRrHq
 xmPRJu08BEGe07xN+zpFa6ZUO/bIembEBYKTdQqbUQu+2mAQhP83X+jKniRACV/43GlqeYTop
 7x4iL1ttWQ+6M1gJr7TyugjLz9mwUAdkj91zftCVwA15dMMJTnnR2NCsy75f7XKyi/VLAyu6X
 t4Yew75Fq0rH4qJ02oSS0susktGLsQoVhqqxrUhr7kUH/PCU/MuZF9KeoHEOUu67qiMCL896w
 TIMmC8UCbgEyi48+NmNsPQkbm1KHoBpmaCls6vLaU/MrDOQFVBDpUNvNsHqzfqP4C2GCpjuyt
 9Boc9beOvnqTBePplIE360xwRRqCPPAP88jObaOMbD/8t4HyOpKZoXY8oV0WvzAeFt/BmdxtF
 4wLc2WFlOWikIvEGoTGWo0TPy1nPVhIOdYbXuf06iV88WSEyUcgMnUU7S1jCeIVqPkVdJP91x
 fA/zQ5lFjPjhj65+CkhBGTP7NZzhIvZcXo7kWTUCZxK6Wa/5N3MJqWoJNMrD3qvgPdpiaKeC0
 2f89ZVXWrfSNZ5Gj3Tr6ouJW4stB6hQg73yL73xqAd3h1J88KSzORF7aloVpU6wRvLQkGjxzp
 Nl3yVq9Yfnpr1oVqQ0AnATRPdGKsHdpSVKT/afzFQXfXuWspQTAci65dkCKmCkxfH04JTecDd
 Jgcz3ynA+vtMmVVKPtnQipUSTcvurhuW7ZaDnXZMLavmFAgNbEleAEEhP/0UIpZR27ty0OPEO
 7JSovAJNiEeIBZVZDqQGNHpEk2Q=
Subject: Re: [cocci] spi: cadence-xspi: Drop useless assignment to NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1298
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/53db2c8f-7b9b-47f7-89ba-d78584c12d7b%40web.de>

>>> Static structs are initialized with zeros for unspecified fields.
>>> So there is no advantage to explicitly initialize .remove with NULL
>>> and the assignment can be dropped without side effects.
>>
>> Would you become interested to delete redundant initialisation repetiti=
ons
>> at any more source code places?
>>
>> A corresponding script for the semantic patch language (Coccinelle soft=
ware)
>> can point more remaining update candidates out for various components.
>
> Coccinelle shows 471 files.

I got the impression that more source code places can be reconsidered acco=
rdingly.

@deletion@
identifier member, s, var;
@@
 static struct s var =3D
 {
 ...,
-.member =3D \( 0 \| NULL \) ,
 ...
 };


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> rg '^-\s' =E2=
=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/delete_NULL_assignment_in_sta=
tic_struct-20231117.diff | wc -l
6567

Regards,
Markus
