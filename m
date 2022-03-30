Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3CBC433EF
	for <cocci@archiver.kernel.org>; Thu, 31 Mar 2022 05:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=veUBsLDA8z1kapNgGskRdZV5ZEcmkX6JnZsbhXJYMpc=;
  b=WbUpcwcADCZDT9R65P1IoqiWDaDz80MKuMhOLj1whueSeA708TGhn2Ru
   yfRHaiVQYVRLO53NitM//JGqeTi8PF9XLiuwn2O6BdjdWV1YPqonoRG+L
   tmQCmfAlTRJpfprdzkxdap9s5/q0vPWy4JQCtIYBJ/3y278tHNtpYMOwm
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29209589"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Mar 2022 07:35:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF409E033C; Thu, 31 Mar 2022 07:35:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BDC8EE7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 21:30:36 +0200 (CEST)
IronPort-SDR: Hx1KTBG/tTpOAkc7sCMJyoOnivH3g0LJwU4f9Ux2SpwDmdefmmrTncDmccwO6H04+phpUf4R7j
 EStYY/kefdHcL0vezH+S4ZoLEJO/EMCJwAXh4FpODa4u8k585rBwsn6ZAObgprLgzpZO1Pbwvb
 BGzr1tt4ONuSsrFYg+aCEbfVqqZpuhIvkiPHUIf3+10jCtpjJyXn9zmy417zoF2LCWfgIEB4eF
 0V/NV/qkdGWbZ3Eefw0uhfzMykA8U8ScuaJUZeRB/9yWxz0xw8HH/rCPpYiZdpY4TW8y/Lc+XO
 xvzH1/1CwKPVX8CjcbQMQfvX
X-IPAS-Result: =?us-ascii?q?A0AhAADjrkRify/SVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UcGAQELAYFRKC5+VysET5NHggceA4snhjSLCoElA1QLAQMBCwEBOwgEAQE9h?=
 =?us-ascii?q?EoChFYCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBA?=
 =?us-ascii?q?Q0LCQcICgEGDg4FYAFhAwFEgU+BdAsDMQ2CNSkBg2QBAQEDEigGARsdAQMMB?=
 =?us-ascii?q?gUYLhARAhEBBQEcBgwHIoJjgmQBAy4BDqIagQQ9izCBFwUXgQGCCQaBQAELA?=
 =?us-ascii?q?YJ8ChkoDWcDgVkCAQYJAQiBKgGGEAGHPnongimCUYE3Nz6CIUIBA4c7IgSZB?=
 =?us-ascii?q?gGBCAUUGASBPxw0KgsvA1MBkSIWrHZDMDEKBgGCIXM4gUGJT45rhXszlkSSC?=
 =?us-ascii?q?IR0kWmNGINUkRYGhFcCCgcGECMSgS0Bcw2BEzMaI4FugUsTDC8BAgEBAQ0BA?=
 =?us-ascii?q?gEBAwECAQIJAQECjh03gzuEWTuFZCc0AjYCBgsBAQMJkWABAQ?=
IronPort-PHdr: A9a23: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
 JrqpHVFiVoLhDEdKqnZJa4PxV9V1Pvmgw==
IronPort-Data: A9a23:bZf7raAqUQMEfBVW///lw5YqxClBgxIJ4kV8jS/XYbTApG8i1jNVm
 mMWUTrSaP3eMDD0Kd50b9/gpk1S65CDz4RmOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPiW1vR0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYozOXjelex
 d9VjsOPGVYMbojWltY6WhYNRkmSPYUekFPGCX22sMjWyFGfNnWwnLNhC0Y5OYBe8eFyaY1M3
 aZAeXZdM1bZ3rrwnO3TpupE3qzPKOHuNZkUt3VniyrSDfMnXYyaa6rP7N5cmjw3g6iiGN6EN
 pNGM2QxPHwsZTVCPloYBrIRgd2CoSDNKyZS80ikv5YOtj27IAtZieCxarI5YOeiTsJelUewv
 XPD522/AxcANdXZxyDt2nalmebLmQvpWYcYDrT+9/hwgVTVyHZ7NfENfV6yoP38jVLnHtwDd
 Aob/S0hqaV0/0uuJjXgY/GmiHiarCczVtBIKLIFuFComo/O7TS+D2dRG1atd+canMMxQDUr0
 HqAkNXoGSFjvdWppZS1puf8QdSaaXh9EIMSWcMXZVBavIS78enfmjqKH4kzSvfk5jHgMWiom
 2jikcQou1kEYSc2O0iT+FnGh3erusGMQFJqoArQWW2h40VyY4vNi22UBbrzvaoowGWxFAHpU
 J04dy62sbBm4XalyXzlfQn1NOv1j8tpyRWF6bKVI7Ev9i6251modp1K7Td1KS9Ba5hYKWK5O
 RKP5FMPvve/2UdGi4cnM+pd7Ox6ncDd+SjNC5g4k/ISOsggLVfZlM2QTRfIgj21+KTTrU3PE
 c7DLZzE4YcyBqNgwz67L9rxIpd6rh3SMVj7HMihpzz+ieT2TCfNGd8taQLSBshksv7siFiKq
 753aprSoz0CAbaWSnSGoeY7cwpWRVBlXsueg5IMJoa+zv9OQj5J5wn5muN/JeSIXs19yo/1w
 51KchQGkACm3y2WdF3ih7IKQOqHYKuTZEkTZUQEVWtEEVB6CWp2xKtAJZYxY5c98+lvkax9Q
 /UfKpePB/1OTnLM/DFENcvxq4lrdRKKgwOSPnr9MGJvIcI4HwGZqMX5egbP9TUVCnXluMY7p
 Yqm3FyJTJcGQTNkE8uLOumkyEm8vCRGle8rBxnIL9BfdV/C6o9vLyCt3PY7L9tdexrGzzqek
 Q2RBE5A9+XKpoY09vjPhLyF/9/5SbsgQhICEjCCv7isNCTc8m6y+qN6Ub6FLWLHSWf52KS+f
 uEKnfzxNfswmlwV4YdxFrBcy71nu4niqrpc+QRTHHvRamOtBL49cGKN2tNCt/EUy7JU5Vm2V
 0aI9oUIMLmFIpm+QlsYJQ5gafjakP9IxX/d6vM6JEi87yhypeLVXUJXNhiKqSpcMLolb99/k
 Ll54JYbu16llx4nEtealSQIpW6CGXoNDvc8vZYADY631wcmlgNYbZrHBnOk6Z2DcY8XYEwjI
 zvRg7abwroAmQzNdH08EXWL1u1Y3MxctBdPxV4EBlKIhtuV2aNtjUMJqWw6HlZP0xFK8+NvI
 Ww3ZUd7EqODomVzj89ZUmHwRgxMCXV1IKAqJ4flSYEYc6WpaoAJBGg0OOLI+1xAtmwAIX5U+
 7aXzGujWjHvFC00Mu3eRmY9w8EPj/QonuEBpCxjN8uAFpg+JzHih8dCoEIW/gD/D5pZaFLv/
 IFXESUZVUE/HSEVqqw/TYKd0Nz8jfxCyHNqGZlcwU/CIY0QlPxeF9RDx4Bdt/6h/8D3zHI=
IronPort-HdrOrdr: A9a23:YeBWZqN1NwaLtsBcTuejsMiBIKoaSvp037By7TEWdfRUGvb3qy
 ncpoVj6faUskdtZJhOo6HjBEDtex/hHNtOkO4s1NSZLXXbUQmTXeRfBOLZqlWKcUDDH6xmpM
 NdmsBFeaLN5DNB7PoSlTPIcOrIt+PmzEnHv4jjJjxWPHlXgulbnnxE4yigYzdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,223,1643670000"; 
   d="scan'208";a="29172668"
X-MGA-submission: =?us-ascii?q?MDGUOTBcAtbLM/+SSLCg9IWQWESOm7A6xmsgXY?=
 =?us-ascii?q?l3KrUL1IBqGxXRbi3OGF3ft9tLN0JTaD81enkjX+MCrpDRd2vOlVrwLh?=
 =?us-ascii?q?/2Hd1ARV/T0hNk7ue4Mo5Xrh4FgTPD1Y5QHTO9fM8jKaj7p7pVqahSHj?=
 =?us-ascii?q?sXe0PS35DZuxCRJyXFVsK+vg=3D=3D?=
Received: from mail-ot1-f47.google.com ([209.85.210.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 21:30:35 +0200
Received: by mail-ot1-f47.google.com with SMTP id b17-20020a0568301df100b005ce0456a9efso2153470otj.9;
        Wed, 30 Mar 2022 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=veUBsLDA8z1kapNgGskRdZV5ZEcmkX6JnZsbhXJYMpc=;
        b=adILIVBCDTIzWnSlVEVuzyyQeLmZJmMOFHyUGAJczwNVMWoAFV4NAzstETyw1aDTXU
         PeEQLPvBoGZwnev7kqXDVH894+ZJpStidUvOyd4/1a6OmOqL4s2xBS6X9x8cJk7Oihqe
         +0/HdD5+tmox7CuSPAksHZtqs2sUxMsx4ttZZY2Z+MG9vnVpDEQzjL4iWBd9R0AMRjb5
         hTGvCbUVUHgokVFAeJzbaRIPyaomR1Qfb+x/h6uFUfBCu2hUOp9EdtCusdpiPwU+kcPm
         wtQaZsJmez5fjcTI5em0IZ63LFU6tv0+hT7r7qlJyGmpPbqsVIKRICrNzYwhE75XWGOg
         r2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=veUBsLDA8z1kapNgGskRdZV5ZEcmkX6JnZsbhXJYMpc=;
        b=FOS0SuRRVV8jrEThCbKF8Pp0cyYKIHUjSXsOvVF8ko+NJZeMVmjn7cR3foCJ4kU72O
         WaUjqmy30IDUAJE/hECY2PrCdPux1XfnATunO6qsLxcCSpL/reLZ82NCgpB+PIR/XAyo
         6bqD5+BHLods67KIT17tyzrwOzii0D8LBuuPDE9Qdorg4DsP0WQMAvVUldrVE6dhg7SJ
         bVJYd5OsazJp4ZIgOO6ZD4JVe8pj/IhJ5W5DyntggcTAS49MJOYs8t+qRMY+6NfcRh1J
         Q9eJCJF6j7fjOANk9TBUxXF86lkFVw1+ck/xlqagbwSAKRsEsHf9JYOVRHWGB9+xWiMQ
         B5gw==
X-Gm-Message-State: AOAM5307/4naOB1kA2TP7t/uAzDW22bo9MEHssp0GP6KFqzit8LKihUi
	Wbq6Fb5/mchYYsATyNEo4PM=
X-Google-Smtp-Source: ABdhPJxKo3vtGI8m11rbEZM4uy18kOD2uIYcCWzcg87bQPdqYAMGuiXvFLPRZant4BK9y506jlNudQ==
X-Received: by 2002:a05:6830:3142:b0:5cb:3e2b:e1e with SMTP id c2-20020a056830314200b005cb3e2b0e1emr4070755ots.38.1648668634039;
        Wed, 30 Mar 2022 12:30:34 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id 24-20020a056870139800b000dea48c55d1sm8503795oas.39.2022.03.30.12.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:30:33 -0700 (PDT)
Date: Wed, 30 Mar 2022 16:30:29 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Daniel Latypov <dlatypov@google.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Message-ID: <YkSv1eUfS9MxotOz@marsc.168.1.7>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
 <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
 <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 2/2] Documentation: dev-tools: Enhance static
 analysis section with discussion
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 316
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/YkSv1eUfS9MxotOz%40marsc.168.1.7>

On 03/30, David Gow wrote:
> On Wed, Mar 30, 2022 at 7:23 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Enhance the static analysis tools section with a discussion on when to
> > use each of them.
> >
> > This was mainly taken from Dan Carpenter and Julia Lawall's comments on
> > the previous documentation patch for static analysis tools.
> >
> > Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Julia Lawall <julia.lawall@inria.fr>
> > ---
> 
> Thanks: this sort of "when to use which tool" information is really
> what the testing guide page needs.
> 
> I'm not familiar enough with these tools that I can really review the
> details properly, but nothing stands out as obviously wrong to me.
> I've made a few comments below regardless, but feel free to ignore
> them if they're not quite right.
> 
> Acked-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> >  Documentation/dev-tools/testing-overview.rst | 33 ++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > index b5e02dd3fd94..91e479045d3a 100644
> > --- a/Documentation/dev-tools/testing-overview.rst
> > +++ b/Documentation/dev-tools/testing-overview.rst
> > @@ -146,3 +146,36 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
> >
> >  Beware, though, that static analysis tools suffer from **false positives**.
> >  Errors and warns need to be evaluated carefully before attempting to fix them.
> > +
> > +When to use Sparse and Smatch
> > +-----------------------------
> > +
> > +Sparse is useful for type checking, detecting places that use ``__user``
> > +pointers improperly, or finding endianness bugs. Sparse runs much faster than
> > +Smatch.
> 
> Given that the __user pointer and endianness stuff is found as a
> result of Sparse's type checking support, would rewording this as
> "Sparse does type checking, such as [detecting places...]" or similar
> be more clear?

Myabe. I tried changing it a little while adding a bit of information from
https://lwn.net/Articles/689907/

"Sparse does type checking, such as verifying that annotated variables do not
cause endianness bugs, detecting places that use ``__user`` pointers improperly,
and analyzing the compatibility of symbol initializers."

Does it sound better?

> 
> > +
> > +Smatch does flow analysis and, if allowed to build the function database, it
> > +also does cross function analysis. Smatch tries to answer questions like where
> > +is this buffer allocated? How big is it? Can this index be controlled by the
> > +user? Is this variable larger than that variable?
> > +
> > +It's generally easier to write checks in Smatch than it is to write checks in
> > +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> > +because there is no reason for re-implementing Sparse's check in Smatch.
> 
> This last sentence isn't totally clear to me. Should this "because" be "so"?

Smatch uses (is shipped with) a modified Sparse implementation which it uses as
a C parser. Apparently, Sparse does some checkings while parsing the code for
Smatch so that's why we have some overlapping between the checks made when we
run Smatch and the ones made when we run Sparse alone.

I didn't dig into the code, but I guess further modifying Sparse to prevent it
from doing some types of cheks wouldn't add much to Smatch. That last saying
should've reflected this fact, but it seems to cause confusion without a proper
context. Reading the sentence back again, I think we could just drop the last
part:

"Nevertheless, there are some overlaps between Sparse and Smatch checks."

> 
> > +
> > +Strong points of Smatch and Coccinelle
> > +--------------------------------------
> > +
> > +Coccinelle is probably the easiest for writing checks. It works before the
> > +pre-compiler so it's easier to check for bugs in macros using Coccinelle.
> > +Coccinelle also writes patches fixes for you which no other tool does.
> > +
> > +With Coccinelle you can do a mass conversion from
> 
> (Maybe start this with "For example," just to make it clear that this
> paragraph is mostly following on from how useful it is that Coccinelle
> produces fixes, not just warnings.)

Will do

> 
> > +``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
> > +that's really useful. If you just created a Smatch warning and try to push the
> > +work of converting on to the maintainers they would be annoyed. You'd have to
> > +argue about each warning if can really overflow or not.
> > +
> > +Coccinelle does no analysis of variable values, which is the strong point of
> > +Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
> > +way.
> > --
> > 2.35.1
> >
