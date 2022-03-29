Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1330AC433FE
	for <cocci@archiver.kernel.org>; Tue, 29 Mar 2022 09:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Seqputb8Xv1GwdRmvmieUMnfPxxMla3k1qIwl65EEFs=;
  b=t+EU/sFFTC1oENAliJOEtE9By3KtCCq0noIo/RdghxUIyktMQbZ7Veax
   xmYArtoG7cZ0RUf/485Q5N3EhIlaELHgRQs4Gn34pZEuNnBnZvkL3u8GS
   JSIHnZq/J+TA0wTTty2dr+4OjdIPudOZWU+FRcL8bBlORj+RpHLZI1ZfH
   A=;
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
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="28851382"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2022 11:24:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8D88CE436E; Tue, 29 Mar 2022 11:24:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E8F0E436E
	for <cocci@sympa.inria.fr>; Tue, 29 Mar 2022 11:24:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Seqputb8Xv1GwdRmvmieUMnfPxxMla3k1qIwl65EEFs=;
  b=sf4mYk9lw+WDDFmTWFMz2NgYHLPpS9FliBgadKVZmohes+xktTkbJNsQ
   aSpyoxIes9CjErv3Rdop2u6u7Oh9eA+o1bKj1+w2vFNC6tRRoJMaj4oPp
   bdpBlpdKbRahYoNgt6lCfMsnt4fNtxWAVuLP1Scjy6MKIMOtSP9YvR4XU
   E=;
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="28851376"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 11:24:50 +0200
Date: Tue, 29 Mar 2022 11:24:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Dan Carpenter <dan.carpenter@oracle.com>
cc: Daniel Latypov <dlatypov@google.com>, 
    Marcelo Schmitt <marcelo.schmitt1@gmail.com>, corbet@lwn.net, 
    mchehab+huawei@kernel.org, davidgow@google.com, linux-doc@vger.kernel.org, 
    linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org, 
    linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
In-Reply-To: <20220329090721.GW3293@kadam>
Message-ID: <alpine.DEB.2.22.394.2203291122290.3490@hadrien>
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7> <CAGS_qxpjj1W54BM7v2Cszne4nh5kUXZt89Dq-5nO3nD7RWhsRQ@mail.gmail.com> <20220329090721.GW3293@kadam>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] Documentation: dev-tools: Add a section for
 static analysis tools
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 306
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203291122290.3490%40hadrien>



On Tue, 29 Mar 2022, Dan Carpenter wrote:

> On Mon, Mar 28, 2022 at 05:37:28PM -0500, Daniel Latypov wrote:
> > On Mon, Mar 28, 2022 at 4:20 PM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Complement the Kernel Testing Guide documentation page by adding a
> > > section about static analysis tools.
> > >
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> >
> >
> > > ---
> > > Hey everyone,
> > >
> > > I think this patch can be a good addition to the documentation as
> > > discussed in the thread for the testing guide documentation page:
> > > Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/
> > >
> > > If you think it would be worth it, I can try making something more
> >
> > Nice!
> > This is definitely worth including, but I'm out of my depth here.
> > Some ideas below in case they're helpful.
> >
> > Acked-by: Daniel Latypov <dlatypov@google.com>
> >
> > > elaborated. Maybe provide some guidance on when to use each tool.
> > > I've been studying how Linux device drivers are tested.
> > > Here's a post I wrote talking about some testing tools.
> > > Link: https://marcelosc.gitlab.io/how-is-linux-tested/
> > >
> > > Best regards,
> > > Marcelo
> > >
> > >  Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > > index 65feb81edb14..b00511109a9d 100644
> > > --- a/Documentation/dev-tools/testing-overview.rst
> > > +++ b/Documentation/dev-tools/testing-overview.rst
> > > @@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
> > >  Some of these tools integrate with KUnit or kselftest and will
> > >  automatically fail tests if an issue is detected.
> > >
> > > +Static Analysis Tools
> > > +======================
> > > +
> > > +In addition to testing a running kernel, one may also scout for bugs by
> > > +analyzing the source code semantics. Three tools are well known for serving this
> > > +purpose.
> > > +
> > > +Sparse can help test the kernel by performing type-checking, lock checking,
> > > +value range checking, in addition to reporting various errors and warnings while
> > > +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> > > +page for details on how to use it.
> > > +
> > > +Smatch extends Sparse and provides additional checks for programming logic
> >
> > Coming from a place of ignorance, when should I use sparse vs smatch?
> > Is there an existing consensus on this, or is that a controversial question?
>
> I am the author of Smatch.
>
> Sparse is a compiler which can print static checker warnings.  Smatch
> uses Sparse as a C front end.
>
> Sparse is useful for type checking, detecting places which use __user
> pointers improperly or endian bugs.  Sparse is much faster than Smatch.
>
> Smatch does flow analysis and if you build the DB, then it does
> cross function analysis.  Smatch tries to answer questions like where is
> this buffer allocated?  How big is it?  Can this index be controlled by
> the user?  Is this variable larger than that variable?  I feel like it's
> generally easier to write checks in Smatch than it is to write checks in
> Sparse.
>
> Coccinelle is probably the easiest for writing checks.  It works before
> the pre-compiler so it easier to check for bugs in macros using
> Coccinelle.  Coccinelle also writes patches fixes for you which no one
> else does.
>
> There are sometimes overlap in their checks.  But I'm not going to
> re-implement Sparse's check in Smatch because Sparse already does that
> well.  If it's just way easier to write the check with Coccinelle then
> do that.
>
> With Coccinelle you can do a mass conversion from
> kmalloc(x * size, GFP_KERNEL) to kmalloc_array(x, size, GFP_KERNEL); and
> that's really useful.  If you just created a Smatch warning and try to
> push the work of converting on to the maintainers they would be annoyed.
> You'd have to argue about each warning if can really overflow or not.

Coccinelle does no analysis of variable values, which is the strong point
of smatch.  On the other hand, as Dan points out, it allows you to do
simple things in a simple way.

julia
