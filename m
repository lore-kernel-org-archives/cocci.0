Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B56EC433F5
	for <cocci@archiver.kernel.org>; Wed, 12 Jan 2022 14:21:14 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208";a="15376948"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jan 2022 15:21:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 245BBE0163; Wed, 12 Jan 2022 15:21:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77B1EE008D
	for <cocci@sympa.inria.fr>; Wed, 12 Jan 2022 15:21:09 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3Av482eKk3juf81Hse2WJXxBjo5gy2JERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzcCyGoZUT+Bb/uCZmLxLtAibo218xhX75DQx4QwSAps+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x/RGQ6YnSHuCmULe?=
 =?us-ascii?q?dYHgrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTckQGWL/fO2BiiFIGBu780l4b/HV0i/lgXBYfQR4/ZzGhnc11ydwLsZWvQ?=
 =?us-ascii?q?AMtFqzKguUUFRdCe817FfQbo+CZcCLl2SCU5wicG5f2+N1hF10xOpYD0uFqHWV?=
 =?us-ascii?q?J8v9eJD1lRhuEjOm36KmqT/FlwMUlNsjieo0F0kyMZxmx4e0OGM+YBfyQvJkGj?=
 =?us-ascii?q?HFg24ZUEOiYfMQDLzxicHz9j9R0Eg9/IPoDcC2A3BETqwFllW8=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ABU+7Za6aBJYKesjjtwPXwaOBI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZHyYlDPBw8Pre+cjztCWE6gr5N0tKpTntAsO9qDbnm6Kdy7NhRItKJTOWwF?=
 =?us-ascii?q?dATrsM0WKS+UyCJ8SWzIc06U4jSclD4bvLYGSS5vyb3ODXKbodKfC8gdGVrNab?=
 =?us-ascii?q?4XdxaAlgL4xh9Q1kEByaFEozZCQuP+tEKLOsouRGuh+pcjA2dN6mCj0kcoH41q?=
 =?us-ascii?q?b2vaOjTx4aIhYtrCmVly+lrJ7bPnGjr20jegIK77c+1GDP1yv++6Wts/uy1x/b?=
 =?us-ascii?q?0FTe545Rn7Lau6Z+Lf3JpMgJDz3mzj+yYodsUaDqhkFQnMifrHgrjfzFqFMYJM?=
 =?us-ascii?q?Jx53nNOkG5yCGdvDXI4XIB62LGwVTduGDkosDyWXYCA9dB7LgpFCfx2g4PvMxY?=
 =?us-ascii?q?2KkO5G6BsooSLx/R9R6NmOT1aw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208";a="15376922"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:21:09 +0100
Date: Wed, 12 Jan 2022 15:21:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Giancarlo_Stoo=DF?= <gstooss@outlook.de>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <VE1PR02MB5391616777980571A67A784EDC529@VE1PR02MB5391.eurprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2201121520440.146837@hadrien>
References: <VE1PR02MB5391616777980571A67A784EDC529@VE1PR02MB5391.eurprd02.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-95745493-1641997269=:146837"
Subject: Re: [cocci] Corrupted or missing coccinelle-tests files
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 114
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-01/alpine.DEB.2.22.394.2201121520440.146837%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-95745493-1641997269=:146837
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 12 Jan 2022, Giancarlo Stooß wrote:

>
> Hi,
>
> i tried downloading your coccinelle-tests.tgz (240 MB), coccinelle-tests.tlz
> (87 MB) or coccinelle-tests.txz (67 MB) files but
> the first one has a missing link and the other two seem to be corrupted when
> i try to unpack them with the tar command on Debian.

A valid file should be available now.

Thanks for the report.

julia
--8323329-95745493-1641997269=:146837--
