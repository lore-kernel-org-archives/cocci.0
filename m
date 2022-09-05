Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA70ECAAD3
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YMUJWuom4SrNnCKO4MAnqxbll2feNC467UMRfyub7R8=;
  b=DIiUdEaSkeAgAOhYqITcWV8X4PNDqBbpOivHrFkCc8ADG3Jloi7Icso3
   ftQ5n3VJQBG4LOMG8cEqN4cBcel6zTzhFbQlMTI+LbHha32qqBx4VWevI
   Qj0ia6OTMTSM9Fbkk2QYjoqmxFLYrWomnSax551bRxHxXru7ep3SvdZTy
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="51337753"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 14:29:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BE7B8E779D; Mon,  5 Sep 2022 14:29:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EE096E015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 14:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YMUJWuom4SrNnCKO4MAnqxbll2feNC467UMRfyub7R8=;
  b=DJtyxSA1MH/+mCSKit1NJO0QYMn7f5LAv4Jv3+2HHuhS8hbZF1VGqug7
   dIWkJbqiCyNFvfc8EEoJO6diCrcW1fkoCN9KMsek/arBmLBl+U4VedJ+l
   JHNbTrVJDK1jYyWXlCCwhRICNdeEIf+nvCMnwyPM0QsLybHupOn/xHhWb
   M=;
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="22878488"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 14:29:19 +0200
Date: Mon, 5 Sep 2022 14:29:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2209051427090.2731@hadrien>
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien> <20220905090915.3569051-1-jtojnar@gmail.com> <alpine.DEB.2.22.394.2209051246490.2731@hadrien> <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 542
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209051427090.2731%40hadrien>



On Mon, 5 Sep 2022, Jan Tojnar wrote:

> On Mon, 5 Sept 2022 at 12:48, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> > I'm not sure to understand the point.  --bench and --compare-with expected
> > don't mean at all the same thing as just keep going.  --bench prints some
> > statistics about the CTL mating, and --compare-with-expected checks that
> > the result is the same as the one indicated in a .res file.
>
> I would expect that when an error occurs during transforming one of the files,
> transforming any other files does not make sense since the SmPL patch
> probably makes incorrect assumptions about the source code.

Each test case applies to a unique file, so this problem doesn't occur.

Furthermore, the original use of Coccinelle was to create a patch, not to
update the file.  One can update the file using the patch afterwards, if
the result is satisfactory.  But I don't know what options most people
use.

Thanks,
julia

>
> In my case, I made the Python script inside the semantic patch raise
> an Exception
> when the source code does not meet certain preconditions, to detect that
> the underlying code changed in a way that the .cocci file needs adjusting.
>
> I guess that failures might make sense for tests (--compare-with-expected
> seems to only be relevant for tests as far as I can tell). But I would expect
> benchmarking to be useful for people creating patches and there, silently
> suppressing failures could be unexpected.
>
> But you are more knowledgeable about the use cases so I will leave it up to you.
> to profile failing
>
