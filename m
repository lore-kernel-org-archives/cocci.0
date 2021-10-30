Return-Path: <SRS0=woii=PS=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C09C433EF
	for <cocci@archiver.kernel.org>; Sat, 30 Oct 2021 09:39:26 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D9D60EB4
	for <cocci@archiver.kernel.org>; Sat, 30 Oct 2021 09:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3D9D60EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3ATlEPyK/e1mNA1KfJ5de/DrUDkX+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUp21WEFnGFODGqFOKmOYWT1f9x3bIm28kJU75HSndNkGVdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OkU7a?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kuq3qd1UDBL/UJwmHzHRMM0SgqkEY9mpjieBiaqBaMBkP49mKt4kZJNFlvpu7Q?=
 =?us-ascii?q?gZsObLKlf41Uh9CEig4M7cuFLrveCLh7ZTMlCUqdFOpmZ2CFnoeNooT8edfCHt?=
 =?us-ascii?q?F9f0GJSpLbR2Zge+yhrWhRYFEjMU4N9jlMqsQv3hhyXfSCvNOaZvETqPH4/dX2?=
 =?us-ascii?q?T4xgoZFGvO2T8YQb3xtKgvBZxlOM1IMIJ07leaswHL4dlVwpFuLpKYs5G7fwgN?=
 =?us-ascii?q?1+LfoOdvRPNeNQK19kkvevWXb7W2/CRYAOdqDyDyt/Xelh+uJliT+MKoZD6C88?=
 =?us-ascii?q?u9Cj1qUyWgeThYRUDOTq/S/h0K/WM53K0EV/Cdot68591fDZtL5WBqjiHyEtRo?=
 =?us-ascii?q?bXMEWGOo/gCmBw6zV7gLfAmUWRTdHb/Qitck/Xzts0UWG9/viBSZuq6GSUXLb/?=
 =?us-ascii?q?LCZrTatMCwZIHUqYS4CRwoZpdLkpekOYrjnJjp4OLavidGwHTDr3z2RsXFuwbQ?=
 =?us-ascii?q?Vl88CkauhlW0rSgmE/vDhJjPZLC2ONo590j5EWQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,195,1631570400"; 
   d="scan'208";a="1264073"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2021 11:39:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F31CE0220; Sat, 30 Oct 2021 11:39:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BC8A6E0072
	for <cocci@sympa.inria.fr>; Sat, 30 Oct 2021 11:39:19 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AjElJeKjSvFLWvJDVAW7SmEQrL3BQXuMji2hC?=
 =?us-ascii?q?6mlwRA09TyX+rbHKoB17726WtN9/YgBGpTgNUJPsfZuhnqQe3WB8B9mftXDd1F?=
 =?us-ascii?q?dAT7sSibcKvQeKJ8SkzIFgPM5bGsBD4bvLbWSS5vyKgjVQfexA/DD+ytHPudvj?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397816133"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2021 11:39:19 +0200
Date: Sat, 30 Oct 2021 11:39:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mansour Moufid <mansourmoufid@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110301135390.2946@hadrien>
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 52
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110301135390.2946%40hadrien>

Hello,

I'm still trying to understand what is the real goal for this issue, to
see if it could be handled in some other way.  Do you want status messages
to be separated from real errors?  Perhaps it would be sufficient to have
an option that would put the status messages on standard out?  Then you
could give the -o argument to put the generated patch into a file.

julia
