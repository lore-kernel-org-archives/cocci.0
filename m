Return-Path: <SRS0=prLC=PX=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F331CC433EF
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 17:30:15 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AC4610D0
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 17:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62AC4610D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AZbNs06Ix/oXRQtdxFE+RwJQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC/0jwn1DRVn2YZCzrQOK7eajagLotzboi2pBkBuZ+DnYNqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHuakUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIsi?=
 =?us-ascii?q?0l67yNEwMWL/bewaU4pZUc/H40l4T/WprjPx9baREAatUo2zhc9RZw9JGvp31T?=
 =?us-ascii?q?hgvM7fkmeIHUhAeHTsW0ahuoueaeiLv4KR/yGWDKRMA2c5GB0Y9Noww8/x8AWB?=
 =?us-ascii?q?Q+OZeKz0XaB2HweWsz9qTQOh3ndUtIuHkOYoevjdryjSxJf0hTJbORY3F4NZZ2?=
 =?us-ascii?q?HE7gcUmNfrXYYwbLyVuaBDBahhUElgSAZM62uyvgxHXfzRGqV6Ooqw77WfX5AN?=
 =?us-ascii?q?02bnpdtHSf7SiScgThUGFtGuA9GPjDxcGNdq3xj+M83bqjejK9QvwQ58WEKyQ+?=
 =?us-ascii?q?fltj1megGcUDXU+X1a9rPW4iVKWW99eLUFS4C0lrrNa3EevSd7mdx+4q3qDuQV?=
 =?us-ascii?q?aUN1Ve8U24QeMx66S5wuLDWECSRZFadovrshwQiYlvneCn8noHiBoqL3TQ3WQ9?=
 =?us-ascii?q?rKLpDe+NDI9KW4Eby4YCwAC5rHeTCsb5v7UZs55F6LwitzuBTzr3mna6ik4nbQ?=
 =?us-ascii?q?ay8ARv5hXNGvv21qEzqUlhCZvjukPYl+Y0w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,209,1631570400"; 
   d="scan'208";a="2053289"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2021 18:30:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9B07EE0295; Thu,  4 Nov 2021 18:30:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B20AE0295
	for <cocci@sympa.inria.fr>; Thu,  4 Nov 2021 18:30:11 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AjGnu/qHOsVVmCZ/CpLqFkZHXdLJyesId70hD?=
 =?us-ascii?q?6mlYUhZVctOVmoSHgZ0gpF7JYVYqKQ8dcB67Scu9qADnhOVICOgqTM+ftWbdyQ?=
 =?us-ascii?q?yVxb9ZnP7fKlHbakjDHgA079YvT0BRYOeARmSSp/yKqDVRi70bsZa6GJnBv5aT?=
 =?us-ascii?q?85+GJTsaIZ2Ilj0JRzpzcXcGPTWuZ6BJcKZ0vfA300vWRZ1/VK3SbRNpM4ejx+?=
 =?us-ascii?q?Ej8qiWESLuKCRXnjVm5gnYmYISfSLovSv2Hwk/p4vLzwL+4n/Ez5TmiOujwhvQ?=
 =?us-ascii?q?k1fO44hb3Pvto+Eze/Cku4wvMCzljgvtXoh7RLGY1QpF3N1G4zwR4avxSgkbTr?=
 =?us-ascii?q?lOwkKURHi8pRao4AX7zDMygkWSs2NwXkGMneXJADU9T8Jbj4NYbRex0TtogO1B?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398270639"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 18:30:10 +0100
Date: Thu, 4 Nov 2021 18:30:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jakub Kicinski <kuba@kernel.org>
cc: Gilles Muller <Gilles.Muller@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Michal Marek <michal.lkml@markovi.net>, cocci@inria.fr
In-Reply-To: <20211104102448.4c97e7e6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.22.394.2111041827060.2680@hadrien>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN> <alpine.DEB.2.22.394.2111032134360.3289@hadrien> <20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN> <alpine.DEB.2.22.394.2111041612130.2680@hadrien>
 <20211104102448.4c97e7e6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 70
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111041827060.2680%40hadrien>



On Thu, 4 Nov 2021, Jakub Kicinski wrote:

> On Thu, 4 Nov 2021 16:16:09 +0100 (CET) Julia Lawall wrote:
> > On Wed, 3 Nov 2021, Jakub Kicinski wrote:
> > > That'd be quite useful, thanks! Would it have any impact on the
> > > performance as well? I see running coccicheck M=net/core/ takes
> > > 2 minutes now, for a 15 patch series that adds up quickly.
> > >
> > > I could run the check on all patches in a series to speed things
> > > up. Would it be possible to feed it a git range?
> >
> > There are now two new options:
> >
> > --use-diff
> > There should also be the name of a directory on the command line.  This
> > will run the semantic patches only on the files that have changed in that
> > directory
> >
> > --use-patch-diff commit
> > This will run spatch only on the files that have changed in commit.
> >
> > --use-patch-diff commit1..commit2
> > This will run spatch only on the files that have changed between commit1
> > and commit2.  In recent versions of git, this uses the --merge-base
> > option.
> >
> > Note that the file names are taken from the commits, but Coccinelle
> > doesn't run on the files at the time of the commits.  Coccinelle always
> > runs on the current snapshot of the indicated file or directory.  For old
> > commits, this may lead to messages about files that don't exist.
> >
> > Let me know if this is useful.
>
> Great, sounds like the exact thing I need.
>
> And I would pass these to coccicheck as
>
> SPFLAGS="--use-patch-diff $hash1..$hash2"

That looks like a reasonable guess.  I'm not sure how it will interact
with what make coccicheck wants to do though.

julia
