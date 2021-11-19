Return-Path: <SRS0=ILoR=QG=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238C7C433F5
	for <cocci@archiver.kernel.org>; Fri, 19 Nov 2021 18:26:41 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1129B61B44
	for <cocci@archiver.kernel.org>; Fri, 19 Nov 2021 18:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1129B61B44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,248,1631570400"; 
   d="scan'208";a="4662188"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Nov 2021 19:26:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 11526E01BF; Fri, 19 Nov 2021 19:26:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A2E4E0072
	for <cocci@sympa.inria.fr>; Fri, 19 Nov 2021 19:26:35 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3AtjSHDanMFnWkP8MRmYVUzvDo5gyaJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzYOzzNJWD2Ca/3YZ2GjftBxaNnk/UIHu8XcndY1TQpo+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?da3grLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTckQGWL/fO2BiiFIGBu780l4b/HV0i/lgXBYfQR4/ZzGhnc11ydwLsZWvQ?=
 =?us-ascii?q?AMtFqzKguUUFRdCe817FfEYpuWefijXXcu7iheun2HX6/5pB0o3FZYJ//5+R2B?=
 =?us-ascii?q?I7/0Rbj4XBi1vLcreLKmTE7Y3wJ15dY+1bMVP5zd6wC+fFvg8B5bOX833CRZj9?=
 =?us-ascii?q?G9Yrqhz8Tz2PpNxheJTUSn9?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ay6QFTaF0Lri9eQ8mpLqE+8eALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOH9om6Oj/PxG8M5w6faWslYssRMb9+xoUZPoKU80nqQb3WB+B9uftUXd2V?=
 =?us-ascii?q?eAHcVSqbHvxDDtAETFm9Jg6Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,248,1631570400"; 
   d="scan'208";a="4662178"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 19:26:31 +0100
Date: Fri, 19 Nov 2021 19:26:30 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: cocci@inria.fr
Message-ID: <alpine.DEB.2.22.394.2111191921100.18418@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1661382851-1637346390=:18418"
Subject: [cocci] Death of Gilles Muller
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 107
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111191921100.18418%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1661382851-1637346390=:18418
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Gilles Muller was the person behind the scenes of Coccinelle.  In 2004, he
had the original idea that led to the development of Coccinelle, he
oversaw its original development, and over the years he ensured its
continued research relevance, which facilitated its ongoing development
and maintenance.  He passed away on Wednesday, November 17.

If you are grateful for Coccinelle, please consider making a donation to
the Centre Eugène Marquis (https://www.centre-eugene-marquis.fr) or to
your local center for cancer research.

thanks,
julia

--8323329-1661382851-1637346390=:18418--
