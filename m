Return-Path: <SRS0=f1Jb=OH=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B062FC433EF
	for <cocci@archiver.kernel.org>; Fri, 17 Sep 2021 04:35:42 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B56611C0
	for <cocci@archiver.kernel.org>; Fri, 17 Sep 2021 04:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2B56611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="528920164"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2021 06:35:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B2A67E001A; Fri, 17 Sep 2021 06:35:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 23D67E0015
	for <cocci@sympa.inria.fr>; Fri, 17 Sep 2021 06:35:37 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=mansourmoufid@gmail.com; spf=Pass smtp.mailfrom=mansourmoufid@gmail.com; spf=None smtp.helo=postmaster@mail-ed1-f42.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3Alma+3xGUCE3D5Is+PNj1jp1Gf+NMhN3EVzX9CrI?=
 =?us-ascii?q?Zgr5DOp6u447ldBSGo6k31BmYBM6GtLptsKn/i+jYQ2sO4JKM4jgpUadncFs7s?=
 =?us-ascii?q?/gQhBEqG8WfCEf2f7bAZi0+G9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQp?=
 =?us-ascii?q?yO+/5BpPeg9642uys55HfeQFFiCeybb5yLhi9sBncuNQRjYZ+MKg61wHHomFPe?=
 =?us-ascii?q?+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4TadFDDs9KGA6+NfrtRj?=
 =?us-ascii?q?YQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+886lkVgPni?=
 =?us-ascii?q?CYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4Y6jTf84VRXBZU8leWSxOAIO?=
 =?us-ascii?q?yYYUMAeQcI+hXs5Lwp0cSoRakGQWgGP/jxz1Oi3Tr3aM6yeMhEQTe0QInBd0Ot?=
 =?us-ascii?q?m/UrNLoNKcITOu7y67IzSjNb/NXxDj29Y/FchU7rvGKRrJwdtfRyVMqFwPCk1W?=
 =?us-ascii?q?Qp43lMC6O2+QCtmiU9etgVea1h2E7rAFxpyGiy8ExgYbGmowb0ErL9TllwIkrP?=
 =?us-ascii?q?924TlZ2bMOmHZZOqS2XNoR4T80+Tm10pSs31KAKtIK0cSUExpoqxBzSZvOIfYS?=
 =?us-ascii?q?U/x7uSPucLDZ6iX9hdryxhxa//VWvx+D6S8K6005KozJbntXQsn0BzR/e58idR?=
 =?us-ascii?q?vdj4kus2iyD2g/N5uxCPEs6j7DUK4Q7zb41jpcTsVrMHivxmEjuia+ZbEQk+uy?=
 =?us-ascii?q?x5+v5f7rqu4aQN4F7hw3gKKgulcu/AeM3MggKQWeX4/iz1Lrm/UHhQbVKiOM5k?=
 =?us-ascii?q?rXBvZzEOcgWorS1DgxV34o59RqzEzSr3M4XkHUZNF5FfQiIj4ntO1HAOvD4CvK?=
 =?us-ascii?q?/jkypkDhxwfDGJbrhAojXLnjGl7fhYLh9609BxwcowtBf4ohbCrAFIP7pRkDxs?=
 =?us-ascii?q?9nYAgcjMwOo2+bnFMl91oQGVG2TBa+WLL/dsV6T6+I0I+iMYZcVtyznJ/gk4f7?=
 =?us-ascii?q?ul345lkUHcamnx5tEIEy/S9drLl7RSn3rgZ9VEmoHpQE5S+/Cg12YVjtSenP0W?=
 =?us-ascii?q?LgzsGIVEoWjWKLKQJuqnabJ+SCmEJxaLjRDA1aXFmrycoKZVfYAQC2XK85l1Dc?=
 =?us-ascii?q?DUO7yGMcayRiyuVqimPJcJe3O93hd7Mq7vDCUz+jalBV3+DAtSsrBiSeCSGZ7m?=
 =?us-ascii?q?m5OTDgzjvgXSaNVxVKK0Kw+iPtdR4U7DxZhXQIzNJqaxOt/WYiaZw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AY94g1a+d7dEabGs4xOJuk+C/I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZLiY1TiX4ra6TdZsgpHzJYVoqKRMdcLO7V5VoP0m9yXcd2+B4Vt2ftWLd1F?=
 =?us-ascii?q?dAQrsO0bff?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AqAQCYahphfyrQVdFagQmBWYN4OzGER?=
 =?us-ascii?q?49JgieKboEAhXCKCoF8CwEDAQ1BBAEBhGECgmsCHQcBBDAJDgECBBUBAQUBAQE?=
 =?us-ascii?q?CAQMDBAETAQENCxAIOCaFaA2CNSkBg2QBAQEDEhEdARsdAQMMBgULDQICJgICI?=
 =?us-ascii?q?gERAQUBHAYTCBqFJAEDL5sIgQQ9izKBFQUXgQGCCAaEbAoZKA1lA4FXAgcSfiq?=
 =?us-ascii?q?EKoJjhmYnHIFJRIFLgm8+h1uCZATFd1qCWIE3C4IsmmQrg1OjIrtGECMSgSuCF?=
 =?us-ascii?q?DMaI4EBgjhQGQ6SEop6KC84AgYLAQEDCYl1AQE?=
X-IPAS-Result: =?us-ascii?q?A0AqAQCYahphfyrQVdFagQmBWYN4OzGER49JgieKboEAhXC?=
 =?us-ascii?q?KCoF8CwEDAQ1BBAEBhGECgmsCHQcBBDAJDgECBBUBAQUBAQECAQMDBAETAQENC?=
 =?us-ascii?q?xAIOCaFaA2CNSkBg2QBAQEDEhEdARsdAQMMBgULDQICJgICIgERAQUBHAYTCBq?=
 =?us-ascii?q?FJAEDL5sIgQQ9izKBFQUXgQGCCAaEbAoZKA1lA4FXAgcSfiqEKoJjhmYnHIFJR?=
 =?us-ascii?q?IFLgm8+h1uCZATFd1qCWIE3C4IsmmQrg1OjIrtGECMSgSuCFDMaI4EBgjhQGQ6?=
 =?us-ascii?q?SEop6KC84AgYLAQEDCYl1AQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="528920157"
X-MGA-submission: =?us-ascii?q?MDFpePkKu/h0q+f0rg6oII9XV91OwRtAz0u0FC?=
 =?us-ascii?q?4+ZOEC3eOVjHdhw9pZzM/R66Z2qHRBcTnS6ywC15NeG84f5o7E668Rrb?=
 =?us-ascii?q?K7923HSk2hm54T0d/6ev9z2aWopJKug6H2wqHfCIaNnjKxUkfEzTZ+Sr?=
 =?us-ascii?q?qvIzCmOVTOG8gnaQf7FQBt4Q=3D=3D?=
Received: from mail-ed1-f42.google.com ([209.85.208.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2021 06:35:35 +0200
Received: by mail-ed1-f42.google.com with SMTP id eg28so2076938edb.1
        for <cocci@inria.fr>; Thu, 16 Sep 2021 21:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2imWfk0EitM/fPAMHmgnCQesXXCPouydUGlQApaX5cg=;
        b=PdYUoNB/gxSlUJ2ihAABuF68rODisuzg4R3kaC6OnaUhGMOvPw85jw/+g7xe9uPVfI
         8Iy+0TNwmgHc3/IkSggcPNYf+JD+O8O2aAaYLWWXlVxSJM8pSy1/keJ7I+kpcieRFbI8
         y9HqoJwKQwogH7iQawZiXUPh0rJKVLjZn6xb9ABKYbBS1VE5839OW5V6GbZgSbVGiMB+
         5D3/H8YSYCMutSizfvOwgBoP24RwKlgTCvJU2oonEv5vh3gS9/e27m6e/TANRutImooT
         1NSXAZQ6mAJh9+k8ZevOKpBiqpIe1bDMjTjkz3gLl8wqMpgIZ8aEfyktlR2ig3ONl9Fz
         B6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2imWfk0EitM/fPAMHmgnCQesXXCPouydUGlQApaX5cg=;
        b=U927JNz8R8ZOZyDqq2gyqtEcwbgQYYK0MHxzmw0y3Yg5TySYNdI27UgoLCvQrYKxcD
         Saqs0d0Ane3KSQqKARB46nnYtfreQvC9eeeAn67DO/xpUfoDi7Jv4tvhhOwU4+SEagN7
         neWXj1haRi1J7rCU+ftY9ejYiI/tbPNDI36LxQfNNi4YNxdjx41W/GYPXPTa68BGqcl2
         TiOx80wB9R5iC8UlopG9vWRnrZQ5t1BP9cUJfl4H/V+u3+Dn/Ne00A/A7YRy9JKleyLZ
         OBCS0cBhWcK94nNNCbb5nqu/Fm0RqjVF6VG9x4jNTXucEg1BTjWGNdl1gMj4kWoZq+5c
         M/qA==
X-Gm-Message-State: AOAM532AvHRu2gRW905pxuaqmQR7mFrspAhbwUNnMBkKhETjz93ZRoxK
	c3Z3ZNGYgWTBLaQwzTvkteYO8J3N36Z6y85S/G0aqdzLHJRBBh5s
X-Google-Smtp-Source: ABdhPJxTk2K0VLrs8Ax8sWvZSzqzWFSm+1UAVil1ex2Vnf5HYewVBUPziI+Th/sEi6NyDOJDzwFkk0DwjGNkDYIiaf0=
X-Received: by 2002:a17:906:b59:: with SMTP id v25mr9811471ejg.547.1631853335278;
 Thu, 16 Sep 2021 21:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <202109161609.9AB60A934B@keescook>
In-Reply-To: <202109161609.9AB60A934B@keescook>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Fri, 17 Sep 2021 00:35:24 -0400
Message-ID: <CALogXGX6rB9vhK-RFbTZOGcP9yuh524BtN8EtH0AOeHyVs2Mmw@mail.gmail.com>
Subject: Re: matching an arbitrary struct or union (but not scalars)
To: Kees Cook <keescook@chromium.org>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Reply-To: Mansour Moufid <mansourmoufid@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 7
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/CALogXGX6rB9vhK-RFbTZOGcP9yuh524BtN8EtH0AOeHyVs2Mmw%40mail.gmail.com>

On Thu, Sep 16, 2021 at 7:48 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> I'd like to match any compound type containing a compound type, i.e. these:
>
> struct foo {
>         struct bar instance;
> };
>
> union bar {
>         int c;
>         struct baz d;
> };

For this first part, maybe something like:

@@
identifier s, u;
type t1 = {struct s, union u};
type t2 = {struct s, union u};
identifier x;
@@
*   t1 {
        ...
*       t2 x;
        ...
    }

I'll attempt the rest tomorrow.
