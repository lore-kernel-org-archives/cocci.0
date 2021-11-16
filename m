Return-Path: <SRS0=hYZ6=QD=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA60C433EF
	for <cocci@archiver.kernel.org>; Tue, 16 Nov 2021 16:57:58 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A1161A52
	for <cocci@archiver.kernel.org>; Tue, 16 Nov 2021 16:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98A1161A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,239,1631570400"; 
   d="scan'208";a="3953251"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2021 17:57:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD990E0285; Tue, 16 Nov 2021 17:57:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 78947E0092
	for <cocci@sympa.inria.fr>; Tue, 16 Nov 2021 17:57:51 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=avarab@gmail.com; spf=Pass smtp.mailfrom=avarab@gmail.com; spf=None smtp.helo=postmaster@mail-ed1-f54.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3A4fP4YxaA92EFp+jjBtag4LL/LTFv14qcDmcuAno?=
 =?us-ascii?q?PtbtCf+yZ8oj4OwSHvLMx1gaPBt+Qt6IMy7KP9fy6ASpYudfJmUtBWaQEbwUCh?=
 =?us-ascii?q?8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV?=
 =?us-ascii?q?6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+Mgi6oR/fu8UIjodvJaU8wQbNrndUZ?=
 =?us-ascii?q?uha32xlKUyPkxrm+su84Jtv+DlMtvw88MJNTb/0dLkiQ7xCCzQmPWE15Mn1uhT?=
 =?us-ascii?q?GUACC+HgSXHgInxRRGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8aFmQwL1h?=
 =?us-ascii?q?SgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoW?=
 =?us-ascii?q?gb4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL43bM03fkvHwHI0gMvHdEAv?=
 =?us-ascii?q?3vIo9v6L6oSTfm1wbPUwTnfdf5b2zHw45XIfBA7pvGMWKp9dNPPyUY1DQPOk0m?=
 =?us-ascii?q?dqZbjPzOb1OQVtXKb9+p9Xu+yiW4osRtxoj21ycc3jYnJgJ8ex1fe+iVn2ok1P?=
 =?us-ascii?q?8e3R1VgbN6rFZtfrSCaN49sTsw+RGFovT83x7sbspG0YCYE0o4oxwLDa/OZaYi?=
 =?us-ascii?q?I5AruWeSSLDl4i39oZrGyihKu/Uav1ODwS9S43VZOoydLktfBqG4A2gLc5MWDS?=
 =?us-ascii?q?/Zw4Fqs1DeB2g7d9O1JIV44mbTFJpMn37U+lYITvFzdEiPqnEj6lqybe0U+9uS?=
 =?us-ascii?q?29+jqYa/qq5+TOoNslA3zPb4iltGxDOgmKAQCQnaX9fim2LH+/kD0RLNHheAsn?=
 =?us-ascii?q?KbDqpDVP8Ebq7a5AwBL1oYj7A6yDzK839QZmXkLNUxKdw+ag4TwNVHDIP/1Ae2?=
 =?us-ascii?q?wg1SrlzdryPTGMaP7DprRKXjDla/tfbd760FC1Ao+1c5T645QB70bI//+WlX9u?=
 =?us-ascii?q?MLEAhI6KQC5w+nqBM141owEWGKPBqGZMLnVsV+N/u8gOfeMa5UPuDnnMPco/PH?=
 =?us-ascii?q?ujXojll8ceamlx4cYaHe9Hvh+OUWWfWLsgssdEWcNpgc+SPbliVOYXj5XY3a/R?=
 =?us-ascii?q?KM95jA+CI29F4fMXJqhgL2H3CehH51ZfHpKCl6WEX3wbYWLR+8MaD6OIs9mijE?=
 =?us-ascii?q?LSb+hRJM92hGvrwL60LpmLu/M+iICr57j1d515/fSlR4o7zB0Ad6dgCmxSDRWg?=
 =?us-ascii?q?2cJTncS1b92pUg1nlWe1alxxfhRCtVX49tIVB07PNjS1bopJcr1X1dvYN6TAH+?=
 =?us-ascii?q?8RNuknyupBvgzysULal16HZ32hw7KxSOgK7AQnr2PQpcz9/SPjDDKO89hxiOeh?=
 =?us-ascii?q?+EahF48T54KbDX+7kaa3wfWDo/N1U6ekvTyHUz99CvE9WPGwGbX+U8FDEh/VqL?=
 =?us-ascii?q?KWX1ZbUzT/4yRDqzqQLqnCLBhOQxEm5fqFw=3D=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3Aq0A7kKOzysvm6kPvrR3WlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQaw0jgj12NSxmcdWm+Ga/qDNjSge990PY+080ICvceDv4NqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjRH+SkUoY?=
 =?us-ascii?q?oBwgoLeNaYHd54f5cs7Vh6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIta?=
 =?us-ascii?q?sk7K+f0FTB7CPYU6BjX1ZX6XkiR9HzsAw+vxjZbxMNAEN02XPwowZJNZl7fRcT?=
 =?us-ascii?q?S8gIKTWke41XBxREiU4NqpDkFPCCSPu7JfJlByun3zEmq0yVinaJ7Yw/u9oCGV?=
 =?us-ascii?q?K3e4ZLToXZ1aCgfi3yfS1UIFEjcMoJ8jDJ5IaongmzDfDDP9gT4qrfklgzcsAi?=
 =?us-ascii?q?W122dQXSK6YP95DPGIpNkWROgkUbw9RVYZhyc62olL6VxFYjHOcg5Ytx1bS6Rg?=
 =?us-ascii?q?oiO20a56NbrRmXu1Ql0ec42/KpiH3X01cO9uYxj6ItHmrg4fycerAcNp6PNWFG?=
 =?us-ascii?q?jRC2TV/B1D/CSH6kXO+qPi9z0OyApdRdhBS9S0poqw/skesS7ERmjXQTGGs5nY?=
 =?us-ascii?q?htxh4SoXWKz1hDoLb5g+YAi4PSTsphBkOqpotXTJzvrOWt4qBONGs2YF5jVqS8?=
 =?us-ascii?q?76VqXW5Pi19waoqDcMbZVNt3uQPa73fQv4CohiP3UJ1YhDI9enM/g23?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASzeVXq0h0V92W+CK14x4lAqjBNEkLtp133Aq?=
 =?us-ascii?q?2lEZdPUzSKylfqGV/cjzuiWetN98YhsdcLO7VpVoI0mxyXcd2+B4AV7IZmbbUQ?=
 =?us-ascii?q?WTQb1f0Q=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BlAgBJ4pNhfzbQVdFQCoEJg06BfgVrh?=
 =?us-ascii?q?Ak+iQOIEAOLGHcMkhwLAQMBCwEBPwIEAQGFBAKCYwIdBwEENBMBAgQVAQEFAQE?=
 =?us-ascii?q?BAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNjAQEBAQIBDAYRHQEbHQEDAQsGAwILD?=
 =?us-ascii?q?QICJgICIxEBBQEBGwY1hSQBAw4hkDmPGYEEPYo4eoEVBReBAYIJBoRIChkoDWk?=
 =?us-ascii?q?5gR4CBwkBCBFtKo0yeiccgg2BS4J0PoQYLYMYgmUEjyxNGQh6EwGCc6pdlBdeg?=
 =?us-ascii?q?gVgnzSVaJFElhShG4RpAgoHBhAjEoFDgX1NIxU7MYI4URkPjisBFhWDO4pfQDM?=
 =?us-ascii?q?4AgYBCgEBAwmCOoMKJhMLAYwEAQE?=
X-IPAS-Result: =?us-ascii?q?A0BlAgBJ4pNhfzbQVdFQCoEJg06BfgVrhAk+iQOIEAOLGHc?=
 =?us-ascii?q?MkhwLAQMBCwEBPwIEAQGFBAKCYwIdBwEENBMBAgQVAQEFAQEBAgEDAwQBEwEBD?=
 =?us-ascii?q?QsQCDgmhWgNgjUpAYNjAQEBAQIBDAYRHQEbHQEDAQsGAwILDQICJgICIxEBBQE?=
 =?us-ascii?q?BGwY1hSQBAw4hkDmPGYEEPYo4eoEVBReBAYIJBoRIChkoDWk5gR4CBwkBCBFtK?=
 =?us-ascii?q?o0yeiccgg2BS4J0PoQYLYMYgmUEjyxNGQh6EwGCc6pdlBdeggVgnzSVaJFElhS?=
 =?us-ascii?q?hG4RpAgoHBhAjEoFDgX1NIxU7MYI4URkPjisBFhWDO4pfQDM4AgYBCgEBAwmCO?=
 =?us-ascii?q?oMKJhMLAYwEAQE?=
X-IronPort-AV: E=Sophos;i="5.87,239,1631570400"; 
   d="scan'208";a="3953239"
X-MGA-submission: =?us-ascii?q?MDHiMV4sghfsdm9Y1sdIfF797aYL8HaUQcxALU?=
 =?us-ascii?q?qX2ZLAd3NPqB/ELlJsrJLxLWGeQzAnAk5ftmjzM3lTOWof5ZOOJfvz0u?=
 =?us-ascii?q?DR5GTXS415MD6KgH9FLgG0dVFLG5aaDu+xBXySQ0IYTQx6oftjCp5U40?=
 =?us-ascii?q?GsmFlzafLSY34xulKdjbjiIw=3D=3D?=
Received: from mail-ed1-f54.google.com ([209.85.208.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2021 17:57:50 +0100
Received: by mail-ed1-f54.google.com with SMTP id m20so45007900edc.5;
        Tue, 16 Nov 2021 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8rsjc8z6juUpkDmaFL2ngaR31gyEL8+p7WY3/gtcyGM=;
        b=AQYWpfvYkNLqfhGci5h3le/m/yZYDMg8i+iodg4z4GU39hLPo+R5G6znPU11WOnNmf
         qHbK6PnRzCOpR9kzz+6EmC1P4Z/+nv7xOOMS+VAWhayyRMVAvToHTuRK/ANSF2TqIbeb
         qzXTQpOcQMLX0Tz8CXk4C0SZC5We8bjVg9WgYw1bIz/dVSfGalU3ckmjJvmy6GN3eTXP
         8gnyoL21J+Q21REVxQAZnGtqc9HIcycJKNfcnJlOCaWGeUoFlNog7ZQVpwlNTlN+0Hlc
         csOq4UkCnYRh6KMP/QJ1py2BaNld6RPrJCoH/mQToNyZxvgPN151UXHY8KHl7DK6BVoo
         bhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8rsjc8z6juUpkDmaFL2ngaR31gyEL8+p7WY3/gtcyGM=;
        b=d99f0nVXhcSFXfUEALzDXRj3Sw8jxqpIqsN+nLcDuGCVC6XWAqHMVroI9j0nRbcGTk
         pQIEMFUfS9KT6+yIOF8nleTQ1Ado1UJTm/q5bY4SFKzYnMrFsrn7N59VbxcHKlB5qFxT
         R/RnZHBYhV/uSsmWKs5QxxDRYv0R9BBuoF25ovhUfkdYjVYL2ffb0GVAYawRfVtabOQG
         JF9s/2fT7IVuy4rEKDR1r0VsASnMHHG8102TGTzpXS3jeuXluQSn2vAeAlVRHpT9ZJh3
         2WNoj2sat3jnb+3NujoelTnPckAylndxyqh5YbowB79YTmsFLVwpW9o3Yu74CjTFKBtY
         xCKg==
X-Gm-Message-State: AOAM5320R42YwAZItV8mHSVE3NZkzeqcVG2SkPzr1KHaej3HF7JXMhDd
	Ir1zqIHfKJ+hrtJvtDDVsP0EkgJWrKoxiA==
X-Google-Smtp-Source: ABdhPJxal3Ft0wFqJH3dpnNlC9OZbDTG3E8N5LRno4VXJq1kuOiGqUV7uDiNe5GvTMty8sIEeFDWFw==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr12049260edq.180.1637081869787;
        Tue, 16 Nov 2021 08:57:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m22sm7178402eda.97.2021.11.16.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 08:57:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1mn1mG-001cO7-Rg;
	Tue, 16 Nov 2021 17:57:48 +0100
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Tue, 16 Nov 2021 17:53:39 +0100
References: <211116.86lf1op65q.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2111161717040.2333@hadrien>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <alpine.DEB.2.22.394.2111161717040.2333@hadrien>
Message-ID: <211116.86h7ccox6b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Is there a --no-includes --but-includet-this foo.h
 --but-in[...] mode?
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 104
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/211116.86h7ccox6b.gmgdl%40evledraar.gmail.com>


On Tue, Nov 16 2021, Julia Lawall wrote:

> On Tue, 16 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> [First time poster, long time spatch user, thanks a lot for providing
>> it!]
>>
>> I'm trying to optimize the runtime of spatch in git.git by leveraging
>> information that's already in the Makefile. Both GCC and Clang know how
>> to spew out information about what headers a given file depends on in
>> "Makefile" format, e.g. for a "hook.c" in git.git:
>>
>>     $ cat .depend/hook.o.d
>>     hook.o: hook.c cache.h git-compat-util.h compat/bswap.h wildmatch.h \
>>      banned.h strbuf.h hashmap.h hash.h repository.h path.h sha1dc_git.h=
 \
>>      sha1collisiondetection/lib/sha1.h sha256/block/sha256.h list.h advi=
ce.h \
>>      gettext.h convert.h string-list.h trace.h trace2.h pack-revindex.h \
>>      oid-array.h mem-pool.h hook.h run-command.h thread-utils.h strvec.h
>>     [...]
>>
>> I wanted to feed that into spatch somehow, but with e.g. --include it
>> will not include anything:
>
> How did you identify that nothing was included with --include?  --include
> is supposed to allow you to specify files that should be included
> regardless of the #includes found in the file.

From strace-ing it it looks like it is including those files I asked for
with just --include, but it doesn't print out an "including" message
like in the other modes, so I assumed it was simply ignoring them.

But it looks like it's working!

> On the other hand, there is nothing to make a list of includes be
> considered to be the only includes that are allowed as you suggest.

For what it's worth I had in mind (presumably simpler)
--check-include-exhaustiveness or whatever, i.e. it wouldn't try to
generate a full list of includes, but just error out if it ever ran
across an "#include" that I hadn't specifiec.

But perhaps for that to be truly useful it would need to at least go far
enough to check if that not-listed include was a local or a non-local
one.

In any case, I could just do that myself by running it twice in some
assertion mode & parsing its output, thanks!

>>
>>     ~/g/coccinelle/spatch.opt --sp-file contrib/coccinelle/strbuf.cocci =
--verbose-includes --no-includes --include cache.h --include path.h hook.c
>>     init_defs_builtins: /home/avar/g/coccinelle/standard.h
>>     HANDLING: hook.c
>>
>> It seems that there's --recursive-includes, --all-includes,
>> --no-includes etc, but those all tweak different aspects of
>> auto-discover, or "seed" the auto-discovery via --include.
>>
>> But I'd like a way to say "here, exhaustively, are my includes", does it
>> have such a mode? If not consider this a feature request.
>>
>> Even better on top would be to further optionally tell it due die if it
>> ever encounters an include file that's not explicitly provided on the
>> command-line.
>>
>> That would serve as a nice sanity check on the *.d files we get from
>> gcc/clang, and make sure that this way of optimizing its runtime works
>> as intended. I was planning to do that by parsing its output, but having
>> it as a native option would be easier.
>>
>> Note: I probably don't *really* need this, since I can look at the *.d
>> file myself and have "make" determine if spatch needs to run at all, and
>> I trust the gcc/clang information well enough.
>>
>> But being able to have spatch use that information exclusively would
>> also be nice, especially for the above mentioned sanity check.
>>
>> Thanks!
>>

