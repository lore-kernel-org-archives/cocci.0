Return-Path: <SRS0=woii=PS=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C6C433F5
	for <cocci@archiver.kernel.org>; Sat, 30 Oct 2021 16:39:00 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBC260F92
	for <cocci@archiver.kernel.org>; Sat, 30 Oct 2021 16:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EBC260F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,195,1631570400"; 
   d="scan'208";a="1289333"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2021 18:38:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3417DE027E; Sat, 30 Oct 2021 18:38:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6DC4CE0072
	for <cocci@sympa.inria.fr>; Sat, 30 Oct 2021 18:38:54 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3ANtchRK+8QEfJzue+faxUDrUDs3yTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUog0GYEn2BKDWHVParfMWWkKNFzOti08BlQu57XytQ2SFdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OkU7a?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kurbyflcLT7i60Qqm2icQBfjk20Ib4HVtic7XN9JFAatTozeUm9F4jtFEqpW0T?=
 =?us-ascii?q?S8oOLfNkaITSXG0FgknZ/0Xo+SdSZS4mYnJp6HcSFPpyvN1C1wsOIoF9Od7KW5?=
 =?us-ascii?q?L/P0cbjsKa3irjOW9y7OTUfhpns1lLc/xPYpZtGsI8N1zJZ7KWriaHP6MvIUBm?=
 =?us-ascii?q?mlgwJATW+zTeYwCZyApahncCyCj82w/UPoW9NpETFGiG9GAlG+omA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AD2lriasf8rwMzPZ76zlxb7xJ7skDcdV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZsgviMc5Ax6ZJhko7G90cq7MBbhHPxOgbX5VI3KNDUO+l?=
 =?us-ascii?q?HYT72KhrGN/9SPIUHDH6JmpMVdWpk7OZnLAV92gd2S2mSFOtwrqePpzJyV?=
X-IronPort-AV: E=Sophos;i="5.87,195,1631570400"; 
   d="scan'208";a="1289332"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2021 18:38:50 +0200
Date: Sat, 30 Oct 2021 18:38:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mansour Moufid <mansourmoufid@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CALogXGWJKs9TjoTxpGn_yQBsa2e4GhhhqyDFa4+VEFqzuzh+iQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110301837520.2946@hadrien>
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com> <alpine.DEB.2.22.394.2110301135390.2946@hadrien> <CALogXGWJKs9TjoTxpGn_yQBsa2e4GhhhqyDFa4+VEFqzuzh+iQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 55
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110301837520.2946%40hadrien>



On Sat, 30 Oct 2021, Mansour Moufid wrote:

> On Sat, Oct 30, 2021 at 5:39 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > Hello,
> >
> > I'm still trying to understand what is the real goal for this issue, to
> > see if it could be handled in some other way.  Do you want status messages
> > to be separated from real errors?  Perhaps it would be sufficient to have
> > an option that would put the status messages on standard out?  Then you
> > could give the -o argument to put the generated patch into a file.
>
> Sorry I didn't explain it well. I am using spatch in a script and
> logging stderr to a temporary file to catch any errors. I just didn't
> want the status messages to appear there because there are so many.
> But I've worked around this by ignoring those lines. I don't think
> anything on stdout should change. The current behaviour is fine, I
> don't mind it that much.

OK, I think I will leave things as is, to avoid adding another option and
more dependencies.

Thanks for the suggestion.

julia
