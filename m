Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66464C636D3
	for <cocci@archiver.kernel.org>; Tue, 31 Jan 2023 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=04kbWGX2AlyQHn4zSHv7qVv+63GpUVIfEvVAziCrKFs=;
  b=mRO0eC+7oofCETA7fFzEblHJd7YOP1J/Ro5/TRvN3ExSS1agmNGXWFA4
   +bjW18ya+uWNFAwJwVObD7WRQ1lqF1+bMxmjpUD8LRjzk8WclIJvFkUuK
   dGFMGrRe2JPLo0r2ABxhlOrOpHBzhPTegAmhdpdYWCu9RoDzxmJBpWGqg
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="90352740"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Jan 2023 17:08:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85139E7441; Tue, 31 Jan 2023 17:08:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CF2F9E743E
	for <cocci@sympa.inria.fr>; Tue, 31 Jan 2023 17:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=04kbWGX2AlyQHn4zSHv7qVv+63GpUVIfEvVAziCrKFs=;
  b=Jr/C3iOlXZz9VM3PuehnCWdZ4k44MJ1G0ONXwnkUmqiKOq8v2SIkJO1C
   15XggQqdn7gbXlfMF5LkrMFhliwlzI7RO3cWo8YM6OPZK/xhZ/U/Cfiep
   kHAog8h3wxt3qE7AP55wdMpIn+zU3VI2UmMoaWKVVa0cMq/zH7hv+RGA9
   0=;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="46495030"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 17:08:03 +0100
Date: Tue, 31 Jan 2023 17:08:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Luca Coelho <luca@coelho.fi>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <48a02a321c06093966bc9999f9e8333f391475d7.camel@coelho.fi>
Message-ID: <df5d799a-941c-1afa-fee2-db2ec89abb19@inria.fr>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>  <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>  <808cd549-f96d-872d-a4db-30ea33095207@web.de>  <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
  <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>  <alpine.DEB.2.22.394.2301281432120.2822@hadrien>  <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>  <alpine.DEB.2.22.394.2301291826510.2852@hadrien>  <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
  <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>  <alpine.DEB.2.22.394.2301292109320.2852@hadrien>  <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>  <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>  <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
  <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>  <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>  <079efecb-91da-e111-1a28-2c883b69af7b@web.de>  <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>  <4ce77f5f-2433-bb99-9270-f66267a84432@inria.fr>
  <9f4c958a4bf370f7eb5fe49ac2be380ada6d9ac5.camel@coelho.fi> <48a02a321c06093966bc9999f9e8333f391475d7.camel@coelho.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 858
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/df5d799a-941c-1afa-fee2-db2ec89abb19%40inria.fr>



On Tue, 31 Jan 2023, Luca Coelho wrote:

> On Mon, 2023-01-30 at 12:59 +0200, Luca Coelho wrote:
> > On Mon, 2023-01-30 at 11:47 +0100, Julia Lawall wrote:
> > > It doesn't find the file with the definition.  You may need to give more
> > > paths.
> > >
> > > I have the impression that the result is improved with
> > >
> > > -I drivers/gpu/drm/i915
> > >
> > > Maybe -I drivers/gpu/drm/i915/display is necessary also.  If you add the
> > > argument --relax-include-path then just -I drivers/gpu/drm/i915 may be
> > > sufficient.  With that option, it will just hunt around in and under the
> > > various include paths for a unique file that has the required name.
> >
> > Alright! That _does_ improve things! Now I can see lots of DPLL matches
> > in that file!
>
> These files I'm trying to parse are so complex that I keep bumping into
> other parsing errors.  Here's one of them:
>
> parse error
>  = File "./drivers/gpu/drm/i915/i915_drv.h", line 385, column 1, charpos = 9644
>   around = 'for',
>   whole content =       for ((id__) = 0; \
> badcount: 7
> bad: }
> bad:
> bad: /* Simple iterator over all initialised engines */
> bad: #define for_each_engine(engine__, dev_priv__, id__) \
> BAD:!!!!!       for ((id__) = 0; \
> bad:         (id__) < I915_NUM_ENGINES; \
> bad:         (id__)++) \
> bad:            for_each_if ((engine__) = (dev_priv__)->engine[(id__)])
> ERROR-RECOV: found sync end of #define, line 395
>
>
> I believe the parser is getting confused by an iterator inside an
> iterator's definition... I already tried to add them both with the
> "iterator name" directive, but it didn't help...
>
> Any idea what I can do about this?

If you don't care about finding things in this code, you can just ignore
it.

julia
