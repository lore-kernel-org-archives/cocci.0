Return-Path: <SRS0=/5U0=PP=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB6EC433EF
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 15:46:19 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6710E610A0
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 15:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6710E610A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3Aogdk3a8dYnpynl47RVsGDrUDln+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUom1mACmGZJUW2Cb/+JYTCkf49yPYS38ElSvZTdz4JlSFdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OkUrG?=
 =?us-ascii?q?cYEideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kuq3qd1UDBL/UJwmHzHRMM0SgqkEY9mpjieBiaqBaMBkP49mKt4kZJNFlvpu7Q?=
 =?us-ascii?q?gZsObLKlf41Uh9CEig4M7cuFLrvfinj65PIp6HBWz62qxl0N2k9OoYT+85+G2p?=
 =?us-ascii?q?O9OIVMnYOYwqFiubwx6i0IsFmh984PcflFIwas3BkizreCJ4OSpfORajMzdBd1?=
 =?us-ascii?q?TY0wMtJGJ72a8MfLzgpcxXEZxxGP0w/B5c3nePujX76GxVUoUyUqbEw5WTdwwh?=
 =?us-ascii?q?Z373kMd6TcduPLe1ZkwCDoX/U9iLyBQsXMsCezxKK93utgqnEmiaTcIkJCbm85?=
 =?us-ascii?q?9Zlh1qcwmFVAxoTPXOxrP+0hk+9R/pfJk0S92w0qqMx7ySDRd36WAaQon6Puhk?=
 =?us-ascii?q?bQJxbFOhSwA2EzKvZ50CdC3oPRzhGQNgnssYsQnotzFDht9jpHz10rLqNSTSX8?=
 =?us-ascii?q?bqUqCy7PSQYN0cGZCkOTBdD6N7myLzfJDqnos1LCLSygpjxGCrsziuX9Xh4hrM?=
 =?us-ascii?q?JjMdN2b/TwLwOuBr0zrChc+L/zl+/srqZ0z5E?=
X-IronPort-AV: E=Sophos;i="5.87,187,1631570400"; 
   d="scan'208";a="794273"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2021 17:46:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE795E0047; Wed, 27 Oct 2021 17:46:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CB796E001C
	for <cocci@sympa.inria.fr>; Wed, 27 Oct 2021 17:46:13 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AxMmlCKGJ0nFqnyOppLqE1ceALOsnbusQ8zAX?=
 =?us-ascii?q?Po5KKCC9Afbo7/xG+85rriMc6QxhIU3I9urwXZVoLUmslqKdpLNhW4tKPzOW31?=
 =?us-ascii?q?dATrsSj7cKqgeIc0aSmtK1l50BT0EUMrLN5DZB4/oSrDPId+rIH+PszJyV?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397544454"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 17:46:13 +0200
Date: Wed, 27 Oct 2021 17:46:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mansour Moufid <mansourmoufid@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CALogXGWiB_XwOZ5MsQe2qKu8ESDMYfRqTYg24ALZQF=sxkSi5A@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110271745200.2966@hadrien>
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com> <alpine.DEB.2.22.394.2110270723001.2966@hadrien> <CALogXGWiB_XwOZ5MsQe2qKu8ESDMYfRqTYg24ALZQF=sxkSi5A@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 43
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110271745200.2966%40hadrien>



On Wed, 27 Oct 2021, Mansour Moufid wrote:

> On Wed, Oct 27, 2021 at 1:24 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > I don't want to see these messages.  I at most just want to record them
> > for future reference.  So I think we would need a new option to offer this
> > behavior.  What would you like it to be called?
>
> I personally like --print-status or --no-status. I've seen other
> command line utilities do something like --verbose=1, --verbose=2,
> etc. I would be happy with either.

--verbose-status ?

julia
