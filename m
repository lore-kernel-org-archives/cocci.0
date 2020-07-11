Return-Path: <SRS0=jdnp=AW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7315C433DF
	for <cocci@archiver.kernel.org>; Sat, 11 Jul 2020 08:02:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825142077D
	for <cocci@archiver.kernel.org>; Sat, 11 Jul 2020 08:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825142077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06B82Le1003101;
	Sat, 11 Jul 2020 10:02:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7EC533FFB;
	Sat, 11 Jul 2020 10:02:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B14CB3D0F
 for <cocci@systeme.lip6.fr>; Sat, 11 Jul 2020 10:02:19 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06B82IQL003087
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 11 Jul 2020 10:02:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 198F62A506D
Message-ID: <c73a6d331759585788c72d3a7c7cdac28916857e.camel@collabora.com>
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sat, 11 Jul 2020 13:32:12 +0530
In-Reply-To: <alpine.DEB.2.22.394.2007110956170.2364@hadrien>
References: <20200711070035.8483-1-jaskaran.singh@collabora.com>
 <alpine.DEB.2.22.394.2007110956170.2364@hadrien>
Organization: Collabora
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jul 2020 10:02:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 11 Jul 2020 10:02:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] parsing_cocci: parse_cocci: Extend
 is_permissible_proto list
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Sat, 2020-07-11 at 09:57 +0200, Julia Lawall wrote:
> 
> On Sat, 11 Jul 2020, Jaskaran Singh wrote:
> 
> > Add more tokens (binary operators and colon) to the match ladder in
> > is_permissible_proto. These cases would otherwise cause parsing
> > errors
> > for function calls after these tokens.
> 
> Thanks, but it doesn't apply:
> 
> Applying: parsing_cocci: parse_cocci: Extend is_permissible_proto
> list
> error: parsing_cocci/parse_cocci.ml: does not match index
> 

That's weird, it applies fine on gitlab/master for me.

Maybe do a git am --abort and try again?

Cheers,
Jaskaran.

> julia
> 
> > Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
> > ---
> >  parsing_cocci/parse_cocci.ml | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/parsing_cocci/parse_cocci.ml
> > b/parsing_cocci/parse_cocci.ml
> > index 598cdc0b..e30039dc 100644
> > --- a/parsing_cocci/parse_cocci.ml
> > +++ b/parsing_cocci/parse_cocci.ml
> > @@ -1052,7 +1052,8 @@ let find_function_names l =
> >        ((PC.TMid0(_),_) | (PC.TAnd0(_),_))::
> >        (PC.TOPar0(_),_)::_ -> false
> >      | (PC.TOPar0(_),_)::rest
> > -    | (PC.TCPar0(_),_)::rest -> is_permissible_proto rest
> > +    | (PC.TCPar0(_),_)::rest
> > +    | (PC.TMul(_),_)::rest -> is_permissible_proto rest
> >      | x::rest when is_mid x ->
> >          let rec loop = function
> >            [] -> false
> > @@ -1076,6 +1077,21 @@ let find_function_names l =
> >      | (PC.TMetaId(_),_)::_
> >      | (PC.TMetaLocalIdExp(_),_)::_
> >      | (PC.TEq(_),_)::_
> > +    | (PC.TEqEq(_),_)::_
> > +    | (PC.TNotEq(_),_)::_
> > +    | (PC.TShROp(_),_)::_
> > +    | (PC.TShLOp(_),_)::_
> > +    | (PC.TSub(_),_)::_
> > +    | (PC.TPlus(_),_)::_
> > +    | (PC.TMinus(_),_)::_
> > +    | (PC.TDmOp(_),_)::_
> > +    | (PC.TAnd(_),_)::_
> > +    | (PC.TOr(_),_)::_
> > +    | (PC.TXor(_),_)::_
> > +    | (PC.TLogOp(_),_)::_
> > +    | (PC.TAndLog(_),_)::_
> > +    | (PC.TOrLog(_),_)::_
> > +    | (PC.TDotDot(_),_)::_
> >      | (PC.TPtrOp(_),_)::_
> >      | (PC.TEllipsis(_),_)::_
> >      | (PC.TOEllipsis(_),_)::_
> > @@ -1086,6 +1102,7 @@ let find_function_names l =
> >      | (PC.TOBrace(_),_)::_
> >      | (PC.TCBrace(_),_)::_
> >      | (PC.TOPar(_),_)::_
> > +    | (PC.TOCro(_),_)::_
> >      | (PC.TIdent(_),_)::_ -> false
> >      | _ -> true in
> >    let decl_or_proto clt info bef aft =
> > --
> > 2.21.3
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
