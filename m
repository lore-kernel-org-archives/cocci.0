Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4766C433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QXQn0tcxvTKL90n82VzZwlxV0PlcnBbfzxGW72fUYyc=;
  b=UbtXgUwwEMJn08GnX3Fg9dxAzhH2DdJNfzAQmpaYRzFPpOXurqx6jFff
   VD77PkXuvcuzWPWcVojwdHJza9MChI4GuWFyETgzvOJBzx0/3rlz0VUH+
   UighbVu6bPMMUYkKVlXunEAyNtZQdmyGJQoTZPJllsMpXZG/QMl4lPmgR
   s=;
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27017613"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 18:57:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1AF65E01B9; Sat, 19 Mar 2022 18:57:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8FA5FE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 18:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QXQn0tcxvTKL90n82VzZwlxV0PlcnBbfzxGW72fUYyc=;
  b=K6d0XOu9UNxveRL8m5SBQ9TaN9aTrH2Wc2/t3DxvD7q7BLrdVHnx42co
   P7fUvv5u7kZ481+8bgVsFcass/r0CWlDgAj4mPHU4RoTVEv3DlnIOcwsq
   wXj+PxL91an7jXeRx5QGZtvt5netHxDNND3dDQXoAKFSt/QpiqDAQUINI
   M=;
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9034817"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 18:56:57 +0100
Date: Sat, 19 Mar 2022 18:56:55 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <b5d854e6-cb4c-cfd6-733a-7adef0b5b37e@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203191851420.3204@hadrien>
References: <b5d854e6-cb4c-cfd6-733a-7adef0b5b37e@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Semantic diff?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 251
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203191851420.3204%40hadrien>



On Sat, 19 Mar 2022, Eric Wheeler wrote:

> Hello all,
>
> Traditional diff would show the following two files very different, but
> Coccinelle understands the syntax so it might be able create a smarter
> diff.
>
> t1.c:
> 	f(
> 	){
> 	}
>
> t2.c:
> 	f(){}
>
> How does Coccinelle do diffs internally?  Does it parse the whole syntax
> tree and then walk the old and new trees to show the difference when it
> writes patches to stdout?


It looks to see if there are differences in the tokens, and then if there
are any, it runs standard diff.

Maybe you want a rule like:

@@
parameter list pl;
statement list sl;
@@

f(
- pl
+ pl
  ) {
-sl
+sl
}

Then run spatch with the option: --force-diff

The resulting patch will use spatch to pretty print the file.  Then you
can use normal diff (or maybe something like ediff in emacs) to see the
differences, without being bothered with newline issues.

julia


>
> If so, then perhaps implementing `smpl-diff` would be trivial.  Just load
> two files and compare them with the existing internal diff logic.
>
> Here is the application:
>
> NEC2 was originally written in Fortran and there have been two different
> ports to C from the original Fortran (xec2c and necpp).
>
> The variable and function names are similar (usually exactly identical).
> However, the authors chose different data structures for global values.
> Still, the program flow is almost always the same.
>
> Is there a way to diff two C implementations to see if there are any
> actual differences, not just differences in naming convention?
>
> It seems that it could be possible, Coccinelle has structural awareness
> and understands datatypes.
>
> Then bugs in one program (or the other) caused by author error while
> porting can be detected through such a static analysis. A human could then
> then be compare the C code implementations to the original Fortran to see
> which one is correct, or if the syntactically different representation was
> computationally equivalent.
>
> For example, these two samples compute the same thing but comments,
> floating point notation, and the storage of variables like icon1 and ind1
> differ:
>
> necpp:
>      if( -icon1[iprx] != jx )
>         ind1=2;
>       else
>       {
>         xi= fabsl( cabj* cab[iprx]+ sabj* sab[iprx]+ salpj* salp[iprx]);
>         if( (xi < 0.999999) || (fabsl(bi[iprx]/b-1.) > 1.e-6) )
>           ind1=2;
>         else
>           ind1=0;
>       }
>
> xnec2c:
>       if( -data.icon1[iprx] != jx )
>         dataj.ind1=2;
>       else
>       {
>         xi= fabs( dataj.cabj* data.cab[iprx]+ dataj.sabj*
>             data.sab[iprx]+ dataj.salpj* data.salp[iprx]);
>         if( (xi < 0.999999) ||
>             (fabs(data.bi[iprx]/dataj.b-1.0) > 1.0e-6) )
>           dataj.ind1=2;
>         else
>           dataj.ind1=0;
>       } /* if( -data.icon1[iprx] != jx ) */
>
>
> --
> Eric Wheeler
>
