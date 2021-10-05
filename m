Return-Path: <SRS0=2JM+=OZ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF4C433FE
	for <cocci@archiver.kernel.org>; Tue,  5 Oct 2021 13:46:00 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7579361506
	for <cocci@archiver.kernel.org>; Tue,  5 Oct 2021 13:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7579361506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="532171207"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2021 15:45:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 459B1E010E; Tue,  5 Oct 2021 15:45:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7E20FE010C
	for <cocci@sympa.inria.fr>; Tue,  5 Oct 2021 15:45:56 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Av2DFGKF8Q42bqY4upLqE+8eALOsnbusQ8zAX?=
 =?us-ascii?q?PidKOHhom62j5qWTdZEguCMc5wx8ZJhNo7C90cq7MBHhHPxOgLX5VI3KNGKNhI?=
 =?us-ascii?q?LCFu5fBOXZsl7d8lbFmNJg6Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="532171202"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 15:45:56 +0200
Date: Tue, 5 Oct 2021 15:45:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: "Richard W.M. Jones" <rjones@redhat.com>
cc: cocci@inria.fr
Subject: Re: Build failures, possibly 32 bit only, with OCaml 4.13.1
In-Reply-To: <20211005121204.GQ7596@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2110051545350.6871@hadrien>
References: <20211005121204.GQ7596@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 22
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110051545350.6871%40hadrien>



On Tue, 5 Oct 2021, Richard W.M. Jones wrote:

> [resending to the new mailing list]
>
> Hi Julia,
>
> https://koji.fedoraproject.org/koji/taskinfo?taskID=76740903
>
> I observed build failures with OCaml 4.13.1.  They manifest as
> segmentation faults.  Unfortunately it's not easy to get the core
> dump, but I might be able to get a stack trace later.  Apart from that
> you can look at the build logs by clicking through the red links above
> and going to "build.log".
>
> The common factor may be 32 bit platforms.
>
> We (Fedora) don't really care too much about cocci on 32 bit since
> it's a development tool and every developer these days has a 64 bit
> machine.  (It could of course be something unrelated to 32 bit)

Thanks for the report, I will see if something can be done.

julia

>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-top is 'top' for virtual machines.  Tiny program with many
> powerful monitoring features, net stats, disk stats, logging, etc.
> http://people.redhat.com/~rjones/virt-top
>
>
