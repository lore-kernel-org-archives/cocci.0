Return-Path: <SRS0=/5U0=PP=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7B5C433EF
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 17:32:19 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82F36109D
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 17:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A82F36109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,187,1631570400"; 
   d="scan'208";a="809079"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2021 19:32:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D32D2E0047; Wed, 27 Oct 2021 19:32:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 81751E001C
	for <cocci@sympa.inria.fr>; Wed, 27 Oct 2021 19:32:11 +0200 (CEST)
IronPort-Data: =?us-ascii?q?A9a23=3ASWHs46uAFWZdbxJ0KepE0ifNJOfnVIhcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3yzMXXz/XMv6IZWf1eo1wbImw9EoHuJKHztA3QVM5+HhgHilAw?=
 =?us-ascii?q?SbnLYTAfx2oZ0t+DeWaERk5t51GAjX4wXFdokb0/n9BCZC86ykjvU20buCkUre?=
 =?us-ascii?q?dYnouHVUMpBoJ0nqPpcZo2+aEvvDpW2thifuqyyHuEAfNNwxcagr42IrfwP9bh?=
 =?us-ascii?q?8kejRtD1rAIiV+ni3eF/5UdJMp3yahctBIUSKEMdgKxb76rIL1UYgrkExkR5tO?=
 =?us-ascii?q?Nyt4Xc2UKS7LIPAWI4pZUc/j/xEYS4HVoi+Bia6F0hUR/0l1lm/hz1dFMvNq0Q?=
 =?us-ascii?q?BggOqnkmeIHUhAeHTsW0ahuqOeWeSfn2SCU5wicG5f2+N1oDUoxOYQDvP5+BWB?=
 =?us-ascii?q?e3eEeKS5IYQqOgeW8xL/+Q+10i99lItODFIYWvGpn0CvcCusoQJzrTKDD5Nse1?=
 =?us-ascii?q?zA17uhFGv3VZuICeD93ZVLBZQdOMxEZEvoDcE2A7pXkW2QH8xTM//NxvTiVnFE?=
 =?us-ascii?q?3yrXzdsHbYJqMSNk9o6pRnUqel0yRP/3QHIX3JeK5z0+R?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKCk9DKmhPpLEkd/17DCGc+2mztnpDfNZimdD?=
 =?us-ascii?q?5ihNYBxZY6WkfrOV7YsmPHjP+UwssRAb6Ku90Mvpexm9yXcb2/h2AV7PZniChI?=
 =?us-ascii?q?LKFvAb0WKB+UyYJ8SWzIc0tNYCAspD4bbLfD9HZLPBkXWF+rgbsb262ZHtqfbf?=
 =?us-ascii?q?yzNMQGhRGt9dBn9Ce3um+1NNLzVuNN44E4eR/c1Kuj6peXEMYt+lCmJAe+DCou?=
 =?us-ascii?q?fAnJXgbQVDCzEugTPjsRqYrL78DhSC2RsCVztOxK0v6nfIiEjc7qWnifuyzRjR?=
 =?us-ascii?q?zCvewJwTt8DmzrJ4afCku4wULSjhkQGleYBoW7iZsCsrrPrqzF4rlePHqxAmM9?=
 =?us-ascii?q?8251zYOkGZyCGD5yDQlDYo9nP4zlOEhXPipNb0Xy03EI5kjYJdSBHQ7E0tp5Vx?=
 =?us-ascii?q?/6oO/2WXsYFSBQ7BmiOV3bb1ay0=3D?=
X-IronPort-AV: E=Sophos;i="5.87,187,1631570400"; 
   d="scan'208";a="809070"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 19:32:12 +0200
Date: Wed, 27 Oct 2021 19:32:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
cc: Mansour Moufid <mansourmoufid@gmail.com>, cocci@inria.fr
In-Reply-To: <3ae7f966-1f4a-6a72-dfb9-c899999a7c6b@univ-grenoble-alpes.fr>
Message-ID: <alpine.DEB.2.22.394.2110271931590.2966@hadrien>
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com> <alpine.DEB.2.22.394.2110270723001.2966@hadrien> <CALogXGWiB_XwOZ5MsQe2qKu8ESDMYfRqTYg24ALZQF=sxkSi5A@mail.gmail.com> <alpine.DEB.2.22.394.2110271745200.2966@hadrien>
 <CALogXGVkE1V_9Whf6ZEYJf4k+3RSA-tYH8nxCP3c2E3_DESuvQ@mail.gmail.com> <3ae7f966-1f4a-6a72-dfb9-c899999a7c6b@univ-grenoble-alpes.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 46
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110271931590.2966%40hadrien>



On Wed, 27 Oct 2021, Nicolas Palix wrote:

> Hi,
>
> On 27/10/2021 18:18, Mansour Moufid wrote:
> > On Wed, Oct 27, 2021 at 11:46 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > > --verbose-status ?
> >
> > Sounds good to me. :)
> >
>
> For the record.
>
> ctermid is in the extunix library.
>
> module U = ExtUnix.Specific
>
> let _ =
>         let tty = U.ctermid () in
>         Printf.printf "%s\n"  tty;
>         let tty_ch = open_out tty in
>         output_string tty_ch "Hello\n";
>         close_out tty_ch
>
> $ dune exec ./ctermid.exe
> Hello
> /dev/tty
>
> $ dune exec ./ctermid.exe > /dev/null
> Hello

Thanks!

julia
