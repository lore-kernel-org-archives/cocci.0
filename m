Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA940C433EF
	for <cocci@archiver.kernel.org>; Tue, 10 May 2022 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9YbYMbl6997LXQh0We/26LpsNBaMytoiq+p8ox0OQOA=;
  b=I7AmdryBpmzsA7rTr1M1lCpXeZkluJdZVhVLHt3HBU9QORh5FzkAN5ZN
   XlgnclrTAStCzwo0dIUYedCCqkeo78p7/YZgOcGtp/RM3B0rWRFZQwpQ0
   A6V8X2EMOeZfIfRa0wBwtJ1Lo/zV2fe3FdWFERyM5WHklSduvncbejJgI
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208,217";a="35526323"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2022 11:19:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0655EE027B; Tue, 10 May 2022 11:19:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DC417E0099
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 11:19:24 +0200 (CEST)
IronPort-SDR: WWl9kAZBil3XB4mhgvd10EqDvtN2iOZN1WAXl8WWlZ/8gLIuGk7/Hfaftf3i5UUgFSQ58gjVCt
 xcsWlo06RW/w1O320HC1kBA9B1uRninsmiVdNOtMpBAtVjKaZKgkrWvVhR/TgZOa5OEN9h545G
 FsOm/I43HqDr7IV87JnBb8Fom2cJo5fnbQPzDFBxYkMHr6Ak3gS3yHp/3s+Gan/qXA3MjjRwql
 6PsjFiko2HbVg/GVRR8lTfgLl8LemPU3a1TM0KhYOrKD93QY7MnlNsSZvJBwxn9Jx/KUX1DDgi
 okb6Jk3KptEWL3gWwwi56Q1Q
X-IPAS-Result: =?us-ascii?q?A0DcAwA6LXpify7ZVdFahHx+VC4EC0OEToEjjUOCJQOML?=
 =?us-ascii?q?Il4iDsLAQMBDTkJBAEBg0yBNgKFPQIdBwEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhAwFEgU+BdAsDMQ2CNSKDa?=
 =?us-ascii?q?wEBAQECARIRHQEbFggDAQsGAwILDSoCAiIBEQEFARwZCBMHglyCYgEDDSQPk?=
 =?us-ascii?q?CCPGoEEQYo4eoEVBReBAYIJBoFAAYMKChkoDRVSA4FZAgEGEoEqhhYCWEoBA?=
 =?us-ascii?q?YchJxCBVUSBS4J0PoJiAoINgymCZQSUW2YIYBMaHBB7CkBaoHqfC3w0B4NMg?=
 =?us-ascii?q?TsGDIlLlGoxg3WTGJFGlmKNI5RBhSsQIxKBQ4F+TSNQMYI3TgECAQEBDQECA?=
 =?us-ascii?q?QEDAQIBAgkBAQKNey4Wg1CBPokiQjE7AgYBCgEBAwmRbwEB?=
IronPort-PHdr: A9a23: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
 kthZm6seg==
IronPort-Data: A9a23:P0KnhaI+xPDqQzRtFE+R7ZMlxSXFcZb7ZxGr2PjKsXjdYENShGAPz
 GoYUWGHb/veYmPyc90gPIzn9k8C6JXTnYA1HAsd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXlrV4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhvMAp8
 /IK7JCMZSAIPJDQycAaUxtWHHQrVUFG0OevzXmXtMWSywjYaCKpzakwSk4xOoIc96B8BmQmG
 f4wcmhcKEDewbjvn/TnFIGAhex7RCXvFIobt2p7xDfVF/FgSpnZRqTM7MNZ9Dg1j8FKW/3ZY
 qL1bBI2N0qeOUEXYD/7DroXhNiGvHSuUgRHkwq0uowU2WH96BJ+he2F3N39I4TWH625hH2wr
 WXN9GXRGQAfLNXZyDyf83vqiPWnoM/gcIcbFbn96OUzxVPPmCocDxoZUVb9qv684qKjZz5BA
 28EohEJ6vE+yGCMb9vAQ0ycp36GsBFJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaWCkeFWxCO
 rihz4OBONB/jFGGYSnCqerM/FteLQBQfDBSP3ZVJecQy4C7+Nlbs/7Zcjp0/EeIYjDdHDjxx
 3WUt3F7ielNy8EM0Kq/8BbMhDfESnn1ouwdtlm/soGNtFsRiGuZi2qAtwOzARFoctzxc7V5l
 CJY8/VyFchXZX13qASDQf8WAJai7OufPTvXjDZHRsd8rW33oiPzINsMvlmSwXuF1O5UKVcFh
 2eD6WtsCGN7YRNGkIcsPt3pVJx0pUQePY2/CKuOBjaxXnSBXFbfoHsGib+40Gfqn0wh+ZzTy
 r/KGftA+U0yUPw9pBLvH7l1+eZymkgWmD2OLbimkEzP+efPPBa9FOZeWHPTP7BRxP3e/G39r
 Y0EX+PUkEU3bQELSnOImWLlBQtacyZT6FGfg5A/S9Nv1SI8Rj57V6+KkeNJlk4Mt/09q9okN
 0qVAidwoGcTT1WeQelTQnw8Or7pQ7hlqnc3YX4lMVqyiiosZI+u6OEUcJ5uJesr8+lqzPhVS
 fgZepXYUq4fFGifozlNP4PgqIFCdQiwgV3cMiegZg85dcEySgHM/OjiYQaypjIFCTC6tJdlr
 rD5jlHbTJMPSh5MFsHTbP7znVq9sWJMyu13VkrMZNJUfRy0ooRtLiXwiN4xIt0NeU2TnGvEi
 17ODE5B9+fXooIz/N3Yvoy+rt+kQ7lkA05XP2jH9rLpZyTX+2yUx4UfAuuFeDbqUnytpPeva
 OBT+PHLMPMdmWFMvYchQa1gyrgz5oe2qrJXklZkEXHMYwj5A79sOCPdj8xGt6kI2KQA/AXqB
 ASA/d5VPbjPM8TgSQZDKA0gZ+WF9PcVhjiCsqhvcRuivHd6rOidTEFfHxiQkygBfrF7B4Uon
 LU6s8kM5g3j1xcnboScgiZP+zjeJ3AMSf985JQTAYuulBFyj18eP9rTDSj55JzJYNJJaxF4L
 jiRjavEprJd2kuSLCZpRCaVhbJQ1cYUpRRH7F4ePFDVyNDLsfk6gU9K+jMtQwUJkxhK3oqf4
 ISw25GZ+ElPw9tpuCSHd2WlGgUEGgbAv0KtlR0Gk2rWS0TuXWvIRIH41SBh42hBm1+wvBACl
 F1b9IoheTnvdcD1mCA1XCaJbtT9GMdp+FSqdN+PRqy48lpTXdYhqqCrbGsM7RDgBKvdQaEBS
 fZCpI5NVEEwCcLcT2DXxWVXOXT8hS1o/FB/fMw=
IronPort-HdrOrdr: A9a23:vl8qz6OtccebwMBcTvijsMiBIKoaSvp037BL7TEJdfUxSKalfq
 +V7ZEmPHPP+VQssTQb6LO90cq7IE80l6QFhbX5VI3KNGLbUSmTTL2KhrGSpAEIdReOkNK1Fp
 0NT0G9MrDN5JRB4voSKTPXL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208,217";a="13662402"
X-MGA-submission: =?us-ascii?q?MDFuwM8fwh1bOx5f5uWWMV9Y2x6/ZInM1FGJ7o?=
 =?us-ascii?q?pbrmCkF9Z22VDLyJ3NAz5qf7MHDmRcrXa27qLleeqXjPACeVQLg8+LfK?=
 =?us-ascii?q?qQ+HdzICXhJqKZnwbk1tGeEE+F8S9TWcydHQwkRK8HL0YH4dG8PoHN/n?=
 =?us-ascii?q?YIdg610yjyb/7LAuppTciY1g=3D=3D?=
Received: from mail-vs1-f46.google.com ([209.85.217.46])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:19:24 +0200
Received: by mail-vs1-f46.google.com with SMTP id a127so16339733vsa.3
        for <cocci@inria.fr>; Tue, 10 May 2022 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9YbYMbl6997LXQh0We/26LpsNBaMytoiq+p8ox0OQOA=;
        b=KbxgqZe9mCCK9/mcVeUfgHuT4QnbqZJd9IymwL7VKJXjU3rA7N5y+wNpSnqJGTt00I
         0nCCPXemNK9Sq6yzuHOuaHI3qevFBh/q8raelZFV4Zmdw+dxO5XEB8+Ad+SAR10+VkKT
         8mm4ZrpJMSfu/lth6GRZtgQ6GgI3tvCQBG+CeR7u31QKJ0XWOR5c3pqgeV5SwU35PEe6
         G4r+kPRaiwhqvzS1vsFRyDAS5tEXazidJ73gclscCPgkk/2KVuoCQ1QBYpRvlJPhRDCi
         uTxMSJ+kB3lr85aQag53N5lpkz9RmUSfRCQLkX/9eAvtkc8wCVwFvrSfAGzaaqgu2LxP
         LRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9YbYMbl6997LXQh0We/26LpsNBaMytoiq+p8ox0OQOA=;
        b=WsZW2HjxG7MHOmCiwLbNpOI65UpUk+1qy3v5gcmqk16CZ0CU3tsn6ZFZk4HrWHKmxc
         l9TxjmC6+v+aqrBGra+dUfCVkoxhDVmkMHWNCxXYKz1sYvFyMwUiPFeKpBStotv4iEAw
         tGhbOFVVazValLwJylIw2D4EWG98X95KMF7VaLhkvnyDDKmq97CrxM57fokw5BAg1Q86
         XUB1WZ7BLqAo+SYfK2J5b9KGA5yXcLBgXkmllDLgQfdJZwsExkfcYRAJzDkYnpF5G3w1
         36X9BygxbpyVBr+pPeNC6+yWTQMIh0Q9mij8rK1FIPmoatr2TIap2bgCO4s8xzd67lkt
         w31w==
X-Gm-Message-State: AOAM533ZYmopDq/ht0j4bPI0G6hDnLspF7rtWMvGFFm6cgeG1KxGoSb1
	YPJ/Yw2DD93d31VKWEE/Drw1Gyyzcx9g1NsydchYjMyF+YE=
X-Google-Smtp-Source: ABdhPJyfBN1+Rv2h0LshP9XXXCHRjLzUJMHJfkNWGda/3IpLAjNXWcoNQCYCF2rWR/2fvFFGnIXNNJ1vC/zwziVWN0s=
X-Received: by 2002:a05:6102:508b:b0:32d:4378:93c3 with SMTP id
 bl11-20020a056102508b00b0032d437893c3mr10858603vsb.30.1652174362152; Tue, 10
 May 2022 02:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2205100957160.2667@hadrien>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Tue, 10 May 2022 11:18:46 +0200
Message-ID: <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="000000000000f694ac05dea4d13b"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 373
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGS%2B4snNh%2B8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q%40mail.gmail.com>

--000000000000f694ac05dea4d13b
Content-Type: text/plain; charset="UTF-8"

Hello Julia,
I modified the coccinelle script in accordance with your suggestions (at
least, my understanding of those).
The script I'm currently using is like this:
```
@excluded@
type T;
identifier i;
position p;
@@

(
 T i@p(...);
|
 extern T i@p;
)


@r@
type T;
identifier i;
expression E;
position q != excluded.p;
position p : script:python(i) { p[0].current_element == i};
@@

(
 T i@q@p;
|
 T i@q@p=E;
)

@script:python@
i << r.i;
@@
print (i)
```
The rule "excluded" should find what I need to be excluded.
Still, the script has trouble with statements like this:
```
__printf(3, 4) __cold
void _dev_printk(const char *level, const struct device *dev,
                 const char *fmt, ...);
```
And it reports "_dev_printk" as a global variable.
There are also problems with some "__randomize_layout" statements, but I've
not yet isolated the minimal statement that can report "__randomize_layout"
as the global variable name.
My assumption is that I can add defines as done in the init_defs_builtins:
/usr/local/lib/coccinelle/standard.h, but using the -define argument with a
file containing these defines does not solve the problem.
Sorry for keeping this thread long, but your advice would be very
appreciated.

cheers
Alessandro



Il giorno mar 10 mag 2022 alle ore 10:06 Julia Lawall <julia.lawall@inria.fr>
ha scritto:

>
>
> On Tue, 10 May 2022, Alessandro Carminati wrote:
>
> > Hello Markus,
> >
> >
> > Il giorno lun 9 mag 2022 alle ore 21:23 Markus Elfring
> > <Markus.Elfring@web.de> ha scritto:
> >
> >             The solution you sent indeed does what I expected.
> >
> >
> > I doubt that it fits to your initial source code analysis desire.
> >
> > Are your expectations still evolving (also for your data processing
> > needs)?
> >
> > Indeed Julia's proposed code does not solve all the situations I
> encounter
> > now  in the kernel source analysis.
> > It reports not only global variable names but also function names.
> > It confuses sparse annotation and a few other macros with variable names.
> > I also have trouble with "extern" declared variables that appear multiple
> > times.
> > Still, it is far better than I was up to, And it allows me to improve the
> > solution by adding statements and rules to make it better suit my use
> case.
> > Currently, I'm using this, but I still have duplicates due to "extern"
> > declarations.
> > ```
> > @func@
> > type T;
> > identifier i;
> > position p : script:python(i) { p[0].current_element == i};
> > @@
> >
> > T i(...)@p;
> >
> >
> > @r depends on !func@
> > type T;
> > identifier i;
> > expression E;
> > position p : script:python(i) { p[0].current_element == i};
> > @@
>
> Thanks for the feedback.  The strategy of !func is a good idea, but it is
> not correct.  There is no particular relation between the func rule and
> this one.  Thus as soon as a file contains code that matches the func
> rule, the file will be ignored.
>
> One solution would be to check that the position of i is not the same as
> the position of a name matched by the func rule.  For that, you could move
> the @p in the func rule from the ) to the function name, and then in this
> rule put as the first metavariable line:
>
> position q != func.p;
>
> and then in the matches below put i@q@p (ensure that is at a position
> that is both different than any func.p and that it satisfies the
> current_element constraint).
>
> But in this case, there is a solution that is even simpler:
>
> (
> T i(...);
> |
> T i@p;
> |
> T i@p=E;
> )
>
> Indeed, I think it should be sufficient to say:
>
> (
> T i(...);
> |
> T i@p=...;
> )
>
> You can run spatch --parse-cocci to see what happens with the rewriting
> due to isomorphisms to see if the simpler rule is sufficient.
>
> Or maybe you want:
>
> (
> T i(...);
> |
> extern T i;
> |
> T i@p=...;
> )
>
>
> >
> > (
> >  T i@p;
> > |
> >  T i@p=E;
> > )
> >
> > @script:python@
> > i << r.i;
> > @@
> > print (i)
>
> Maybe you also want to inherit the position variable and print the file
> and line number of the declaration?
>
> julia
>
> > ```
> >
> >
> >
> >             Would you mind add a short explanation of this
> >             statement:
> >             `position p : script:python(i) {
> >             p[0].current_element == i};`
> >             I probably have a simplified understanding of what a
> >             position is.
> >
> > I imagine that known information sources can help further.
> >
> >
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a
> > 6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410
> >
> https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e
> > 537f97ab62a/docs/manual/cocci_syntax.tex#L410
> >
> > Thanks for this.
> >
> >
> >
> >
> >             Maybe it is worth digging deeper and having a more
> >             concrete knowledge.
> >
> >
> > Probably, yes.
> >
> >
> >
> >       Any read you want to suggest to me?
> >
> >
> > Related links for example:
> >
> >
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a
> > 6f4465c286a2792354/docs/Coccilib.3cocci#L5
> >
> https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae7
> > 4294515c6b3/docs/Coccilib.3cocci#L5
> >
> >
> >
> > Regards,
> > Markus
> >
> >
> >

--000000000000f694ac05dea4d13b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div d=
ir=3D"ltr">Hello Julia,<br>I modified the coccinelle script in accordance w=
ith your suggestions (at least, my understanding of those).<br>The script I=
&#39;m currently using is like this:<br>```<br>@excluded@<br>type T;<br>ide=
ntifier i;<br>position p;<br>@@<br><br>(<br>=C2=A0T i@p(...);<br>|<br>=C2=
=A0extern T i@p;<br>)<br><br><br>@r@<br>type T;<br>identifier i;<br>express=
ion E;<br>position q !=3D excluded.p;<br>position p : script:python(i) { p[=
0].current_element =3D=3D i};<br>@@<br><br>(<br>=C2=A0T i@q@p;<br>|<br>=C2=
=A0T i@q@p=3DE;<br>)<br><br>@script:python@<br>i &lt;&lt; r.i;<br>@@<br>pri=
nt (i)<br>```<br>The rule &quot;excluded&quot; should find what I need to b=
e excluded.<br>Still, the script has trouble with statements like this:<br>=
```<br>__printf(3, 4) __cold<br>void _dev_printk(const char *level, const s=
truct device *dev,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const char *fmt, ...);<br>```<br>And it reports &quot;_dev_printk=
&quot; as a global variable.<br>There are also problems with some &quot;__r=
andomize_layout&quot; statements, but I&#39;ve not yet isolated the minimal=
 statement that can report &quot;__randomize_layout&quot; as the global var=
iable name.<br>My assumption is that I can add defines as done in the init_=
defs_builtins: /usr/local/lib/coccinelle/standard.h, but using the -define =
argument with a file containing these defines does not solve the problem.<b=
r>Sorry for keeping this thread long, but your advice would be very appreci=
ated.<div><br></div><div>cheers<br clear=3D"all"><div><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr">Alessandro</div></div></div></div></div></div></div></div><br><div=
 style=3D"display:inline"></div></div></div></div></div></div></div></div><=
br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">Il giorno mar 10 mag 2022 alle ore 10:06 Julia Lawall &lt;<a href=3D"mai=
lto:julia.lawall@inria.fr">julia.lawall@inria.fr</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On Tue, 10 May 2022, Alessandro Carminati wrote:<br>
<br>
&gt; Hello Markus,<br>
&gt;<br>
&gt;<br>
&gt; Il giorno lun 9 mag 2022 alle ore 21:23 Markus Elfring<br>
&gt; &lt;<a href=3D"mailto:Markus.Elfring@web.de" target=3D"_blank">Markus.=
Elfring@web.de</a>&gt; ha scritto:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The solution you sent i=
ndeed does what I expected.<br>
&gt;<br>
&gt;<br>
&gt; I doubt that it fits to your initial source code analysis desire.<br>
&gt;<br>
&gt; Are your expectations still evolving (also for your data processing<br=
>
&gt; needs)?<br>
&gt;<br>
&gt; Indeed Julia&#39;s proposed code does not solve all the situations I e=
ncounter<br>
&gt; now=C2=A0 in the kernel source analysis.<br>
&gt; It reports not only global variable names but also function names.<br>
&gt; It confuses sparse annotation and a few other macros with variable nam=
es.<br>
&gt; I also have trouble with &quot;extern&quot; declared variables that ap=
pear multiple<br>
&gt; times.<br>
&gt; Still, it is far better than I was up to, And it allows me to improve =
the<br>
&gt; solution by adding statements and rules to make it better suit my use =
case.<br>
&gt; Currently, I&#39;m using this, but I still have duplicates due to &quo=
t;extern&quot;<br>
&gt; declarations.<br>
&gt; ```<br>
&gt; @func@<br>
&gt; type T;<br>
&gt; identifier i;<br>
&gt; position p : script:python(i) { p[0].current_element =3D=3D i};<br>
&gt; @@<br>
&gt;<br>
&gt; T i(...)@p;<br>
&gt;<br>
&gt;<br>
&gt; @r depends on !func@<br>
&gt; type T;<br>
&gt; identifier i;<br>
&gt; expression E;<br>
&gt; position p : script:python(i) { p[0].current_element =3D=3D i};<br>
&gt; @@<br>
<br>
Thanks for the feedback.=C2=A0 The strategy of !func is a good idea, but it=
 is<br>
not correct.=C2=A0 There is no particular relation between the func rule an=
d<br>
this one.=C2=A0 Thus as soon as a file contains code that matches the func<=
br>
rule, the file will be ignored.<br>
<br>
One solution would be to check that the position of i is not the same as<br=
>
the position of a name matched by the func rule.=C2=A0 For that, you could =
move<br>
the @p in the func rule from the ) to the function name, and then in this<b=
r>
rule put as the first metavariable line:<br>
<br>
position q !=3D func.p;<br>
<br>
and then in the matches below put i@q@p (ensure that is at a position<br>
that is both different than any func.p and that it satisfies the<br>
current_element constraint).<br>
<br>
But in this case, there is a solution that is even simpler:<br>
<br>
(<br>
T i(...);<br>
|<br>
T i@p;<br>
|<br>
T i@p=3DE;<br>
)<br>
<br>
Indeed, I think it should be sufficient to say:<br>
<br>
(<br>
T i(...);<br>
|<br>
T i@p=3D...;<br>
)<br>
<br>
You can run spatch --parse-cocci to see what happens with the rewriting<br>
due to isomorphisms to see if the simpler rule is sufficient.<br>
<br>
Or maybe you want:<br>
<br>
(<br>
T i(...);<br>
|<br>
extern T i;<br>
|<br>
T i@p=3D...;<br>
)<br>
<br>
<br>
&gt;<br>
&gt; (<br>
&gt; =C2=A0T i@p;<br>
&gt; |<br>
&gt; =C2=A0T i@p=3DE;<br>
&gt; )<br>
&gt;<br>
&gt; @script:python@<br>
&gt; i &lt;&lt; r.i;<br>
&gt; @@<br>
&gt; print (i)<br>
<br>
Maybe you also want to inherit the position variable and print the file<br>
and line number of the declaration?<br>
<br>
julia<br>
<br>
&gt; ```<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Would you mind add a sh=
ort explanation of this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0statement:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`position p : script:py=
thon(i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p[0].current_element =
=3D=3D i};`<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I probably have a simpl=
ified understanding of what a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0position is.<br>
&gt;<br>
&gt; I imagine that known information sources can help further.<br>
&gt;<br>
&gt; <a href=3D"https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069ea=
eadd731ecdd99e7a" rel=3D"noreferrer" target=3D"_blank">https://gitlab.inria=
.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a</a><br>
&gt; 6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410<br>
&gt; <a href=3D"https://github.com/coccinelle/coccinelle/blob/ae337fce1512f=
f15aabc3ad5b6d2e" rel=3D"noreferrer" target=3D"_blank">https://github.com/c=
occinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e</a><br>
&gt; 537f97ab62a/docs/manual/cocci_syntax.tex#L410<br>
&gt;<br>
&gt; Thanks for this.=C2=A0=C2=A0<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Maybe it is worth diggi=
ng deeper and having a more<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0concrete knowledge.<br>
&gt;<br>
&gt;<br>
&gt; Probably, yes.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Any read you want to suggest to me?<br>
&gt;<br>
&gt;<br>
&gt; Related links for example:<br>
&gt;<br>
&gt; <a href=3D"https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069ea=
eadd731ecdd99e7a" rel=3D"noreferrer" target=3D"_blank">https://gitlab.inria=
.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a</a><br>
&gt; 6f4465c286a2792354/docs/Coccilib.3cocci#L5<br>
&gt; <a href=3D"https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e=
22bb2d8c20e8dae7" rel=3D"noreferrer" target=3D"_blank">https://github.com/c=
occinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae7</a><br>
&gt; 4294515c6b3/docs/Coccilib.3cocci#L5<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt; Markus<br>
&gt;<br>
&gt;<br>
&gt;</blockquote></div>

--000000000000f694ac05dea4d13b--
