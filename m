Return-Path: <SRS0=IsyB=5E=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CDC4332D
	for <cocci@archiver.kernel.org>; Thu, 19 Mar 2020 05:12:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDD82070A
	for <cocci@archiver.kernel.org>; Thu, 19 Mar 2020 05:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="viM/Io9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDD82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02J5C7mP022559;
	Thu, 19 Mar 2020 06:12:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D521A7809;
	Thu, 19 Mar 2020 06:12:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8665D7808
 for <cocci@systeme.lip6.fr>; Thu, 19 Mar 2020 06:12:05 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02J5C2lO007712
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 19 Mar 2020 06:12:03 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id mj6so485230pjb.5
 for <cocci@systeme.lip6.fr>; Wed, 18 Mar 2020 22:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=f22FH604CHOzB99xxgj8YEBMCc69jVAeqzoSs0AcHhk=;
 b=viM/Io9Sa7IYvVbz48zYOV9Ek1N+KgyToYZ7qJNK/iCnyglT/v6Bw+YPSjwyONnwxb
 cyNf6IPkDsJ+7YIC83RNmXh83qGPwMTNV+2DHLIiFHErpm/02dnxWmABJqVHaiWlCAXO
 u7DECc9vFMb0VrQ2+JOVMvN5QH3HbPVB8rB2WLZfkgIb1xGIOft5oAhtdAmaHMRTNjvI
 sSe1Bsj+/ymTOW2LZU6UJGNExBbrFNZNF74V71jU377Etf2QH+HU+Xthkw4zUnHhkacM
 IS/HVBYHgSFVQWNEZdpyXTw2k39LrZUY/KkPj0Fu+fbtI2ZEOldzumfsNSaL9LzLBuAs
 PdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=f22FH604CHOzB99xxgj8YEBMCc69jVAeqzoSs0AcHhk=;
 b=XhaMmPCGtROABPU1YgkXUFQax67qm4WPnys/kXCPbJrKXMSclPcgN93nAnXCEK1HZK
 DcHRwOBv3CAJnIBiyzuzVQhYjIBcg+gqAx5xREkvCtffq35ssHNe0ASoFbq/2AGIBx60
 stIpsELJtScFruGJK5FdWIItO4Fod/Oty2obgP01lt9q1EnE1bjIK3L8lMVtnSFRymx2
 f8y7qep+BFzBVPFvdlQ/97vzSlmN6KsUQSeVTX7me0dcxjY3mKtGYUo/xRgIgqEBegr0
 UbHsQFmup3g9U4fRYNEiGchxMJsz8VBxLO8Lg+kvCdD9EieJ9NXkY/aVsZ3OxXO6jCnV
 gJgg==
X-Gm-Message-State: ANhLgQ1nn6vRAvxkNfaL0qS7ogu2csz2FoVgcGidWns1M/Z5KIeMrh3X
 4b6hugVZlAyo0nvqb4VaOfo=
X-Google-Smtp-Source: ADFU+vu+uw4rmR3yAq/t9mGRcHIoACb2vH2kSxerBNuo6dCgp4LFbC8pOkDBjF5pvpN/JtNV/5+jQw==
X-Received: by 2002:a17:902:341:: with SMTP id 59mr1705523pld.29.1584594721256; 
 Wed, 18 Mar 2020 22:12:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id f8sm692905pfd.57.2020.03.18.22.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 22:12:00 -0700 (PDT)
Message-ID: <98213125c43ce9f603643ef31ca1ad186857b16d.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 19 Mar 2020 10:41:56 +0530
In-Reply-To: <alpine.DEB.2.21.2003181831030.2979@hadrien>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
 <20200316100319.27935-4-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2003181831030.2979@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 19 Mar 2020 06:12:08 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 19 Mar 2020 06:12:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 03/26] parsing_cocci: parser: Add
 direct_declarator/direct_abstract_d rules
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

On Wed, 2020-03-18 at 18:31 +0100, Julia Lawall wrote:
> 
> On Mon, 16 Mar 2020, Jaskaran Singh wrote:
> 
> > The direct_declarator rule and the direct_abstract_d rule are
> > present in the C parser. Add similar rules to the SmPL parser so
> > that
> > declarators are parsed as they are in the C parser.
> > 
> > For the type ParenType, direct_declarator and direct_abstract_d
> > only
> > allow the following productions:
> > 
> > 	( * id  [ .* ] ) ( params )
> > 
> > i.e. a function pointer or an array of function pointers. The
> > compromise
> > is flexibility in the range of productions, mainly because
> > collateral
> > evolutions needed by having a flexible rule are very large and
> > distasteful.
> 
> It is not clear what is meant by flexible.  Can you give an example
> of
> what will not be supported?
> 

Well, it's mainly anything that uses ParenType for anything other than
a function pointer or an array of function pointers. Examples of
productions that aren't supported:

int (**x[])(params); // array of pointer to function pointer

int (*x[][])(params); // array of array of function pointers

int ((*x))(params); // ident wrapped in double parantheses

To be honest, I think the first two and similar ones (i.e. array of
array of ... pointer to pointer to ....) can be supported by
implementing some kind of loop, but don't know about other
productions.

Cheers,
Jaskaran.

> julia
> 
> > Replace usage of the older d_ident rule in the SmPL parser with the
> > above mentioned rules. All usages of d_ident, however, have not
> > been
> > removed due to reduce/reduce conflicts.
> > 
> > Remove rules/productions that parse function pointers with usage of
> > direct_declarator and direct_abstract_d.
> > 
> > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > ---
> >  parsing_cocci/parser_cocci_menhir.mly | 239 +++++++++++++---------
> > ----
> >  1 file changed, 116 insertions(+), 123 deletions(-)
> > 
> > diff --git a/parsing_cocci/parser_cocci_menhir.mly
> > b/parsing_cocci/parser_cocci_menhir.mly
> > index 26958f63..fade830f 100644
> > --- a/parsing_cocci/parser_cocci_menhir.mly
> > +++ b/parsing_cocci/parser_cocci_menhir.mly
> > @@ -1116,33 +1116,17 @@ struct_decl_one:
> >  	{ let (mids,code) = t in
> >  	Ast0.wrap
> >  	  (Ast0.ConjField(P.id2mcode lp,code,mids, P.id2mcode rp)) }
> > -    | t=ctype d=d_ident_option bf=struct_bitfield? pv=TPtVirg
> > +    | t=ctype d=direct_decl_option(disj_ident) bf=struct_bitfield?
> > pv=TPtVirg
> >  	 { let (id,fn) = d in
> >  	 Ast0.wrap(Ast0.Field(fn t,id,bf,P.clt2mcode ";" pv)) }
> > -    | t=ctype lp1=TOPar st=TMul d=d_ident_option rp1=TCPar
> > -	lp2=TOPar p=decl_list(name_opt_decl) rp2=TCPar
> > -	bf=struct_bitfield? pv=TPtVirg
> > -        { let (id,fn) = d in
> > -        let t =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp1,P.clt2mcode "*" st,P.clt2mcode
> > ")" rp1,
> > -		P.clt2mcode "(" lp2,p,P.clt2mcode ")" rp2)) in
> > -        Ast0.wrap(Ast0.Field(fn t,id,bf,P.clt2mcode ";" pv)) }
> > -     | cv=ioption(const_vol) i=pure_ident_or_symbol
> > d=d_ident_option
> > +    | cv=ioption(const_vol) i=pure_ident_or_symbol
> > +      d=direct_decl_option(disj_ident)
> >  	 bf=struct_bitfield?
> >  	 pv=TPtVirg
> >  	 { let (id,fn) = d in
> >  	 let idtype = P.make_cv cv (Ast0.wrap (Ast0.TypeName(P.id2mcode
> > i))) in
> >  	 Ast0.wrap(Ast0.Field(fn idtype,id,bf,P.clt2mcode ";" pv)) }
> > 
> > -d_ident_option:
> > -	 { None, (fun x -> x) }
> > -     | d=d_ident {
> > -       let (id, fn) = d in
> > -       (Some id, fn)
> > -    }
> > -
> >  struct_bitfield:
> >     c=TDotDot e=expr { (P.clt2mcode ":" c, e) }
> > 
> > @@ -1529,17 +1513,9 @@ storage:
> >         | s=Tregister    { P.clt2mcode Ast.Register s }
> >         | s=Textern      { P.clt2mcode Ast.Extern s }
> > 
> > -decl: t=ctype i=disj_ident a=list(array_dec)
> > -	{ let t = P.arrayify t a in Ast0.wrap(Ast0.Param(t, Some i)) }
> > +decl: t=ctype d=direct_declarator(disj_ident)
> > +	{ let (i,fn) = d in Ast0.wrap(Ast0.Param(fn t, Some i)) }
> >      | t=ctype { (*verify in FunDecl*) Ast0.wrap(Ast0.Param(t,
> > None)) }
> > -    | t=ctype lp=TOPar s=TMul i=disj_ident rp=TCPar
> > -	lp1=TOPar d=decl_list(name_opt_decl) rp1=TCPar
> > -        { let fnptr =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp,P.clt2mcode "*" s,P.clt2mcode ")"
> > rp,
> > -		P.clt2mcode "(" lp1,d,P.clt2mcode ")" rp1)) in
> > -	Ast0.wrap(Ast0.Param(fnptr, Some i)) }
> >      | TMetaParam
> >  	{ let (nm,cstr,pure,clt) = $1 in
> >  	Ast0.wrap(Ast0.MetaParam(P.clt2mcode nm clt,cstr,pure)) }
> > @@ -1547,14 +1523,6 @@ decl: t=ctype i=disj_ident a=list(array_dec)
> > 
> >  name_opt_decl:
> >        decl  { $1 }
> > -    | t=ctype lp=TOPar s=TMul rp=TCPar
> > -	lp1=TOPar d=decl_list(name_opt_decl) rp1=TCPar
> > -        { let fnptr =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp,P.clt2mcode "*" s,P.clt2mcode ")"
> > rp,
> > -		P.clt2mcode "(" lp1,d,P.clt2mcode ")" rp1)) in
> > -	Ast0.wrap(Ast0.Param(fnptr, None)) }
> > 
> >  const_vol:
> >        Tconst       { P.clt2mcode Ast.Const $1 }
> > @@ -1684,13 +1652,15 @@ decl_var:
> >      t=ctype pv=TPtVirg
> >        { [Ast0.wrap(Ast0.TyDecl(t,P.clt2mcode ";" pv))] }
> >    | TMetaDecl { [P.meta_decl $1] }
> > -  | s=ioption(storage) t=ctype d=comma_list(d_ident) pv=TPtVirg
> > +  | s=ioption(storage) t=ctype
> > +      d=comma_list(direct_declarator(disj_ident)) pv=TPtVirg
> >        { List.map
> >  	  (function (id,fn) ->
> >  	    Ast0.wrap(Ast0.UnInit(s,fn t,id,[],P.clt2mcode ";" pv)))
> >  	  d }
> >    | f=funproto { [f] }
> > -  | s=ioption(storage) t=ctype d=d_ident a=attr_list q=TEq
> > e=initialize
> > +  | s=ioption(storage) t=ctype d=direct_declarator(disj_ident)
> > +    a=attr_list q=TEq e=initialize
> >        pv=TPtVirg
> >        {let (id,fn) = d in
> >        [Ast0.wrap
> > @@ -1711,18 +1681,6 @@ decl_var:
> >        let idtype = P.make_cv cv (Ast0.wrap
> > (Ast0.TypeName(P.id2mcode i))) in
> >        [Ast0.wrap(Ast0.Init(s,fn idtype,id,a,P.clt2mcode "=" q,e,
> >  			   P.clt2mcode ";" pv))] }
> > -  /* function pointer type */
> > -  | s=ioption(storage)
> > -    t=ctype lp1=TOPar st=TMul d=d_ident rp1=TCPar
> > -    lp2=TOPar p=decl_list(name_opt_decl) rp2=TCPar
> > -    pv=TPtVirg
> > -      { let (id,fn) = d in
> > -        let t =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp1,P.clt2mcode "*" st,P.clt2mcode
> > ")" rp1,
> > -		P.clt2mcode "(" lp2,p,P.clt2mcode ")" rp2)) in
> > -        [Ast0.wrap(Ast0.UnInit(s,fn t,id,[],P.clt2mcode ";" pv))]
> > }
> >    | s=ioption(storage) d=decl_ident o=TOPar e=eexpr_list_option
> > c=TCPar
> >        p=TPtVirg
> >        { [Ast0.wrap(Ast0.MacroDecl(s,d,P.clt2mcode "(" o,e,
> > @@ -1735,56 +1693,25 @@ decl_var:
> >  	       (s,d,P.clt2mcode "(" o,e,
> >  		P.clt2mcode ")" c,P.clt2mcode "=" q,i,
> >  		P.clt2mcode ";" p))] }
> > -  | s=ioption(storage)
> > -    t=ctype lp1=TOPar st=TMul d=d_ident rp1=TCPar
> > -    lp2=TOPar p=decl_list(name_opt_decl) rp2=TCPar
> > -    q=TEq e=initialize pv=TPtVirg
> > -      { let (id,fn) = d in
> > -        let t =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp1,P.clt2mcode "*" st,P.clt2mcode
> > ")" rp1,
> > -		P.clt2mcode "(" lp2,p,P.clt2mcode ")" rp2)) in
> > -      [Ast0.wrap
> > -	  (Ast0.Init(s,fn t,id,[],P.clt2mcode "=" q,e,P.clt2mcode ";"
> > pv))]}
> > -  | s=Ttypedef t=typedef_ctype id=comma_list(typedef_ident)
> > pv=TPtVirg
> > +  | s=Ttypedef t=typedef_ctype
> > +      d=comma_list(direct_declarator(typedef_ident)) pv=TPtVirg
> >        { let s = P.clt2mcode "typedef" s in
> >          List.map
> > -	  (function id ->
> > -	    Ast0.wrap(Ast0.Typedef(s,t,id,P.clt2mcode ";" pv)))
> > -	  id }
> > -  | s=Ttypedef t=typedef_ctype id=typedef_ident
> > -      l=TOCro i=eexpr r=TCCro pv=TPtVirg
> > -      { let s = P.clt2mcode "typedef" s in
> > -        let t = P.arrayify t [(l,Some i,r)] in
> > -	[Ast0.wrap(Ast0.Typedef(s,t,id,P.clt2mcode ";" pv))] }
> > -  | s=Ttypedef t=typedef_ctype id=typedef_ident
> > -      l=TOCro i=eexpr r=TCCro
> > -      l2=TOCro i2=eexpr r2=TCCro pv=TPtVirg
> > -      { let s = P.clt2mcode "typedef" s in
> > -        let t = P.arrayify t [(l,Some i,r)] in
> > -        let t = P.arrayify t [(l2,Some i2,r2)] in
> > -	[Ast0.wrap(Ast0.Typedef(s,t,id,P.clt2mcode ";" pv))] }
> > -  | s=Ttypedef
> > -    t=typedef_ctype lp1=TOPar st=TMul id=typedef_ident rp1=TCPar
> > -    lp2=TOPar p=decl_list(name_opt_decl) rp2=TCPar pv=TPtVirg
> > -      { let s = P.clt2mcode "typedef" s in
> > -        let t =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp1,P.clt2mcode "*" st,P.clt2mcode
> > ")" rp1,
> > -		P.clt2mcode "(" lp2,p,P.clt2mcode ")" rp2)) in
> > -	[Ast0.wrap(Ast0.Typedef(s,t,id,P.clt2mcode ";" pv))]}
> > +	  (function (id,fn) ->
> > +	    Ast0.wrap(Ast0.Typedef(s,fn t,id,P.clt2mcode ";" pv)))
> > +	  d }
> > 
> >  one_decl_var:
> >      t=ctype pv=TPtVirg
> >        { Ast0.wrap(Ast0.TyDecl(t,P.clt2mcode ";" pv)) }
> >    | TMetaDecl { P.meta_decl $1 }
> > -  | s=ioption(storage) t=ctype d=d_ident a=attr_list pv=TPtVirg
> > +  | s=ioption(storage) t=ctype d=direct_declarator(disj_ident)
> > +      a=attr_list pv=TPtVirg
> >        { let (id,fn) = d in
> >          Ast0.wrap(Ast0.UnInit(s,fn t,id,a,P.clt2mcode ";" pv)) }
> >    | f=funproto { f }
> > -  | s=ioption(storage) t=ctype d=d_ident a=attr_list q=TEq
> > e=initialize
> > +  | s=ioption(storage) t=ctype d=direct_declarator(disj_ident)
> > +      a=attr_list q=TEq e=initialize
> >        pv=TPtVirg
> >        { let (id,fn) = d in
> >        Ast0.wrap
> > @@ -1802,18 +1729,6 @@ one_decl_var:
> >        let idtype = P.make_cv cv (Ast0.wrap
> > (Ast0.TypeName(P.id2mcode i))) in
> >        Ast0.wrap(Ast0.Init(s,fn idtype,id,a,P.clt2mcode "=" q,e,
> >  			   P.clt2mcode ";" pv)) }
> > -  /* function pointer type */
> > -  | s=ioption(storage)
> > -    t=ctype lp1=TOPar st=TMul d=d_ident rp1=TCPar
> > -    lp2=TOPar p=decl_list(name_opt_decl) rp2=TCPar
> > -    pv=TPtVirg
> > -      { let (id,fn) = d in
> > -        let t =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp1,P.clt2mcode "*" st,P.clt2mcode
> > ")" rp1,
> > -		P.clt2mcode "(" lp2,p,P.clt2mcode ")" rp2)) in
> > -        Ast0.wrap(Ast0.UnInit(s,fn t,id,[],P.clt2mcode ";" pv)) }
> >    | s=ioption(storage) d=decl_ident o=TOPar e=eexpr_list_option
> > c=TCPar
> >        p=TPtVirg
> >        { Ast0.wrap(Ast0.MacroDecl(s,d,P.clt2mcode "(" o,e,
> > @@ -1826,19 +1741,103 @@ one_decl_var:
> >                 (s,d,P.clt2mcode "(" o,e,
> >                  P.clt2mcode ")" c,P.clt2mcode "=" q,i,
> >                  P.clt2mcode ";" p)) }
> > -  | s=ioption(storage)
> > -    t=ctype lp1=TOPar st=TMul d=d_ident rp1=TCPar
> > -    lp2=TOPar p=decl_list(name_opt_decl) rp2=TCPar a=attr_list
> > -    q=TEq e=initialize pv=TPtVirg
> > -      { let (id,fn) = d in
> > -        let t =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp1,P.clt2mcode "*" st,P.clt2mcode
> > ")" rp1,
> > -		P.clt2mcode "(" lp2,p,P.clt2mcode ")" rp2)) in
> > -      Ast0.wrap(Ast0.Init(s,fn t,id,a,P.clt2mcode "="
> > q,e,P.clt2mcode ";" pv))}
> > 
> > 
> > +direct_declarator(ident_type):
> > +    ident_type
> > +      { ($1, function x -> x) }
> > +  | o=TOPar m=list(TMul) d=direct_declarator(ident_type) c=TCPar
> > +      { let (id,fn) = d in
> > +        (id,
> > +         function t ->
> > +          let ty =  fn (P.pointerify t m) in
> > +          let _ =
> > +           match Ast0.unwrap ty with
> > +            Ast0.Pointer(ty1,_) ->
> > +             (match Ast0.unwrap ty1 with
> > +               Ast0.FunctionType(ty2,_,_,_) -> ()
> > +             | _ ->
> > +              raise (Semantic_cocci.Semantic "expected function
> > pointer"))
> > +           | Ast0.Array(ty1,_,_,_) ->
> > +              (match Ast0.unwrap ty1 with
> > +                Ast0.Pointer(ty2,_) ->(
> > +                 match Ast0.unwrap ty2 with
> > +                  Ast0.FunctionType(ty3,_,_,_) -> ()
> > +                 | _ ->
> > +                  raise (Semantic_cocci.Semantic "expected
> > function pointer"))
> > +             | _ ->
> > +              raise (Semantic_cocci.Semantic "expected function
> > pointer"))
> > +           | _ ->
> > +            raise (Semantic_cocci.Semantic "expected function
> > pointer") in
> > +          Ast0.wrap
> > +            (Ast0.ParenType
> > +               (P.clt2mcode "(" o,
> > +                ty,
> > +                P.clt2mcode ")" c))) }
> > +  | d=direct_declarator(ident_type) a=array_dec
> > +      { let (id,fn) = d in
> > +        (id, function t -> let r = P.arrayify t [a] in fn r) }
> > +  | d=direct_declarator(ident_type)
> > +      o=TOPar arglist=decl_list(name_opt_decl) c=TCPar
> > +      { let (id,fn) = d in
> > +        (id, function t ->
> > +              let r =
> > +               Ast0.wrap
> > +                (Ast0.FunctionType
> > +                  (t,P.clt2mcode "(" o,arglist,P.clt2mcode ")" c))
> > in fn r) }
> > +
> > +
> > +direct_abstract_d:
> > +    o=TOPar m=list(TMul) d=direct_abstract_d c=TCPar
> > +      { function t ->
> > +          let ty = d (P.pointerify t m) in
> > +          let _ =
> > +           match Ast0.unwrap ty with
> > +            Ast0.Pointer(ty1,_) ->
> > +             (match Ast0.unwrap ty1 with
> > +               Ast0.FunctionType(ty2,_,_,_) ->()
> > +             | _ ->
> > +              raise (Semantic_cocci.Semantic "expected function
> > pointer"))
> > +           | Ast0.Array(ty1,_,_,_) ->
> > +              (match Ast0.unwrap ty1 with
> > +                Ast0.Pointer(ty2,_) ->(
> > +                 match Ast0.unwrap ty2 with
> > +                  Ast0.FunctionType(ty3,_,_,_) -> ()
> > +                 | _ ->
> > +                  raise (Semantic_cocci.Semantic "expected
> > function pointer"))
> > +             | _ ->
> > +              raise (Semantic_cocci.Semantic "expected function
> > pointer"))
> > +           | _ ->
> > +            raise (Semantic_cocci.Semantic "expected function
> > pointer") in
> > +          Ast0.wrap
> > +            (Ast0.ParenType
> > +               (P.clt2mcode "(" o,
> > +                ty,
> > +                P.clt2mcode ")" c))
> > +      }
> > +  | a=array_dec
> > +      { function t -> P.arrayify t [a] }
> > +  | d=direct_abstract_d a=array_dec
> > +      { function t -> let r = P.arrayify t [a] in d r }
> > +  | o=TOPar arglist=decl_list(name_opt_decl) c=TCPar
> > +      { function t ->
> > +               Ast0.wrap
> > +                (Ast0.FunctionType
> > +                  (t,P.clt2mcode "(" o,arglist,P.clt2mcode ")" c))
> > }
> > +  | d=direct_abstract_d o=TOPar arglist=decl_list(name_opt_decl)
> > c=TCPar
> > +      { function t ->
> > +              let r =
> > +               Ast0.wrap
> > +                (Ast0.FunctionType
> > +                  (t,P.clt2mcode "(" o,arglist,P.clt2mcode ")" c))
> > in d r }
> > +
> > +
> > +direct_decl_option(ident_type):
> > +      { (None, function x -> x) }
> > +  | d=direct_declarator(ident_type)
> > +      { let (id,fn) = d in
> > +        (Some id, fn) }
> > +
> >  d_ident:
> >      disj_ident list(array_dec)
> >        { ($1, function t -> P.arrayify t $2) }
> > @@ -2151,16 +2150,10 @@ cast_expr(r,pe):
> >      unary_expr(r,pe)                      { $1 }
> >    | lp=TOPar t=ctype rp=TCPar e=cast_expr(r,pe)
> >        { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, t,
> > +                             P.clt2mcode ")" rp, e)) }
> > +  | lp=TOPar t=ctype d=direct_abstract_d rp=TCPar
> > e=cast_expr(r,pe)
> > +      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, d t,
> >  			     P.clt2mcode ")" rp, e)) }
> > -  | lp=TOPar t=ctype lp1=TOPar s=TMul rp1=TCPar
> > -      lp2=TOPar d=decl_list(name_opt_decl) rp2=TCPar rp=TCPar
> > -      e=cast_expr(r,pe)
> > -      { let fnptr =
> > -	  Ast0.wrap
> > -	    (Ast0.FunctionPointer
> > -	       (t,P.clt2mcode "(" lp1,P.clt2mcode "*" s,P.clt2mcode ")"
> > rp1,
> > -		P.clt2mcode "(" lp2,d,P.clt2mcode ")" rp2)) in
> > -      Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, fnptr, P.clt2mcode
> > ")" rp, e)) }
> > 
> >  unary_expr(r,pe):
> >      postfix_expr(r,pe)                   { $1 }
> > --
> > 2.21.1
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
