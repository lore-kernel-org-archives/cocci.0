Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE616C433EF
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 11:56:51 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CB0610FC
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 11:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99CB0610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AHbsxr6LyW0CPgTqKFE+RwJQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC8hj0q02RWyzEdCGmPb6yKM2qmedB/bImx80wFu5CBzoNqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHuGkUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIsi?=
 =?us-ascii?q?0l67yNEwMWL/bewaU4pZUc/H40l4T/WprjPx9baREAatUo2zhc9RZw9JGvp31T?=
 =?us-ascii?q?hgvM7fkmeIHUhAeHTsW0ahuoeCWfyPu6aR/yGWDKRMA2c5GB0Y9Noww8/x8AWB?=
 =?us-ascii?q?Q+OZeKz0XaB2HweWsz9qTQOh3ndUtIuHkOYoevjdryjSxJf0hTJbORY3F4NZZ2?=
 =?us-ascii?q?HE7gcUmNfrXYYwbLyVuaBDBahhUElgSAZM62uyvgxHXfzRGqV6Ooqw77WfX5AN?=
 =?us-ascii?q?02bnpdtHSf7SiScgThUGFtGuA9GPjDxcGNdq3xj+M83bqjejK9QvwQ58WEKyQ+?=
 =?us-ascii?q?fltj1megGcUDXU+X1a9rPW4iVKWW99eLUFS4C0lrrNa3EevSd7mdx+4q3qDuQV?=
 =?us-ascii?q?aUN1Ve8U24QeMx66S5wuLDWECSRZFadovrshwQiYlvneCn8noHiBoqL3TQ3WQ9?=
 =?us-ascii?q?rKLpDe+NDI9KW4Eby4YCwAC5rHeTCsb5v7UZs55F6LwitzuBTzr3mna6ik4nbQ?=
 =?us-ascii?q?ay8ARv5hXNGvv21qEzqUlhCZsjukPYl+Y0w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1796390"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 12:56:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E101EE02AF; Wed,  3 Nov 2021 12:56:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E13BEE004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 12:56:46 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7Y5zYquCZttWxtYz03YYGFeg7skCCYMji2hC?=
 =?us-ascii?q?6mlwRA09T+WxjMqunOsW2FvdlV8qKTYdcKO7Sdu9qBLnhO1ICOYqTMmftWPd2V?=
 =?us-ascii?q?dAErsSprcKrweQZxEXGIZmpONdm4YXMqywMbFRt7e13OEheOxQheVuyciT9KXj?=
 =?us-ascii?q?J50Ed3ArV0gY1XY7Nu/5KDwHeOAlP+tHKHPG3LsM1nedkB0sB6zRaxVrP5mh1r?=
 =?us-ascii?q?i78OOAEHh2fm9dmXOzZFWTmcjH+jejr1sjulh0sMAfGAb+4nHED+mYwoCGIiG3?=
 =?us-ascii?q?7R6b0306orXc4+oGP8CKgtUYMXHUlwilIL55U7m5tjYvrIiUmSIXueiJmBsmN9?=
 =?us-ascii?q?l+8DfpY2+45SH10w3bzT4y5xbZuCqlaXCIm72weNvkMaAx5/MgTjLpr00n+Nlm?=
 =?us-ascii?q?2qNKwG7xjesZMS/9?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398124397"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 12:56:46 +0100
Date: Wed, 3 Nov 2021 12:56:46 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <40d3e13c-0b1c-cf12-efd9-007532039d72@web.de>
Message-ID: <alpine.DEB.2.22.394.2111031256000.3289@hadrien>
References: <b2aa6f7a-2169-143c-59c4-bab1830126bf@web.de> <40d3e13c-0b1c-cf12-efd9-007532039d72@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1258557722-1635940606=:3289"
Subject: Re: [cocci] Checking parts of binary computations with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 60
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111031256000.3289%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1258557722-1635940606=:3289
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 3 Nov 2021, Markus Elfring wrote:

> > *idex = left_ex bo rigth_ex;
>
> Such a search pattern looks usable (in principle).
> Source code places should be found then where one binary operator is applied
> at least for computations so that their values will be stored somewhere.
> But I guess that it is unclear then how many code would be matched by
> the metavariable “left_ex” (and/or “rigth_ex”).
> Is such a system detail improvable anyhow?

Coccinelle parses the code according to the standard precedence rules.  So
there is no ambiguity.  bo will match whatever is at the root of the parse
tree.

julia
--8323329-1258557722-1635940606=:3289--
