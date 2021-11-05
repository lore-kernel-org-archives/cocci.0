Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B4C433F5
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 19:21:48 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CAC6124A
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 19:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7CAC6124A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2245804"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 20:21:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 264BDE006A; Fri,  5 Nov 2021 20:21:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BD51DE004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 20:21:42 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3ANTwbM6KpgubjlpoeFE+RHJclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC7hTgr0D0FnTNLXm2HOa6PZGWjf9pwao/i9kID7JXWyYNqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHuekU4Y?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIsu?=
 =?us-ascii?q?hyeqkN1UQRdY+PyDe2jwPAfDk20kT4HVog87XN9JFAatTowmJnt1r0sQLkJWqV?=
 =?us-ascii?q?QYvM7/kmeIHUhAeHTsW0ahuouWbfCfu7qR/yGWDKRMA2c5GB0Y9Noww4fdyGWg?=
 =?us-ascii?q?I9PoCKTlLYArrr+e9z6i8RMFvi94lIc2tO5kQ0kyMZxmx4e0OT5feHvSPvOhd3?=
 =?us-ascii?q?Tgqw5AeWK+EP49AOGsqNU6RJRNFKhEPEpUulevugHTjGwC0YWm9/cIfi1U/BiQ?=
 =?us-ascii?q?tuFQ1DOfoRw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AymJnra592ObrBi4mgwPXwPjXdLJyesId70hD?=
 =?us-ascii?q?6qm+c3Nom6uj5qSTdZUgpHrJYVkqOE3I9ersBIChRjfG+Ydx8c0NO96ZPTUO21?=
 =?us-ascii?q?HYTr2Kj7GSoAEIcheWntK1l50KT0EUMrPN5DZB4frS3BO1CJIpztWB7cmT79vj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2245797"
Received: from fou59-1_migr-88-120-199-129.fbx.proxad.net (HELO pl347-pro) ([88.120.199.129])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 20:21:39 +0100
References: <YXxGHEuS0zi+sbft@bombadil.infradead.org>
User-agent: mu4e 1.4.15; emacs 27.2
From: Thierry Martinez <Thierry.Martinez@inria.fr>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: cocci@inria.fr
In-reply-to: <YXxGHEuS0zi+sbft@bombadil.infradead.org>
Date: Fri, 05 Nov 2021 20:21:37 +0100
Message-ID: <ow4bl2ys91a.fsf@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Cannot infer Python version: when no /usr/bin/python
 symlink is found (resend)
Reply-To: Thierry Martinez <Thierry.Martinez@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 75
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/ow4bl2ys91a.fsf%40inria.fr>

Luis Chamberlain:
> Cannot infer Python version

I was not able to reproduce this error: are you sure that it is due to a
missing /usr/bin/python symlink? This error message should appear when
libpython3-dev is missing (and I have to admit we should change for a
better error message!).

For instance, the following Dockerfile succeeds=20

$ cat >Dockerfile <<EOF
FROM debian:latest
RUN apt-get update
RUN apt-get install --yes ocaml ocaml-findlib libpython3-dev curl autoconf \
    automake make
RUN curl --remote-name --location \
    https://gitlab.inria.fr/coccinelle/coccinelle/-/archive/1.1.1/coccinell=
e-1.1.1.tar.bz2
RUN tar --extract --file coccinelle-1.1.1.tar.bz2
WORKDIR coccinelle-1.1.1
RUN autoreconf
RUN ./configure
RUN make
RUN cd tests && \
    ../spatch.opt --sp-file countcalls_python.cocci countcalls_python.c
RUN test ! -f /usr/bin/python
EOF

Cheers.
--=20
Thierry.

Luis Chamberlain=C2=A0:
> Debian and OpenSUSE Tumblweed no longer have the /usr/bin/python
> symlink, at least this is explained and spelled out on the Debian
> Python Policy [0]. This guideline specifically requests that scripts
> do not use `/usr/bin/env`, do not use `/usr/bin/python` and instead
> use the exact version desired.
>
> When running coccinelle on a system without this /usr/bin/python
> symlink Coccinelle will complain when using a python script on a cocci
> file:
>
> Cannot infer Python version
>
> Fixing this is just to create the symlink, but I *really* don't want
> to do that. And so I think we may need to support:
>
> script:python3
> initialize:python3
>
> Maybe it makes sense then to always look for python2 if a version is
> not specified, and if that does not exist look for python3 as new
> systems may not have python2.
>
> [0] https://www.debian.org/doc/packaging-manuals/python-policy/ch-python.=
html#s-interpreter
>
>   Luis

