Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED9EC05027
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CKXudx6D8ghx+FrwdKjLTeAENff6ZhcvHr24bvecLjE=;
  b=Gii/DAyDwJYSaLRZHYQNHqmeJZ1ks2neFBh0KhaeJ02sc9p4LxNFOwb/
   iXQNKClDQoYsvMC/989vBg4w9yXF5bHf++put3J0yRy8aYL5YBYfCnLRh
   KyRmQKj+eEpnJT50m9FvjkKbQ9bF4KMvbTz4szySZ1iLOL7F+PuO+1Qc8
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89928013"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 16:22:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F61AE743F; Sun, 29 Jan 2023 16:22:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 91022E743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 16:22:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CKXudx6D8ghx+FrwdKjLTeAENff6ZhcvHr24bvecLjE=;
  b=pCBslvixOo73tPhSVfWo5vjIpWA6xTkxcP6hR7xtD1Ch0D6KZkIEHBwj
   JdiPkXzk2Alk8lXWbwrEAfOFKA9SQ8ZwPn8ewMlzj9ufXQdQ/B1Qz14r1
   DpqNxJenLsczNAVJovcfxnG4fXTJIaeDHn3BSu9zlAaGMtiDC9UPlo04U
   w=;
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="46283717"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 16:22:03 +0100
Date: Sun, 29 Jan 2023 16:22:03 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
cc: linux-doc@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, Jonathan Corbet <corbet@lwn.net>, 
    cocci@inria.fr, linux-kernel@vger.kernel.org
In-Reply-To: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
Message-ID: <alpine.DEB.2.22.394.2301291621350.2852@hadrien>
References: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1914809095-1675005724=:2852"
Subject: Re: [cocci] [PATCH] Documentation: coccinelle: Escape --options to
 fix Sphinx output
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 831
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301291621350.2852%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1914809095-1675005724=:2852
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Jan 2023, Jonathan Neuschäfer wrote:

> Without such escaping, -- is rendered as – (en dash).
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thanks.

Acked-by: Julia Lawall <Julia.Lawall@inria.fr>

> ---
>  Documentation/dev-tools/coccinelle.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index d9976069ed126..535ce126fb4fa 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -219,7 +219,7 @@ instance::
>      cat cocci.err
>
>  You can use SPFLAGS to add debugging flags; for instance you may want to
> -add both --profile --show-trying to SPFLAGS when debugging. For example
> +add both ``--profile --show-trying`` to SPFLAGS when debugging. For example
>  you may want to use::
>
>      rm -f err.log
> @@ -248,7 +248,7 @@ variables for .cocciconfig is as follows:
>
>  - Your current user's home directory is processed first
>  - Your directory from which spatch is called is processed next
> -- The directory provided with the --dir option is processed last, if used
> +- The directory provided with the ``--dir`` option is processed last, if used
>
>  Since coccicheck runs through make, it naturally runs from the kernel
>  proper dir; as such the second rule above would be implied for picking up a
> @@ -265,8 +265,8 @@ The kernel coccicheck script has::
>      fi
>
>  KBUILD_EXTMOD is set when an explicit target with M= is used. For both cases
> -the spatch --dir argument is used, as such third rule applies when whether M=
> -is used or not, and when M= is used the target directory can have its own
> +the spatch ``--dir`` argument is used, as such third rule applies when whether
> +M= is used or not, and when M= is used the target directory can have its own
>  .cocciconfig file. When M= is not passed as an argument to coccicheck the
>  target directory is the same as the directory from where spatch was called.
>
> --
> 2.39.0
>
>
--8323329-1914809095-1675005724=:2852--
