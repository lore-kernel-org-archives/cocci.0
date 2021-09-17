Return-Path: <SRS0=f1Jb=OH=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1465C433EF
	for <cocci@archiver.kernel.org>; Fri, 17 Sep 2021 19:16:39 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D94061152
	for <cocci@archiver.kernel.org>; Fri, 17 Sep 2021 19:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D94061152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529106777"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2021 21:16:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C9780E001B; Fri, 17 Sep 2021 21:16:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 818DEE0015
	for <cocci@sympa.inria.fr>; Fri, 17 Sep 2021 21:16:33 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=mansourmoufid@gmail.com; spf=Pass smtp.mailfrom=mansourmoufid@gmail.com; spf=None smtp.helo=postmaster@mail-ed1-f44.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AbMlXXRCtRkI6MhnS8SbTUyQUrUMY04WdBeb1wqQ?=
 =?us-ascii?q?uh78GSKm/5ZOqZBWZua81yg6QFtiEo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/t?=
 =?us-ascii?q?MMNggY7C9SEA0CoZNTjbig9AdgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1?=
 =?us-ascii?q?oLejpB4Lelcu62/6u95HJZwhEmTWxbLNwIR6rsQjfq84ajJd4JK0s0BXJuHxIe?=
 =?us-ascii?q?+pXxWNsO12emgv369mz8pB+7Sleouot+MFcX6r0eaQ4VqFYAy89M28p/s3rtAL?=
 =?us-ascii?q?MQhWJ63ABT2gZiBtIAwzC7BHnQpf8tzbxu+Rh1CWGO8D9UKs5Uiq+4ah1VBDoi?=
 =?us-ascii?q?T8HNz8n/2HRlsxwl79QrBa4qxBi34LYfISZOfxjda3fYNwaX3JMUclfVyNDAo2?=
 =?us-ascii?q?yYYgBAfcfM+lEtIT9u0cCoAGiCQWwGO/iyDlFjWL2060g1OQhFBnL0gs6ENIIq?=
 =?us-ascii?q?3TUq8j1NL0PWu6yy6nI0DvDb/JL1jzg74XIdwouofeXXbJ3bMrR00wvFwTYjlW?=
 =?us-ascii?q?eqIzqIiiY1usIs2eB7upgUfijhHIgqwF0uzWiwNonhYbViIwP0F/E6Tl5z5gvJ?=
 =?us-ascii?q?d2+UEN2fNypHYVOuyybOIV7TN8vT311tSsk17ELpZG2cSYExpkkxRPSZPOJf5S?=
 =?us-ascii?q?V7h//SeucIDV1iXZrdry/hxu+7Eetx+vhXce3yFZHtjRJnsXIu3wX1BHe6tKLR?=
 =?us-ascii?q?uVh8kqiwzqC2A/e5+dZKk4uj6XbMYQuwrsom5oTr0vDGij2lV3zjKCMd0Uk/vG?=
 =?us-ascii?q?k5Pr6bbn7v5OcOYB5hw7kPqQhncy/Bus4MgwQUGSB5eu807jj8VX4QLVMkPI2j?=
 =?us-ascii?q?rHUvI7GKckfvKK0AA9Y3pw95xqjDDqqytsVkHYfIFJAYh2HjozpO1/UIPD/CPe?=
 =?us-ascii?q?ym1Gsny1tx/DdOb3hH4/NLn3EkLf8c7Z96lNTxRE8zdBa/Z1UC7UBLOjvVU/2s?=
 =?us-ascii?q?dzUFgU5PBCsw+b7FNV90ZsTVn6IAqCFLKzSsESF5vkvIumJfI8aoizxK/kj5/7?=
 =?us-ascii?q?0jH82g0URfaez3chfVHftPflrOA2yZn3vyoMCHGoRtQ05T8ThiEeFVD9OYjC1R?=
 =?us-ascii?q?a1qtR8hD4fzKI7FXYewmvSk2zq1H5EeMmVPDEuLDG3tcJiKWvskZyebI8snmTs?=
 =?us-ascii?q?BA+vyA7Q93A2j4Vepg4FsKfDZr2hB7cqLPD1d6OjalBV0/jtxXZz1O46lQGR9n?=
 =?us-ascii?q?2dOTDgzjvkXSa1Vz16C1e11j6UdG4APofxOVQg+ONjXyOkoU7jP?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A48UZ2qEUScqewi3ZpLqEOseALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKKSC9HfbzqynDppsmPD7P5Ar5O0tApTnjAtjifZq0z/cc3WFKVo3IYOCMgg?=
 =?us-ascii?q?aVxfRZnO3fKkrbalTDH4Bmu5uIC5IOb+EYWmIK6frS0U2KAvIny9mD/OSDg+Pb?=
 =?us-ascii?q?x3BhJDsaCZ1I3kNLGyKcGU1ySE14CYEiFJyaj/A3wgadRQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AsAQCYahphfyzQVdFagQmBWYJXAYEgO?=
 =?us-ascii?q?zGER49JgieKboEAhXCKCoF8CwEDAQ1BBAEBhGECgmsCHQcBBDAJDgECBBUBAQU?=
 =?us-ascii?q?BAQECAQMDBAETAQENCxAIOCaFaA2CNSkBg2QBAQEDEhEdARsdAQMMBgULDQICJ?=
 =?us-ascii?q?gICIgERAQUBHAYTIoUkAQMvmwiBBD2LMoEVBReBAYIIBoRsChkoDWUDgVcCBxJ?=
 =?us-ascii?q?+KoQqgmOGZiccgUlEgUuCbz6HW4JkBKZQnydagliBNwuCLJpkK6Z1u0YQIxKBK?=
 =?us-ascii?q?4IUMxojgQGCOFAZDpISinooLzgCBgsBAQMJiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0AsAQCYahphfyzQVdFagQmBWYJXAYEgOzGER49JgieKboE?=
 =?us-ascii?q?AhXCKCoF8CwEDAQ1BBAEBhGECgmsCHQcBBDAJDgECBBUBAQUBAQECAQMDBAETA?=
 =?us-ascii?q?QENCxAIOCaFaA2CNSkBg2QBAQEDEhEdARsdAQMMBgULDQICJgICIgERAQUBHAY?=
 =?us-ascii?q?TIoUkAQMvmwiBBD2LMoEVBReBAYIIBoRsChkoDWUDgVcCBxJ+KoQqgmOGZiccg?=
 =?us-ascii?q?UlEgUuCbz6HW4JkBKZQnydagliBNwuCLJpkK6Z1u0YQIxKBK4IUMxojgQGCOFA?=
 =?us-ascii?q?ZDpISinooLzgCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529106773"
X-MGA-submission: =?us-ascii?q?MDE3O8hkjyBzBALy8aCExUFIDPKLRCmvlnb1h8?=
 =?us-ascii?q?wM+VnhOe/mKZZbSjGipPhZEdOH2d3rs3yUF8xDErpiRmYa3kD3e9zQDM?=
 =?us-ascii?q?uEbo+ylToHa6xCHdr/0YwI7tnIi4I5qXin9OxTeMHac1fg+16hCy/nQs?=
 =?us-ascii?q?MMHKXNnLoYTF7hahTXmGKsgg=3D=3D?=
Received: from mail-ed1-f44.google.com ([209.85.208.44])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2021 21:16:32 +0200
Received: by mail-ed1-f44.google.com with SMTP id v5so33279461edc.2
        for <cocci@inria.fr>; Fri, 17 Sep 2021 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZLBHYbvuYX7bjppVZPQbTZZ/lpK7hBVci9zkNaI2/0=;
        b=XUpOSy/yHMypM/eUCOsNKEhJl13ihpBcFr9r4h+D01e3i9zt7YqXVCOugjbaTYDVaG
         HGmaLu8TUiQ1AzrYcFnGRY7Xf/ZJfGQKTCg+mnV4mxdApTmgc+NbaJgbBrhkYgVqfzLK
         3Bmgkxdf7j4JdJcnxjG8rOvi2iryeSkyCf15I8RyjAMPyw9FvE56d8/QOIIWW96j3yfT
         KX3l1n+vD5FVZzZMCKNTNB3D6hw0YVTY89YZEsbKc20BWZ3/ySLvjSAPZ+un09SrGT3J
         zKDQZKCz6tDJ28UIwOkKthFYjyFSxce/BkbZ5AHYRtB7qtQ4JAP9WCbm9zLkb+un75FW
         MviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZLBHYbvuYX7bjppVZPQbTZZ/lpK7hBVci9zkNaI2/0=;
        b=GpbQMxRSaavle4C6b6SEppyKUuUYBX4h4jiuGVqBZ1lf7bkyxN0AkvO+3V+stA6KND
         7H2BVDUJKUYJCVfujCh4zPZIgcdTX6jzg885cW9CGyGm8Ty5AXovs1SnQpdL36oymfZW
         G0h2kaLnVj66lcwZxMMORKDgNBCLCUaxrg6hlsI4te6JYKgwuDZ8DJJtUzTYVrJ+sF9w
         3TiAtLnJvNSEIPwodRVuJYT1HODqvJ8A+N6SqSYhc6hLlvHik1Eg/5GV7tWv6BazuYxJ
         kUrltzKGXLA8Ct7iCCAeK9aSwi5ZWNcLnTzAY0B40BpBt4RtQ44imjaJpyYWBuPVF/GB
         Ge9g==
X-Gm-Message-State: AOAM533D7nq4x6JYThxQaWjYyd8TDZaB/I8kkoK9rJE+/902tTVvB6zm
	4E9xyoN5kl+7nElqKe/eNVPeCNBmjYPxoNPu82M=
X-Google-Smtp-Source: ABdhPJxkwe7uGOD+9zRxzIJg1/DAJKHc27WrweFDv5efq/z1Qz1PNE5LQmvid+ytw7tkG0Of7FHG4uWj97NDsH9IsJw=
X-Received: by 2002:a05:6402:742:: with SMTP id p2mr14605313edy.347.1631906191945;
 Fri, 17 Sep 2021 12:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <202109161609.9AB60A934B@keescook>
In-Reply-To: <202109161609.9AB60A934B@keescook>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Fri, 17 Sep 2021 15:16:21 -0400
Message-ID: <CALogXGUA2-ztW4eDLQ9RNCda8=8k8cSS_A230vMMAG0zCMeEfA@mail.gmail.com>
Subject: Re: matching an arbitrary struct or union (but not scalars)
To: Kees Cook <keescook@chromium.org>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Reply-To: Mansour Moufid <mansourmoufid@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 10
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/CALogXGUA2-ztW4eDLQ9RNCda8%3D8k8cSS_A230vMMAG0zCMeEfA%40mail.gmail.com>

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
>
> char buf[5][9];
>
> and the uuid_t type, where a zero initializer is used:
>
> struct foo instance = { 0 };
>
> [...]
>
> But I do not want to match scalars and single-dimensional scalar arrays
> like these:
>
>         char name[8] = { 0 };

This:

@@
type t;
identifier x;
@@
*   t x[...][...];

will match two or more dimensional arrays, like x[1][2] and x[][2] as
well as x[1][2][3] and so on.

So altogether a script could look like this:

@a@
identifier s, u;
type t1 = {struct s, union u};
type t2 = {struct s, union u};
identifier x;
@@
    t1 {
        ...
        t2 x;
        ...
    }

@@
typedef uuid_t;
type t = {a.t1, uuid_t};
identifier x;
@@
    t x[...] = {
-       0
    };

@@
type t;
identifier x;
@@
    t x[...][...] = {
-       0
    };

I assume this is for the Linux kernel? It looks like there are plenty
of variables of those types but none initialized to {0}. (Although the
script is not done running through the entire kernel, that takes
forever.)
