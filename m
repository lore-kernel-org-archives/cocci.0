Return-Path: <SRS0=prLC=PX=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE06C433EF
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 15:16:17 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F6A61212
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 15:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65F6A61212
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,209,1631570400"; 
   d="scan'208";a="2025463"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2021 16:16:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9AF0E02AF; Thu,  4 Nov 2021 16:16:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 277F8E004C
	for <cocci@sympa.inria.fr>; Thu,  4 Nov 2021 16:16:10 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3A5hxiO6IApDA7iuieFE+RUpclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC7gGkh3jcAn2NLXD+FaayIZzGgfYh2aN6z9UsB68KExoNqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHuakUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIt+?=
 =?us-ascii?q?517LybUQORvjKNBKPkTxXXbKji15MvETe0I5ibqpaOBwR1WrPwY0ZJNZl7PRcT?=
 =?us-ascii?q?S8rI6nNkaIZWgZRFyVWPKtc+baBL2LXXcm7lRWcLiewnp2CC2lzZ+X04N1fAnx?=
 =?us-ascii?q?E/NQbJSoLYxTFgPi5qJq0T/Rogsk5BNvqOYkFszdhyyvYBLAoW/jrRaTB4ttRx?=
 =?us-ascii?q?3Eoj8RPDd7fYsMWLzR1BDzFYhZPM1NRDJE7mM+tj2P8dCNZ7lSYucIf6G/Yxw1?=
 =?us-ascii?q?Zy6noKNOTe9qQRMwTkFzwm45s1wwVGTkWKJmbwCWM9nbqnubVnDi9WYQIFbT++?=
 =?us-ascii?q?OQCvbFa/URLYDV+aLdxiaDRZpaCZu9i?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AAywfgqMxaoruY8BcTv+jsMiBIKoaSvp037BN?=
 =?us-ascii?q?7SFMoH1uHPBw+Pre+MjzuSWZtN9zYhEdcLK7Scu9qBrnnPYfi7X5VY3SPzUO01?=
 =?us-ascii?q?HEEGgN1+Tf6gylNQm7zOJWybxhbrgWMqyXMbAw5fyKhTVRV70bsb66zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.87,209,1631570400"; 
   d="scan'208";a="2025445"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 16:16:10 +0100
Date: Thu, 4 Nov 2021 16:16:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jakub Kicinski <kuba@kernel.org>
cc: Gilles Muller <Gilles.Muller@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Michal Marek <michal.lkml@markovi.net>, cocci@inria.fr
In-Reply-To: <20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN>
Message-ID: <alpine.DEB.2.22.394.2111041612130.2680@hadrien>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN> <alpine.DEB.2.22.394.2111032134360.3289@hadrien> <20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 68
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111041612130.2680%40hadrien>



On Wed, 3 Nov 2021, Jakub Kicinski wrote:

> On Wed, 3 Nov 2021 21:37:07 +0100 (CET) Julia Lawall wrote:
> > On Wed, 3 Nov 2021, Jakub Kicinski wrote:
> > > Hi folks!
> > >
> > > I'd like to run coccicheck on all patches before they are committed
> > > to Linux networking trees. Is there a recommended way of doing that?
> > >
> > > I'm looking for a way to run the checks only on files which were
> > > touched and in the fastest way possible..
> >
> > I had an intern who worked on an extension to Coccinelle to take a patch
> > and then only apply spatch to that file.  Perhaps I can resurrect that
> > code.
>
> That'd be quite useful, thanks! Would it have any impact on the
> performance as well? I see running coccicheck M=net/core/ takes
> 2 minutes now, for a 15 patch series that adds up quickly.
>
> I could run the check on all patches in a series to speed things
> up. Would it be possible to feed it a git range?

There are now two new options:

--use-diff
There should also be the name of a directory on the command line.  This
will run the semantic patches only on the files that have changed in that
directory

--use-patch-diff commit
This will run spatch only on the files that have changed in commit.

--use-patch-diff commit1..commit2
This will run spatch only on the files that have changed between commit1
and commit2.  In recent versions of git, this uses the --merge-base
option.

Note that the file names are taken from the commits, but Coccinelle
doesn't run on the files at the time of the commits.  Coccinelle always
runs on the current snapshot of the indicated file or directory.  For old
commits, this may lead to messages about files that don't exist.

Let me know if this is useful.

julia
