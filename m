Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEBDC432C0
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 17:20:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5256216F4
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 17:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep1a+13F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5256216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATHJxDN019434;
	Fri, 29 Nov 2019 18:19:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8E03277D4;
	Fri, 29 Nov 2019 18:19:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 701BE77D2
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 18:19:57 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:331] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATHJuSh028230
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 18:19:56 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id s14so9144987wmh.4
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 09:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1mRyFy1VGf70vpdTQrq0VhPFbGNnXSk7B0PV/3MyllU=;
 b=Ep1a+13Fixd3cw9hVk6J1ydOJcUCzZtiv/cRd613KvfCD3HQjr4h2WX6+WF6vWKN95
 FQNkZF6rRcp3Vkm/H3RDdj6i1jCgORw2UWOuWAcg57SkQaBq3HrTXX27IlCY2q1rCzCg
 LkzhmJpH7IBCH3BpNqdT+fBqLK0fLt7f+/5YgvT1oh0yhw5fP1OkTpNUvO4/DAEj8Idy
 wOjwSP5+435wc5XdDOamHWjQGT1z1Nh98F6reHvquOtlgE/J4yhYH5/CNYVb7AGLKL4+
 SHZZkPwaB0DABezdx7wA5b+wPR6V43kPD1tY2dHeFuSBKAjZFIfnLCWhNofegypkYPPe
 y1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1mRyFy1VGf70vpdTQrq0VhPFbGNnXSk7B0PV/3MyllU=;
 b=WsGec2V8yHgTmLGDn8Ff1TsOXwbEQ04AptybsyXXrW5JUcBh+36YQW0XAZDK1BThor
 XKFmLlG1cuUfT9JuDro7QJnPFaLOh7ta02c952gQre2q2zQe++s9ds74VbgF7VttDM7O
 1PMr4rUArGwunz7/JjlWWRQoj5L9HVDA3YP4W3yhdOxw4YvuqnDhpDCm4pxHsL9kB4FZ
 fDSp9DKsjwSdauVkOT44IgnQ7NwiYS19uwlee+a2i5+2m8pEvb0dZpg6uL6TSKBGRYhJ
 stujitdaCYZaFPx5C3OZRIkI7mfnsWb7teUWQcY5nJSQ4EeOtIKpKrZOBvpt9XhO7wl3
 dv6Q==
X-Gm-Message-State: APjAAAVDSm9cB/giNLY984Ct45Ged0srKnizntrKySDtzVcTOIFJNT5B
 gGPlnmUT8pCNNNtoyW+j9MmxS2iKWKaEr3EBfeU=
X-Google-Smtp-Source: APXvYqztKy4udZMfQBd43COC/i598EauDU60xSOx9+2L46ckHLEW86sKma8kkzvJRiMSpen3aaChEp4zq4EDasELXcA=
X-Received: by 2002:a1c:f705:: with SMTP id v5mr15216620wmh.82.1575047996334; 
 Fri, 29 Nov 2019 09:19:56 -0800 (PST)
MIME-Version: 1.0
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <9e9f6596-1b8d-dc4f-86cf-21094200809d@web.de>
In-Reply-To: <9e9f6596-1b8d-dc4f-86cf-21094200809d@web.de>
From: Strace Labs <stracelabs@gmail.com>
Date: Fri, 29 Nov 2019 15:19:20 -0200
Message-ID: <CABvP5W1HPdE8=h2LGDo4etG2oWzi7DnycJczu=zVr+AKOamVdA@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 18:20:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 Nov 2019 18:19:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf() parameters according to used data
	types
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
Content-Type: multipart/mixed; boundary="===============0028047253=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0028047253==
Content-Type: multipart/alternative; boundary="00000000000053697405987f70bd"

--00000000000053697405987f70bd
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 29, 2019 at 2:09 PM Markus Elfring <Markus.Elfring@web.de>
wrote:

> > so, that suggestion works the same as my previous shared statement.
>
> I suggest to take another look at presented implementation details.
>
>
I did it, even digging the grammar and ALL samples and didn't find anything
similar to handle format strings with multiple parameters as mentioned.


>
> > but, only for calls like: *my_printf("%s", h1.name);*,
>
> I limited my suggestion intentionally.
>
>
> > not for *my_printf("%d here also, tt=%s | %s and %m\n", id, h2->name,
> h2->name, s2);*
>
> Such a function call is using more parameters. Would you get into
> the mood then to specify additional metavariables in SmPL script variants?
>
>

I can't because the calls around the code have different uses with
different variants.



> > so, I am not sure if Coccinelle is able to do that.
>
> I hope that more useful data processing for format strings will become
> supported by the semantic patch language.
> Yesterday an information was given that another functionality is also
> work in progress.
>



Interesting.



>
> > I've read all samples available in the Kernel and Coccinelle repo's
>
> I find such information interesting and promising.
>
>
> > and I didn't see any similar case.
>
> This observation can be fine.
> How often do you fiddle with source code transformations around
> format strings?
>
>


Well, I've used it before but for me, it is the first "complex" case that I
am working on. even I still digging trying to figure out how to do that but
I still not sure if the Coccelinne is capable to do that yes or no.




>
> > I think that if Julia Lawall don't know, No one in the world knows.
>
> Such an impression can occur. - But I would like to point further
> possibilities out for desired knowledge distribution.
>
> * Would you like to contact any more related developers?

* How do you think about to improve your own expertise
>   (around the discussed free software) in any ways?
>
> Regards,
> Markus
>

--00000000000053697405987f70bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Nov 29, 2019 at 2:09 PM Markus El=
fring &lt;<a href=3D"mailto:Markus.Elfring@web.de">Markus.Elfring@web.de</a=
>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">&gt; so, that suggestion works the same as my previ=
ous shared statement.<br>
<br>
I suggest to take another look at presented implementation details.<br>
<br></blockquote><div><br></div><div>I did it, even digging the grammar and=
 ALL samples and didn&#39;t find anything similar to handle format strings =
with multiple parameters as mentioned.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
&gt; but, only for calls like:=C2=A0*my_printf(&quot;%s&quot;, <a href=3D"h=
ttp://h1.name" rel=3D"noreferrer" target=3D"_blank">h1.name</a>);*,<br>
<br>
I limited my suggestion intentionally.<br>
<br>
<br>
&gt; not for=C2=A0*my_printf(&quot;%d here also, tt=3D%s | %s and %m\n&quot=
;, id, h2-&gt;name, h2-&gt;name, s2);*<br>
<br>
Such a function call is using more parameters. Would you get into<br>
the mood then to specify additional metavariables in SmPL script variants?<=
br>
<br></blockquote><div><br></div><div><br></div><div>I can&#39;t because the=
 calls around the code have different uses with different variants.=C2=A0</=
div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; so, I am not sure if Coccinelle is able to do that.<br>
<br>
I hope that more useful data processing for format strings will become<br>
supported by the semantic patch language.<br>
Yesterday an information was given that another functionality is also<br>
work in progress.<br></blockquote><div><br></div><div><br></div><div><br></=
div><div>Interesting.</div><div>=C2=A0</div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; I&#39;ve read all samples available in the Kernel and Coccinelle repo&=
#39;s<br>
<br>
I find such information interesting and promising.<br>
<br>
<br>
&gt; and I didn&#39;t see any similar case.<br>
<br>
This observation can be fine.<br>
How often do you fiddle with source code transformations around<br>
format strings?<br>
<br></blockquote><div><br></div><div><br></div><div><br></div><div>Well, I&=
#39;ve used it before but for me, it is the first &quot;complex&quot; case =
that I am working on. even I still digging trying to figure out how to do t=
hat but I still not sure if the Coccelinne is capable to do that yes or no.=
</div><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
&gt; I think that if Julia Lawall don&#39;t know, No one in the world knows=
.<br>
<br>
Such an impression can occur. - But I would like to point further<br>
possibilities out for desired knowledge distribution.<br>
<br>
* Would you like to contact any more related developers?</blockquote><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
* How do you think about to improve your own expertise<br>
=C2=A0 (around the discussed free software) in any ways?<br>
<br>
Regards,<br>
Markus<br>
</blockquote></div></div>

--00000000000053697405987f70bd--

--===============0028047253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0028047253==--
