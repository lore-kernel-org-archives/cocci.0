Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BE6C00140
	for <cocci@archiver.kernel.org>; Mon,  8 Aug 2022 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=jXDlESmfL8fwPrScPmCibVJE2Ixpw6GUMtjVUheb2RU=;
  b=mlggJbMUkSmMjb06QvIWQ7W6X5qICo5z1FIrtcGNG2/uejk7bmn2+U01
   nX8wiENi7+OOuko0I/ZqR2Vsf2r8hjOjGKlyLlXdIyLiG25Ju3cJvYUZG
   d9tIrPwNIDyN9IqiQMmbIS/jglkmETRrn8PZ+q/+iJ+eLBWBLa+XZd6qc
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
X-IronPort-AV: E=Sophos;i="5.93,222,1654552800"; 
   d="scan'208";a="48253591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Aug 2022 13:56:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC5D8E0B51; Mon,  8 Aug 2022 13:56:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4472CE0235
	for <cocci@sympa.inria.fr>; Mon,  8 Aug 2022 13:56:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jXDlESmfL8fwPrScPmCibVJE2Ixpw6GUMtjVUheb2RU=;
  b=A1yZwt7E6XzLxqc+sjY/eezy0hkSuFR+7GDXetOMbDQqRVwujcJz2Iyr
   Pn4YivIvJvKLa3XtW+UJgf/YwKrWE3f4EsAnc8+KN3yEHvnIb/+8NbADP
   BkT+0itw64hQ+lsfiX+z3d17m1I5MsMq30PlZL3r9HOF6nK4njA0ShYaQ
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,222,1654552800"; 
   d="scan'208";a="48253581"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:56:23 +0200
Date: Mon, 8 Aug 2022 13:56:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Palani kodeswaran <palani.k@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAASoEDTjytDuj6quFJpmhcppBZxEUXpTOSk5eZDhS8gUm6hAzA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208081353080.2707@hadrien>
References: <CAASoEDTjytDuj6quFJpmhcppBZxEUXpTOSk5eZDhS8gUm6hAzA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-920061024-1659959783=:2707"
Subject: Re: [cocci] Replacing struct field references with field references
 from a different struct
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 504
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208081353080.2707%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-920061024-1659959783=:2707
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 8 Aug 2022, Palani kodeswaran wrote:

> Hello,
> I am trying to replace field references inside a struct of given type with
> references from a different struct (that is passed as an input parameter for
> a function).  I have the following coccinelle rule that is not working
>
> @vlan@    
> identifier p,c,fn;
> type t;          
> struct vlan_hdr *v;
> @@                
> t fn(struct xdp_md *ctx){
> ...                      
> - v->h_vlan_encapsulated_proto
> + ctx->vlan_proto            
> }

I thik that you want to do the replacement everywhere that it is relevant
in the function body.  The above rule (sort of) says that it should only
be done at the end of the function.  So:

@vlan@    
identifier p,c,fn;
type t;          
struct vlan_hdr *v;
@@                
t fn(struct xdp_md *ctx){
<...                      
- v->h_vlan_encapsulated_proto
+ ctx->vlan_proto            
...>
}

I would suggest doing the same for your other rule.  The other rule your
wrote only works when there is exactly one occurrence of the changed thing
on every execution path.  This is because ... implicitly checks that there
is no occurrence of the thing before or after the ... in the matched
region.  <... ...> says do the change whereever the matched thing occurs.
Including nowhere.

julia


>
> However, I have a similar rule that works for another struct type.  I am not
> sure what I am missing in the above rule compared to the one below. The only
> difference I can see in the source code is that the above rule needs to
> transform a piece of code inside an if block. I believe the three ellipsis
> (...) would handle that anyways?
>
> @rule3@
> identifier p,c,fn;                                                         
>                                                     type t;
> struct ethhdr *e;
> @@              
> t fn(struct xdp_md *ctx){
> ...                      
> - e->h_proto            
> + ctx->protocol
> ...
> }
>
> Appreciate your help.
>
> Regards,
> Palani.
>
>

--8323329-920061024-1659959783=:2707--
