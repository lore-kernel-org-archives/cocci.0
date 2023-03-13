Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D97C6FD19
	for <cocci@archiver.kernel.org>; Mon, 13 Mar 2023 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OREHc2uwknBKNj+LTn2ny50Ms9Ew5LAAj4Ig8FDTgRo=;
  b=CD1QdNGKexw//hd6FN8TniB3Wjc+Jhw1xXcIvV8/Q+1VTR2lYssmQylG
   DN27gnooNGhXWtU6sngm1HB2zpDEIXJJMb53zVPwJTBjTa/UAUB28ID6v
   4t5FmEoj7eV3ff/qXuox+kUQNIZRd96zoHJ+CSztkUb5IX7FjTHKZJQ1l
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.98,257,1673910000"; 
   d="scan'208";a="96961406"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2023 21:29:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CAA8BE02A3; Mon, 13 Mar 2023 21:29:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A5338E0010
	for <cocci@sympa.inria.fr>; Mon, 13 Mar 2023 20:38:52 +0100 (CET)
IronPort-SDR: 640f7bcb_JL+QI7WhqHvYslJz7lae2TFMvNpfm71KEPnISX7+DpdBpp3
 vjWQrVYs7I7cg8Itj69UXNDwXANf0wIwi50yK6g==
X-IPAS-Result: =?us-ascii?q?A0HSAQBfeg9kfzPQVdFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4IugUsvBFGNUYY9gXIDi1iCE4QpjHo+DwEDAQsBAUICBAEBAwQ4h?=
 =?us-ascii?q?EYChTMCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQA?=
 =?us-ascii?q?QEZCRkHDg4FJIVoDYI3KQF1TQM4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQQCfjkBAR0BAQEBAgESKAYBGx0BAwELBgUYLiMRAQUBH?=
 =?us-ascii?q?AYTIoUEAQMOIwMEomuBBEKKOHiBFwUCFoEBggkGnAsKGSgNa4FbAgcJAQgVg?=
 =?us-ascii?q?RmEOCOCaYh1eieBAxWBEIEVgyo+iwMEgieHaY1TAQMCAgMCAgMGBAICAgUEA?=
 =?us-ascii?q?gEDBAIOBA4DAQECAgEBAgQIAgIDAwIIDxMDBwIBBgUBAwECBgQCBAELAgUCC?=
 =?us-ascii?q?gECBAECAgIBBQkBAwEDAQsCAgcCAwUGBAIDDQIBAQMCAgINAwIDAgQBBQUBA?=
 =?us-ascii?q?RACBgQHAQYDCwIEAQQDAQIFBwMGAwICAgIIBBICAwICBAUCAgIBAgQFAgcGA?=
 =?us-ascii?q?gECAgIEAgEDAgQCAgQCAgQDGwIDBQMOAgICAgEJCwIDBwQCAwMBBwICDAEDG?=
 =?us-ascii?q?AMCAgICAgIBAwcKBAkEAgUBAgEECwEFAQ0EAgICAgIDAgEBAwYIBgMKAgUEA?=
 =?us-ascii?q?wMGCQ8PCAUDAQQDAgMCAQgLAgMCAgQIAgMBAgIBBgIDAQICAQICAQsBAQIDB?=
 =?us-ascii?q?QICEQECAgICAgEBAgMCAwEHAQICHAYEBQMDBAICAQQBAgIEBAULAgQDAQEBA?=
 =?us-ascii?q?gICAgMCCwMFAwEGAwMKBwQBCAIGAwQCBQQDBAQGAgICAgIBBAEECwMCBAQDA?=
 =?us-ascii?q?wYDCQICDAIUAhIGAQQLCwQBAgICDgMEBgIDAwIFCQQCAgICAgMGAgcEAgIDA?=
 =?us-ascii?q?wICAwMHAwECAgIDAQQKAwIEAgEDAgQCAgYDBAEHAgICAgIDAQICAwMBAgEGA?=
 =?us-ascii?q?wICAgUCAgEIAgMCAgICAwMPAQEBAgoCAwEBAQUEAgIEBAIEBAECAgICAgwDA?=
 =?us-ascii?q?gICAwIEAwICAxQDAgUCBAwBAgIEAgINAgICAgICAgIBAgICAgMGBAIBAgMDA?=
 =?us-ascii?q?gQFAwMCAgMCAgUBAwQBBwQCAgYDAgUGAgIFARcPAwMCIANEHQIJAyMPAwsJC?=
 =?us-ascii?q?BMXKAYMBzQENAEUBwENBwcGKg4GAgYDBAEKCwUEBQgBAgEBBgIEAgcJDAIBB?=
 =?us-ascii?q?gEFAgIDAgEFAgEGAwECAgICBQYFAwQFAxMDAQEEAwIBAgECAwIDBwMCBAIDA?=
 =?us-ascii?q?QIDBAYGAQkEBgUNAwQCAgECAQEDBAQEAgIBAgIDAQQCAgEBAwMDAgICAwQCA?=
 =?us-ascii?q?wMLBAoHBAIBBQsEAgMCAQEDAQYJBAICBgECBAICAgICAgMBAQMJBAIBAwICB?=
 =?us-ascii?q?AMGAgECAQkFAgEJAwECAQIBBAEDCQECAgQJAgMHBQoCAgICCAICDgMDAgEBB?=
 =?us-ascii?q?AICBAUJAQIHAgUBAQMFBwICAQICAQQDAQkEAQIDAgEBAxIDAwEEAgUDAw0JB?=
 =?us-ascii?q?gICAQMCAQ0DAQIBAgMBBQUXAwgHFAMFAgIEBAEHAgIDAwMCAQIJBgEDAQUCD?=
 =?us-ascii?q?gMCAgQGAQIBAQIDDwUBAQEBFwEDBAIDAQQDAQECAQIDDwQBBAULAxwCBAEIC?=
 =?us-ascii?q?AICAwMBAgMFAQIDBAIBCAoCAgICCQIKAwIDAQMFAQMCCQMBBQECBwIGAQEBA?=
 =?us-ascii?q?gICBgIIAgMLAQMFBgIBAgIBBQIBAgIFAwUCAgICBA0CBQICAgUBAgcEAgICA?=
 =?us-ascii?q?wECAgYFAQIHBwIFAgICAwMKBAQMBAEBAQIBAQUBAgEDAwECBAECAQIFAwYCA?=
 =?us-ascii?q?gICAQICAQEBCAICAgICAgMDAgibbSYZe2ZbSlpYkitBgmKNBIIWnjwHg32EC?=
 =?us-ascii?q?JxiTBOWdZI3l2aiaYUFAgoHBhAjEoFEI4FcMxojgzdPAxkPjiAMFoNQj3pAN?=
 =?us-ascii?q?DsCBwsBAQMJhUMmEwsBhTsBAQ?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:p1wdrqxCKFROTtrLEtViKrPwAb1zdoMgy1knxilNoNJuA6ilfq
 eV7YkmPH7P+UwssRQb8+xoV5PwIk80maQFg7X5eI3SJTUO21HYV72Kj7GSpQEIcheWnoU86U
 4jSdkHNDSZNzlHZK3BkW6F+rgbsby6GWOT6ds2DU0BceinUc5dBs5CZDqmLg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,257,1673910000"; 
   d="scan'208";a="96958618"
X-MGA-submission: =?us-ascii?q?MDGCYFXp9LUP1FwjUqIu2JcNnH9bMD6vFRK3b4?=
 =?us-ascii?q?M0bFweBSNPalQWKRpUzwaL1fB/Nc0ygLxYjlo3SwYC8HoOwlGIXHVf1L?=
 =?us-ascii?q?l82rf7QxkqJOu4YCc9kQf+v1pd7vA2CnDtpIvxvREEg/H9gW1OmORFcy?=
 =?us-ascii?q?BLKrGOMne6XaiLPnBdSFnPCg=3D=3D?=
Received: from mail-ed1-f51.google.com ([209.85.208.51])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 20:38:52 +0100
Received: by mail-ed1-f51.google.com with SMTP id r15so25994305edq.11;
        Mon, 13 Mar 2023 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678736331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OREHc2uwknBKNj+LTn2ny50Ms9Ew5LAAj4Ig8FDTgRo=;
        b=I/80EOKeyu0ls6wKJjyy85CBKFCNOgch9NQumaYvTbYRNPdsZWlULgys7q3aAKguXA
         7bvKEqV5vaSFhb+WsrCMVufEL/1UlP/6aNpoARDlq/oOUIrtiiB1Ihys9u+w9IrTGSV0
         +FpD3l4wm1I+rR1RDVr40z8IF40LdzsPUy0RoXyEX6jePit3F+ueCkyqwM6CLbIO8PRL
         iVXU5j/PDKx0QbdN5NNb/q+h/t2NFltCifn20kQ5aEpkzRXHm8hDYGb+3IonsBjXL9sM
         XyFvXHOiLH3wbi8LRxtOKcm1YZotfEYTj55WRMDyV67JFe+DU531mbGJdoZbwNepTEVO
         ACZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678736331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OREHc2uwknBKNj+LTn2ny50Ms9Ew5LAAj4Ig8FDTgRo=;
        b=PAHWJCaOlIQwtaqxdmIqyI1K6UpOC5rn7SXVs6NACPG4ZY96a7SM4TppgOIcm4ozgX
         yQa0gtnMV6MHBsNLYT8z1iEjDTwVsbGmlzRhXNGNISSrDGMWvkfL1jO624xQnnAgeDOJ
         c/U3ki27qJ9Moz0bEUr4x+0bSdXwrCkHBxdXJkLQPXKwp6ftkNkD9HCB0fmte6IH0MhI
         FMsDstv3hpgQBQz+NFrZEjEwFchWF3kNRE56RcyX6EwdHhllaapjAyqFkawVgqmwTOKP
         iWG455qJuQYk8I/yS/Zv0PH4zPIa3Htu9+vuQ6JDFqIIPh5ahPZ3ptZOy2SIocF3zO4s
         HmFA==
X-Gm-Message-State: AO0yUKX3P6EOTuXGDcEGhsfK58M8fu2nFGW0I3UVLBSzb8hvSsJsK74F
	091lQ+ulYNgwreFomLJ45RVwK+qLZIQ=
X-Google-Smtp-Source: AK7set8Nr/0FEsXjwlb0QjiPKL3eSkuu0VpcxKRyqHEf7yRp9PYd2TLa1qGRZhnb77FNPZdP5HFtIg==
X-Received: by 2002:a50:ff19:0:b0:4ab:497a:2e84 with SMTP id a25-20020a50ff19000000b004ab497a2e84mr11760587edu.12.1678736331412;
        Mon, 13 Mar 2023 12:38:51 -0700 (PDT)
Received: from nbbrfq (80-110-214-113.static.upcbusiness.at. [80.110.214.113])
        by smtp.gmail.com with ESMTPSA id z101-20020a509e6e000000b004c44d00a3b5sm184549ede.20.2023.03.13.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:38:51 -0700 (PDT)
Date: Mon, 13 Mar 2023 20:38:47 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: rep.dot.nop@gmail.com, cocci@inria.fr
Message-ID: <20230313203847.33c9ff24@nbbrfq>
In-Reply-To: <145e5e3e-1ce3-819f-a271-5c8b8a273a53@inria.fr>
References: <20230309092812.71b25d5c@nbbrfq>
	<89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr>
	<ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr>
	<20230310110135.66cbd31b@nbbrfq>
	<145e5e3e-1ce3-819f-a271-5c8b8a273a53@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 888
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230313203847.33c9ff24%40nbbrfq>

On Fri, 10 Mar 2023 11:12:27 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Fri, 10 Mar 2023, Bernhard Reutner-Fischer wrote:
> 
> > On Thu, 9 Mar 2023 09:47:17 +0100 (CET)
> > Julia Lawall <julia.lawall@inria.fr> wrote:
> >  
> > > On Thu, 9 Mar 2023, Julia Lawall wrote:  
> > > > On Thu, 9 Mar 2023, Bernhard Reutner-Fischer wrote:  
> > []  
> > > Another issue is that your semantic patch could be more efficient.  You
> > > have the declaration
> > >
> > > type mpz_t;
> > >
> > > I think you meant:
> > >
> > > typedef mpz_t;
> > >
> > > Then the only goal of the pattern
> > >
> > > mpz_t i;
> > > ...
> > >
> > > seems to be to ensure the type of i.  This can be done in the metavariable
> > > declaration:
> > >
> > > local idexpression mpz_t i
> > >
> > > and then in the second rule, it would be:
> > >
> > > local idexpression mpz_t mpz_0_find.i;
> > >
> > > In this way, you will not be matching from the top of the function, but
> > > rather only from the relevant call to the return.  
> >
> > mhm. But if there is no return statement whatsoever in that scope?
> >
> > Consider:
> > int myround (double dbl)
> > {
> >   int ret = 0;
> >   // mpfr_t outer; mpfr_init (outer);
> >   if (global_var)
> >     {
> >       unsigned long ul;
> >       mpfr_t i;
> >       mpfr_init (i);
> >       mpfr_frac (i, dbl, MPFR_RNDZ);
> >       if (mpfr_cmp_si (i, 0) != 0)
> >         {
> > 	  ret = 42;
> > 	  moan ("round");
> > 	}
> >       /* mpfr_clear (i); missing here */
> >     }
> >   // mpfr_clear (outer) insertion works, there is a return stmt.
> >   // probably breaks in a void function like in the scope above..
> >   // There is no 'i' to clear _here_, of course!
> >   return ret;
> > }
> > EOF
> >
> > If i'd understand a local idexpression 'i' to have a scope, i would have
> > hoped to somehow get at the position of i at end of scope?
> > But i think i need to match either a return or end-of-block, so i can
> > insert the mpfr_clear properly in either case. Somehow.  
> 
> OK, there are some hacks to deal with the issue at the end of the
> function, but not in the case of an arbitrary scope.
> 
> Typically missing frees affect if branches, so the problem doesn't arise,
> but if you want the whole scope, it seems that you would need the {}.

So IIUC i would need to attach a position to the closing curly brace
'}'.
But how would i do that? I tried:

/// mpfr ///////////////////////////////////////////////////////////////

@ mpfr_0_find exists @
type mpfr_t;
identifier i;
position ret_pos, e_pos, s_pos;
expression E0, E1;
statement s0;
@@
{...
mpfr_t i;...
// rejected: <...{...>
( mpfr_init_set_str (i, ...)
| mpfr_init (i)
| mpfr_init2 (i, ...)
| mpfr_init3 (i, ...)
)
<+... when != mpfr_clear (i)
    when != mpfr_clears (...,i,...)
( return \(<+...i...+>\);
| return@ret_pos ...;
//rejected: | }@e_pos
)
...+>
//rejected: <...}...>
// the below does not seem to work for me (2)
}@e_pos

@ mpfr_0_replace @
identifier mpfr_0_find.i;
expression mpfr_0_find.E0;
statement mpfr_0_find.s0;
position mpfr_0_find.ret_pos;
position mpfr_0_find.e_pos;
position mpfr_0_find.s_pos;
@@
(
++ mpfr_clear (i) /* ret */;
? return@ret_pos ...;
|
++ mpfr_clear (i) /* E0 */;
// below an attempt to reference e_pos as per (2) above:
//assertion failed:  e_pos;
//rejected:  @e_pos
//rejected, no semicolon?:  E0@e_pos
//rejected: no semicolon?:? E0@e_pos
//the below does not work, E0 was not set
 E0@e_pos;
|
++ mpfr_clear (i) /* s0 */;
  s0@s_pos;
)
