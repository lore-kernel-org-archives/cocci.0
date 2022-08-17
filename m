Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998D2C25B08
	for <cocci@archiver.kernel.org>; Wed, 17 Aug 2022 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=yA3WCOMYPtruHClrPfsB+M4dm8NoY8qiivAhGpmQC9I=;
  b=CJO5zCQkNgjiAvI4OxUOeM/fNe4IjkbN8PMwyVgcoo0r+aiYHG6yNoT/
   cdFn1wkJ4N8h99ZVomCsC/sZ4uINKfIu/CHiF7SI/LasCqAV1ldSv8FjK
   VqD61CbGIUTLZuKbASqryH6CaEu7tq9ba1KeHxvdoSZBHYUQeiMb8xkiP
   M=;
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
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49037934"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2022 17:26:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ABF4EE0382; Wed, 17 Aug 2022 17:26:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BF673E0380
	for <cocci@sympa.inria.fr>; Wed, 17 Aug 2022 17:26:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yA3WCOMYPtruHClrPfsB+M4dm8NoY8qiivAhGpmQC9I=;
  b=cctIXUi096YWcUYTiemvmay4Etrbwq7dEmnC6Jf2i62HndbXXz43BNgw
   uGdeUuKHTP+TH/5qOTwK4AoGOUU02GPiIB58mYA4kFp5ORWT9Yu1kh8O0
   NjmFDN8KlWMmzzNooO3xnzk2u0EGBOeigSNtK+botKJcN5kNwAu98+n31
   U=;
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49037933"
Received: from unknown (HELO hadrien) ([95.166.247.26])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 17:26:46 +0200
Date: Wed, 17 Aug 2022 17:26:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jakob Koschel <jkl820.git@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <4DFE05B0-AD73-42C5-87C3-F6ED651D8439@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208171721210.2482@hadrien>
References: <20220816085416.1542114-1-jkl820.git@gmail.com> <alpine.DEB.2.22.394.2208161337001.2561@hadrien> <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com> <alpine.DEB.2.22.394.2208162306410.2625@hadrien> <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien> <4DFE05B0-AD73-42C5-87C3-F6ED651D8439@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 513
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208171721210.2482%40hadrien>



On Wed, 17 Aug 2022, Jakob Koschel wrote:

>
>
> > On 17. Aug 2022, at 16:36, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Wed, 17 Aug 2022, Jakob Koschel wrote:
> >
> >>
> >>
> >>> On 16. Aug 2022, at 23:07, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >>>
> >>>>>> Based on that I was wondering if there is a way to say: match if the expression is
> >>>>>> within an expression list. So if I for instance have something like this:
> >>>>>>
> >>>>>> @main@
> >>>>>> type T;
> >>>>>> parameter list P;
> >>>>>> expression list E;
> >>>>>> expression E1;
> >>>>>> identifier func, func_call;
> >>>>>> @@
> >>>>>>
> >>>>>> T func(P@E) {
> >>>>>>  ...
> >>>>>>  func_call(E1 in E)
> >>>>>>  ...
> >>>>>> }
> >>>>>>
> >>>>>> (above is not valid syntax of course)
> >>>>>>
> >>>>>> Ideally I would like to make and get the parameters of 'func' that are used in any position
> >>>>>> as arguments in 'func_call' if that makes sense?
> >>>>
> >>>> Do you have any idea regarding the expression lists?
> >>>>
> >>>> looking at the following code snippet:
> >>>>
> >>>> test.c:
> >>>>
> >>>>  int func1(int argc, char *argv) {
> >>>>     func2(argc, argv);
> >>>>
> >>>>     func3(argc, argv);
> >>>>
> >>>>     func3(argv);
> >>>>  }
> >>>>
> >>>> what works is (only matches the first func3 call):
> >>>>
> >>>>  @main4@
> >>>>  expression list Es;
> >>>>  @@
> >>>>
> >>>>  func2(Es)
> >>>>
> >>>>  @main5@
> >>>>  expression list main4.Es;
> >>>>  identifier func;
> >>>>  @@
> >>>>
> >>>>    func(Es);
> >>>>  + // add comment
> >>>>
> >>>>
> >>>> what doesn't work (matching on the expression list from the parameter list):
> >>>>
> >>>>  @main4@
> >>>>  expression list Es;
> >>>>  @@
> >>>>
> >>>>  int func1(Ps@Es) {
> >>>>  ...
> >>>>  }
> >>>>
> >>>>  @main5@
> >>>>  expression list main4.Es;
> >>>
> >>> Could you try
> >>>
> >>> expression list main4.Ps;
> >>>
> >>> It may transform the parameters into a list of expressions.
> >>
> >> I just tried:
> >>
> >> @main4@
> >> parameter list Ps;
> >> @@
> >>
> >> int func1(Ps) {
> >> ...
> >> }
> >>
> >> @main5@
> >> expression list main4.Ps;
> >> identifier func;
> >> @@
> >>
> >>  func(Es);
> >> + // add comment
> >>
> >> but that throws:
> >>
> >> meta: semantic error: incompatible inheritance declaration Ps
> >>  File "test.cocci", line 45, column 24, charpos = 539
> >>  around = ';',
> >>  whole content = expression list main4.Ps;
> >
> > OK, there is a specific context in which this works, but it is only for
> > generating semantic patch rules.
> >
> > You can do something like
> >
> > @r@
> > parameter list [n] ps;
> > type t;
> > identifier i,f;
> > @@
> >
> > f(ps,t i, ...) { ... }
> >
> > @@
> > expression list[r.n] es;
> > identifier r.i, r.f;
> > expression e;
> > @@
> >
> > (
> > f(es,i,...)
> > |
> > f(es,
> > - e
> > + 0
> >  ,...)
> > )
> >
> > I'm not sure if that is exactly what you want to do, but perhaps it will
> > give some ideas.
>
> I just realized that you are no longer in the 'cc' in the email I send to Markus so I'm pasting
> what I'm trying to do here:
>
> Finally I would like to archive something like this:
>
> void func(void) {
>
>    int x = 0;
>    int y = 0;
>
>    func1(x, 0);
>    func2(0, y);
> }
>
> void func1(int arg1, int arg2) {
>    interesting_func(arg1);
> }
>
> void func2(int arg1, int arg2) {
>    interesting_func(arg2);
> }
>
> In the end I want to, for example, turn it into:
>
> void func(void) {
>
>    int x = 0;
>    // 'x' was used as first argument to interesting_func
>    int y = 0;
>    // 'y' was used as first argument to interesting_func
>
>    func1(x, 0);
>    func2(0, y);
> }
>
> void func1(int arg1, int arg2) {
>    interesting_func(arg1);
> }
>
> void func2(int arg1, int arg2) {
>    interesting_func(arg2);
> }
>
> Basically I want to flag create the matching from 'x'/'y' to the argument to interesting_func.
>
> I was imagining if I could match the parameter list of any function calling 'interesting_func'
> then I can also create a matching from x to that function call and do the rest of the correlation
> in python somehow.
>
> However I'm still failing to detect if any argument (arg1 or arg2 in this case) is used as
> any argument in 'interesting_func'.
>
> I hope this makes more sense?
>
> I think I understand your example, and you are basically matching on the length of 'n' on the parameter list. I'm not exactly sure if that would work with what I'm trying to accomplish.
>
> The more problematic case I *think* is matching the parameter list to the usage within that function.
> In your example it is matching from a function definition to a call to that function.
>
> so not matching:
>
> f(x, y);
>
> to
>
> void f(int arg1, int arg2) { ... }
>
> but matching the parameter to a function call within:
>
> void f(int arg1, int arg2) {
>
>     insteresting_func(arg1); // match arg1 here
>
> }

How many insteresting_funcs do you have?

How about:

@ok exists@
position p; // add other metavariables as needed
@@

f(...,t i,...) {
  ... when any
  interesting_func@p(i)
  ... when any
}

@@
position p1 != ok.p;
@@

*interesting_func@p1(...)

If you know the maximum number of arguments of insteresting_func, then you
can make a series of rules, for the first argument, for the second
argument, etc.

julia

>
> Thanks,
> Jakob
>
> >
> > julia
> >
> >>
> >>>
> >>> julia
> >>>
> >>>>  identifier func;
> >>>>  @@
> >>>>
> >>>>    func(Es);
> >>>>  + // add comment
> >>>>
> >>>>
> >>>> Ideally I would like to 'find' all parameters used in a function call,
> >>>> I also tried this:
> >>>>
> >>>>  @main4@
> >>>>  parameter P;
> >>>>  expression E;
> >>>>  @@
> >>>>
> >>>>  int func1(..., P@E, ...) {
> >>>>  ...
> >>>>  }
> >>>>
> >>>>  @main5@
> >>>>  expression main4.E;
> >>>>  identifier func;
> >>>>  @@
> >>>>
> >>>>    func(..., E, ...);
> >>>>  + // add comment
> >>>>
> >>>>
> >>>> But it throws: 'rule starting on line 41 contains unattached metavariables: main4.E'.
> >>>>
> >>>> Any idea, why e.g. the second one doesn't work? If I print it with python the expression list
> >>>> looks the same as for the first one.
> >>>> Also in the end this boils down to: is it possible to match to any of the expression list elements?
> >>>>
> >>>> Thanks,
> >>>> Jakob
> >>>>
> >>>>>>
> >>>>>>
> >>>>>> Any help is very much appreciated!
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Jakob
>
>
