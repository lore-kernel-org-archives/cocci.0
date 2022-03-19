Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA09C433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3FC4FihtNANtmzSxY3dRUhOwj7j2BDE+SwC80lGJgMA=;
  b=nN4LmZ7mhav6huy2JQkR8qHY2txw/s76LdSjgqlkvsQribGymHufnhNg
   Gdl6TFlhf8jMJM6oyNQl/ygyjEregV878jLAJ96uDZlUuLG6ZufMeSBjE
   C/d+pg5xmsq0SoqRA9ABZ9x8gwUzII7EzipWTizymW+yRrmMRx/0YOM7x
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27021873"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 20:39:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E22ACE0210; Sat, 19 Mar 2022 20:39:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4DEEEE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 20:39:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3FC4FihtNANtmzSxY3dRUhOwj7j2BDE+SwC80lGJgMA=;
  b=Z6VShvpS6Cf5p/OgOzTxohAN94FAGSXkspIa4BwolFdU92rUqejXzs+s
   NXlla2k+V9O+sRM+6CnfTpvBnI3XM71fhxS5fSjkyGejXxZW5aKpjFxLx
   aQQXCDKbfk8DAfHQtB9NNq7gNcFiXv1OM/CCQUn6eAOMEvAMI5jDC+AsN
   w=;
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27021872"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 20:39:09 +0100
Date: Sat, 19 Mar 2022 20:39:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203192038220.3204@hadrien>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 253
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203192038220.3204%40hadrien>



On Sat, 19 Mar 2022, Eric Wheeler wrote:

> Hi All,
>
> Just a quick tip for others (like me) who are new to Coccinelle:
>
> You might already use this, but if not, here's a hint for doing lots of
> replacements in parallel:
>
> 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
>
> If the SmPL depends on interactions between files then `parallel` won't
> work, but if the changes work per-file then it runs much faster with lots
> of big .c files.
>
> In cases where you do need to run over lots of files and they _do_
> interact, you might get a Stack Overflow error.  In this case set
> something like this for 1GB of stack space:
> 	ulimit -s $((1024*1024))
>
> In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few
> minutes and finished thousands of replacements!
>
> Julia, you might add this to documentation if you think it would be
> useful.

I'm not sure what you are trying to do.  You can give spatch the name of a
directory and the argument -j N for a number for cores N, ad it will run
in parallel on the files in the directroy.

julia
