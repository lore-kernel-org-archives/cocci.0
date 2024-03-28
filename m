Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3596FCD1283
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2024 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xwRuOB+QA0UWxk/oev/haeSvBzm9C6Cc2KYAMDWi36E=;
  b=Q++PnXzEfthldtosg/6PbJc61q0aAfe7YvfdH1VZHBFqX4KSnZn2rkp9
   3zp4aXOIFqvyybXRM1Z1ts8F9fqF924PXQQMxekIJ2tq2y4Jt2dXNEHni
   8GwXfNC6m7t5OPOWpZtA12E9v6rPa7nFaQiSGBsiebbFdMPQWPJ9QgA6O
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,162,1708383600"; 
   d="scan'208";a="158957454"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2024 15:49:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E824E01A8; Thu, 28 Mar 2024 15:49:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 53902E0131
	for <cocci@sympa.inria.fr>; Thu, 28 Mar 2024 15:49:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xwRuOB+QA0UWxk/oev/haeSvBzm9C6Cc2KYAMDWi36E=;
  b=Yor4fGWFPIOGMfW5sWXqSLH6fBSUIhTb3XtG0G20h+6AtgP9meUTPwaY
   qvFP6JStUV1lB1hVOOgKnXdRGNjygCdjILTD4W9LOAshNKS4CzdDA1IBL
   Za7fnQnwJNpi9fZAIfms7fwfWMcCL29UUeHksc2EGfxxI1vd3ZFQnzYjQ
   c=;
X-IronPort-AV: E=Sophos;i="6.07,162,1708383600"; 
   d="scan'208";a="83351971"
Received: from n2-77-213.dhcp.drexel.edu (HELO n3-88-209.dhcp.drexel.edu) ([144.118.77.213])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 15:49:14 +0100
Date: Thu, 28 Mar 2024 10:49:12 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Peter Senna Tschudin <peter.senna@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CA+MoWDo-DJKq1jjC7Sr41c3+7G=P_wGsQHJrGaxMNyB+UOsjwg@mail.gmail.com>
Message-ID: <e669e126-f627-646e-d069-baca9c3e0eb@inria.fr>
References: <CA+MoWDqtRxQQ08k53_bP6L96FReUx8AxV2BU7dHWC-hfEr_kow@mail.gmail.com> <ffb475dd-496c-2ae-6329-86d6163b2bb6@inria.fr> <CA+MoWDoScx-d3bj+niNbPYjrujb+pO0fyrhkSDZHxkcntDLimg@mail.gmail.com> <23254a95-222e-494-3f0-508a2790753@inria.fr>
 <CA+MoWDo-DJKq1jjC7Sr41c3+7G=P_wGsQHJrGaxMNyB+UOsjwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-311492982-1711637353=:3496"
Subject: Re: [cocci] Returning statically allocated nested structs
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1628
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/e669e126-f627-646e-d069-baca9c3e0eb%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-311492982-1711637353=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 28 Mar 2024, Peter Senna Tschudin wrote:

> Thanks Julia,
>
> Your question about nesting inspired me to a simpler solution:
>
> @rule1@

You could add the word exists after rule1, in case some other returns do
something different.

> identifier i, s;
> position p;
> @@
> struct i s;
> ...
> return@p s;
>
> @script:python@
> p << rule1.p;
> s << rule1.s;
> @@
> cocci.print_main(s, p)
>
> Do I need to worry about calling cocci.print_secs() after the print_main()?

No, just print_main is fine.

julia

>
> On Thu, Mar 28, 2024 at 11:10 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Thu, 28 Mar 2024, Peter Senna Tschudin wrote:
> >
> > > Hi Julia,
> > >
> > > Thanks for the reply!
> > >
> > > On Thu, Mar 28, 2024 at 10:08 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > >
> > > >
> > > > On Thu, 28 Mar 2024, Peter Senna Tschudin wrote:
> > > >
> > > > > Dear list,
> > > > >
> > > > > I am trying to come up with a semantic patch to detect uses of nested
> > > > > structs, more specifically:
> > > > >  - the nested struct is statically allocated
> > > > >  - the statically allocated nested struct is returned by a function.
> > > > >
> > > > > Here is an example:
> > > > >
> > > > > struct inner {
> > > > >
> > > > >     /* some inner struct stuff*/
> > > > >
> > > > > } inner;
> > > > >
> > > > > struct outer  {
> > > > >
> > > > >     /* some outer struct stuff*/
> > > > >
> > > > >     struct inner i; // The kind of nesting I care about
> > > > >     struct inner is[SOME_MAGIC_NUMBER]; // The kind of nesting I care about too
> > > > >
> > > > >     struct inner *ip; // Nah, this is boring. I don't care about boring
> > > > > } outer;
> > > > >
> > > > > void sillyfu() {
> > > Argh, that was a typo!
> > >
> > > struct outer sillyfu() {
> > > > >     struct outer ou = { }; // initialization does not matter.
> > > > >     struct outer *oup = NULL; // Nah, this is boring. I don't care about boring
> > > > >
> > > > >     /* some serious silly stuff */
> > > > >
> > > > >     return ou;
> > > >
> > > > Not sure to understand.  The return type of the function is void.  Was
> > > > that a typo?
> > > >
> > > > Returning a structure in general seems like something to be concerned
> > > > about.  Does it matter that another structure is nested inside?
> > >
> > > I am not sure if it matters, but it may. The compiler seems to be the
> > > arbiter who decides what happens when returning a local struct. It may
> > > work, it may not. One theory for not working is variable scope.
> > > Returning a local struct may not work due to the local nature of the
> > > struct. In this case the compiler would free the memory used by the
> > > struct when the function returns, causing undefined behavior. In this
> > > scenario the nested struct simply adds another layer of the same
> > > problem.
> > >
> > > Another theory says that the compiler may decide based on the struct
> > > size. The compiler may tolerate returning certain struct sizes, but
> > > not others.
> >
> > The following is not tested, but seems like it should be sufficient.
> >
> > @r@
> > identifier i, j, k;
> > @@
> >
> > struct i { ...
> >   struct j k;
> >   ...
> > };
> >
> > @@
> > identifier r.i;
> > identifier f,x;
> > @@
> >
> > f(...) {
> >   struct i x = ...;
> >   ...
> > * return x;
> > }
> >
> > julia
>
>
>
> --
>                          Peter
>
--8323329-311492982-1711637353=:3496--
