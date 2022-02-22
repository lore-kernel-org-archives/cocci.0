Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2462C433EF
	for <cocci@archiver.kernel.org>; Tue, 22 Feb 2022 12:55:17 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,387,1635199200"; 
   d="scan'208";a="22649617"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Feb 2022 13:55:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0631E6E6B; Tue, 22 Feb 2022 13:55:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0E669E6E66
	for <cocci@sympa.inria.fr>; Tue, 22 Feb 2022 13:55:11 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=avarab@gmail.com; spf=Pass smtp.mailfrom=avarab@gmail.com; spf=None smtp.helo=postmaster@mail-ej1-f49.google.com
IronPort-SDR: 2HhilYECHS90y4YOUe8pVbyTIpraMCEuaL1Rab/13tHOZCaBdYHfnWOGBDX8Fx2UnEzaV9CQMh
 lgdtr5U/Znx9rJsR+q5X9pXl1/dWVr5m6O/L/qrGkntDIuqQb5S5WPeChOyWbRrGIA8C1xLX14
 6qhex7IJ4PE5OvCTY+xm0wi6Sn9c4+wuLxRg2ES9OMrYMyPNVEjefVFndddS3pKLXpBPPWVDmA
 Klspn19GN9trJItG7QocK1PIz55MI9OkNoA5AsrtUbzwP/cCNibInySoKUDFlVhfcs8eXPHokr
 UIZkrvA6oFCZwqtUUMfcsXUw
X-IPAS-Result: =?us-ascii?q?A0AhAAD82xRifzHaVdFQCh0BAQEBCQESAQUFAUCBRggBC?=
 =?us-ascii?q?wGBfyh+VysETQOEEz6IJmCIEQOMG5A/gXwLAQMBCwEBNwgCBAEBhQcChAgCH?=
 =?us-ascii?q?QcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQ0LCQcIC?=
 =?us-ascii?q?gcODgVgAWEDAUSBT4F0CwMxDYI1KQGDYwEBAQECAQwGER0BGx0BAwELBgMCC?=
 =?us-ascii?q?w0CAiYCAhARAhEBBQEBGwYTIoJjgmQBAw0hD49gjxmBBD2KOHqBFQUXgQGCC?=
 =?us-ascii?q?QaBQAGDCAoZKA1qOoEeAgcJAQgRbSwBhg2DeIJaaAF6JxyCDYFLgj03PoIhQ?=
 =?us-ascii?q?gKBMy2DGIJlBJQ7BgIwMBoTCyFxVBokARtbkVuDNJYuk2BrXoINZosEjmaGL?=
 =?us-ascii?q?IVAkHGRZJZOjRKDT5VpAgoHBhAjEoEsghVNIxVsgjgJRQECAQEBDQECAQEDA?=
 =?us-ascii?q?QIBAgkBAQKOHQwWgQQBCQOCP4UUbFGEDkA0AgEBATMCBgEKAQEDCYI6gwomE?=
 =?us-ascii?q?wsBiR4tghcBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:xzYzEKNbFDIC6V3vrR2GkcFynXyQoLVcMsEvi/4bfWQNrUohhjEFy
 mUfXD/VaP7fMWb2f4x3aIy38U5Xup6DydQyHnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2UILd9IR2NYy24DjWVnV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2UzspM6
 vBnk6XsUCY4E63okeccQT1xRnQW0a1uoNcrIFC6uM2XikDEKj7in6QoA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3bvmhu7qIgVvrpxLwM3DNZ0WoHhq5T7cBPciB5vERs0m4PcChmls150fQ54yY
 eIZZhtJZRn9fyROI0cGFpI5kKCTgUfgJmgwRFW9/PJruQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RP/0BHNmWyD7A/3D1w+GTzGX0X4UdELD+/flv6LGO+oANIABHT2aZhNOfsxKnesNyK
 2gd+Ss8iYFnoSRHUeLBdxG/pXeFuDsVVNxRD/A25WmxJkz8s1bx6o8sHm4pVTA2iCMlbWd1i
 QLRzrsFERQq4eLFEyvMnluBhWrqYXB9EIMUWcMToeI4DzTLpYgyilfCTI8mHvLkyNLyHj70z
 naBqy1Wa1QvYSwjh/jTEbPv2WrESn31ougduFm/soWNsF4RWWJdT9b0gWU3FN4ZRGpjcnGPv
 WIfh++V5/0UAJeGmUSlGbtRQe33t6zdaGaD0DaD+qXNERz9qxZPmqgAsFlDyLtBb67ohBe1O
 haI4VoJjHOtFCLyMvQnC25ONyja5fG4SY6NugH8Yd1JbZx8HDJrDwk/DXN8K1vFyRB2+YlmY
 cnzWZ/1UR4yVPo6pBLrGL91+eJ6nkgWmDKILbimnkTP+eTFPxa9F+xVWGZim8hjs8toVi2Oo
 4gBXyZLoj0DONDDjt7/q9BLdglSdSBhbX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJRoxZybXF+
 G+TQEhdxAatjHHLM1TYZXVqabepVpF69CppMSspNFeu+n4ifYf/tPdFJ8VrJeEqpL550Pp5b
 /gZYMHfUPlCTzLw/T5CP5TwqYpVcgum2FCVNC2/bTljJJNtHlSb+tLtcgb12jMJCy676Zk3r
 7G6h1HURJMCQ0JpC8OPMKCjyFa4vH48nuNuXhuQcoMDJhm0qIUzcn7/lP46Jc0IOC7v/DrC2
 lbEGwocqMnMv5Qxr4vEiKWCmIGjTLlzE09cKG/EtOrkOCTf+F2j9o9OSuO/ez7QCTHv86K4a
 OQJlvzxPaFVnFtOtIYgQb9nwbhkvInqrr5eiwlmRTDFMwXtBbRnLX2Lm8JIs/QVlLNevAK3X
 GOJ+8VbaerVYpK7SAZJKVp3dPmH2NEVhiLWsaY/LnL86XIl57GAS0hTY0SBhXAPNrdzK495k
 +4ttNRMsF66gxsud9uE12VaqzXKIXsHXKEq8JodBdaz2AYsz1hDZ73aCzP3sM7TMYQSahFyL
 2/GnrfGipRd2lHGLyg5G0/L0LcPnp8Joh1LkAIPKlnhdgApXRPrMMC9MAjbTzi5Cj1C2uN3f
 2Vpbgh7efTI8DBvi8xOGWurHmmtwfFfFlPZkzM0eK/xFiFElVAh6EUyPO+M+AYS9Gc0kv1z4
 uSD0Gi8Odr1VJiZ48bxMHKJb9TsSNVw8kvJn8XP8wFp2XUlSWKNv5JCrlbkZ/cq7Q3dSaEHS
 SRXED5MVJDG
IronPort-HdrOrdr: A9a23:pMOTRaG4BXFlfjIMpLqEIseALOsnbusQ8zAXPo5KOHhom6uj5r
 +TdZUgpGPJYVMqMk3I9urwXpVoLUmsl6JdwY5UJru6WRmjpW3AFvAY0WKA+UycJ8SdzJ8m6U
 4IScEXY72AbmSSz/yKmTVQe+xA/DDtytHOuQ6x9QYJcShXca16qw92BgGHe3cGPDWuxqBUKH
 Nf3Kd6TvabFkj/p/7UOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,387,1635199200"; 
   d="scan'208";a="22649596"
X-MGA-submission: =?us-ascii?q?MDGq7lrWQ3w1EpkSNwwiAwqEO8ML6Cm4uWZMd+?=
 =?us-ascii?q?9nD6R6ZlOcEcYsAITosmjhyJaEaRQYkFC/YPpwAB4nF4h/P2nNP3MSQF?=
 =?us-ascii?q?H5/9aHdLeBG4kXp3ablV4PeanuTS50T3hVz5pQOcUF6HX4uBu/SIquqB?=
 =?us-ascii?q?W/u+MyYYqQGmRpaTjk+tVg+w=3D=3D?=
Received: from mail-ej1-f49.google.com ([209.85.218.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 13:55:10 +0100
Received: by mail-ej1-f49.google.com with SMTP id qk11so42714129ejb.2
        for <cocci@inria.fr>; Tue, 22 Feb 2022 04:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ltMh9xEZXMbUUahkFMzXJ8G3AlHS+vl0E8bYr37F1sA=;
        b=Iu4Q8gmDKJa6FtHwXE9p+KTM9192v4DnjufcMyAGftSex+4dn0cJns70LA8twgc1zr
         Trb+aLMe8zi7HPp7bYLM7/R3WcE0TgqDWOGO8W4AXDRyR2Tr34KSnS11fcZxzxTwT+nw
         fp+H2EnD3/0xZW3A/WNE6bdNiSe/krsWK6RkiGQogEtlCkwl2cfbiOlB4ygcqRb7C83E
         6RtSvBnBqyCNYf+V8RSuNxVg3nu4I88p5qmmhQMSRCocf92l27uUxGwrkSrH88Je1oGm
         +W1v6//AxOPbfVAPKCK1jbVOjKtUFYXIV08B7mDBDaiFyETiEq9lw9tq7m3um76g3eDE
         ZIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ltMh9xEZXMbUUahkFMzXJ8G3AlHS+vl0E8bYr37F1sA=;
        b=KXjloI8q5YX1yqK9eH64UQcmImFSmEF0USvSEPDi5tH7z8nnkppjocSJN2MZBvys4X
         w/tWDgYEBTxfOnH7bN2nM5wQ7eBPTcj7Xl8W8gx88To+ifOWNNGxzOaU30FCWvKlOUUN
         TjGJoA0/oDwolDhWJo45akOdpYma1V7AZ57vn6tR7Z80aZilAUyJhHptypATPWpv5VTW
         4WD2KTfjjKgm19GLjajZMNPQxRp4iqJhxnSbNiqzbPF55GqQzCiFNsSFx7xHhx4REzD8
         eRu/wFIkYUHgtslP0jJw1Cr4ZFalZMLvl/+fYIwIU4Moxtn8qet+1nTuf4xKBwyYzmCB
         E7bg==
X-Gm-Message-State: AOAM530bwbyks+1SSWGX7shN8swLWU2M+ePQsClNG1fy/5SazjGvp4lA
	gOO0ma9fSMz1xfgNnwyymxg5qeW/nT4h4lwG
X-Google-Smtp-Source: ABdhPJxnukduLoorKUH38uXq/sYZmpsjA07nij5KtHEkbTG1g2h9sbYfZ3dzMMy+13w3bKhTNE8ePA==
X-Received: by 2002:a17:907:58e:b0:6ce:375a:4b8d with SMTP id vw14-20020a170907058e00b006ce375a4b8dmr18953846ejb.107.1645534509639;
        Tue, 22 Feb 2022 04:55:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kw5sm6379608ejc.140.2022.02.22.04.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:55:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1nMUhA-0063YS-Lo;
	Tue, 22 Feb 2022 13:55:08 +0100
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
	Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
	git <git@vger.kernel.org>, cocci@inria.fr
Date: Tue, 22 Feb 2022 13:37:12 +0100
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
 <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
 <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet>
Message-ID: <220222.867d9n83ir.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH] add usage-strings ci check and amend remaining
 usage strings
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 143
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/220222.867d9n83ir.gmgdl%40evledraar.gmail.com>


On Tue, Feb 22 2022, Johannes Schindelin wrote:

> Hi Julia,
>
> I would like to loop you in here because you have helped us with
> Coccinelle questions in the past.

Thanks. Probably better to CC the relevant ML, adding it.

> On Mon, 21 Feb 2022, Abhradeep Chakraborty wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>>
>> > That should be fairly easy to do though, and if not we could always
>> > just dump these to stderr or something if a
>> > git_env_bool("GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP", 0) was true,
>> > and do the testing itself in t0012-help.sh.
>>
>> Okay but if the logic can't be implented in the `parse-options.c` file
>> (most probably I will be able to implement the logic), would you allow
>> me to try the `coccinelle script` method you mentioned?
>
> The task at hand is to identify calls to the macro `OPT_CMDMODE()` (and
> other, similar macros) that get a fourth argument of the form
>
> 	N_("<some string>")
>
> The problem is to identify `<some string>` that ends in a `.` (which we
> want to avoid) or that starts with some prefix and a colon but follows
> with an upper-case character.
>
> In other words, we want to suggest replacing
>
> 	N_("log: Use something")
>
> or
>
> 	N_("log: use something.")
>
> by
>
> 	N_("log: use something")
>
> =C3=86var suggested that Coccinelle can do that. Could you give us a hand=
 how
> this would be possible using `spatch`?

I probably shouldn't have mentioned that at all, and I think this is
academic in this context, because as noted we can just add this to
parse_options_check() (linking it here again for off-git-ml context):

    https://lore.kernel.org/git/220221.86tucsb4oy.gmgdl@evledraar.gmail.com/

We now pay that trivial runtime overhead every time, we could run it
only during the tests if we ever got worried about it.

And it's a lot less fragile and easy to understand than running
coccicheck, i.e. as nice as it is it's still takes a while to run, is
its own mini-language, needs to be kept in sync with code changes etc.

So by doing it at runtime we can adjust messages, code & tests in an
atomic patch more easily (i.e. not assume that you ran some cocci target
to validate it).

It also makes it really easy to do things that are really hard (or
impossible?) with coccinelle. I.e. some of these checks are run as a
function of what flag gets passed into some function later on, which in
the general case would require coccinelle to have some runtime emulator
for C code just to see *what* checks it wants to run.

That being said (and with the caveat that I've only looked at this code,
not done this myself) if you clone linux.git and browse through:

    git grep -C100 -F coccilib.report '*.cocci'

You can see a lot of examples of using cocci for these sorts of checks.

And the same goes if you clone coccinelle.git and do:

    git grep -C100 @script: -- tests

For linux.git it's documented here:
https://github.com/torvalds/linux/blob/master/Documentation/dev-tools/cocci=
nelle.rst

I.e. it's basically writing the sort of cocci rules we have in-tree with
a callback script that complaints about the required change.

For our use it would probably better (in lieu of parse_options_check(),
which is the right thing here) to just have a normal *.cocci file and
complain if it applies changes. We already error in the CI if those need
to apply any changes.

But I don't off-hand know how to do that. E.g. I was trying the other
day to come up with some coccinelle rule that converted:

    die("BUG: blah blah");

To:

    BUG("blah blah");

And while I'm sure there's some way to do this, couldn't find a way to
write a rule to "reach in" to a constant string, apply some check or
search/replacement on it, and to do a subsequent transformation on it.

In this case the OPT_BLAH(1, 2, 3, "string here") has OPT_BLAH() as a
macro. I can't remember if there's extra caveats around using coccinelle
for macros v.s. symbols.

Disclaimer: By "couldn't" I mean I grepped the above examples for all of
a few minutes quickly skimmed the coccinelle docs, didn't find a
template I could copy, then ended up writing some nasty grep/xargs/perl
for-loop instead :)
