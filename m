Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F79C433F5
	for <cocci@archiver.kernel.org>; Wed, 12 Jan 2022 12:23:34 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208";a="15340755"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jan 2022 13:23:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6828EE008D; Wed, 12 Jan 2022 13:23:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4FB56E008D
	for <cocci@sympa.inria.fr>; Wed, 12 Jan 2022 13:23:32 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3ATVltha483JjZqvlbGP0xbQxRtAzFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0GEAyTdODGCPOq2NamL3f910YY+z9hsGu5Pdy4VgTFc5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOixxZVA/fvQHOCkUbe?=
 =?us-ascii?q?eYnoZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk577e0EQQ7PUVeSMoioLHfbyxEEY/2prjf1T2Pk0MC+7jx2LgtRwwZNJvIO5T?=
 =?us-ascii?q?QMBP6vWme1bXQMw/yRWZ/MbpueffRBTtuTWlSUqaUDEzO5yC0YtJqUf5/pzBmZ?=
 =?us-ascii?q?Ns/AVQBgGaRuIhsqt0bejQ69tgN4iJY/lJusiVttIpd3CJa95GtaaGfyMu48ej?=
 =?us-ascii?q?Gp2nM1QW+3QfYwfZCYHUfgJWDUXUn9/NX70tL7AaqHDTgBl?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AtLuRxqxuq88PDqE7p3cbKrPwS71zdoMgy1kn?=
 =?us-ascii?q?xilNoHtuHfBw9vrCoB11726WtN98YhAdcLO7VJVoI0msl6KdiLN5VdzJYOCMgg?=
 =?us-ascii?q?WVxe9Zjbff/w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208";a="2656004"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:23:32 +0100
Date: Wed, 12 Jan 2022 13:23:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Giancarlo_Stoo=DF?= <gstooss@outlook.de>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <VE1PR02MB5391616777980571A67A784EDC529@VE1PR02MB5391.eurprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2201121322520.146837@hadrien>
References: <VE1PR02MB5391616777980571A67A784EDC529@VE1PR02MB5391.eurprd02.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-751938402-1641990212=:146837"
Subject: Re: [cocci] Corrupted or missing coccinelle-tests files
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 113
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-01/alpine.DEB.2.22.394.2201121322520.146837%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-751938402-1641990212=:146837
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 12 Jan 2022, Giancarlo Stooß wrote:

>
> Hi,
>
> i tried downloading your coccinelle-tests.tgz (240 MB), coccinelle-tests.tlz (87 MB) or coccinelle-tests.txz (67 MB) files but
> the first one has a missing link and the other two seem to be corrupted when i try to unpack them with the tar command on Debian.

The DIKU link is certainly out of data.  Where did you get the gitlab
links from?

julia
--8323329-751938402-1641990212=:146837--
